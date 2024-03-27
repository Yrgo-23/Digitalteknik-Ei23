--------------------------------------------------------------------------------
-- @brief Test bench for the adas module. Each combination 0000 - 1111 of the 
--        inputs is tested during 10 ns, hence the simulation time is 160 ns.
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity adas_tb is
end entity;

architecture behaviour of adas_tb is

--------------------------------------------------------------------------------
-- @brief Signals used to simulate the adas module. These signals are connected
--        to the corresponding ports with the same name. By doing this, we can 
--        control the input and check the output of the adas module.
--------------------------------------------------------------------------------
signal driver_break, camera, radar, adas_error, vehicle_break: std_logic := '0';

begin

    --------------------------------------------------------------------------------
    -- @brief Creates an instance of module adas for testing and connects its ports
    --        with the same name for testing.
    --------------------------------------------------------------------------------
    sim_instance: entity work.adas
    port map(driver_break, camera, radar, adas_error, vehicle_break);
    
    --------------------------------------------------------------------------------
    -- @brief Test all combinations 0000 - 1111 of the inputs. Each combination is 
    --        tested during 10 ns, hence the simulation time is 160 ns.
    --
    -- @note The process is halted when the simulation is finished, else it would 
    --       start all over again.
    --------------------------------------------------------------------------------
    sim_process: process is
    begin
        for i in 0 to 15 loop
            (driver_break, camera, radar, adas_error) <= std_logic_vector(to_unsigned(i, 4));
            wait for 10 ns;
        end loop;
        wait;
    end process;
    
end architecture;