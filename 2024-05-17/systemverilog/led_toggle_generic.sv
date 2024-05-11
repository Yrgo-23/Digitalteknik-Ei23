/*******************************************************************************
 * @brief Implementation of generic design for toggling an arbitrary number
 *        of LEDs via a corresponding number of buttons.
 *
 * @tparam DEVICE_COUNT The number of LEDs and corresponding buttons used
 *                      in the design (default = 3).
 *
 * @param clock    50 MHz system clock.
 * @param reset_n  Asynchronous inverting reset signal connected to a button.
 * @param button_n Buttons used for toggling LEDs.
 * @param led      LEDs toggled by the corresponding buttons.
 ******************************************************************************/
module led_toggle_generic
    #(parameter DEVICE_COUNT = 3)
     (input logic clock, reset_n,
      input logic[DEVICE_COUNT - 1 : 0] button_n,
      output logic[DEVICE_COUNT - 1 : 0] led);
      

    /*******************************************************************************
     * @brief Signals used internally for the button and LED.
     *
     * @param reset_s2_n        Synchronized inverting reset signal.
     * @param button_pressed_s2 Synchronized signals indicating pressdown of 
     *                          the buttons (on falling edge).
     * @param led_s             Internal representation of the LEDs.
     ******************************************************************************/
    logic reset_s2_n                              = '1;
    logic[DEVICE_COUNT - 1 : 0] button_pressed_s2 = '0;
    logic[DEVICE_COUNT - 1 : 0] led_s             = '0;
     
    /*******************************************************************************
     * @brief Implements meta stability prevention via synchronized input signals.
     ******************************************************************************/
    meta_prev #(DEVICE_COUNT) 
    meta_prev1(clock, reset_n, button_n, reset_s2_n, button_pressed_s2);
     
    /*******************************************************************************
     * @brief Updates the LED signals on rising clock edge and system reset. Each 
     *        LED is toggled whenever the corresponding button is pressed. All LEDs
     *        are immediately disabled on system reset.
     ******************************************************************************/
    always_ff @ (posedge clock or negedge reset_s2_n)
    begin: LED_PROCESS
        if (!reset_s2_n) begin
            led_s <= '0;
        end
        else begin
            for (int i = 0; i < DEVICE_COUNT; ++i) begin
                if (button_pressed_s2[i]) begin
                    led_s[i] <= !led_s[i];
                end
            end
        end
    end
    
    /*******************************************************************************
     * @brief Writes the led_s value to the LED.
     ******************************************************************************/
    assign led = led_s;
     
endmodule 