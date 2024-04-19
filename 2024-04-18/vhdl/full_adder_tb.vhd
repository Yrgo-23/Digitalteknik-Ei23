--------------------------------------------------------------------------------
-- @brief Test bench for the full_adder module. Each combination 000 - 111 of
--        inputs {a, b, cin} is tested during 10 ns, hence the simulation time
--        is 160 ns.
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity full_adder_tb is
end entity;


architecture behaviour of full_adder_tb is

--------------------------------------------------------------------------------
-- @brief Signals used for simulating the full adder.
--------------------------------------------------------------------------------
signal inputs : std_logic_vector(2 downto 0) := "000";
signal outputs: std_logic_vector(1 downto 0) := "00";

begin

    --------------------------------------------------------------------------------
    -- @brief Creates a full adder and connects signals for simulation.
    --------------------------------------------------------------------------------
    sim_instance: entity work.full_adder
    port map(inputs, outputs);
    
    --------------------------------------------------------------------------------
    -- @brief Tests all combinations 000 - 111 of inputs during 10 ns each.
    --        After the simulation is finished, the process is halted, else the
    --        simulation would start over.
    --------------------------------------------------------------------------------
    sim_process: process is
    begin
        for i in 0 to 7 loop
            inputs <= std_logic_vector(to_unsigned(i, 3));
            wait for 10 ns;
        end loop;
        wait;
    end process;

end architecture;