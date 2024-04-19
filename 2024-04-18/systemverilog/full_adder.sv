/*******************************************************************************
 * @brief Implementation of a full adder consisting of inputs {a, b, cin} and
 *        outputs {cout, sum}. The truth table is shown below:
 *
 *        {a, b, cin} {cout, sum}
 *            000          00
 *            001          01
 *            010          01
 *            011          10
 *            100          01
 *            101          10
 *            110          10
 *            111          11
 *
 * @param inputs[in]   Inputs and carry in.
 * @param outputs[out] Carry out and sum of inputs.
 ******************************************************************************/
module full_adder(input logic[2:0] inputs,
                  output logic[1:0] outputs);   
   
    /*******************************************************************************
     * @brief Sets the output in accordance with the truth table.
     ******************************************************************************/
    always_comb
    begin: output_process
        case (inputs)
            3'b000 : outputs <= 2'b00;
            3'b001 : outputs <= 2'b01;
            3'b010 : outputs <= 2'b01;
            3'b011 : outputs <= 2'b10;
            3'b100 : outputs <= 2'b01;
            3'b101 : outputs <= 2'b10;
            3'b110 : outputs <= 2'b10;
            3'b111 : outputs <= 2'b11;
            default: outputs <= 2'b00;
        endcase
    end
endmodule 