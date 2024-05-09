# 2024-05-07 - Eventdetektering med D-vippor

Eventdetektering för toggling av en lysdiod vid nedtryckning av en tryckknapp, implementerat
via eventdetektering med D-vippor. En asynkron reset-signal ansluten till en tryckknapp
har lagts till för att enkelt kunna genera systemåterställning.

## Gridnät
Filen *led_toggle.png* utgör grindnätet för konstruktionen, implementerat i CircuitVerse.  

Filen *led_toggle.cv* kan importeras i CircuitVerse för att simulera konstruktionen (klicka *Project -> Import File* och välj denna fil).

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
