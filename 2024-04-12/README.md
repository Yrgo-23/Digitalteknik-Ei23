# 2024-04-12 - Konstruktion av komparatorer

Konstruktion av en 4-bitars komparator, både för hand med simulering i CircuitVerse samt i VHDL med simulering i ModelSim. 

Komparatorn har fyra inportar ABCD samt tre utportar XYZ.  
Inportar AB respektive CD fungerar som 2-bitars tal som jämförs med varandra.   

Komparatorn fungerar därmed enligt nedan:

* AB > CD => XYZ = 100   
* AB = CD => XYZ = 010  
* AB < CD => XYZ = 001   

Sanningstabellen för komparatorn visas nedan:  

|  ABCD  |  XYZ  |  
| :----: | :---: |  
|  0000  |  010  |  
|  0001  |  001  |  
|  0010  |  001  |     
|  0011  |  001  |    
|  0100  |  100  |   
|  0101  |  010  |     
|  0110  |  001  |      
|  0111  |  001  |  
|  1000  |  100  |  
|  1001  |  100  |  
|  1010  |  010  |     
|  1011  |  001  |    
|  1100  |  100  |   
|  1101  |  100  |     
|  1110  |  100  |      
|  1111  |  010  |  

Filen *comparator_4bit.png* utgör komparatorns grindnät, realiserat för hand och testat i CircuitVerse.
Se dokumentet *Lösningsförslag övningsuppgifter 2024-04-12.pdf* på Classroom för detaljerade instruktioner gällande
framtagandet av grindnätet.  

Katalogen *vhdl* innehåller syntesbar kod samt testbänk för konstruktionen, skriven i VHDL.

**Vid intresse**, se motsvarande konstruktion skriven i SystemVerilog i katalogen *systemverilog*.

**Tips:** Använd .qar-filen i respektive katalog för att direkt öppna motsvarande projektet med pins samt testbänk konfigurerade.

Filen *struct_demo.c* demonstrerar användning av struktar i C för enkel hantering av persondata.  