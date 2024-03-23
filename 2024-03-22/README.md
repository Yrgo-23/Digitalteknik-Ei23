# 2024-03-22 - Introduktion till VHDL

Konstruktion av en OR-grind i VHDL.

Filen "or_gate.vhd" innehåller modulen or_gate, som utgör en OR-grind realiserad i VHDL.  

Filen "or_gate.qar" utgör en arkivfil innehållande modulen or_gate med kPINs konfigurerade för in- och utportarna.  
Denna fil kan öppnas i Quartus för att testa konstruktionen.  

## Nyckelord i VHDL

### entity
entity utgör utsidan av en modul, där portarna deklareras. Som exempel kan en OR-grind med inportar a och b samt utport x deklareras via en entitet döpt or_gate såsom visas nedan:  

```vhdl
entity or_gate is  
    port(a, b: in std_logic;  
         x   : out std_logic);  
end entity;  
```

### architecture 
architecture utgör insidan av en modul, där modulens beteende/funktionalitet beskrivs.  
Som exempel, arkitekturen för entiteten or_gate ovan kan definieras såsom visas nedan för att realisera funktionaliteten av en OR-grind:  

```vhdl
architecture behaviour of or_gate is  
begin  
    x <= a or b;  
end architecture;  
```

### std_logic
std_logic utgör en datatyp för signaler som ska kunna anta logiska värden ’0’ och ’1’ samt övriga värden som behövs för att realisera  digitala signaler i praktiken, såsom högohmig/tri-state (’Z’), don’t care (’-’) med mera.  

std_logic utgör ett utmärkt val för signaler och variabler som ska tilldelas en eller flera bitar (för fler bitar används datatypen  std_logic_vector, dvs. en vektor med bitar).  

I VHDL måste datatypen std_logic inkluderas från ett package döpt std_logic_1164 i biblioteket IEEE, vilket åstadkommes via följande instruktioner:  

library ieee;  
use ieee.std_logic_1164.all;  

### process
En process utgör ett sekventiellt block, vilket innebär att innehållet exekverar sekventiellt (uppifrån och ned) en instruktion i taget, så som sker vid  mjukvaruprogrammering i C, C++, Python eller andra språk. Genom att använda flera processer kan saker ske parallellt för ökad prestanda, likt flertrådade mjukvaruprogram.   

Funktionaliteten för OR-grinden ovan hade kunnat realiseras via en process döpt OR_PROCESS såsom visas nedan. Processen i fråga exekverar vid förändring av någon av  insignaler a och b, vilket implementeras genom att deklarera dessa portar i den så kallade känslighetslistan (innehållet i parentesen efter nyckelordet or_gate).  
Via en if-else sats sätts utsignal x till hög om antingen a eller b är höga, annars sätts x till 0:  

```vhdl
architecture behaviour of or_gate is
begin
    OR_PROCESS: process(a, b) is
    begin
        if (a = '1' or b = '1') then
            x <= '1';
        else
            x <= '0';
        end if;
    end process;
end architecture;
```

### signal
Nyckelordet signal används för interna signaler inom en arkitektur, tänk ledningar mellan logiska grindar. Signaler kan tilldelas ett värde kontinuerligt eller via en  process.  

Signalens värde kan läsas i hela arkitekturen, men tilldelning kan bara ske från en källa. Signaler kan därmed användas likt filglobala variabler i ett   programspråk; i detta fall sträcker sig dock synligheten inte till hela filen, utan till den aktuella arkitekturen.  

Alla signaler deklareras i den deklarativa delen av arkitekturen, alltså direkt ovanför nyckelordet begin.   

Som exempel på användning av en signal i ett system med insignaler a, b, c och d och utsignal x som ska uppfylla den logiska funktionen x = a + b’cd kan en signal döpt y = b’cd implementeras enligt nedan, i detta fall primärt för att göra koden mer läsbar:  

```vhdl
library ieee;
use ieee.std_logic_1164.all;
 
entity signal_example is
    port(a, b, c, d: in std_logic;
         x         : out std_logic);
end entity;
 
architecture behaviour of signal_example is
signal y: std_logic;
begin
    y <= (not b) and c and d;
    x <= a or y;
end architecture;
```

Utan att använda signalen Y hade koden sett ut såsom visas nedan:  

```vhdl
library ieee;
use ieee.std_logic_1164.all;
 
entity signal_example is
    port(a, b, c, d: in std_logic;
         x         : out std_logic);
end entity;
 
architecture behaviour of signal_example is
begin
       x <= a or ((not b) and c and d);
end architecture;
```


