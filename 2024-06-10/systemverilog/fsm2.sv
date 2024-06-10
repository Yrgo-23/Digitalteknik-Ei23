/*******************************************************************************
 * @brief Implementation of FSM (finite state machine) for controlling a LED.
 *  
 *        The following states are implemented:
 *            - STATE_OFF  : The LED is disabled.
 *            - STATE_BLINK: The LED is blinking every 100 ms.
 *            - STATE_ON   : The LED is enabled.
 *
 *        The state is set via two push buttons, where the first changes
 *        the state to next and the second changes the state to previous.
 *
 * @param clock    50 MHz system clock.
 * @param reset_n  Asynchronous inverting reset signal connected to a button.
 * @param button_n Buttons used for setting the state of the FSM.
 * @param led      LED controlled by the FSM.
 ******************************************************************************/
module fsm2(input logic clock, reset_n,
            input logic[1:0] button_n,
            output logic led);
      
    /*******************************************************************************
     * @brief Signals used internally for the button and LED.
     *
     * @param reset_s2_n        Synchronized inverting reset signal.
     * @param button_pressed_s2 Synchronized signals indicating pressdown of 
     *                          the buttons (on falling edge).
     * @param led_s             Internal representation of the LED.
     * @param timer_enabled     Enable bit for the timer (1 = enabled).
     * @param timer_elapsed     Flag indicating if the timer has elapsed.
     * @param state             Holds the current state of the FSM.
     * @param next_state        Flag indicating state shall be updated to next.
     * @param previous_state    Indicates if the state shall be updated to previous.
     ******************************************************************************/ 
    logic reset_s2_n             = '0;
    logic[1:0] button_pressed_s2 = '0;    
    logic led_s                  = '0;
    logic timer_enabled          = '0;
    logic timer_elapsed          = '0;
    state_t state                = STATE_OFF;
    logic next_state             = '0;
    logic previous_state         = '0;
     
    /*******************************************************************************
     * @brief Implements meta stability prevention via synchronized input signals.
     ******************************************************************************/ 
    meta_prev #(.BUTTON_COUNT(2))
    meta_prev1(clock, reset_n, button_n, reset_s2_n, button_pressed_s2);
     
    /*******************************************************************************
     * @brief Creates a 10 Hz timer.
     ******************************************************************************/
    timer #(.FREQUENCY(TIMER_FREQUENCY_10HZ))
    timer1(clock, reset_s2_n, timer_enabled, timer_elapsed);
     
    /*******************************************************************************
     * @brief Updates current state of the FSM on rising clock edge or system reset
     *        in accordance with pressdown of the buttons. The state is set to 
     *        STATE_OFF upon system reset.
     ******************************************************************************/ 
    always_ff @ (posedge clock or negedge reset_s2_n)
    begin: STATE_PROCESS
        if (!reset_s2_n) begin
            state <= STATE_OFF;
        end
        else begin
            case (state)
                STATE_OFF:
                    if (next_state) begin
                        state <= STATE_BLINK;
                    end
                    else if (previous_state) begin
                        state <= STATE_ON;
                    end
                STATE_BLINK:
                    if (next_state) begin
                        state <= STATE_ON;
                    end
                    else if (previous_state) begin
                        state <= STATE_OFF;
                    end
                STATE_ON:
                    if (next_state) begin
                        state <= STATE_OFF;
                    end
                    else if (previous_state) begin
                        state <= STATE_BLINK;
                    end
                default:
                    state <= STATE_OFF;
            endcase
        end
    end
     
    /*******************************************************************************
     * @brief Updates the led_s signal upon rising clock edge or system reset. 
     *        The assigned value is set in accordance with current state, expect
     *        during system reset, when led_s is cleared.
     ******************************************************************************/ 
     always_ff @ (posedge clock or negedge reset_s2_n)
     begin: LED_PROCESS
         if (!reset_s2_n) begin
             led_s <= '0;
         end
         else begin
             case (state)
                 STATE_OFF:
                     led_s <= '0;
                 STATE_BLINK:
                     if (timer_elapsed) begin
                         led_s <= !led_s;
                     end
                 STATE_ON:
                     led_s <= '1;
                 default:
                     led_s <= '0;
             endcase
         end
     end
     
    /*******************************************************************************
     * @brief Assigns the led_s value to the LED.
     ******************************************************************************/ 
    assign led = led_s;
     
    /*******************************************************************************
     * @brief Enables the timer whenever current state is STATE_BLINK.
     ******************************************************************************/ 
    assign timer_enabled = state == STATE_BLINK ? '1 : '0;
     
    /*******************************************************************************
     * @brief Indicates that the state shall be updated to the next on falling
     *        edge of button_n(0).
     ******************************************************************************/ 
    assign next_state = !button_pressed_s2[1] & button_pressed_s2[0];
     
    /*******************************************************************************
     * @brief Indicates that the state shall be updated to the previous on falling
     *        edge of button_n(1).
     ******************************************************************************/ 
    assign previous_state = button_pressed_s2[1] & !button_pressed_s2[0];
     
endmodule
