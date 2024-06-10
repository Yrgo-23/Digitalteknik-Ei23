--------------------------------------------------------------------------------
-- @brief Implementation of timer circuits with selectable frequency in the
--        range 0.1 Hz - 10 Hz.
--
-- @tparam FREQUENCY The timer frequency (default = 1 Hz).
--
-- @param clock[in]      50 MHz system clock.
-- @param reset_s2_n[in] Inverting reset signal.
-- @param enabled[in]    Indicates if the timer is enabled.
-- @param elapsed[out]   Indicates if the timer has elapsed.
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.definitions.all;

entity timer is
    generic(FREQUENCY: timer_frequency_t := TIMER_FREQUENCY_1HZ);
    port(clock, reset_s2_n, enabled: in std_logic;
         elapsed                   : out std_logic);
end entity;

--------------------------------------------------------------------------------
-- @brief Signals and constants used for the counter.
-- 
-- @param COUNTER_MAX Counter max value.
--    
-- @param counter Counter register (counts clock pulses from 0 to COUNTER_MAX.
--
-- @note The timer elapsed when counter = COUNTER_MAX.
--------------------------------------------------------------------------------
architecture behaviour of timer is
constant COUNTER_MAX: timer_frequency_t := FREQUENCY;
signal counter      : natural := 0;
begin
        
    --------------------------------------------------------------------------------
    -- @brief Increments the counter on rising edge of the clock (if the timer is
    --        enabled). The timer elapses when counter >= COUNTER_MAX, then the
    --        elapsed signal is set and the counter is cleared. Both the counter
    --        and the elapsed signal are cleared on system reset. The elapsed
    --        signal is always cleared when the timer is disabled.
    --------------------------------------------------------------------------------
    COUNTER_PROCESS: process (clock, reset_s2_n) is
    begin
        if (reset_s2_n = '0') then
            elapsed <= '0';
            counter <= 0;
        elsif (rising_edge(clock)) then
            if (enabled = '1') then
                counter <= counter + 1;
                if (counter >= COUNTER_MAX) then
                    elapsed <= '1';
                    counter <= 0;
                else
                    elapsed <= '0';
                end if;
            else
                elapsed <= '0';
            end if;
        end if;
    end process;
    

end architecture;