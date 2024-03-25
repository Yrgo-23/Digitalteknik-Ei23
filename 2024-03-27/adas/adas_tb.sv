/*******************************************************************************
 * @brief Test bench for the adas module. Each combination 0000 - 1111 of the 
 *        inputs is tested during 10 ns, hence the simulation time is 160 ns.
 ******************************************************************************/
module adas_tb();

    /*******************************************************************************
     * @brief Signals used to simulate the adas module. These signals are connected
     *        to the corresponding ports with the same name. By doing this, we can 
     *        control the input and check the output of the adas module.
     ******************************************************************************/
    logic driver_break = 0, camera = 0, radar = 0, adas_error = 0, vehicle_break = 0;
    
    /*******************************************************************************
     * @brief Creates an instance of module adas for testing and connects its ports
     *        with the same name for testing.
     ******************************************************************************/
    adas sim_instance(driver_break, camera, radar, adas_error, vehicle_break);
    
    /*******************************************************************************
     * @brief Tests all 16 combinations 0000 - 1111 of the inputs during 10 ns
     *        each (via the local signals with the same name).
     ******************************************************************************/
    initial 
    begin: SIM_PROCESS
        for (int i = 0; i < 16; ++i) 
        begin
            { driver_break, camera, radar, adas_error } <= i;
            #10ns;
        end
    end
    
endmodule 