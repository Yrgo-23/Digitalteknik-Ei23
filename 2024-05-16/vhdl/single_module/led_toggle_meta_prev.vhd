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
-- @brief Signals used internally for metastability prevention, event detection,
--        toggling the led etc. Two signals are implemented for the reset signal
--        and the button respectively to create two flip flops for each. A third
--        button signal is created to detect pressdown on falling edge.
--------------------------------------------------------------------------------
signal reset_s1_n, reset_s2_n               : std_logic := '1';
signal button_s1_n, button_s2_n, button_s3_n: std_logic := '1';
signal button_pressed_s2                    : std_logic := '0';
signal led_s                                : std_logic := '0';

begin

    --------------------------------------------------------------------------------
    -- @brief Synchronizes the reset signals at rising edge of the system clock.
    --        All reset signals are immediately cleared upon system reset.
    --------------------------------------------------------------------------------
    RESET_PROCESS: process (clock, reset_n) is
    begin
        if (reset_n = '0') then
            reset_s1_n <= '0';
            reset_s2_n <= '0';
        elsif (rising_edge(clock)) then
            reset_s1_n <= '1';
            reset_s2_n <= reset_s1_n;
        end if;
    end process;
    
    --------------------------------------------------------------------------------
    -- @brief Synchronizes the button signals at rising edge of the system clock.
    --        All button signals are immediately set upon system reset.
    --------------------------------------------------------------------------------
    BUTTON_PROCESS: process (clock, reset_s2_n) is
    begin
        if (reset_s2_n = '0') then
            button_s1_n <= '1';
            button_s2_n <= '1';
            button_s3_n <= '1';
        elsif (rising_edge(clock)) then
            button_s1_n <= button_n;
            button_s2_n <= button_s1_n;
            button_s3_n <= button_s2_n;
        end if;
    end process;
    
    --------------------------------------------------------------------------------
    -- @brief Updates the LED signal on rising clock edge and system reset. The LED
    --        is toggled whenever the button is pressed. The LED is immediately
    --        disabled on system reset.
    --------------------------------------------------------------------------------
    LED_PROCESS: process (clock, reset_s2_n) is
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
    -- @brief button_n is pressed if button_s2_n (the "current" input) is 0 and
    --       button_s3_n (the "previous" input) is 1.
    --------------------------------------------------------------------------------
    button_pressed_s2 <= (not button_s2_n) and button_s3_n;
    
    --------------------------------------------------------------------------------
    -- @brief Writes the led_s value to the LED.
    --------------------------------------------------------------------------------
    led <= led_s;
    
end architecture; 