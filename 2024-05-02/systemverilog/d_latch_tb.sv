/*******************************************************************************
 * @brief Test bench for the d_latch module. The simulation is performed twice
 *        to check the latch output when the previous output is high and low.
 ******************************************************************************/
module d_latch_tb();

    /*******************************************************************************
     * @brief Signals used to test the d_latch module.
     ******************************************************************************/
    logic d = 0, enable = 0, q = 0, q_n = 1;
    
    /*******************************************************************************
     * @brief Creates a D latch and connects signals to its ports for simulation.
     ******************************************************************************/
    d_latch sim_instance(d, enable, q, q_n);
    
    /*******************************************************************************
     * @brief Tests all combinations 00 - 11 of inputs {enable, d} twice to validate
     *        the latch function both when the precious output is high and low.
     ******************************************************************************/
    initial
    begin: SIM_PROCESS
        for (int i = 0; i < 2; ++i) begin
            for (int j = 0; j < 3; ++j) begin
                {enable, d} <= j;
                #10ns;
            end
        end
    end
    
endmodule 