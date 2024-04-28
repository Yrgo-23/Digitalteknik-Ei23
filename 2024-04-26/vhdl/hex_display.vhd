--------------------------------------------------------------------------------
-- @brief System for displaying two hexadecimal numbers 0 - F via hex displays.
--        The number displayed on each display is entered in 4-bit binary form
--        via four slide switches.
--
--
-- @param inputs[in] Eight slide-switches used for entering two 4-bit numbers.
-- @param hex1[out]  The first hex display, controlled by inputs[7:4].
-- @param hex0[out]  The second hex display, controlled by inputs[3:0].
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity hex_display is
    port(input     : in std_logic_vector(7 downto 0);
         hex0, hex1: out std_logic_vector(6 downto 0));
end entity;

architecture behaviour of hex_display is
begin

    --------------------------------------------------------------------------------
    -- @brief Implements hardware for hex0, which is controlled by inputs[3:0]. 
    --------------------------------------------------------------------------------
    display0: entity work.display
    port map(input(3 downto 0), hex0);
    
    --------------------------------------------------------------------------------
    -- @brief Implements hardware for hex1, which is controlled by inputs[7:4]. 
    --------------------------------------------------------------------------------
    display1: entity work.display
    port map(input(7 downto 4), hex1);

end architecture;
