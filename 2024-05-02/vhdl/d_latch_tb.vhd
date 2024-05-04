--------------------------------------------------------------------------------
-- @brief Test bench for the d_latch module. The simulation is performed twice
--        to check the latch output when the previous output is high and low.
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity d_latch_tb is
end entity;

architecture behaviour of d_latch_tb is

--------------------------------------------------------------------------------
-- @brief Signals used for testing the d_latch module.
--
-- @param d      D latch input.
-- @param enable D latch lock signal (1 = latch open, 0 = latch locked).
-- @param q      D latch output.
-- @param q_n    Inverse of D latch output.
--------------------------------------------------------------------------------
signal d, enable, q, q_n: std_logic := '0';

begin

    --------------------------------------------------------------------------------
    -- @brief Creates a D latch and connects signals to its ports for simulation.
    --------------------------------------------------------------------------------
    sim_instance: entity work.d_latch
    port map(d, enable, q, q_n);
    
    --------------------------------------------------------------------------------
    -- @brief Tests all combinations 00 - 11 of inputs {enable, d} twice to validate
    --        the latch function both when the precious output is high and low.
    --------------------------------------------------------------------------------
    sim_process: process is
    begin
       for i in 0 to 1 loop 
          for j in 0 to 3 loop
              (enable, d) <= std_logic_vector(to_unsigned(j, 2));
              wait for 10 ns;
          end loop; 
       end loop; 
       wait;
    end process;

end architecture;