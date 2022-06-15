# Test script

## Použití
* Musíte si stáhnout metatrader 5 a založit účet u brokera třeba u https://ftmo.com/cs/ z tama musíte stáhnout i metatrader 
* Následně si metatrader 5 nainstalujete a přihlásíte se
* Poté je potřeba v souboru settings.txt změnit login, password a server na ten který máte v zapnutém metatraderu 
* Musíte si stáhnout python3.9 požadované knihovny.
## Spouštění 
Je velmi jednoduché a vysvětlím ho na pár nasledujích příkazech 
Následují příkaz otestuje strategie která používá trochu modifikovaného stocha kde argument -ch=%k period = 5: %k slowing period = 3: %d period = 4 

viz https://corporatefinanceinstitute.com/resources/knowledge/trading-investing/fast-stochastic-indicator/

argument tp a sl znamená kolik pip bude takeprofit a stoplose argument dy znamená kolik dní dozadu od dnešného chceme testovat. Pokud bychom dy uvedli ve tvaru dy=100:200 znamená to že chceme testovat tento den -100 až tento den -200 dní. 
```
python3.9 back_tester.py -tp=100 -sl=150 -dy=20 -ch=5:3:4
```
Program nám nasledně vypíše na výstup například následující čísla
![image](https://user-images.githubusercontent.com/45818202/165969437-03db7179-d66e-4bf4-ad50-5d16ddf48fb2.png)

* První číslo znamená kolik pip jsme v minusu/plusu 
* Druhé jaká je celková úspěšnost strategie
* A třetí je kolik obchodů jsme uskutečnili 

Pokud se potřebujeme podívat na obchody trošku z blízka jak probíhali kdy se zadavali a kdy skončili použijeme argument -plot otevře se nám v prohlížeči následují soubor kde na grafu vidíme kdy se otevřel obchod a kdy zavřel. V legendě můžeme najít o jaký typ obchodu se jedná. V prohlížeči se nám otevře graf pro každý instrument.
![image](https://user-images.githubusercontent.com/45818202/165970810-ce1c8bd5-43c2-44df-80e9-27d4daaa656e.png)

Output test scriptu je taky trošku obsáhlejší snad je z názvu jasné co je co. Zase se nám vypisuje output pro každý instument zvlášt. 
![image](https://user-images.githubusercontent.com/45818202/165971898-e2ec29a1-8cc3-4392-990f-b75099b56d41.png)
## run test 
Složka obsahuje script run_test.py který testuje strategii pro více hodnot stocha. Zatím je ještě ve vývoji.

# Bot


