------------------------------------------------------------------------------------------------
-- @brief Test bench for the or_gate module. Each combination 00 - 11 of inputs ab is tested
--        during 10 ns each, hence the simulation time amounts to 40 ns.
------------------------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity or_gate_tb is
end entity;

architecture behaviour of or_gate_tb is

 --------------------------------------------------------------------------------
 -- @brief Signals used to simulate the or_gate module. These signals are
 --        connected to ports ab and x in the or_gate module.
 --        By doing this, we can control the input and check the output of
 --        module or_gate. Each signal is initialized to 0.
 --------------------------------------------------------------------------------
signal a, b, x: std_logic := '0';
begin

    --------------------------------------------------------------------------------
    -- @brief Creates an instance of module or_gate and connects its ports to
    --        local signals ab and x for simulation purposes.
    --------------------------------------------------------------------------------
    sim_instance: entity work.or_gate
    port map(a, b, x);
    
    --------------------------------------------------------------------------------
    -- @brief Tests or_gate with all four combinations 00 - 11 of inputs ab during
    --        10 ns each (via the local signals with the same name). After all
    --        combinations have been tested the process is halted, else it would
    --        start all over again.
    --------------------------------------------------------------------------------
    SIM_PROCESS: process is
    begin
        for i in 0 to 3 loop                               -- Iterates i from 0 to 3.
            (a, b) <= std_logic_vector(to_unsigned(i, 2)); -- Converts i to 2 bits.
            wait for 10 ns;                                -- Waits for 10 ns;
        end loop;                                          
        wait;                                              -- Halts process when finished.
    end process;

end architecture;