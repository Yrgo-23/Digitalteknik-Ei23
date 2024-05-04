--------------------------------------------------------------------------------
-- @brief Design of a D latch.
--
-- @param d[in]      D latch input.
-- @param enable[in] D latch lock signal (1 = latch open, 0 = latch locked).
-- @param q[out]     D latch output.
-- @param q_n[out]   Inverse of the D latch output.
--
-- The function of the D latch is as follows:
--     - enable = 0 => latch locked => q = q, q_n = q_n
--     - enable = 1 => latch open   => q = d, q_n = ~d
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity d_latch is
    port(d, enable: in std_logic;
         q, q_n   : out std_logic);
end entity;

architecture behaviour of d_latch is

--------------------------------------------------------------------------------
-- @brief Internal representation of D latch output Q.
--------------------------------------------------------------------------------
signal q_s: std_logic := '0';

begin

   --------------------------------------------------------------------------------
   -- @brief Updates q_s whenever the enable signal is high.
   --------------------------------------------------------------------------------
   q_s <= d when enable = '1' else q_s;

   --------------------------------------------------------------------------------
   -- @brief Sets the latch output (and its inverse) via the q_s signal.
   -------------------------------------------------------------------------------- 
   q   <= q_s; 
   q_n <= not q_s;  
   
end architecture;