--------------------------------------------------------------------------------
-- @brief Implementation of generic design for toggling an arbitrary number
--        of LEDs via a corresponding number of buttons.
--
-- @tparam DEVICE_COUNT The number of LEDs and corresponding buttons used
--                      in the design (default = 3).
--
-- @param clock    50 MHz system clock.
-- @param reset_n  Asynchronous inverting reset signal connected to a button.
-- @param button_n Buttons used for toggling LEDs.
-- @param led      LEDs toggled by the corresponding buttons.
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity led_toggle_generic is
    generic(DEVICE_COUNT: natural range 1 to 4 := 3);
    port(clock, reset_n : in std_logic;
         button_n       : in std_logic_vector(DEVICE_COUNT - 1 downto 0);
         led            : out std_logic_vector(DEVICE_COUNT - 1 downto 0));
end entity;

architecture behaviour of led_toggle_generic is

--------------------------------------------------------------------------------
-- @brief Signals used internally for the button and LED.
--
-- @param reset_s2_n        Synchronized inverting reset signal.
-- @param button_pressed_s2 Synchronized signals indicating pressdown of 
--                          the buttons (on falling edge).
-- @param led_s             Internal representation of the LEDs.
--------------------------------------------------------------------------------
signal reset_s2_n       : std_logic := '0';
signal button_pressed_s2: std_logic_vector(DEVICE_COUNT - 1 downto 0) := (others => '0');
signal led_s            : std_logic_vector(DEVICE_COUNT - 1 downto 0) := (others => '0');

begin

    --------------------------------------------------------------------------------
    -- @brief Implements meta stability prevention via synchronized input signals.
    --------------------------------------------------------------------------------
    meta_prev1: entity work.meta_prev
    generic map(DEVICE_COUNT)
    port map(clock, reset_n, button_n, reset_s2_n, button_pressed_s2);
    
    --------------------------------------------------------------------------------
    -- @brief Updates the LED signals on rising clock edge and system reset. Each 
    --        LED is toggled whenever the corresponding button is pressed. All LEDs
    --        are immediately disabled on system reset.
    --------------------------------------------------------------------------------
    LED_PROCESS: process(clock, reset_s2_n) is
    begin
        if (reset_s2_n = '0') then
            led_s <= (others => '0');
        elsif (rising_edge(clock)) then
            for i in 0 to DEVICE_COUNT -  1 loop
                if (button_pressed_s2(i) = '1') then
                    led_s(i)  <= not led_s(i);
                end if;
            end loop;
        end if;
    end process;
    
    --------------------------------------------------------------------------------
    -- @brief Writes the led_s value to the LEDs.
    --------------------------------------------------------------------------------
    led <= led_s;

end architecture;