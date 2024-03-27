# 2024-03-27 - Syntes och simulering i VHDL (del II)

Skapande av testbänkar för logiska grindnät.

Katalogen "or_gate" innehåller modulen *or_gate* inklusive testbänk, skriven i VHDL respektive SystemVerilog.  

Katalogen "adas" innehåller modulen *adas* inklusive testbänk, skriven i VHDL respektive SystemVerilog.

**Tips**  
Använd .qar-filen i respektive katalog för att direkt öppna motsvarande projektet med pins samt testbänk konfigurerade.


## Exempel på testbänk

Anta att vi ska testa samtliga kombinationer 0000 - 1111 av insignaler till en modul döpt *net1*, vars entitet visas nedan:

```vhdl
entity net1 is
    port(a, b, c, d: in std_logic;
         x         : out std_logic);   
end entity;  
```

En enkel testbänk för ovanstående modul i VHDL har följande struktur:  

```vhdl
library ieee;
use ieee.std_logic_1164.all; -- Innehåller datatyper std_logic och std_logic_vector.
use ieee.numeric_std.all;    -- Innehåller datatyper natural och unsigned.

entity net1_tb is   
end entity;  
```

```vhdl
architecture behaviour of net1_tb is

--------------------------------------------------------------------------------
-- Deklaration av signaler som ska kopplas till toppmodulens portar.
-- Samtliga signaler initieras till 0 (apostrofer används runt enskilda bitar
-- i VHDL, för multipla bitar används i stället citattecken).
--------------------------------------------------------------------------------
signal a, b, c, d, x: std_logic := '0';
begin

    --------------------------------------------------------------------------------
    -- Vi skapar en instans av modulen vi ska testa och ansluter våra signaler till 
    -- dess portar. Vi döper instansen till sim_instance i detta fall och deklarerar 
    -- att det är en instans av entiteten net1 i vårt arbetsbibliotek work, dvs. en 
    -- av våra lokala filer.
    --------------------------------------------------------------------------------
    sim_instance: entity work.net1
    port map(a, b, c, d, x);      

    --------------------------------------------------------------------------------
    -- Vi testar samtliga kombinationer 0000 - 1111 av insignaler abcd under 10 ns 
    -- var via en process, dvs. ett sekventiellt block, som i detta fall döps till 
    -- sim_process. Vi genererar naturliga tal 0 - 15 via en for loop och omvandlar 
    -- dem till fyra bitar i två steg, först från naturligt tal till 4-bitars 
    -- osignerad form och sedan till std_logic_vector (en bitarray). Dessa bitar 
    -- tilldelas till signaler abcd, som är anslutna till portarna med samma namn.
    -- Efter simuleringen är slutförd stannar vi processen, annars hade processen 
    -- startats om från början.
    --------------------------------------------------------------------------------
    sim_process: process is
    begin
        for i in 0 to 15 loop                                    -- Kör en loop där 0 <= i <= 15.
            (a, b, c, d) <= std_logic_vector(to_unsigned(i, 4)); -- Tilldelar talet i på 4-bitars binär form.
            wait for 10 ns;                                      -- Väntar 10 ns innan nästa kombination av abcd testas.
        end loop;      
        wait;                                                    -- Fryser processen efter att alla 16 kombinationer har testats.
    end process;
    
end architecture;
```

Mer information om nyckelorden *process* samt *signal* finns här:  
https://github.com/Yrgo-23/Digitalteknik-Ei23/blob/main/2024-03-22/README.md