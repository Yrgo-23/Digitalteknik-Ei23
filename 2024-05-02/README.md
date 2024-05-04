# 2024-05-02 - Konstruktion av D-latchen

Implementering av D-latchen, både för hand med simulering i CircuitVerse samt i VHDL med simulering i ModelSim. 

## Grundläggande information om D-latchen
D-latchen är en typ av låskrets (latch på engelska). Latchar är enkla minneskretsar som kan lagra en bit. 
Utsignalen (den bit som lagras) kan låsas via en enable-signal. Bara när latchen är öppen kan utsignalen uppdateras.

D-latchen innehar följande portar:  
* **D[in]**: D-latchens insignal, som enbart utgörs av en bit.
* **enable[in]**: Låssignal (1 => latchen är öppen, 0 => latchen är låst).
* **Q[out]**: D-latchens utsignal, vilket är den bit som "lagras".
* **Qn[out]**: Inversen av D-latchens utsignal.

Kortfattat fungerar latchen så här:
* **enable = 0** => latchen är låst => Q och Qn oförändrade.
* **enable = 1** => latchen är öppen => Q = D, Qn = D'.
* **Vid tiden t = 0** gäller att Q = 0 och Qn = 1.

Latchar är asynkrona, vilket innebär att utsignalen uppdateras direkt ifall latchen är öppen. Vi kommer senare gå igenom vippor, där utsignalen först uppdateras vid stigande klockpuls. 

## Grindnät
Filen *d_latch.png* utgör D-latchens grindnät, realiserat för hand och simulerat i CircuitVerse. 

Filen *d_latch.cv* kan öppnas i CircuitVerse för att testa latchens funktion (klicka på Project -> Import file och välj denna fil).

# Syntesbar kod och testbänk i VHDL
Katalogen *vhdl* innehåller syntesbar kod för konstruktionen, skriven i VHDL. Här har insignaler {d, enable} anslutits till var sin slide-switch,
medan Utsignaler {q, q_n} har anslutits till var sin lysdiod.

## Exempelkod i SystemVerilog
Katalogen *systemverilog* innehåller konstruktionen skriven i SystemVerilog.  
Ladda ned och öppna .qar-filen i denna katalog för att direkt öppna projektet med pins konfigurerade.  

**Tips:** Använd .qar-filen i respektive katalog för att direkt öppna motsvarande projektet med pins samt testbänk konfigurerade.
Efter att ha öppnat projektet, klicka på *Restore project* i den ruta som kommer upp.  
Kompilera sedan koden, anslut ett FPGA-kort och flasha till denna.  
