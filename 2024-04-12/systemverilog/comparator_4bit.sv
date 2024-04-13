/*******************************************************************************
 * @brief Implementation of a 4-bit comparator consisting of inputs abcd and 
 *        outputs xyzv.
 *
 *        The truth table of the comparator is shown below:
 *
 *        | abcd | xyz |
 *        | 0000 | 010 |
 *        | 0001 | 001 |
 *        | 0010 | 001 |
 *        | 0011 | 001 |
 *        | 0100 | 100 |
 *        | 0101 | 010 |
 *        | 0110 | 001 |
 *        | 0111 | 001 |
 *        | 1000 | 100 |
 *        | 1001 | 100 |
 *        | 1010 | 010 |
 *        | 1011 | 001 |
 *        | 1100 | 100 |
 *        | 1101 | 100 |
 *        | 1110 | 100 |
 *        | 1111 | 010 |
 *
 * @param abcd[in] Comparator input.
 * @param xyz[out] Comparator output.
 ******************************************************************************/
module comparator_4bit(input logic[3:0] abcd,
                       output logic[2:0] xyz);

    always_comb
    begin: output_process
        case (abcd)
            4'b0000 : xyz <= 3'b010;
            4'b0001 : xyz <= 3'b001;
            4'b0010 : xyz <= 3'b001;
            4'b0011 : xyz <= 3'b001;
            4'b0100 : xyz <= 3'b100;
            4'b0101 : xyz <= 3'b010;
            4'b0110 : xyz <= 3'b001;
            4'b0111 : xyz <= 3'b001;
            4'b1000 : xyz <= 3'b100;
            4'b1001 : xyz <= 3'b100;
            4'b1010 : xyz <= 3'b010;
            4'b1011 : xyz <= 3'b001;
            4'b1100 : xyz <= 3'b100;
            4'b1101 : xyz <= 3'b100;
            4'b1110 : xyz <= 3'b100;
            4'b1111 : xyz <= 3'b010;
            default : xyz <= 3'b000;
        endcase
    end
    
endmodule 