--------------------------------------------------------------------------------
-- @brief Implementation of a 4-bit comparator consisting of inputs abcd and 
--        outputs xyzv.
--
--        The truth table of the comparator is shown below:
--
--        | abcd | xyz |
--        | 0000 | 010 |
--        | 0001 | 001 |
--        | 0010 | 001 |
--        | 0011 | 001 |
--        | 0100 | 100 |
--        | 0101 | 010 |
--        | 0110 | 001 |
--        | 0111 | 001 |
--        | 1000 | 100 |
--        | 1001 | 100 |
--        | 1010 | 010 |
--        | 1011 | 001 |
--        | 1100 | 100 |
--        | 1101 | 100 |
--        | 1110 | 100 |
--        | 1111 | 010 |
--
-- @param abcd[in] Comparator input.
-- @param xyz[out] Comparator output.
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity comparator_4bit is
    port(abcd: in std_logic_vector(3 downto 0);
         xyz : out std_logic_vector(2 downto 0));
end entity;

architecture behaviour of comparator_4bit is
begin
    output_process: process(abcd) is
    begin
        case (abcd) is
            when "0000" => xyz <= "010";
            when "0001" => xyz <= "001";
            when "0010" => xyz <= "001";
            when "0011" => xyz <= "001";
            when "0100" => xyz <= "100";
            when "0101" => xyz <= "010";
            when "0110" => xyz <= "001";
            when "0111" => xyz <= "001";
            when "1000" => xyz <= "100";
            when "1001" => xyz <= "100";
            when "1010" => xyz <= "010";
            when "1011" => xyz <= "001";
            when "1100" => xyz <= "100";
            when "1101" => xyz <= "100";
            when "1110" => xyz <= "100";
            when "1111" => xyz <= "010";
            when others => xyz <= "000";
        end case;
    end process;
end architecture;