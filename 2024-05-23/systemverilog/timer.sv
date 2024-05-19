/*******************************************************************************
 * @brief Implementation of timer with selectable frequency in the range 
 *        0.1 - 10 Hz.
 *
 * @tparam FREQUENCY The timer frequency (default = 1 Hz).
 *
 * @param clock      50 MHz system clock.
 * @param reset_s2_n Asynchronous inverting reset signal.
 * @param enabled    Enable signal for the timer (1 = enabled).
 * @param elapsed    Indicates if the timer has elapsed.
 ******************************************************************************/
import definitions::*;

module timer
    #(timer_frequency_t FREQUENCY = TIMER_FREQUENCY_1HZ)
     (input logic clock, reset_s2_n, enabled,
      output logic elapsed);
      
    /*******************************************************************************
     * @brief Signals and parameters used internally for the timer.
     *
     * @param COUNTER_MAX Max value of the internal counter.
     * @param counter     Counter register, which counts from 0 - COUNTER_MAX.
     *                    When counter = COUNTER_MAX, the timer has elapsed.
     ******************************************************************************/ 
     localparam logic[31:0] COUNTER_MAX = FREQUENCY;
     logic[31:0] counter                = '0;
     
    /*******************************************************************************
     * @brief Updates the counter on rising edge of the system clock and upon
     *        system reset. The counter is immediately cleared during system reset.
     *        During normal execution, the counter increments each clock cycle.
     *        When the counter is equal to (or more than) COUNTER_MAX, the timer
     *        has elapsed and the counter is cleared.
     ******************************************************************************/ 
     always_ff @ (posedge clock or negedge reset_s2_n)
     begin: COUNTER_PROCESS
         if (!reset_s2_n) begin
             counter <= '0;
             elapsed <= '0;
         end
         else begin
             if (enabled) begin
                 counter <= counter + 1;
                 if (counter >= COUNTER_MAX) begin
                     elapsed <= '1;
                     counter <= '0;
                 end
                 else begin
                     elapsed <= '0;
                 end
             end
             else begin
                 elapsed <= '0;
             end
         end
     end
      
endmodule 