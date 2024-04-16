/*******************************************************************************
 * @brief Design of a 8-to-1 multiplexer.
 *
 * @param inputs[in] Multiplexer inputs connected to slide switches.
 * @param sel_n[in]  Inverted selector bits connected to active low buttons.
 * @param x[out]     Multiplexer output connected to a LED.
 ******************************************************************************/
module mux_8_to_1(input logic[7:0] inputs,
                  input logic[2:0] sel_n,
                  output logic x);
                   
    logic[2:0] sel = 3'b0;
    
    /*******************************************************************************
     * @brief Negates the selector signals, since the connected buttons are
     *        active low.
     ******************************************************************************/ 
     always_comb
     begin: negation_process
         for (int i = 0; i < 3; ++i)
         begin
             sel[i] <= !sel_n[i];
         end
     end

    /*******************************************************************************
     * @brief Process that updates the output upon change of the selector signals.
     ******************************************************************************/ 
     always_comb
     begin: output_process
         case (sel)
             3'b000 : x <= inputs[0];
             3'b001 : x <= inputs[1];
             3'b010 : x <= inputs[2];
             3'b011 : x <= inputs[3];
             3'b100 : x <= inputs[4];
             3'b101 : x <= inputs[5];
             3'b110 : x <= inputs[6];
             3'b111 : x <= inputs[7];
             default: x <= 1'b0;
         endcase
     end
     
endmodule 