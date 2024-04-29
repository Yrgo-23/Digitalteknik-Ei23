# 2024-04-29 - Delkomponenter i VHDL (del II)

Konstruktion av system för att skriva ut ett hexadecimalt tal på en given 7-segmentsdisplay.
Talet som ska skrivas ut matas in på 4-bitars binär form. 

Konstruktionen innehåller syntesbar kod samt testbänk för en delkomponent som hanterar vilket tal som
skrivs ut på ansluten 7-segmentsdisplay.  

## Syntesbar kod i VHDL
Katalogen *vhdl* innehåller syntesbar kod samt testbänk för konstruktionen, skriven i VHDL.  

## Exempelkod i SystemVerilog
Katalogen *systemverilog* innehåller konstruktionen skriven i SystemVerilog. 

## Testa bifogade exempel
Ladda ned och öppna .qar-filen i respektive katalog för att direkt öppna projektet med pins konfigurerade.  
Efter att ha öppnat projektet, klicka på *Restore project* i den ruta som kommer upp.  
Kompilera sedan koden, anslut ett FPGA-kort och flasha till denna.  
