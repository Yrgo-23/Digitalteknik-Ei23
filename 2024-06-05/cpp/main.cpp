/*******************************************************************************
 * @brief Implementation of FSM (finite state machine) for controlling a LED.
 *  
 *        The following states are implemented:
 *            - STATE_OFF  : The LED is disabled.
 *            - STATE_BLINK: The LED is blinking every 100 ms.
 *            - STATE_ON   : The LED is enabled.
 *
 *        The state is updated to next/previous via two buttons. A third
 *        button is used to generate system reset. 
 *
 * @param reset_button[in]    Button for generating system reset,
 *                            connected to PIN 11 (PORTB3).
 * @param previous_button[in] Button for changing the state to previous,
 *                            connected to PIN 12 (PORTB4).
 * @param next_button[in]     Button for changing the state to next,
 *                            connected to PIN 13 (PORTB5).
 * @param led[out]            LED controlled by the state machine,
 *                            connected to PIN 9 (PORTB1).
 ******************************************************************************/
#include "gpio.h"
#include "timer.h"
#include "watchdog.h"

using namespace driver;

/*******************************************************************************
 * @brief Enumeration for implementing the different states of the FSM.
 ******************************************************************************/
enum class State { Off, Blink, On };

namespace 
{

/********************************************************************************
 * @brief Implementation of external devices used in the embedded system
 *        see the description above for details.
 ********************************************************************************/
GPIO led{9U, GPIO::Direction::Output};
GPIO resetButton{11U, GPIO::Direction::InputPullup};
GPIO previousButton{12U, GPIO::Direction::InputPullup};
GPIO nextButton{13U, GPIO::Direction::InputPullup};

/********************************************************************************
 * @brief Implementation of internal devices.
 *
 * @param timer0 Debounce timer, which disables PIN change interrupts on PORTB 
 *               for 300 ms after pressdown to reduce effects of contact bounces.
 * @param timer1 Timer used to toggle the LED.
 ********************************************************************************/
Timer timer0{Timer::Circuit::Timer0, 300U};
Timer timer1{Timer::Circuit::Timer1, 100U};

/*******************************************************************************
 * @brief Variable holding the current state of the FSM.
 ******************************************************************************/
State state{State::Off};

/*******************************************************************************
 * @brief Indicates whether the FSM shall be updated to next state.
 *
 * @return True if the FSM shall be updated to next state.
 ******************************************************************************/
inline bool nextState(void)
{
    return nextButton.read() && !previousButton.read();
}

/*******************************************************************************
 * @brief Indicates whether the FSM shall be updated to previous state.
 *
 * @return True if the FSM shall be updated to previous state.
 ******************************************************************************/
inline bool previousState(void)
{
    return !nextButton.read() && previousButton.read();
}

/*******************************************************************************
 * @brief Generates system reset; the state is set to Off and the LED
 *        and Timer 1 are disabled.
 ******************************************************************************/
void resetSystem(void)
{
    timer1.stop();
    led.clear();
    state = State::Off;
}

/*******************************************************************************
 * @brief Updates the current whenever one of the buttons is pressed.
 ******************************************************************************/
static void updatestate(void)
{
    if (resetButton.read()) { resetSystem(); }
    else
    {
        switch (state)
        {
            case State::Off:
                if (nextState())          { state = State::Blink; }
                else if (previousState()) { state = State::On; }
                break;
            case State::Blink:
                if (nextState())          { state = State::On; }
                else if (previousState()) { state = State::Off; }
                break;
            case State::On:
                if (nextState())          { state = State::Off; }
                else if (previousState()) { state = State::Blink; }
                break;
            default:
               resetSystem();
               break;
        }

        if (state == State::Blink) { timer1.start(); }
        else                       { timer1.stop(); }
        led.write(state == State::On);
    }
}

/*******************************************************************************
 * @brief Updates the state machine whenever a button is pressed. PIN change
 *        interrupts are disabled for 300 ms after pressdown to mitigate
 *        effects of contact bounces.
 ******************************************************************************/
void buttonCallback(void) 
{
    GPIO::disableInterruptsOnIoPort(GPIO::IoPort::B);
    timer0.start();
    updatestate();
}

/********************************************************************************
 * @brief Enables pin change interrupts on the button's I/O port 300 ms after
 *        press or release to reduce the effects of contact bounces.
 ********************************************************************************/
void timer0Callback(void) 
{
    timer0.stop();
    GPIO::enableInterruptsOnIoPort(GPIO::GPIO::IoPort::B);
}

/********************************************************************************
 * @brief Toggles the LED when timer1 elapses, which is every 100 ms when enabled.
 ********************************************************************************/
void timer1Callback(void) { led.toggle(); }

/*******************************************************************************
 * @brief Initializes the system by adding callbacks, enabling PIN change 
 *        interrupts and setting up the Watchdog counter.
 ******************************************************************************/
inline void setup(void) 
{
    resetButton.addCallback(buttonCallback);
	timer0.addCallback(timer0Callback);
    timer1.addCallback(timer1Callback);

    resetButton.enableInterrupt();
    previousButton.enableInterrupt();
	nextButton.enableInterrupt();

    watchdog::init(watchdog::Timeout::Timeout1024ms);
    watchdog::enableSystemReset();
}

} // namespace

/*******************************************************************************
 * @brief Runs the state machine continuously.
 ******************************************************************************/
int main(void)
{
    setup();

    while (1) 
    {
	    watchdog::reset();
    }
	return 0;
}

