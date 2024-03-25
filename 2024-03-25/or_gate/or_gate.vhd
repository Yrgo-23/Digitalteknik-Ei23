------------------------------------------------------------------------------------------------
-- @brief Implementation of an OR gate.
--
-- @param a[in]  First input bit of the OR gate.
-- @param b[in]  Second input bit of the OR gate.
-- @param x[out] Output of the OR gate.
--
-- @note We include the package std_logic_1164 from library ieee to utilize the std_logic
--       data type, which is widely used for bits in VHDL. 
--
-- @note A module consists of an entity and (at least one) architecture.
--
-- @note The entity is the outside of the module. Here we declare ports (inputs and outputs).
--       An entity shall be defined as shown below:
--
--       entity <ENTITY_NAME> is
--           port(<PORT1_NAME>: <DATA_DIRECTION> <DATA_TYPE>;
--                <PORT2_NAME>: <DATA_DIRECTION> <DATA_TYPE>);
--       end entity;

-- @note The architecture is the inside of the module. Here we describe the behaviour/function
--       of the module. An architecture shall defined as shown below:
--
--       architecture <ARCHITECTURE_NAME> of <ENTITY_NAME> is
--       -- Declaration of signals and constants. --
--       begin
--           -- Implementation of behaviour. --
--       end architecture;
------------------------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity or_gate is
    port(a, b: in std_logic; 
         x   : out std_logic);
end entity;

architecture behaviour of or_gate is
begin
    x <= a or b;
end architecture;