/*******************************************************************************
 * @brief Test bench for module sv_net1. Each combination 0000 - 1111 of
 *        inputs abcd is tested during 10 ns each, hence the simulation time
 *        is 160 ns.
 ******************************************************************************/
module sv_net1_tb();
 
    /*******************************************************************************
     * Signals used to simulate the sv_net1 module. These signals are connected to
     * ports abcd and xy in the sv_net1 module. By doing this, we can control the
     * input and check the corresponding output. Each signal is initialized to 0.
     * 
     * @param abcd Inputs implemented as a single 4-bit vector, where a = abcd(3).
     * @param xy   Outputs implemented as a 2-bit vector, where x = xy(1).
     ******************************************************************************/
    logic[3:0] abcd = 0;
    logic[1:0] xy   = 0;
     
    /*******************************************************************************
     * Creates an instance of module sv_net1 named sim_instance and connects its 
     * ports to signals abcd and xy for simulation purposes.
     ******************************************************************************/
    sv_net1 sim_instance(abcd[3], abcd[2], abcd[1], abcd[0], xy[1], xy[0]);
     
    /*******************************************************************************
     * @brief Tests the sv_net1 with all 16 combinations 0000 - 1111 of inputs
     *        abcd during 10 ns each (via the abcd signal). 
     ******************************************************************************/
    initial
    begin: sim_process
        for (int i = 0; i < 16; ++i) // 0 <= i <= 15
        begin
            abcd <= i;               // abcd = i
            #10ns;                   // Waits for 10 ns before i++
        end      
    end
    
endmodule 
