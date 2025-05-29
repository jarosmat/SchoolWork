# C/C++
## Casts
 - explicitní konverze, bez warningů, říká pro compiler, že je ok změnit typ - vhodné pro
 - změnu z menšího na větší, naopak s ztratí data, někdy možné
 - např
    `double d = 4.2;
    float f = (float)d;`
## Variably
 - hodnoty jsou uložené v paměti, nalezne se místo v paměti - pouze pojmenované ísto v paměti,
 - proměnné musí být deklarované, nemusí být inicializované, ale je to lepší
 - pokud nejsou inicializované, hodnota bude nula
### Variable scope
 - určuje, kde lze používat proměnnou a kde je proměnná uložená
 - Local Variables - leží v jednom bloku (například ve funkci), leží na stacku, argumenty funkcí jsou Local variably
 - Global Variables - deklarovaná mimo funkci, všechny funkce v kódu, které jsou za touto proměnnou ji vidí
 - Static global variables - jsou vidět jako local, ale drží hodnotu po celý runtime
 - lze vytvořit více proměnných se stejným jménem, pokud jsou v jiném scopu (nejsou ve stejném bloku), potom pracujeme s nejmladší proměnnou, pokud ve funkci vytvoříme proměnnou se stejným jménem jako global variable, tak ve funkci po deklaraci té proměnné není možno dosáhnout globální hodnoty normálním způsobem
## Statmenty (příkazy)
- compound statment (blok), ve složených závorkách
- expression statment, ukončený středníkem
- if statment, kontoluje, jestli hodnota je různá od nuly daného typu následuje příkaz, ten může být nahrazen blokem
- Switch, jsou v něm větve, umí testovat pouze celočíselný typy, pokud 2 casy za sebou sdílejí stejný kód (např za sebou case 2 a case 3 je hned na dalším řádku), vždy kočí breakem, switch skočí do dané části kódu, větev musí být ukočena breakem, pokud nebude ukončeno breakem, tak to bude propadat do dalších casu (bude to vykonávat jejich kód, dokud nenarazí na break)
- while cyklus, podmínka stejná jako if
- do while cyklus
- Regular loop (for loop (einit; etest; einc)) - první je inicializační příkaz (provede se jednou na začátku), pak je while loop s podmínkou etest, na konci while loopu se provede einc
- loop contol statmenty 
  - break - vztahuje se k nejbližšímu příkazu, který ho využívá (switch v loopu, break breakne switch, loop ve switchi break breakne loopů)
  - continue
- unconditional control flow direction - goto příkaz, skákat lze pouze uvnitř funkce, není vhodné používat, lze nahradit jinou konstrukcí
## Expresion Operators
- aritmetické
  - binární i unární: +, -, *, /, % (modulo je divné pro záporná čísla, není vhodné používat)
    - vždy se veznou typy operandů a menší typ se převede na větší, operace se provádí ve větším typu, výsledek ve větším typu (pokud obě hodnoty celočíselné, celočíselné dělení)(pokud jeden floating point je to ve floatech)(pokud signed a unsigned, převede se na unsigned)
    - ++, --, preincrement, postdecrement (před nebo za hosnotou), `int i = 1; int v = ++i` - preincrement vrátí hodotu zvětšenou o jedna a zvětší hodnotu o jedna, `int i = 1; int v = i++` - post increment, napřed vrátím hodnotu a pak zvětším hodnotu, i bude 2 a hodnota v bude 1, preincrement (i predecrement) je obecně lepší, je rychlejší, platí pro vlastní aritmetické typy - lze operator overloading
- relační (porovnávací) - menší typ se převádí na větší jako u aritmetických, výsledek je bool
- bitwise
  - ~ negace
  - & konjunkce
  - | disjunkce
  - ^ xor
  - << shift left
  - \>> shift right - u signed čísel drží znaménko, u zároných se drží na začátku 1
- Logical - zkrácené vyhodnocení, vyhodnocuje zleva doprava, pokud jasný výsledek, dál se nevyhodnocuje, může být výhodné dát rychlejší operand jako první (operand jehož vyhodnocení je rychlejší)
  - pro vyhodnocení obou operandů lze teoreticky použít bitwise and (&)
  - &&, pokud první operand false, druhý se nevyhodnocuje
  - ||, pokud první operand true, druhý se nevyhodnocuje
  - nejdřív se vyhodnocují andy a pak ory, lepší použít závorky
  - !, negace
- Pointers
  - &
  - \*
- Assigment - přiřazení hodnoty je výraz (někde je to příkaz)
  - lze napsat  `i = j = 1`
  - aritmetické: `=`,`+=`, `*=`, `/=`, `%=`
  - bitwise: `&=`, `|=`, `^=`
- Variable/type size in bytes: `sizeof`, vrací velikost proměnné nebo typu
- Ternary expr (jako if else): `test ? e1 : e2` pokud test různý od nule provede se `e1`, jinak se provede `e2`
  - např: `if (a < 5) v=5; else v = 4` lze napsat `v = a < 5 ? 5 : 4`, je rychlejší než if else

