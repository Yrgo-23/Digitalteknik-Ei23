# 2024-05-06 - Konstruktion av D-vippan

Konstruktion av D-vippan via:
* Realisering samt simulering av grindnät CircuitVerse.
* Hårdvarubeskrivande kod i VHDL.

## Skillnaden mellan latchar och vippor 
Latchar (låskretsar) och vippor (*flip flops* på engelska) är två typer av enkla minneskretsar som kan lagra en bit. För båda kretsar kan utsignalen låsas via en enable-signal. 

De primära skillnaderna mellan latchar och vippor är att:
* Vippor är synkrona, vilket innebär att utsignalen enbart uppdateras vid klockpuls, medan latchar är asynkrona, vilket innebär att utsignalen uppdateras direkt (förutsatt att latchen respektive vippan är "öppen" i respektive fall).
* Vippor kräver mer hårdvara (klockan samt reset-signalerna medför att antalet grindar ökar) och är långsammare (då signalerna inte uppdateras omedelbart), men medför kraftigt förbättrad kontroll av timing (då uppdatering enbart sker vid klockpuls), vilket är särskilt viktigt i större digitala system.

*Att vippor är synkroniserade kan liknas vid att medlemmar i en storbandsorkester spelar i samma takt, där systemklockan utgör trumslagaren. Detta ökar strukturen på låtarna, där alla spelar samma del av en låt samtidigt. Dock krävs mer resurser på grund av en trumslagare. Latchar kan liknas vid att medlemmarna spelar i olika takt, vilket minskar mängden resurser, men samtidigt kan strukturen på låtarna bli lidande. Därmed föredras normalt vippor framför latchar.*

## Gridnät
Filen *d_flip_flop.png* utgör grindnät för D-vippan med en asynkron reset-signal, implementerad i CircuitVerse.  

Filen *d_flip_flop.cv* kan importeras i CircuitVerse för att simulera konstruktionen (klicka *Project -> Import File* och välj denna fil).

## Syntesbar kod samt testbänk i VHDL
Katalogen *vhdl* innehåller konstruktionen skriven i VHDL.  
* Ladda ned och öppna .qar-filen i denna katalog för att direkt öppna projektet med pins konfigurerade.   
* Efter att ha öppnat projektet, klicka på *Restore project* i den ruta som kommer upp.  
* Kompilera sedan koden, anslut ett FPGA-kort och flasha till denna. 

## Syntesbar kod samt testbänk i SystemVerilog
Katalogen *systemverilog* innehåller konstruktionen skriven i SystemVerilog.  
Ladda ned och öppna .qar-filen i denna katalog för att direkt öppna projektet med pins konfigurerade.  

