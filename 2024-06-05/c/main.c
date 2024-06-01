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
 * @param RESET_BUTTON[in]    Button for generating system reset,
 *                            connected to PIN 11 (PORTB3).
 * @param PREVIOUS_BUTTON[in] Button for changing the state to previous,
 *                            connected to PIN 12 (PORTB4).
 * @param NEXT_BUTTON[in]     Button for changing the state to next,
 *                            connected to PIN 13 (PORTB5).
 * @param LED[out]            LED controlled by the state machine,
 *                            connected to PIN 9 (PORTB1).
 ******************************************************************************/
#include "definitions.h"

/*******************************************************************************
 * @brief Variable holding the current state of the FSM.
 ******************************************************************************/
 static state_t state = STATE_OFF;

/*******************************************************************************
 * @brief Variables storing the number of executed timer interrupts.
 ******************************************************************************/
static volatile uint8_t timer0_counter = 0x00;
static volatile uint8_t timer1_counter = 0x00; 

/*******************************************************************************
 * @brief Initializes the system. The PINs are set up, PIN change interrupts
 *        are enabled on the button PINs and the timers are initialized.
 ******************************************************************************/
static void setup(void)
{
    DDRB   = (1U << LED);
    PORTB  = ((1U << RESET_BUTTON) | (1U << PREVIOUS_BUTTON) | (1U << NEXT_BUTTON));
    PCICR  = (1U << PCIE0);
    PCMSK0 = ((1U << RESET_BUTTON) | (1U << PREVIOUS_BUTTON) | (1U << NEXT_BUTTON));
    TCCR0B = (1U << CS00) | (1U << CS02);
    TCCR1B = (1U << CS10) | (1U << CS12) | (1 << WGM12);
    OCR1A  = 256U;
    asm("SEI");
}

/*******************************************************************************
 * @brief Generates system reset; the state is set to STATE_OFF, the LED and
 *        Timer 1 are disabled and the corresponding timer counter is cleared.
 ******************************************************************************/
static void reset_system(void)
{
    TIMER1_DISABLE;
    LED_OFF;
    state          = STATE_OFF;
    timer1_counter = 0x00;
}

/*******************************************************************************
 * @brief Updates the current whenever one of the buttons is pressed.
 ******************************************************************************/
static void update_state(void)
{
    if (RESET_BUTTON_IS_PRESSED) { reset_system(); }
    else
    {
        switch (state)
        {
            case STATE_OFF:
                if (NEXT_STATE)          { state = STATE_BLINK; }
                else if (PREVIOUS_STATE) { state = STATE_ON; }
                break;
            case STATE_BLINK:
                if (NEXT_STATE)          { state = STATE_ON; }
                else if (PREVIOUS_STATE) { state = STATE_OFF; }
                break;
            case STATE_ON:
                if (NEXT_STATE)          { state = STATE_OFF; }
                else if (PREVIOUS_STATE) { state = STATE_BLINK; }
                break;
            default:
               reset_system();
               break;
        }

        if (state == STATE_BLINK) { TIMER1_ENABLE; }
        else                      { TIMER1_DISABLE; }

        if (state == STATE_OFF)     { LED_OFF; }
        else if (state == STATE_ON) { LED_ON; }
    }
}

/*******************************************************************************
 * @brief Updates the state machine whenever a button is pressed. PIN change
 *        interrupts are disabled for 300 ms after pressdown to mitigate
 *        effects of contact bounces.
 ******************************************************************************/
ISR (PCINT0_vect)
{
    PORTB_PCI_DISABLE;
    TIMER0_ENABLE;
    update_state();
}

/*******************************************************************************
 * @brief Enables PIN change interrupts on PORTB 300 ms after pressdown in
 *        order to mitigate effects of contact bounces.
 ******************************************************************************/
ISR (TIMER0_OVF_vect)
{
    if (++timer0_counter >= TIMER0_COUNTER_MAX_300MS)
    {
        PORTB_PCI_ENABLE;
        TIMER0_DISABLE;
        timer0_counter = 0x00;
    }
}

/*******************************************************************************
 * @brief Toggles the LED every 100 ms whenever Timer 1 is enabled.
 ******************************************************************************/
ISR (TIMER1_COMPA_vect)
{
    if (++timer1_counter >= TIMER1_COUNTER_MAX_100MS)
    {
        LED_TOGGLE;
        timer1_counter = 0x00;
    } 
 }

/*******************************************************************************
 * @brief Runs the state machine continuously.
 ******************************************************************************/
int main(void)
{
    setup();

    while (1) 
    {
    }
}

