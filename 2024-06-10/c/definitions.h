/*******************************************************************************
 * @brief Definitions used for the project.
 ******************************************************************************/
#ifndef DEFINITIONS_H_
#define DEFINITIONS_H_

#include <avr/io.h>
#include <avr/interrupt.h>

/*******************************************************************************
 * @brief Definitions for devices.
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
 #define LED             PORTB1
 #define RESET_BUTTON    PORTB3
 #define PREVIOUS_BUTTON PORTB4
 #define NEXT_BUTTON     PORTB5

/*******************************************************************************
 * @brief Definitions for controlling the LED.
 ******************************************************************************/
 #define LED_ON     PORTB |= (1U << LED)
 #define LED_OFF    PORTB &= ~(1U << LED)
 #define LED_TOGGLE PINB |= (1U << LED)

/*******************************************************************************
 * @brief Definitions for reading the button inputs.
 ******************************************************************************/
 #define NEXT_BUTTON_IS_PRESSED     (PINB & (1U << NEXT_BUTTON))
 #define PREVIOUS_BUTTON_IS_PRESSED (PINB & (1U << PREVIOUS_BUTTON))
 #define RESET_BUTTON_IS_PRESSED    (PINB & (1U << RESET_BUTTON))

/*******************************************************************************
 * @brief Definitions for signaling update to next or previous state.
 ******************************************************************************/
 #define NEXT_STATE     (NEXT_BUTTON_IS_PRESSED && !PREVIOUS_BUTTON_IS_PRESSED)
 #define PREVIOUS_STATE (!NEXT_BUTTON_IS_PRESSED && PREVIOUS_BUTTON_IS_PRESSED)

/*******************************************************************************
 * @brief Definitions for enabling/disabling PIN change interrupts on PORTB.
 ******************************************************************************/
#define PORTB_PCI_ENABLE  PCICR = (1U << PCIE0)
#define PORTB_PCI_DISABLE PCICR &= ~(1U << PCIE0)

/*******************************************************************************
 * @brief Definitions for controlling Timer 0.
 ******************************************************************************/
 #define TIMER0_ENABLE  TIMSK0 = (1U << TOIE0)
 #define TIMER0_DISABLE TIMSK0 = 0x00

/*******************************************************************************
 * @brief Definitions for controlling Timer 1.
 ******************************************************************************/
 #define TIMER1_ENABLE  TIMSK1 = (1U << OCIE1A)
 #define TIMER1_DISABLE TIMSK1 = 0x00

/*******************************************************************************
 * @brief Interrupt count on Timer 0 that corresponds to 300 ms.
 ******************************************************************************/
 #define TIMER0_COUNTER_MAX_300MS 18U

/*******************************************************************************
 * @brief Interrupt count on Timer 0 that corresponds to 300 ms.
 ******************************************************************************/
 #define TIMER1_COUNTER_MAX_100MS 6U

/*******************************************************************************
 * @brief Enumeration for implementing the different states of the FSM.
 ******************************************************************************/
 typedef enum { STATE_OFF, STATE_BLINK, STATE_ON } state_t;

#endif /* DEFINITIONS_H_ */