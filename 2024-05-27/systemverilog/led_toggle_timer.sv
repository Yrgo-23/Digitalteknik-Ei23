/*******************************************************************************
 * @brief Implementation for toggling LEDs via associated timers implemented
 *        internally. Each timer is toggled by pressdown of a specific button. 
 *
 * @param clock    50 MHz system clock.
 * @param reset_n  Asynchronous inverting reset signal connected to a button.
 * @param button_n Buttons used for toggling LEDs.
 * @param led      LEDs toggled by the associated timers.
 *
 * @note led[0] is toggled every 1000 ms when the associated timer is enabled.
 * @note led[1] is toggled every 500 ms when the associated timer is enabled.
 * @note led[2] is toggled every 100 ms when the associated timer is enabled.
 ******************************************************************************/
module led_toggle_timer(input logic clock, reset_n,
                        input logic[2:0] button_n,
                        output logic[2:0] led);

    /*******************************************************************************
     * @brief Signals used internally for the button and LED.
     *
     * @param reset_s2_n        Synchronized inverting reset signal.
     * @param button_pressed_s2 Synchronized signals indicating pressdown of 
     *                          the buttons (on falling edge).
     * @param led_s             Internal representation of the LEDs.
     * @param timer_enabled     Enable signals for the timers.
     * @param timer_elapsed     Indicates if each timer has elapsed.
     ******************************************************************************/                        
    logic reset_s2_n             = '1;
    logic[2:0] button_pressed_s2 = '0;
    logic[2:0] led_s             = '0;
    logic[2:0] timer_enabled     = '0;
    logic[2:0] timer_elapsed     = '0;
    
    /*******************************************************************************
     * @brief Implements meta stability prevention via synchronized input signals.
     ******************************************************************************/
    meta_prev #(.BUTTON_COUNT(3)) 
    meta_prev1(clock, reset_n, button_n, reset_s2_n, button_pressed_s2);
    
    /*******************************************************************************
     * @brief Creates a 1 Hz timer.
     ******************************************************************************/
    timer timer0 (clock, reset_s2_n, timer_enabled[0], timer_elapsed[0]);
     
    /*******************************************************************************
     * @brief Creates a 2 Hz timer.
     ******************************************************************************/
    timer #(.FREQUENCY(TIMER_FREQUENCY_2HZ))
    timer1 (clock, reset_s2_n, timer_enabled[1], timer_elapsed[1]);
    
    /*******************************************************************************
     * @brief Creates a 10 Hz timer.
     ******************************************************************************/
    timer #(.FREQUENCY(TIMER_FREQUENCY_10HZ))
    timer2 (clock, reset_s2_n, timer_enabled[2], timer_elapsed[2]);
    
    /*******************************************************************************
     * @brief Toggles a given timer whenever the associated button is pressed.
     *        All timers are disabled upon system reset.
     ******************************************************************************/
    always_ff @ (posedge clock or negedge reset_s2_n)
    begin: TIMER_PROCESS
        if (!reset_s2_n) begin
            timer_enabled <= '0;
        end
        else begin
            for (int i = 0; i < 3; ++i) begin
                if (button_pressed_s2[i]) begin
                    timer_enabled[i] <= !timer_enabled[i];
                end
            end
        end
    end
    
    /*******************************************************************************
     * @brief Toggles a given LED whenever the associated timer elapses.
     *        A given LED is disabled whenever the associated timer is disabled.        
     *        All LEDs are disabled upon system reset.
     ******************************************************************************/
    always_ff @ (posedge clock or negedge reset_s2_n)
    begin: LED_PROCESS
        if (!reset_s2_n) begin
            led_s <= '0;
        end
        else begin
            for (int i = 0; i < 3; ++i) begin
                if (timer_enabled[i]) begin
                    if (timer_elapsed[i]) begin
                        led_s[i] <= !led_s[i];
                    end
                end
                else begin
                    led_s[i] <= '0;
                end
            end
        end
    end
    
    /*******************************************************************************
     * @brief Writes the led_s value to the LEDs.
     ******************************************************************************/
    assign led = led_s;
    
    
endmodule 