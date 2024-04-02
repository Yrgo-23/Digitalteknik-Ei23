--------------------------------------------------------------------------------
-- @brief Implementation of a net consisting of inputs abcd and outputs xy.
--
-- @param abcd[in] Input bits.
-- @param xy[out]  Output bits.
--
-- @note The truth table of the net is shown below:
--
--        | abcd | xy |
--        | 0000 | 10 |
--        | 0001 | 10 |
--        | 0010 | 00 |
--        | 0011 | 00 |
--        | 0100 | 11 |
--        | 0101 | 11 |
--        | 0110 | 01 |
--        | 0111 | 01 |
--        | 1000 | 10 |
--        | 1001 | 00 |
--        | 1010 | 10 |
--        | 1011 | 00 |
--        | 1100 | 11 |
--        | 1101 | 11 |
--        | 1110 | 11 |
--        | 1111 | 11 |
--
--       The following equations have been derived for outputs x and y:
--           - x = ab + a'c' + ad'
--           - y = b
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity vhdl_net1 is
    port(a, b, c, d: in std_logic;
         x, y      : out std_logic);
end entity;

architecture behaviour of vhdl_net1 is
begin
    x <= (a and b) or ((not a) and (not c)) or (a and (not d));
    y <= b;
end architecture;