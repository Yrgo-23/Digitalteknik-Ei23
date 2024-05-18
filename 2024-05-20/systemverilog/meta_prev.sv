/*******************************************************************************
 * @brief Module for synchronizing input signals to prevent metatability.
 *        Each input signal (expect the system clock) is synchronized via
 *        two flip flops. Event detection is implemented for the connected
 *        button in order to detect pressdown (falling down).
 *
 * @tparam BUTTON_COUNT The number of buttons to synchronize (default = 1).
 *
 * @param clock[in]              50 MHz system clock.
 * @param reset_n[in]            Inverting reset connected to a push button.
 * @param button_n[in]           Inverting push buttons.
 * @param reset_s2_n[out]        Synchronized inverting reset signal.
 * @param button_pressed_s2[out] Synchronized signals indicating pressdown
 *                               of the buttons (on falling edge).
 ******************************************************************************/
module meta_prev
    #(parameter BUTTON_COUNT = 1)
     (input logic clock, reset_n,
      input logic[BUTTON_COUNT - 1 : 0] button_n,
      output logic reset_s2_n,
      output logic[BUTTON_COUNT - 1 : 0] button_pressed_s2);
    
    /*******************************************************************************
     * @brief Signals used to generate flip flops for the input signals.
     ******************************************************************************/
    logic reset_s1_n                        = '1;
    logic[BUTTON_COUNT - 1 : 0] button_s1_n = '1, button_s2_n = '1, button_s3_n = '1;
     
    /*******************************************************************************
     * @brief Synchronizes the reset signals at rising edge of the system clock.
     *        All reset signals are immediately cleared upon system reset.
     ******************************************************************************/
    always_ff @ (posedge clock or negedge reset_n)
    begin: RESET_PROCESS
        if (!reset_n) begin
            reset_s1_n <= '0;
            reset_s2_n <= '0;
        end
        else begin
            reset_s1_n <= '1;
            reset_s2_n <= reset_s1_n;
        end
    end
     
    /*******************************************************************************
     * @brief Synchronizes the button signals at rising edge of the system clock.
     *        All button signals are immediately set upon system reset.
     ******************************************************************************/
    always_ff @ (posedge clock or negedge reset_s2_n)
    begin: BUTTON_PROCESS
        if (!reset_s2_n) begin
            button_s1_n <= '1;
            button_s2_n <= '1;
            button_s3_n <= '1;
        end
        else begin
            button_s1_n <= button_n;
            button_s2_n <= button_s1_n;
            button_s3_n <= button_s2_n;
        end
    end
     
    /*******************************************************************************
     * @brief Updates the button pressed event signals upon system reset and rising
     *        edge of the source clock. A given button i is pressed if the "current"
     *        input button_s2_n_s(i) is 0 and the "previous" input buttoN_s3_n_s(i)
     *        is 1. All event signals are cleared upon system reset. 
     ******************************************************************************/
    always_ff @ (posedge clock or negedge reset_s2_n)
    begin: BUTTON_PRESSED_PROCESS
        if (!reset_s2_n) begin
            button_pressed_s2 <= '0;
        end
        else begin
            for (int i = 0; i < BUTTON_COUNT; ++i) begin
                button_pressed_s2[i] <= !button_s2_n[i] & button_s3_n[i];
            end
        end
    end
     
endmodule 
     