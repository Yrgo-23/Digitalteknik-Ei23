--------------------------------------------------------------------------------
-- @brief Package containing miscellaneous definitions.
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package definitions is

--------------------------------------------------------------------------------
-- @brief Type for implementing the different states of the FSM.
--------------------------------------------------------------------------------
type state_t is (STATE_OFF, STATE_BLINK, STATE_ON);

--------------------------------------------------------------------------------
-- @brief Subtype for selecting timer frequency between 0.1 Hz - 10 Hz.
--------------------------------------------------------------------------------
subtype timer_frequency_t is natural range 5000000 to 500000000;

--------------------------------------------------------------------------------
-- @brief System clock frequency in Hz (corresponds to 50 MHz).
--------------------------------------------------------------------------------
constant CLOCK_FREQUENCY_HZ : natural := 50000000;

--------------------------------------------------------------------------------
-- @brief Parameters for setting the frequency of timer circuits.
--------------------------------------------------------------------------------
constant TIMER_FREQUENCY_1HZ   : timer_frequency_t := CLOCK_FREQUENCY_HZ;
constant TIMER_FREQUENCY_2HZ   : timer_frequency_t := CLOCK_FREQUENCY_HZ / 2;
constant TIMER_FREQUENCY_5HZ   : timer_frequency_t := CLOCK_FREQUENCY_HZ / 5;
constant TIMER_FREQUENCY_10HZ  : timer_frequency_t := CLOCK_FREQUENCY_HZ / 10;
constant TIMER_FREQUENCY_100mHz: timer_frequency_t := CLOCK_FREQUENCY_HZ * 10;

end package;