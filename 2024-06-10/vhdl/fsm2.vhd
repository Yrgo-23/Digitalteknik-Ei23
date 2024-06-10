--------------------------------------------------------------------------------
-- @brief Implementation of FSM (finite state machine) for controlling a LED.
--  
--        The following states are implemented:
--            - STATE_OFF  : The LED is disabled.
--            - STATE_BLINK: The LED is blinking every 100 ms.
--            - STATE_ON   : The LED is enabled.
--
--        The state is set via two push buttons, where the first changes
--        the state to next and the second changes the state to previous.
--
-- @param clock    50 MHz system clock.
-- @param reset_n  Asynchronous inverting reset signal connected to a button.
-- @param button_n Buttons used for setting the state of the FSM.
-- @param led      LED controlled by the FSM.
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.definitions.all;

entity fsm2 is
    port(clock, reset_n: in std_logic;
         button_n      : in std_logic_vector(1 downto 0);
         led           : out std_logic);
end entity;

architecture behaviour of fsm2 is

--------------------------------------------------------------------------------
-- @brief Signals used internally for the button and LED.
--
-- @param reset_s2_n        Synchronized inverting reset signal.
-- @param button_pressed_s2 Synchronized signals indicating pressdown of 
--                          the buttons (on falling edge).
-- @param led_s             Internal representation of the LED.
-- @param timer_enabled     Enable bit for the timer (1 = enabled).
-- @param timer_elapsed     Flag indicating if the timer has elapsed.
-- @param state             Holds the current state of the FSM.
-- @param next_state        Flag indicating state shall be updated to next.
-- @param previous_state    Indicates if the state shall be updated to previous.
--------------------------------------------------------------------------------
signal reset_s2_n       : std_logic := '0';
signal button_pressed_s2: std_logic_vector(1 downto 0) := (others => '0');
signal led_s            : std_logic := '0';
signal timer_enabled    : std_logic := '0';
signal timer_elapsed    : std_logic := '0';
signal state            : state_t   := STATE_OFF;
signal next_state       : std_logic := '0';
signal previous_state   : std_logic := '0';

begin

    --------------------------------------------------------------------------------
    -- @brief Implements meta stability prevention via synchronized input signals.
    --------------------------------------------------------------------------------
    meta_prev1: entity work.meta_prev
    generic map(BUTTON_COUNT => 2)
    port map(clock, reset_n, button_n, reset_s2_n, button_pressed_s2);
    
    --------------------------------------------------------------------------------
    -- @brief Creates a 10 Hz timer.
    --------------------------------------------------------------------------------
    timer1: entity work.timer
    generic map(FREQUENCY => TIMER_FREQUENCY_10HZ)
    port map(clock, reset_s2_n, timer_enabled, timer_elapsed);
    
    --------------------------------------------------------------------------------
    -- @brief Updates current state of the FSM on rising clock edge or system reset
    --        in accordance with pressdown of the buttons. The state is set to 
    --        STATE_OFF upon system reset.
    --------------------------------------------------------------------------------
    STATE_PROCESS: process (clock, reset_s2_n) is
    begin
        if (reset_s2_n = '0') then
            state <= STATE_OFF;
        elsif (rising_edge(clock)) then
            case (state) is
                when STATE_OFF =>
                    if (next_state = '1') then
                        state <= STATE_BLINK;
                    elsif (previous_state = '1') then
                        state <= STATE_ON;
                    end if;
                when STATE_BLINK =>
                    if (next_state = '1') then
                        state <= STATE_ON;
                    elsif (previous_state = '1') then
                        state <= STATE_OFF;
                    end if;
                when STATE_ON =>
                    if (next_state = '1') then
                        state <= STATE_OFF;
                    elsif (previous_state = '1') then
                        state <= STATE_BLINK;
                    end if;
                when others =>
                    state <= STATE_OFF;
            end case;
        end if;
    end process;
    
    --------------------------------------------------------------------------------
    -- @brief Updates the led_s signal upon rising clock edge or system reset. 
    --        The assigned value is set in accordance with current state, expect
    --        during system reset, when led_s is cleared.
    --------------------------------------------------------------------------------
    LED_PROCESS: process (clock, reset_s2_n) is
    begin
        if (reset_s2_n = '0') then
            led_s <= '0';
        elsif (rising_edge(clock)) then
           case (state) is
               when STATE_OFF =>
                   led_s <= '0';
               when STATE_BLINK =>
                   if (timer_elapsed = '1') then
                       led_s <= not led_s;
                   end if;
               when STATE_ON =>
                   led_s <= '1';
               when others => 
                   led_s <= '0';
           end case;
      end if;
    end process;
    
    --------------------------------------------------------------------------------
    -- @brief Assigns the led_s value to the LED.
    --------------------------------------------------------------------------------
    led <= led_s;
    
    --------------------------------------------------------------------------------
    -- @brief Enables the timer whenever current state is STATE_BLINK.
    --------------------------------------------------------------------------------
    timer_enabled <= '1' when state = STATE_BLINK else '0';
    
    --------------------------------------------------------------------------------
    -- @brief Indicates that the state shall be updated to the next on falling
    --        edge of button_n(0).
    --------------------------------------------------------------------------------
    next_state <= (not button_pressed_s2(1)) and button_pressed_s2(0);
    
    --------------------------------------------------------------------------------
    -- @brief Indicates that the state shall be updated to the previous on falling
    --        edge of button_n(1).
    --------------------------------------------------------------------------------
    previous_state <= button_pressed_s2(1) and (not button_pressed_s2(0));

end architecture;