------------------------------------------------------------------------------------------------
-- @brief Implementation of an OR gate.
--
-- @param a[in]  First input bit of the OR gate.
-- @param b[in]  Second input bit of the OR gate.
-- @param x[out] Output of the OR gate.
------------------------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity or_gate is
    port(a, b: in std_logic; 
         x   : out std_logic);
end entity;

architecture behaviour of or_gate is
begin
    x <= a or b;
end architecture;