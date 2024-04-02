--------------------------------------------------------------------------------
-- @brief Test bench for module vhdl_net1. Each combination 0000 - 1111 of
--        inputs abcd is tested during 10 ns each, hence the simulation time
--        is 160 ns.
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity vhdl_net1_tb is
end entity;

architecture behaviour of vhdl_net1_tb is

--------------------------------------------------------------------------------
-- @brief Signals used to simulate the vhdl_net1 module. These signals are
--       connected to ports abcd and xy in the vhdl_net1 module. By doing this, 
--       we can control the input and check the corresponding output. 
--       Each signal is initialized to 0.
--      
-- @param abcd Inputs implemented as a single 4-bit vector, where a = abcd(3).
-- @param xy   Outputs implemented as a 2-bit vector, where x = xy(1).
-------------------------------------------------------------------------------
signal abcd: std_logic_vector(3 downto 0) := "0000";
signal xy  : std_logic_vector(1 downto 0) := "00";
begin

    --------------------------------------------------------------------------------
    -- @brief Creates an instance of module vhdl_net1 named sim_instance and 
    --        connects its ports to signals abcd and xy for simulation purposes.
    --------------------------------------------------------------------------------
    sim_instance: entity work.vhdl_net1
    port map(abcd(3), abcd(2), abcd(1), abcd(0), xy(1), xy(0));
    
    --------------------------------------------------------------------------------
    -- @brief Tests the vhdl_net1 with all 16 combinations 0000 - 1111 of inputs
    --        abcd during 10 ns each (via the abcd signal). The process is halted
    --        when every single combination has been tested, else the simulation
    --        would start over.
    --
    -- @note A for loop is used to provide every integer in the range [0, 15].
    --       The integer is converted to four bits, for instance, the integer 7
    --       is converted to 0111. These four bits are assigned to signals
    --       abcd, which are connected to abcd of vhdl_net1. We wait 10 ns to
    --       allow the signals to pass through the vhdl_net1 instance.
    --------------------------------------------------------------------------------
    sim_process: process is
    begin
        for i in 0 to 15 loop                            -- 0 <= i <= 15
            abcd <= std_logic_vector(to_unsigned(i, 4)); -- abcd = i (converted to four bits)
            wait for 10 ns;                              -- Waits for 10 ns before i++
        end loop;                                        
        wait;                                            -- Halts the process when finished
    end process;

end architecture;