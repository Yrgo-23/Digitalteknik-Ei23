# 2024-05-16 - Förebyggande av metastabilitet med D-vippor

Förebyggande av metastabilitet via double-flop metoden, dvs. samtliga insignaler synkroniseras via två vippor.  
Kretsen som konstruerades föregående lektion har i utökats med metastabilitetsskydd.  
Implementeringen genomförs med D-vippor, både för hand i CircuitVerse samt i VHDL.

## Metastabilitet
Ett metastabilit tillstånd innebär att utsignalen ur en vippa varken är 0 eller 1, vilket kan uppstå när en insignal ändrar värde för nära en klockpuls. Då hinner signalen inte stabilisera sig på 0 eller 1 och vippans utsignal kan då sväva någonstans mellan 0 - 1 en viss tid. Oftast stabiliserar sig sedan vippans utsignal till 0 eller 1, annars kan systemfel uppstå, då vissa efterföljande grindar kan tolka vippans utsignal som 0, andra som 1, vilket kan få märkliga effekter. 

För att förebygga metastabilitet brukar double-flop metoden användas, vilket innebär att varje insignal (förutom klockkretsen)
synkroniseras via två vippor, i detta fall D-vippor. Utsignalen ur den andra vippan (märkt med postfix s2 för att indikera
synkronisering med två vippor) kommer vara stabil, dvs. 1 eller 0.

## Gridnät
Filen *led_toggle_meta_prev.png* utgör grindnätet för konstruktionen, implementerat i CircuitVerse.  

Filen *led_toggle_meta_prev.cv* kan importeras i CircuitVerse för att simulera konstruktionen (klicka *Project -> Import File* och välj denna fil).

- Reset-signalen reset_n synkroniseras via två D-vippor, där synkroniserad signal reset_s2_n används i resten av kretsen.  

- Tryckknappen button_n synkroniseras via två D-vippor och ytterligare en vippa används för flankdetektering, där button_s2_n utgör "nuvarande" insignal och button_s3_n utgör "föregående" insignal. Vid nedtryckning (fallande flank) gäller att button_s2_n = 0 och button_s3_n = 1. Då ettställs signalen button_pressed_s2 för att indikera knapptryckning. 
- Vid nedtryckning av tryckknappen togglas en lysdiod. Lysdiodens tillstånd hålls via en D-vippa, där signalen led_s tilldelas vippans utsignal.

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

