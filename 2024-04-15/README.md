# 2024-04-15 - Konstruktion av multiplexers

Konstruktion av en 8-to-1 multiplexer, både för hand med simulering i CircuitVerse samt i VHDL med simulering i ModelSim. 

Multiplexern har åtta inportar A - H, tre selektorsignaler S[2:0] samt en utport X.

Selektorsignalerna S[2:0] avgör vilken av insignalerna som ansluts till utgången enligt nedan:

* S[2:0] = 000 => X = A
* S[2:0] = 001 => X = B
* S[2:0] = 010 => X = C
* S[2:0] = 011 => X = D
* S[2:0] = 100 => X = E
* S[2:0] = 101 => X = F
* S[2:0] = 110 => X = G
* S[2:0] = 111 => X = H

Filen *mux_8_to_1.png* utgör multiplexerns grindnät, realiserat för hand och simulerat i CircuitVerse.

Katalogen *vhdl* innehåller syntesbar kod för konstruktionen, skriven i VHDL. Här har insignaler A - H döpts till *inputs*
och anslutits till var sin slide-switch. Selektorsignalerna har anslutits till var sin tryckknapp med aktivt låg signal.
Selektorsignalerna är därmed inverterande och har därmed döpts *sel_n*. Inversen av selektorsignalerna används internt via en signal döpt *sel*.

**Vid intresse**, se motsvarande konstruktion skriven i SystemVerilog i katalogen *systemverilog*.

**Tips:** Använd .qar-filen i respektive katalog för att direkt öppna motsvarande projektet med pins samt testbänk konfigurerade.
