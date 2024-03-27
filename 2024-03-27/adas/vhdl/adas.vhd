--------------------------------------------------------------------------------
-- @brief Implementation of ADAS (Advanced Driver Assistance System).
--
-- @param driver_break[in]   Signal from break pedal.
-- @param camera[in]         Indicates an object in front of the vehicle.
-- @param radar[in]          Indicates an object approaching the vehicle.
-- @param adas_error[in]     Indicates ADAS error.
-- @param vehicle_break[out] Break signal to the engine.
--
-- @note If the driver breaks or ADAS indicates an object approaching the 
--       vehicle, the vehicle break will be enabled. The camera and radar
--       signals are ignored if an ADAS-related error occurs.
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity adas is
    port(driver_break, camera, radar, adas_error: in std_logic;
         vehicle_break                          : out std_logic);
end entity;

architecture behaviour of adas is

--------------------------------------------------------------------------------
-- @param adas_break Indicates if the ADAS system tells us to break. 
--------------------------------------------------------------------------------
signal adas_break: std_logic := '0';
begin
    adas_break    <= camera and radar and (not adas_error);
    vehicle_break <= driver_break or adas_break;
end architecture; 