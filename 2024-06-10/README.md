# 2024-06-10 - Tillståndsmaskiner (del III)

Implementering av en tillståndsmaskin för styrning av en lysdiod.

Tillståndsmaskinen innehar tre tillstånd:
* STATE_OFF: Lysdioden hålls släckt.
* STATE_BLINK: Lysdioden blinkar var 100:e millisekund
* STATE_ON: Lysdioden hålls tänd.

Byte av tillstånd görs via två tryckknappar. En reset-signal används för att återstålla tillståndsmaskinen till STATE_OFF.  

## Gridnät
Filen *fsm2.png* utgör grindnätet för tillståndsmaskinen, implementerat i CircuitVerse.  

Filen *fsm2.cv* kan importeras i CircuitVerse för att simulera konstruktionen (klicka *Project -> Import File* och välj denna fil).

## Syntesbar kod i VHDL
Katalogen *vhdl* innehåller konstruktionen skriven i VHDL.  
* Ladda ned och öppna .qar-filen i denna katalog för att direkt öppna projektet med pins konfigurerade.   
* Efter att ha öppnat projektet, klicka på *Restore project* i den ruta som kommer upp.  
* Kompilera sedan koden, anslut ett FPGA-kort och flasha till denna. 

## Syntesbar kod i SystemVerilog
Katalogen *systemverilog* innehåller konstruktionen skriven i SystemVerilog.  
Ladda ned och öppna .qar-filen i denna katalog för att direkt öppna projektet med pins konfigurerade.  

## Exempelkod i C
Katalogen *c* innehåller motsvarande system för mikroprocessor ATmega328P, skrivet i C.  

## Exempelkod i C++
Katalogen *cpp* innehåller motsvarande system för mikroprocessor ATmega328P, skrivet i C++ med mitt eget bibliotek.  
Använd gärna detta bibliotek för framtida projekt inom inbyggda system om ni vill testa på C++.    

**OBS!** All kod applicerad specifikt för tillståndsmaskinen finns i *main.cpp*, resterande kod utgörs av biblioteket i sig. 

