/********************************************************************************
 * @brief Test bench for the or_gate module. 
 *******************************************************************************/
module or_gate_tb();

    /********************************************************************************
     * @brief Signals used to simulate the or_gate module. These signals are
     *        connected to ports ab and x in the or_gate module.
     *        By doing this, we can control the input and check the output of
     *        module or_gate. Each signal is initialized to 0.
     *******************************************************************************/
    logic a = 0, b = 0, x = 0;

    /********************************************************************************
     * @brief Creates an instance of module or_gate and connects its ports to
     *        local signals ab and x for simulation purposes
     *******************************************************************************/
    or_gate sim_instance(a, b, x);
    
    /********************************************************************************
     * @brief Tests or_gate with all four combinations 00 - 11 of inputs ab during
     *        10 ns each (via the local signals with the same name). 
     ********************************************************************************/
     initial
     begin: SIM_PROCESS
         for (int i = 0; i <= 3; ++i) 
         begin
             { a, b } <= i;
             #10ns;
         end
     end
endmodule 