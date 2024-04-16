--------------------------------------------------------------------------------
-- @brief Design of a 8-to-1 multiplexer.
--
-- @param inputs[in] Multiplexer inputs connected to slide switches.
-- @param sel_n[in]  Inverted selector bits connected to active low buttons.
-- @param x[out]     Multiplexer output connected to a LED.
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity mux_8_to_1 is
    port(inputs: in std_logic_vector(7 downto 0);
         sel_n : in std_logic_vector(2 downto 0);
         x     : out std_logic);
end entity;

--------------------------------------------------------------------------------
-- @note The selector bits are connected to active low buttons, i.e. the input
--       is low when pressed, hence the inverse values are used internally.
--------------------------------------------------------------------------------
architecture behaviour of mux_8_to_1 is
signal sel: std_logic_vector(2 downto 0) := (others => '1');
begin

    --------------------------------------------------------------------------------
    -- @brief Process that updates the output upon change of the selector signals.
    --------------------------------------------------------------------------------
    output_process: process (sel) is
    begin
        case (sel) is
            when "000"  => x <= inputs(0);
            when "001"  => x <= inputs(1);
            when "010"  => x <= inputs(2);
            when "011"  => x <= inputs(3);
            when "100"  => x <= inputs(4);
            when "101"  => x <= inputs(5);
            when "110"  => x <= inputs(6);
            when "111"  => x <= inputs(7);
            when others => x <= '0';
        end case;
    end process;
    
    sel <= not sel_n;

end architecture;