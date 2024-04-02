# 2024-04-02 - Syntes och simulering i VHDL (del III)

Syntes och simulering av ett logiskt grindnät innehållande insignaler ABCD samt utsignaler XY.

Sanningstabellen för grindnätet visas nedan:  

|  ABCD  |  XY  |  
| :----: | :--: |  
|  0000  |  10  |  
|  0001  |  10  |  
|  0010  |  00  |     
|  0011  |  00  |    
|  0100  |  11  |   
|  0101  |  11  |     
|  0110  |  01  |      
|  0111  |  01  |  
|  1000  |  10  |  
|  1001  |  00  |  
|  1010  |  10  |     
|  1011  |  00  |    
|  1100  |  11  |   
|  1101  |  11  |     
|  1110  |  11  |      
|  1111  |  11  |  

Katalogen *vhdl* innehåller syntesbar kod samt testbänk för konstruktionen, skriven i VHDL.

**Tips:** Använd .qar-filen i respektive katalog för att direkt öppna motsvarande projektet med pins samt testbänk konfigurerade.

**Vid intresse**, se motsvarande konstruktion skriven i SystemVerilog i katalogen *systemverilog*.