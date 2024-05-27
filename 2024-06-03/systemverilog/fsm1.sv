/*******************************************************************************
 * @brief Implementation of a simple FSM (Finite State Machine) consisting of
 *        four states STATE_0, STATE_1, STATE_2 and STATE_3. A button is used
 *        to update the state to next. A LED is enabled in STATE_3. The state
 *        machine is circular, hence the next state after STATE_3 is STATE_0.
 *
 * @param clock[in]   50 MHz system clock.
 * @param reset_n[in] Inverting asynchronous reset connected to a push button.
 * @param button_n[in] Inverting push button to update the state to next.
 * @param led[out]     LED enabled in STATE_3 only.
 ******************************************************************************/
module fsm1(input logic clock, reset_n, button_n,
            output logic led);

    /*******************************************************************************
     * @brief Enumeration for implementing the different states of the FSM.
     ******************************************************************************/
    typedef enum { STATE_0, STATE_1, STATE_2, STATE_3 } state_t;
    
    /*******************************************************************************
     * @brief Signals used in the top module.
     *
     * @param reset_s2_n        Synchronized inverting reset signal.
     * @param button_pressed_s2 Synchronized signal indicating pressdown of 
     *                          the button (on falling edge).
     * @param state             Signal holding the current state.
     ******************************************************************************/
    logic reset_s2_n        = '0; 
    logic button_pressed_s2 = '0;
    state_t state           = STATE_0;
    
    /*******************************************************************************
     * @brief Implements meta stability prevention via synchronized input signals.
     ******************************************************************************/
    meta_prev meta_prev1(clock, reset_n, button_n, reset_s2_n, button_pressed_s2);
    
    /*******************************************************************************
     * @brief Updates the state of the state machine on system reset or att falling
     *        edge of the button. The state is set to STATE_0 at system reset.
     *        The state is updated to the next at falling edge of the button.
     ******************************************************************************/
    always_ff @ (posedge clock or negedge reset_s2_n)
    begin: STATE_PROCESS
        if (!reset_s2_n) begin
            state <= STATE_0;
        end
        else begin
            if (button_pressed_s2) begin
                case (state)
                   STATE_0: state <= STATE_1;
                   STATE_1: state <= STATE_2;
                   STATE_2: state <= STATE_3;
                   STATE_3: state <= STATE_0;
                   default: state <= STATE_0;
                endcase
            end
        end
    end
    
    /*******************************************************************************
     * @brief Enables the LED when current state if STATE_3, else it's disabled.
     ******************************************************************************/
    assign led = state == STATE_3 ? '1 : '0;
    
    
endmodule 