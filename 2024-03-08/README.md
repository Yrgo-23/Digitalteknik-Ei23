# 2024-03-08 - Konstruktion av logiskt grindnät

Konstruktion av ett logiskt grindnät samt konstruktion av en OR-grind med MOSFET-transistorer.

Ett innehållande insignaler ABC samt utsignal X ska konstrueras.  
Sanningstabellen för systemet visas nedan:  

|    ABC     |    X    |
| :--------: | :-----: | 
|    000     |    1    |
|    001     |    1    |
|    010     |    0    |     
|    011     |    0    |    
|    100     |    1    |   
|    101     |    1    |     
|    110     |    0    |      
|    111     |    0    |      

Utsignal X är hög för ABC = 000, 001, 100 samt 101, vilket på boolesk algebra skrivs enligt nedan:  

X = A'B'C' + A'B'C + AB'C' + AB'C,  

där A' uttalas A-prim och betyder "när A = 0". Samma gäller för B' och C'.  

Som exempel, för kombinationen ABC = 001 blir A'B'C lika med 1, då  

A'B'C = 0' * 0' * 1 = 1 * 1 * 1 = 1  

Ekvationen ovan ska realiseras via ett grindnät. För att minska antalet grindar som behövs, vilket medför lägre kostnad  
samt att kretsen tar upp mindre yta, kan ekvationen förenklas:  

X = A'B'C' + A'B'C + AB'C' + AB'C,  

där de två första termerna har A'B' gemensamt, medan de två andra har AB' gemensamt.  

Vi kan därmed bryta ut dessa såsom visas nedan:  

X = A'B'(C' + C) + AB'(C' + C),  

där C' + C = 1, den enda alltid kommer vara 1 och den andra 0 => C' + C = 1 + 0 = 1.  

Därmed kan ekvationen ovan förenklas till  

X = A'B' + AB' = B'(A' + A),  

där A' + A = 1, vilket innebär att  

X = B' * 1 = B'  

Kretsen kan därmed konstrueras i enlighet med den förenklade ekvationen X = B'.  
Utsignal X är alltså lika med inversen av insignal B.  

Därmed kan kretsen realiseras med en NOT-grind, som har B som insignal.  

Filen "net.cv" utgör det minimerade grindnätet realiserat i CircuitVerse.  
Filen "net.png" utgör en bild över grindnätet.  

Filen "or_gate.asc" utgör en OR-grind realiserad med MOSFET-transistorer i LTspice.  
Tillvägagångssättet för att realisera OR-grinden beskrivs också.    
Filen "or_gate.png" utgör en bild över OR-grinden.  
