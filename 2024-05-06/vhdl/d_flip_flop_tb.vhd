--------------------------------------------------------------------------------
-- @brief Test bench for the d_flip flop module. The simulation is performed 
--        four times to check the flip flop output when the previous output is 
--        high and low, both during normal execution and system reset. 
--        The total simulation time is therefore 160 ns.
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity d_flip_flop_tb is
end entity;

architecture behaviour of d_flip_flop_tb is

--------------------------------------------------------------------------------
-- @brief Sets the clock period to 10 ns.
--------------------------------------------------------------------------------
constant CLOCK_PERIOD: time := 10 ns;

--------------------------------------------------------------------------------
-- @brief Signals used for connecting to the ports of the d_flip_flop module.
--------------------------------------------------------------------------------
signal clock, reset_n, d, enable: std_logic := '0';
signal q, q_n                   : std_logic := '0';

--------------------------------------------------------------------------------
-- @brief Indicates if the simulation is finished.
--------------------------------------------------------------------------------
signal simulation_finished: boolean := false;

begin

    --------------------------------------------------------------------------------
    -- @brief Creates a D flip flop and connects signals to its ports for simulation.
    --------------------------------------------------------------------------------
    sim_instance: entity work.d_flip_flop
    port map(clock, reset_n, d, enable, q, q_n);
    
    --------------------------------------------------------------------------------
    -- @brief Toggles the clock signal every half clock period.
    --------------------------------------------------------------------------------
    CLOCK_PROCESS: process is
    begin
        if (not simulation_finished) then
            clock <= not clock;
            wait for CLOCK_PERIOD / 2;
        end if;
    end process;
    
    --------------------------------------------------------------------------------
    -- @brief Simulates system reset after eight clock cycles.
    --------------------------------------------------------------------------------
    RESET_PROCESS: process is
    begin
        reset_n <= '1';
        wait for CLOCK_PERIOD * 8;
        reset_n <= '0';
        wait for CLOCK_PERIOD * 8;
        reset_n <= '1';
    end process;
    
    --------------------------------------------------------------------------------
    -- @brief Simulates all input combinations 00 - 11 of {enable, d} four times
    --        to check the locking mechanism when the output is high and low, both
    --        during normal execution and during system reset. Each combination
    --        is tested during 10 ns, hence the the total simulation time is 
    --        4 x 4 x 10 ns = 160 ns.
    --------------------------------------------------------------------------------
    INPUT_PROCESS: process is
    begin
        for i in 0 to 3 loop
            for j in 0 to 3 loop
                (enable, d) <= std_logic_vector(to_unsigned(j, 2));
                wait for CLOCK_PERIOD;
            end loop;
        end loop;
        simulation_finished <= true;
    end process;

end architecture;