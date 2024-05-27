--------------------------------------------------------------------------------
-- @brief Implementation of generic design for toggling three LEDs via
--        associated timers. Each timer can be toggled via pressdowns of a.
--        associated push button.
--
-- @param clock    50 MHz system clock.
-- @param reset_n  Asynchronous inverting reset signal connected to a button.
-- @param button_n Buttons used for toggling timers.
-- @param led      LEDs toggled by via associated timers.
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

use work.definitions.all;

entity led_toggle_timer is
    port(clock, reset_n: in std_logic;
         button_n      : in std_logic_vector(2 downto 0);
         led           : out std_logic_vector(2 downto 0));
end entity;

architecture behaviour of led_toggle_timer is

--------------------------------------------------------------------------------
-- @brief Signals used internally for the button and LED.
--
-- @param reset_s2_n        Synchronized inverting reset signal.
-- @param button_pressed_s2 Synchronized signals indicating pressdown of 
--                          the buttons (on falling edge).
-- @param led_s             Internal representation of the LEDs.
-- @param timer_enabled     Enable bits for each timer (1 = enabled).
-- @param timer_elapsed     Flags indicating if each timer has elapsed.
--------------------------------------------------------------------------------
signal reset_s2_n       : std_logic := '1';
signal button_pressed_s2: std_logic_vector(2 downto 0) := (others => '0');
signal led_s            : std_logic_vector(2 downto 0) := (others => '0');
signal timer_enabled    : std_logic_vector(2 downto 0) := (others => '0');
signal timer_elapsed    : std_logic_vector(2 downto 0) := (others => '0');
begin

    --------------------------------------------------------------------------------
    -- @brief Implements meta stability prevention via synchronized input signals.
    --------------------------------------------------------------------------------
    meta_prev1: entity work.meta_prev
    generic map(BUTTON_COUNT => 3)
    port map(clock, reset_n, button_n, reset_s2_n, button_pressed_s2);
    
    --------------------------------------------------------------------------------
    -- @brief Creates a 1 Hz timer.
    --------------------------------------------------------------------------------
    timer0: entity work.timer
    port map(clock, reset_n, timer_enabled(0), timer_elapsed(0));
    
    --------------------------------------------------------------------------------
    -- @brief Creates a 2 Hz timer.
    --------------------------------------------------------------------------------
    timer1: entity work.timer
    generic map(FREQUENCY => TIMER_FREQUENCY_2HZ)
    port map(clock, reset_n, timer_enabled(1), timer_elapsed(1));
    
    --------------------------------------------------------------------------------
    -- @brief Creates a 10 Hz timer.
    --------------------------------------------------------------------------------
    timer2: entity work.timer
    generic map(FREQUENCY => TIMER_FREQUENCY_10HZ)
    port map(clock, reset_n, timer_enabled(2), timer_elapsed(2));
    
    --------------------------------------------------------------------------------
    -- @brief Updates the timer enable signals on rising clock edge and system 
    --        reset. Each rimwe is toggled whenever the corresponding button is 
    --        pressed. All timers are immediately disabled on system reset.
    --------------------------------------------------------------------------------
    TIMER_PROCESS: process (clock, reset_s2_n) is
    begin
        if (reset_s2_n = '0') then
            timer_enabled <= (others => '0');
        elsif (rising_edge(clock)) then
            for i in 0 to 2 loop
                if (button_pressed_s2(i) = '1') then
                    timer_enabled(i) <= not timer_enabled(i);
                end if;
            end loop;
        end if;
    end process;
    
    --------------------------------------------------------------------------------
    -- @brief Updates the LED signals on rising clock edge and system reset. Each 
    --        LED is toggled whenever the corresponding timer elapses (if the 
    --        timer is enabled). A given LED is disabled if the associated timer
    --        is disabled. All LEDs are immediately disabled on system reset.
    --------------------------------------------------------------------------------
    LED_PROCESS: process(clock, reset_s2_n) is
    begin
        if (reset_s2_n = '0') then
           led_s <= (others => '0');
        elsif (rising_edge(clock)) then
            for i in 0 to 2 loop
                if (timer_enabled(i) = '1') then
                    if (timer_elapsed(i) = '1') then
                        led_s(i) <= not led_s(i);
                    end if;
                else
                    led_s(i) <= '0';
                end if;
            end loop;
        end if;
    end process;
    
    --------------------------------------------------------------------------------
    -- @brief Writes the led_s value to the LEDs.
    --------------------------------------------------------------------------------
    led <= led_s;

end architecture;