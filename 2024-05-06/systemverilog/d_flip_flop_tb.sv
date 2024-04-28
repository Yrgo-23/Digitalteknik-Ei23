/*******************************************************************************
 * @brief Test bench for the d_flip flop module. The simulation is performed 
 *        four times to check the flip flop output when the previous output is 
 *        high and low, both during normal execution and system reset. 
 *        The total simulation time is therefore 160 ns.
 ******************************************************************************/
module d_flip_flop_tb();

    /*******************************************************************************
     * @brief Signals used for connecting to the d_flip_flop module.
     ******************************************************************************/
     logic clock = 0, reset_n = 1, d = 0, enable = 0, q = 0, q_n = 0;
     
    /*******************************************************************************
     * @brief Sets the clock period to 10 ns.
     ******************************************************************************/
     const time CLOCK_PERIOD = 10ns;
     
    /*******************************************************************************
     * @brief Creates a D flip flop and connects signals to its ports for simulation.
     ******************************************************************************/
     d_flip_flop sim_instance(clock, reset_n, d, enable, q, q_n);
     
    /*******************************************************************************
     * @brief Toggles the clock signal every half clock period.
     ******************************************************************************/
     initial 
     begin: CLOCK_PROCESS
         clock <= !clock;
         #(CLOCK_PERIOD/2);
     end
     
    /*******************************************************************************
     * @brief Simulates system reset after eight clock cycles.
     ******************************************************************************/
     initial 
     begin: RESET_PROCESS
          reset_n <= 1;
          #(CLOCK_PERIOD * 8);
          reset_n <= 0;
          #(CLOCK_PERIOD * 8);
     end
     
    /*******************************************************************************
     * @brief Simulates all input combinations 00 - 11 of {enable, d} four times
     *        to check the locking mechanism when the output is high and low, both
     *        during normal execution and during system reset. Each combination
     *        is tested during 10 ns, hence the the total simulation time is 
     *        4 x 4 x 10 ns = 160 ns.
     ******************************************************************************/
     initial
     begin: INPUT_PROCESS
         for (int i = 0; i < 4; ++i) begin
             for (int j = 0; j < 4; ++j) begin
                 {enable, d} <= j;
                 #(CLOCK_PERIOD);
             end
         end
         $finish;
     end 

endmodule 