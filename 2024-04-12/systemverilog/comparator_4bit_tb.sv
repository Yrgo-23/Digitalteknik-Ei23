/*******************************************************************************
 * @brief Test bench for top module comparator_4bit. All 16 combinations of
 *        inputs abcd = 0000 - 1111 are tested during 10 ns each. Hence the 
 *        total simulation time is 160 ns.
 ******************************************************************************/
module comparator_4bit_tb();

    /*******************************************************************************
     * @brief Signals used to simulate the top module.
     ******************************************************************************/
    logic[3:0] abcd = 4'b0000;
    logic[2:0] xyz  = 3'b000;
    
    /*******************************************************************************
     * @brief Creates an instance of the top module and connects its ports to
     *        signals abcd and xyzv for simulation.
     ******************************************************************************/
    comparator_4bit sim_instance(abcd, xyz);
    
    /*******************************************************************************
     * @brief Tests the top module with all 16 combinations 0000 - 1111 of inputs
     *        abcd during 10 ns each. 
     ******************************************************************************/
    initial 
    begin: sim_process
        for (int i = 0; i < 16; ++i)
        begin
            abcd <= i;
            #10ns;
        end
    end
    
endmodule 