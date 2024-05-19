/*******************************************************************************
 * @brief Contains miscellaneous definitions.
 ******************************************************************************/
package definitions;

/*******************************************************************************
 * @brief System clock frequency in Hz (corresponds to 50 MHz).
 ******************************************************************************/
localparam CLOCK_FREQUENCY_HZ = 50000000;

/*******************************************************************************
 * @brief Parameters for setting the frequency of timer circuits.
 ******************************************************************************/
typedef enum
{
    TIMER_FREQUENCY_100MHZ = CLOCK_FREQUENCY_HZ * 10,
    TIMER_FREQUENCY_1HZ   = CLOCK_FREQUENCY_HZ,
    TIMER_FREQUENCY_2HZ   = CLOCK_FREQUENCY_HZ / 2,
    TIMER_FREQUENCY_5HZ   = CLOCK_FREQUENCY_HZ / 5,
    TIMER_FREQUENCY_10HZ  = CLOCK_FREQUENCY_HZ / 10  
} timer_frequency_t;

endpackage 