--------------------------------------------------------------------------------
-- @brief Design for toggling a LED whenever a button is pressed.
--        A reset signal is implemented to generate a system reset.
--
-- @param clock[in]    50 MHz system clock.
-- @param reset_n[in]  Inverting reset connected to a push button.
-- @param button_n[in] Inverting button used to toggle the LED.
-- @param led[out]     The LED to toggle whenever button_n is pressed.
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity led_toggle is
    port(clock, reset_n, button_n: in std_logic;
         led                     : out std_logic);
end entity;

architecture behaviour of led_toggle is

--------------------------------------------------------------------------------
-- @brief Signals used internally for the button and LED.
--
-- @param button_s1_n    The previous value of button_n.
-- @param button_pressed Signal indicating pressdown of button_n (falling edge).
-- @param led_s          Internal representation of the LED value.
--------------------------------------------------------------------------------
signal button_s1_n          : std_logic := '1';
signal button_pressed, led_s: std_logic := '0';
begin

    --------------------------------------------------------------------------------
    -- @brief Updates the button signals on rising clock edge and system reset.
    --        The button is pressed if the previous value (button_s1_n) is high
    --        while the current value (button_n) is low.
    --------------------------------------------------------------------------------
    BUTTON_PROCESS: process(clock, reset_n) is
    begin
        if (reset_n = '0') then
            button_s1_n    <= '1';
            button_pressed <= '0';
        elsif (rising_edge(clock)) then
            if (button_n = '0' and button_s1_n = '1') then
                button_pressed <= '1';
            else
                button_pressed <= '0';
            end if;
            button_s1_n <= button_n;
        end if;
    end process;
    
    --------------------------------------------------------------------------------
    -- @brief Updates the LED signal on rising clock edge and system reset. The LED
    --        is toggled whenever the button is pressed. The LED is immediately
    --        disabled on system reset.
    --------------------------------------------------------------------------------
    LED_PROCESS: process(clock, reset_n) is
    begin
        if (reset_n = '0') then
            led_s <= '0';
        elsif (rising_edge(clock)) then
            if (button_pressed = '1') then
                led_s <= not led_s;
            end if;
        end if;
    end process;
    
    --------------------------------------------------------------------------------
    -- @brief Writes the led_s value to the LED.
    --------------------------------------------------------------------------------
    led <= led_s;

end architecture;

