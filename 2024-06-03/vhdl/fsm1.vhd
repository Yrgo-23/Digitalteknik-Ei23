--------------------------------------------------------------------------------
-- @brief Design of a simple FSM (Finite State Machine) consisting of four
--        states STATE_0, STATE_1, STATE_2, and STATE_3. A LED is enabled
--        in STATE_3, else it's disabled. A button is used to change state
--        to the next.
--
-- @param clock    50 MHz system clock.
-- @param reset_n  Inverting reset signal connected to a button. 
-- @param button_n Inverting button for changing to next state (at falling edge).
-- @param led      LED enabled in STATE_3 only.
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fsm1 is
    port(clock, reset_n: in std_logic;
         button_n      : in std_logic_vector(0 downto 0);
         led           : out std_logic);
end entity;

architecture behaviour of fsm1 is

--------------------------------------------------------------------------------
-- @brief Enumeration for the different states of the FSM.
--------------------------------------------------------------------------------
type state_t is (STATE_0, STATE_1, STATE_2, STATE_3);

--------------------------------------------------------------------------------
-- @brief Signals used in the top module.
--
-- @param state             Signal holding current state of the FSM.
-- @param reset_s2_n        Inverting synchronized reset signal.
-- @param button_pressed_s2 Indicates falling edge of button_n.
--------------------------------------------------------------------------------
signal state            : state_t := STATE_0;
signal reset_s2_n       : std_logic := '0';
signal button_pressed_s2: std_logic_vector(0 downto 0) := "0";

begin

    --------------------------------------------------------------------------------
    -- @brief Implements meta stability prevention and edge detection on button_n.
    --------------------------------------------------------------------------------
    meta_prev1: entity work.meta_prev
    generic map(BUTTON_COUNT => 1)
    port map(clock, reset_n, button_n, reset_s2_n, button_pressed_s2);
    
    --------------------------------------------------------------------------------
    -- @brief Updates the state at system reset of rising clock edge (only at
    --        falling edge of the button). If reset occurs, the state machine
    --        is reset to STATE_0. The state is changed to next at falling edge
    --        of the button. The system is also reset if an error occurs.
    --------------------------------------------------------------------------------
    STATE_PROCESS: process (clock, reset_s2_n) is
    begin
        if (reset_s2_n = '0') then
            state <= STATE_0;
        elsif (rising_edge(clock)) then
            case (state) is
                when STATE_0 =>
                    if (button_pressed_s2 = "1") then
                        state <= STATE_1;
                    end if;
                when STATE_1 =>
                    if (button_pressed_s2 = "1") then
                        state <= STATE_2;
                    end if;
                when STATE_2 =>
                    if (button_pressed_s2 = "1") then
                        state <= STATE_3;
                    end if;
                when STATE_3 =>
                    if (button_pressed_s2 = "1") then
                        state <= STATE_0;
                    end if;
                when others  =>
                    state <= STATE_0;
            end case;
        end if;
    end process;
    
    --------------------------------------------------------------------------------
    -- @brief Enables the LED in STATE_3 only.
    --------------------------------------------------------------------------------
    led <= '1' when state = STATE_3 else '0';
 
end architecture;