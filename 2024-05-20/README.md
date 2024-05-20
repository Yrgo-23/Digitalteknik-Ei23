# 2024-05-20 - Generiska parametrar i VHDL

Implementering av generiska parametrar för val av antalet tryckknappar och lysdioder i en konstruktion.

## Generic
Generic är ett sätt att öka mångformigheten i en modul via parametrar, vars värde kan väljas vid instansiering.
Exempelvis kan frekvensen på en timer, antalet tryckknappar eller lysdioder eller annat sättas vid instansiering av en viss modul. 

Därmed kan en enda modul användas för ett specifikt ändamål (såsom en timerimplementering), i stället för att använda flera snarlika moduler (tänk separata timermodul för varje olika frekvenser eller separata moduler för olika antal tryckknappar).

Generiska parametrar är en typ av konstanter, vars värde sätts vid instansiering av en modul (eller via ett default-värde som
inget värde specifikt anges). 

Generiska parametrar definieras i entitetsdeklarationen. Nedan visas ett exempel på en generisk entitetsdeklaration innehållande ett valfritt antal lysdioder mellan 1 – 100. Defaultvärdet sätts till 10 via den generiska parametern LED_COUNT. Därmed gäller att om användaren inte specificerar något värde på LED_COUNT vid instansiering sätts antalet lysdioder till tio:  

```vhdl
entity led_module is
    generic(LED_COUNT  : natural range 1 to 100 := 1); -- Det är okej att skippa defaultvärdet.
    port(clock, reset_n: in std_logic;
         led           : out std_logic_vector(LED_COUNT - 1 downto 0));
end entity;
```

Vid instansiering av ovanstående modul kan antalet lysdioder definieras via en generic map enligt nedan. 
I detta exempel sätts antalet lysdioder till två:

```vhdl
    led_instance: entity work.led_module
    generic map(LED_COUNT => 2) -- Det går också att skriva 2 direkt i parentesen.
    port map(clock, reset_n, led);
```

Det är okej att skippa generic map om samtliga generiska parametrar har ett defaultvärde. Om man skippar generic map används defaultvärdet på respektive generisk parameter. Eftersom vi tidigare satte den generiska parametern LED_COUNT till 10 sätts antalet lysdioder som default till tio om vi instansierar enligt nedan:

```vhdl
led_instance: entity work.led_module
port map(clock, reset_n, led);
```

## Gridnät
Filen *led_toggle_generic.png* utgör grindnätet för konstruktionen med tre lysdioder och tre tryckknappar, implementerat i CircuitVerse.  

Filen *led_toggle_generic.cv* kan importeras i CircuitVerse för att simulera konstruktionen (klicka *Project -> Import File* och välj denna fil).

## Syntesbar kod i VHDL
Katalogen *vhdl* innehåller konstruktionen skriven i VHDL.  
* Ladda ned och öppna .qar-filen i denna katalog för att direkt öppna projektet med pins konfigurerade.   
* Efter att ha öppnat projektet, klicka på *Restore project* i den ruta som kommer upp.  
* Kompilera sedan koden, anslut ett FPGA-kort och flasha till denna. 

## Syntesbar kod i SystemVerilog
Katalogen *systemverilog* innehåller konstruktionen skriven i SystemVerilog.  
Ladda ned och öppna .qar-filen i denna katalog för att direkt öppna projektet med pins konfigurerade.  

Efter att ha öppnat projektet, klicka på *Restore project* i den ruta som kommer upp.  
Kompilera sedan koden, anslut ett FPGA-kort och flasha till denna.  

