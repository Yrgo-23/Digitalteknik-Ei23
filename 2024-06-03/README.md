# 2024-06-03 - Tillståndsmaskiner (del I)

Exempel på implementering av enkel tillståndsmaskin innehållande fyra tillstånd STATE_0, STATE_1, STATE_2 samt STATE_3. 
* En lysdiod hålls tänd i STATE_3, för övriga tillstånd hålls den släckt.
* En tryckknapp används för att byta tillstånd till nästa.  
* En reset-signal används för att återstålla tillståndsmaskinen till STATE_0.
* Konstruktionen är cirkulär, så tillståndet nästa tillstånd efter STATE_3 är STATE_0.

## Exempelkod i SystemVerilog
Katalogen *systemverilog* innehåller konstruktionen skriven i SystemVerilog.  
Ladda ned och öppna .qar-filen i denna katalog för att direkt öppna projektet med pins konfigurerade.  

Efter att ha öppnat projektet, klicka på *Restore project* i den ruta som kommer upp.  
Kompilera sedan koden, anslut ett FPGA-kort och flasha till denna.  

## Exempelkod i C
Katalogen *c* innehåller motsvarande system för mikroprocessor ATmega328P, skrivet i C.  

