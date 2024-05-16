--------------------------------------------------------------------------------
-- @brief Module for synchronizing input signals to prevent metatability.
--        Each input signal (expect the system clock) is synchronized via
--        two flip flops. Event detection is implemented for the connected
--        button in order to detect pressdown (falling down).
--
-- @param clock[in]              50 MHz system clock.
-- @param reset_n[in]            Inverting reset connected to a push button.
-- @param button_n[in]           Inverting push button.
-- @param reset_s2_n[out]        Synchronized inverting reset signal.
-- @param button_pressed_s2[out] Synchronized signal indicating pressdown
--                               of button_n (falling edge).
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity meta_prev is
    port(clock, reset_n, button_n     : in std_logic;
         reset_s2_n, button_pressed_s2: out std_logic);
end entity;

architecture behaviour of meta_prev is

--------------------------------------------------------------------------------
-- @brief Signals used to generate flip flops for the input signals.
--------------------------------------------------------------------------------
signal reset_s1_n, reset_s2_n_s             : std_logic := '1';
signal button_s1_n, button_s2_n, button_s3_n: std_logic := '1';

begin

    --------------------------------------------------------------------------------
    -- @brief Synchronizes the reset signals at rising edge of the system clock.
    --        All reset signals are immediately cleared upon system reset.
    --------------------------------------------------------------------------------
    RESET_PROCESS: process (clock, reset_n) is
    begin
        if (reset_n = '0') then
            reset_s1_n   <= '0';
            reset_s2_n_s <= '0';
        elsif (rising_edge(clock)) then
            reset_s1_n   <= '1';
            reset_s2_n_s <= reset_s1_n;
        end if;
    end process;
    
    --------------------------------------------------------------------------------
    -- @brief Synchronizes the button signals at rising edge of the system clock.
    --        All button signals are immediately set upon system reset.
    --------------------------------------------------------------------------------
    BUTTON_PROCESS: process (clock, reset_s2_n_s) is
    begin
        if (reset_s2_n_s = '0') then
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
    -- @brief Assigns the outputs.
    --
    -- @note button_n is pressed if button_s2_n (the "current" input) is 0 and
    --       button_s3_n (the "previous" input) is 1.
    --------------------------------------------------------------------------------
    reset_s2_n        <= reset_s2_n_s;
    button_pressed_s2 <= (not button_s2_n) and button_s3_n;
    
end architecture;