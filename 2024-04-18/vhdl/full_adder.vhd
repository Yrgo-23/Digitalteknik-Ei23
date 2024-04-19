--------------------------------------------------------------------------------
-- @brief Implementation of a full adder consisting of inputs {a, b, cin} and
--        outputs {cout, sum}. The truth table is shown below:
--
--        {a, b, cin} {cout, sum}
--            000          00
--            001          01
--            010          01
--            011          10
--            100          01
--            101          10
--            110          10
--            111          11
--
-- @param inputs[in]   Inputs and carry in.
-- @param outputs[out] Carry out and sum of inputs.
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity full_adder is
    port(inputs : in std_logic_vector(2 downto 0);
         outputs: out std_logic_vector(1 downto 0));
end entity;

architecture behaviour of full_adder is
begin
    --------------------------------------------------------------------------------
    -- @brief Updates the output whenever the input changes. 
    --------------------------------------------------------------------------------
    output_process: process (inputs) is
    begin
        case (inputs) is
            when "000"  => outputs <= "00";
            when "001"  => outputs <= "01";
            when "010"  => outputs <= "01";
            when "011"  => outputs <= "10";
            when "100"  => outputs <= "01";
            when "101"  => outputs <= "10";
            when "110"  => outputs <= "10";
            when "111"  => outputs <= "11";
            when others => outputs <= "00";
        end case;
    end process;
    
end architecture;