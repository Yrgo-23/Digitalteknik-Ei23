/*******************************************************************************
 * @brief Design of a D latch.
 *
 * @param d[in]      D latch input.
 * @param enable[in] Enable signal for opening/locking the latch (1 = open).
 * @param q[out]     D latch output.
 * @param q_n[out]   Inverse of the D latch output.
 *
 * The function of the D latch is as follows:
 *     - enable = 0 => latch locked => q = q, q_n = q_n
 *     - enable = 1 => latch open   => q = d, q_n = ~d
 ******************************************************************************/
module d_latch(input logic d, enable,
               output logic q, q_n);
               
    /*******************************************************************************
     * @brief Signal used to store the latch output internally.
     ******************************************************************************/
    logic q_s  = 0;
    
    /*******************************************************************************
     * @brief Updates the the q_s signal whenever the latch is open.
     ******************************************************************************/
    always_latch
    begin
        if (enable) begin
            q_s <= d;
        end
    end
    
    /*******************************************************************************
     * @brief Sets the latch output (and its inverse) via the q_s signal.
     ******************************************************************************/
    assign q   = q_s;
    assign q_n = ~q_s;
    
endmodule 