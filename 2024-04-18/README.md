# 2024-04-18 - Konstruktion av adderare

Konstruktion av en heladderare, både för hand med simulering i CircuitVerse samt i VHDL med simulering i ModelSim. 

Heltalsadderaren har tre insignaler A, B och Cin (carry in) samt två utsignaler Sum (sum) och Cout (carry out).  
Summan av insignalerna tilldelas utsignal Sum. Eftersom Sum bara utgörs av en bit kan det hända att vi får en carry-bit, 
som tilldelas utsignal Cout.  

Man kan också tänka att utsignalerna tillsammans utgör ett 2-bitars tal, där Cout utgör MSB (mest signifikant bit).  
Heladdarens logik kan då uttryckas i en ekvation såsom visas nedan:  

{Cout, Sum} = A + B + Cin

Därmed gäller att
* {Cout, Sum} = {0, 0} om A + B + Cin = 0
* {Cout, Sum} = {0, 1} om A + B + Cin = 1
* {Cout, Sum} = {1, 0} om A + B + Cin = 2
* {Cout, Sum} = {1, 1} om A + B + Cin = 3

Heladderarens sanningstabell visas nedan:  

|  {A, B, Cin}  |  {Cout, Sum}  |  
| :-----------: | :-----------: |  
|      000      |      00       |  
|      001      |      01       |  
|      010      |      01       |     
|      011      |      10       |    
|      100      |      01       |   
|      101      |      10       |     
|      110      |      10       |      
|      111      |      11       |  

Filen *full_adder.png* utgör multiplexerns grindnät, realiserat för hand och simulerat i CircuitVerse.

Katalogen *vhdl* innehåller syntesbar kod för konstruktionen, skriven i VHDL. Här har insignaler {A, B, Cin} döpts till *inputs*
och anslutits till var sin slide-switch. Utsignaler {Cout, Sum} har döpts till outputs och har anslutits till var sin lysdiod.

**Vid intresse**, se motsvarande konstruktion skriven i SystemVerilog i katalogen *systemverilog*.

**Tips:** Använd .qar-filen i respektive katalog för att direkt öppna motsvarande projektet med pins samt testbänk konfigurerade.
