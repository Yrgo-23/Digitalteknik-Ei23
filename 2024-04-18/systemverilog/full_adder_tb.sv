/*******************************************************************************
 * @brief Test bench for the full_adder module. Each combination 000 - 111 of
 *        inputs {a, b, cin} is tested during 10 ns, hence the simulation time
 *        is 160 ns.
 ******************************************************************************/
module full_adder_tb();

    /*******************************************************************************
     * @brief Signals used for simulating the full adder.
     ******************************************************************************/
    logic[2:0] inputs  = 3'b000;
    logic[1:0] outputs = 2'b00;
    
    /*******************************************************************************
     * @brief Creates a full adder and connects signals for simulation.
     ******************************************************************************/
    full_adder sim_instance(inputs, outputs);
    
    /*******************************************************************************
     * @brief Simulates each combination 000 - 111 of the inputs during 10 ns.
     ******************************************************************************/
    initial
    begin: sim_process
        for (int i = 0; i < 8; ++i)
        begin
            inputs <= i;
            #10ns;
        end
    end

endmodule 