--------------------------------------------------------------------------------
-- @brief Test bench for the or_gate module.
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 

entity or_gate_tb is
end entity;

architecture behaviour of or_gate_tb is

--------------------------------------------------------------------------------
-- @brief Creates signals to connect to ports.
--------------------------------------------------------------------------------
signal a, b, x: std_logic := '0';
begin

    --------------------------------------------------------------------------------
    -- @brief Creates an OR gate and connects our signals for testing.
    --------------------------------------------------------------------------------
    sim_instance: entity work.or_gate
    port map(a, b, x);
             
    --------------------------------------------------------------------------------
    -- @brief Tests each combination 00 - 11 of input during 10 ns.
    --        The process if halted after simulation is finished.
    --------------------------------------------------------------------------------
    sim_process: process is
    begin
        for i in 0 to 3 loop
            (a, b) <= std_logic_vector(to_unsigned(i, 2));
            wait for 10 ns;
        end loop;
        wait; 
    end process;


end architecture;

