/*******************************************************************************
 * @brief Implementation of a net consisting of inputs abcd and outputs xy.
 *
 * @param abcd[in] Input bits.
 * @param xy[out]  Output bits.
 *
 * @note The truth table of the net is shown below:
 *
 *        | abcd | xy |
 *        | 0000 | 10 |
 *        | 0001 | 10 |
 *        | 0010 | 00 |
 *        | 0011 | 00 |
 *        | 0100 | 11 |
 *        | 0101 | 11 |
 *        | 0110 | 01 |
 *        | 0111 | 01 |
 *        | 1000 | 10 |
 *        | 1001 | 00 |
 *        | 1010 | 10 |
 *        | 1011 | 00 |
 *        | 1100 | 11 |
 *        | 1101 | 11 |
 *        | 1110 | 11 |
 *        | 1111 | 11 |
 *
 *       The following equations have been derived for outputs x and y:
 *           - x = ab + a'c' + ad'
 *           - y = b
 ******************************************************************************/
module sv_net1(input logic a, b, c, d, 
               output logic x, y);
    assign x = (a & b) | (!a & !c) | (a & !d);
    assign y = b;
endmodule 