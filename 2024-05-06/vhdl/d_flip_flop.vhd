--------------------------------------------------------------------------------
-- @brief Design of a D flip flop with an inverting asynchronous reset.
--
-- @param clock[in]   50 MHz system clock.
-- @param reset_n[in] Inverting reset signal (0 = system reset).
-- @param d[in]       Flip flop input.
-- @param enable[in]  Enable signal for opening/locking the flip flop (1 = open).
-- @param q[out]      Flip flop output.
-- @param q_n[out]    Inverse of the flip flop output.
--
-- The function of the D flip flop is as follows:
--     - reset_n = 0                => q = 0, q_n = 1
--     - reset_n = 1 and enable = 0 => q = q, q_n = q_n
--     - reset_n = 1 and enable = 1 => q = d, q_n = ~d
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity d_flip_flop is
    port(clock, reset_n, d, enable: in std_logic; 
         q, q_n                   : out std_logic);
end entity;

architecture behaviour of d_flip_flop is

--------------------------------------------------------------------------------
-- @param q_s Signal used to store the flip flop output internally.
--------------------------------------------------------------------------------
signal q_s: std_logic := '0';
begin

    --------------------------------------------------------------------------------
	 -- @brief Updates the the q_s signal on rising edge of the clock and falling
    --        edge of the reset signal. The q_s signal is cleared immediately upon 
    --        system reset.
	 --------------------------------------------------------------------------------
    process (clock, reset_n) is
    begin
        if (reset_n = '0') then 
            q_s <= '0';
        elsif (rising_edge(clock)) then 
            if (enable = '1') then 
                q_s <= d;         
            end if;
        end if;
    end process;

    --------------------------------------------------------------------------------
    -- @brief Updates the output signals via continuous assignments.
    --------------------------------------------------------------------------------
    q   <= q_s;
    q_n <= not q_s;

end architecture;