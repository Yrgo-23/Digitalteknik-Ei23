/*******************************************************************************
 * @brief Design of a D flip flop with an inverting asynchronous reset.
 *
 * @param clock[in]   50 MHz system clock.
 * @param reset_n[in] Inverting reset signal (0 = system reset).
 * @param d[in]       Flip flop input.
 * @param enable[in]  Enable signal for opening/locking the flip flop (1 = open).
 * @param q[out]      Flip flop output.
 * @param q_n[out]    Inverse of the flip flop output.
 *
 * The function of the D flip flop is as follows:
 *     - reset_n = 0                => q = 0, q_n = 1
 *     - reset_n = 1 and enable = 0 => q = q, q_n = q_n
 *     - reset_n = 1 and enable = 1 => q = d, q_n = ~d
 ******************************************************************************/
module d_flip_flop(input logic clock, reset_n, d, enable,
                   output logic q, q_n);
                   
    /*******************************************************************************
     * @brief Signal used to store the flip flop output internally.
     ******************************************************************************/
    logic q_s = 1'b0;
    
    /*******************************************************************************
     * @brief Updates the the q_s signal on rising edge of the clock and falling
     *        edge of the reset signal. The q_s signal is cleared immediately upon 
     *        system reset.
     ******************************************************************************/
    always_ff @ (posedge clock or negedge reset_n)
    begin
        if (!reset_n) begin
            q_s <= 1'b0;
        end
        else begin
            if (enable) begin
                q_s <= d;
            end
        end
    end
    
    /*******************************************************************************
     * @brief Sets the flip flop output (and its inverse) via the q_s signal.
     ******************************************************************************/
    assign q   = q_s;
    assign q_n = !q_s;
    
endmodule 