/*******************************************************************************
 * @brief Implementation of a simple FSM (Finite State Machine) consisting of
 *        four states STATE_0, STATE_1, STATE_2 and STATE_3. 
 *        A button connected to PIN 13 (PORTB5) is used to update the state 
 *        to next. A button connected to PIN 12 (PORTB4) is used to reset
 *        the FSM. A LED connected to PIN 9 (PORTB1) is enabled in STATE_3. 
 *       
 * @note The FSM is circular, hence the state after STATE_3 is STATE_0.
 ******************************************************************************/
#include <avr/io.h>
#include <avr/interrupt.h>

/*******************************************************************************
 * @brief Definitions used for the project.
 ******************************************************************************/
#define LED PORTB1    
#define BUTTON PORTB5
#define RESET_BUTTON PORTB4

#define LED_ON            PORTB |= (1U << LED)
#define LED_OFF           PORTB &= ~(1U << LED)
#define BUTTON_IS_PRESSED (PINB & (1U << BUTTON))
#define SYSTEM_RESET      (PINB & (1U << RESET_BUTTON))

/*******************************************************************************
 * @brief Enumeration for implementing the different states of the FSM.
 ******************************************************************************/
typedef enum { STATE_0, STATE_1, STATE_2, STATE_3 } state_t;

/*******************************************************************************
 * @brief Variable holding the current state of the FSM.
 ******************************************************************************/
 static state_t state = STATE_0;

/*******************************************************************************
 * @brief Initializes the system. The PINs are set up and PIN change interrupt
 *        is enabled on the button PINs.
 ******************************************************************************/
static void setup(void)
{
    DDRB   = (1U << LED);
    PORTB  = (1U << BUTTON) | (1U << RESET_BUTTON);
    PCICR  = (1U << PCIE0);
    PCMSK0 = (1U << BUTTON | (1U << RESET_BUTTON));
    asm("SEI");
}

/*******************************************************************************
 * @brief Updates the state machine whenever a button is pressed.
 ******************************************************************************/
static void update_state(void)
{
    if (SYSTEM_RESET)
    {
        state = STATE_0;
    }
    else if (BUTTON_IS_PRESSED)
    {
        switch (state)
        {
            case STATE_0:
                state = STATE_1;
                break;
            case STATE_1:
                state = STATE_2;
                break;
            case STATE_2:
                state = STATE_3;
                break;
            default:
                state = STATE_0;
                break;
        }
    }
    if (state == STATE_3) { LED_ON; }
    else { LED_OFF; }
}

/*******************************************************************************
 * @brief Updates the state machine whenever a button is pressed.
 ******************************************************************************/
ISR (PCINT0_vect)
{
    update_state();
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

