--------------------------------------------------------------------------------
-- @brief Design for toggling a LED whenever a button is pressed.
--        A reset signal is implemented to generate a system reset.
--        Metastability prevention is implemented via D flip flops.
--
-- @param clock[in]    50 MHz system clock.
-- @param reset_n[in]  Inverting reset connected to a push button.
-- @param button_n[in] Inverting button used to toggle the LED.
-- @param led[out]     The LED to toggle whenever button_n is pressed.
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity led_toggle_meta_prev is
    port(clock, reset_n, button_n: in std_logic;
         led                     : out std_logic);
end entity;

architecture behaviour of led_toggle_meta_prev is

--------------------------------------------------------------------------------
-- @brief Signals used internally for the button and LED.
--
-- @param reset_s2_n        Synchronized inverting reset signal.
-- @param button_pressed_s2 Synchronized signal indicating pressdown of 
--                          button_n (falling edge).
-- @param led_s             Internal representation of the LED value.
--------------------------------------------------------------------------------
signal reset_s2_n              : std_logic := '1';    
signal button_pressed_s2, led_s: std_logic := '0';       
begin

    --------------------------------------------------------------------------------
    -- @brief Implements meta stability prevention via synchronized input signals.
    --------------------------------------------------------------------------------
    meta_prev1: entity work.meta_prev
    port map(clock, reset_n, button_n, reset_s2_n, button_pressed_s2);
    
    --------------------------------------------------------------------------------
    -- @brief Updates the LED signal on rising clock edge and system reset. The LED
    --        is toggled whenever the button is pressed. The LED is immediately
    --        disabled on system reset.
    --------------------------------------------------------------------------------
    LED_PROCESS: process(clock, reset_s2_n) is
    begin
        if (reset_s2_n = '0') then
            led_s <= '0';
        elsif (rising_edge(clock)) then
            if (button_pressed_s2 = '1') then
                led_s <= not led_s;
            end if;
        end if;
    end process;
    
    --------------------------------------------------------------------------------
    -- @brief Writes the led_s value to the LED.
    --------------------------------------------------------------------------------
    led <= led_s;

end architecture;

