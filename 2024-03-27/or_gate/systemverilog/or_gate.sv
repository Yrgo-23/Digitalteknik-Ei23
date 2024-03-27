/*******************************************************************************
 * @brief Implementation of an OR gate.
 *
 * @param a[in]  First input bit of the OR gate.
 * @param b[in]  Second input bit of the OR gate.
 * @param x[out] Output of the OR gate.
 ******************************************************************************/
module or_gate(input logic a, b, 
               output logic x);
    assign x = a | b;
endmodule 