## Arrays
- sekvence položek stejného typu, okupuje spojitou posloupnost paměti
- zero based index, fixed size daná při kompilaci
- nekontroluje se, jestli se neindexuje mimo velikost pole, může být memory corruption
- `int u[4];` alokuje paměť na 4 inty, pokud lokální v arrayi mohou být náhodné hodnoty
- `int p[] = {1, 2, 2}`
- `int a[][]`, je to row major, v paměti jsou hodnoty zapsané pro řádcích
- size_of vrací velikost v bytech 
- je to vlastne Pointer na prvni prvek v pameti (tento pointer nem8 vlastni misto v pameti)
## Strings
- Array of characters končící zero (nul) characterem
- `char str[] = "Hippo"`, array velikosti 6, `str[5] == \0`, tady size
- `char sha[] = {"H", "i", "p", "p", "o"}` má velikost 5, nekončí `\0`
## Memory alignment (zarovnání paměti)
- procesory vyžadují (je to vynucené), aby adresa, kde leží hodnota, musí násobkem její velikosti
## Structures
- kolekce polí (členů)
- logicky spojené

`
struct data {
char c;
double d;
int i;
}
`
Je potřeba dělat vnější a vnitřní padding
- první polužka (`char c`) je na offsetu 0, pořeba najít offest dělitelný 8 (velikost double), int se dá na offset 8, jsme na offsetu 16, který je dělitelný 4 (velikost intu) - vnitřní padding
- poté se velikost celé struktury musí zarovnat tak, aby velikost celé struktury byl násobek nejvyšší hodnoty (což je 8)
- jednotlivé hodnoty v struktuře jsou v paměti tak, jak jsou ve struktuře


# Constants and enums
- const - konstantní proměnná
- constexpr (compile time konstanta, C++), neexistuje v paměti, kompilátor ji kódu nahradí hodnotou
- enumerations - typ s předdefinovanými hodnotami, kompiluje se do intu (kompilátor si to převede na konstanty, efektivní
  `class enum state_t { WAITING, RUNNING, STOPPED} (definování, v C není class)
state_t s = state_t::WAITING (použití v C++), enum state_t s = WAITING (v C, lze použít i v C++) `


## Preprocessor

- Preprocessor directives   - text based replacents handled at compile time
  - #include <neco> (tohle jsou includy, které jsou standartní pro jazyk) nebo #include "my_module.h" (uživatelský include, pokud nenajde uživatelský hledá i ve standartních), nahradí to nějakým souborem (rekurzivně, pokud v headrech je taky nahradí se taky)
  - #define N 1000, #define ALLOW_DEBUG - konstanta v C, nezabírá paměť, preprocessor nahradí každé N tou hodnotou
  - #ifdef ALLOW_DEUBUG, končí #ednif, pokud ALLOW_DEBUG je definován provede kód mezi částmi (dá ho do zdrojáku), pokud není, odebere ho ze zdrojáku

`
#ifdef ALLOW_DEBUG
nejaký kód
#endif`


## Application entry point
- funkce main, vrací exit code


## Pointers
- abstrakce nad pamětí
- pointer je číslo, které ukazuje do paměti (index začítečního bytu)
- pointery jsou typované
  - vyjadřuje jaký typ dat můžeme čekat v paměti
  - pointery různých typů nejsou kompatibilní (nemůžeme do stejné proměnné přiřadit 2 pointery ukazující na různé typy)

`
int v = 8; //leží na adrese 1234 (nemělo by tam být podle memory allignmentu)` \

`int *pv = & // pomoci & ziskam adresu promenne, pomoci * definuji typ jako ukazatel`\
`*pv = 4 //prepise v, sahne na ukazatel a vyyvedne hodnotu promenne z pameti (pointer na promennou lze pouzivat misto promenn do jiste miry i guess)`

- Array variable, je to vlastne poiter na nulty prvek pole
  - plati i pro Stringy (vse co plati pro )

` int vals[] = {4, 3,2}`
` int *vals = {4,3,2} // je taky legalni, ale toto lze zmenit, lze zmenit hodnotu pointeru, tim ztratim promennou`

- Pointerova aritmetika

`char *str = "text"` \
` *(str + i) // timto dostanu i-tou hodnotu pole (pokud se to dela na vetsi typy (v B), tak to funguje stejne, akorat kompiler to vynasobi velikosti typu`
`str[i] a *(str + i) delaji to same`\
`++str //zmeni permanetne hodnotu pointeru (jde to i vefinale pretypovat)`\
`while (*str) {++str} // lze delat, proloopuje stringem`

## References
- Reference (C++)
  - fixed pointer, nelze ji zmenit, ukazuje fixne na jedno misto, nefunguje na to pointerova aritmetika
  - nevyhoda pouzivani je to, ze dvakrat se musi pristupovat do pameti (vyzvednout hodnotu pointeru a pak vyzvednout hodnotu)

`int v = 8`\
`int &rv = v //prirazeni do reference`\
`rv = 4 // pokud s referenci potrebujeme pracovat nemusime specifikova, ze je to pointer, do promenne na kterou ukazuje rv priradi 4`

## Funkce
- parametry v C jsou predavany hodnotou
- outpu (mutable parametry musi byt predavany pointrem) (preda se promenna ve ktere je hodnota ukazatele)

` void rotate(pint2d in, pint2d *out) { out->x = in.y; out->y = - in.x;
// out->x je stejne jako (*out).x
} `

## tridy
- stejne jako struktury az na viditelnost polozek
- strukturu pouzivat pokud to jsou polozky, ktere drzi hodnoty a potrebuji byt pohromade
- tridy pouzivat pokud je to entita, ktera ma stav a tento stav lze zjistit pouze funkci tridy, stav se da menit pomoci method
- pokud funkce jenom cte mel by se za jmeno napsat const `int get_sum() const {}`
