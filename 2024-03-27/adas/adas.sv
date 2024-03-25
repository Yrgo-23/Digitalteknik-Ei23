/*******************************************************************************
 * @brief Implementation of ADAS (Advanced Driver Assistance System).
 *
 * @param driver_break[in]   Signal from break pedal.
 * @param camera[in]         Indicates an object in front of the vehicle.
 * @param radar[in]          Indicates an object approaching the vehicle.
 * @param adas_error[in]     Indicates ADAS error.
 * @param vehicle_break[out] Break signal to the engine.
 *
 * @note If the driver breaks or ADAS indicates an object approaching the 
 *       vehicle, the vehicle break will be enabled. The camera and radar
 *       signals are ignored if an ADAS-related error occurs.
 ******************************************************************************/
module adas(input logic driver_break, camera, radar, adas_error,
            output logic vehicle_break);
    assign adas_break    = camera & radar & !adas_error;
    assign vehicle_break = driver_break | adas_break;
endmodule 