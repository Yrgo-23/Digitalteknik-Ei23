--------------------------------------------------------------------------------
-- @brief Test bench for top module comparator_4bit. All 16 combinations of
--        inputs abcd = 0000 - 1111 are tested during 10 ns each. Hence the 
--        total simulation time is 160 ns.
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity comparator_4bit_tb is
end entity;

architecture behaviour of comparator_4bit_tb is

--------------------------------------------------------------------------------
-- @brief Signals used to simulate the top module.
--------------------------------------------------------------------------------
signal abcd: std_logic_vector(3 downto 0) := (others => '0');
signal xyz : std_logic_vector(2 downto 0) := (others => '0');
begin

    --------------------------------------------------------------------------------
    -- @brief Creates an instance of the top module and connects its ports to
    --        signals abcd and xyzv for simulation.
    --------------------------------------------------------------------------------
    sim_instance: entity work.comparator_4bit
    port map(abcd, xyz);
    
    --------------------------------------------------------------------------------
    -- @brief Tests the top module with all 16 combinations 0000 - 1111 of inputs
    --        abcd during 10 ns each. The process is halted after every single 
    --        combination has been tested, else it would start all over.
    --------------------------------------------------------------------------------
    sim_process: process is
    begin
        for i in 0 to 15 loop
            abcd <= std_logic_vector(to_unsigned(i, 4));
            wait for 10 ns;
        end loop;
        wait;
    end process;

end architecture;