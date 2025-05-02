# Memory
Hierarchie paměti - na pyramidě čím víš, tak tím rychlejší, ale dražší, větší a čím níž tím déle tam vydrží zapsaná data
- cache slouží k vyrovnání rychlosti mezi CPU a pamětí
- power on nahoru - vše co je zde se ztratí po vypnutí
- persistent RAM stejná jako RAM, ale po vypnutí tam zzůstanou informace
- zelená čára nahoru - directly accesible (adressable) by CPU
  - pod zelenou čárou - external I/O, musí se na přístup sem použít řadič

## Definiton
- paměť dělená na slovo, do paměti se přistupuje po slovech
- dneska 8 bitová slova, (byte) (v RAMkách)
- přístupné adresou, 32 nebo 64 bitové adresy
## adress space
- byty se nepřekrývaj, ale jsou přímo za sebou, není mezi nima mezera

## fyzický pohled na paměť
- 2D array - row x column
- napřed se paměti řekne která řádka, potom sloupec, toto je uloženo v aderese
- Timing 
  - CAS (tCL) - Column Acces Strobe - počet taktů co tvrá než paměť odpoví na vystavení adresy sloupce, důležitý parametr, toto se používá nejčastěji - když se přistupuje sekvenčné, tak se mění toto
## Memory alignment
- CPU potřebujou, aby data v paměti byly uložené na adresa, která je dělitelná velikostí data (daného datového typu)
  - musí to být zarovnaná jako absolutní adresu
- struktura (adressa, kde je uložená) je zarovnaná na nejvyšší datový typ dostupný na CPU
- ve struktuře se dělá inner padding podle toho, jak jsou velké položky ve struktuře (mezi položkami může být paměť, která se nevyužije)
- outer padding - na konec struktury se přidá díra, tak aby velikost struktury byl násobek největší datové položky ve struktuře
- takže prvky struktury jsou na adrese takové, že to násobek velikosti prvku a celá struktura musí mít přidaný outer padding takový, že zabírá část paměťi, která je násobek velikosti největšího prvku struktury
- sizeof struktury vrací velikost včetně paddingu

## Memory managment
- globální proměnné
  - alokované na začátku, mají fixní pozici v paměti, paměť uvolněná po konci programu
- lokální proměnné, argumenty funkcí
  - alokované na zásobníku stack pointrem
  - na zásobníku jsou i návratové adresy
- Dynamicky alocované proměnných
  - alokované programátorem (`malloc()`, `new`, `free`)
  - alokované at runtime
  - mají dedikovaný paměťový blok pro tyto alokace, musí být opět uvolněné (programátorem nebo garbage collector)
  - jsou alokované on Heap
## Memory allocation
## Fragmentation
- Internal
  - při alokaci paměti pro dynamicky alokovanou proměnnou se naalokuje více paměti než je potřeba (např pro strukturu)
  - naalokuje se tolik, aby to bylo hezké na zarovnání, aby vždy vše na Heapu mělo adresu, která je správný násobek (např násobek 16 (nejmenší alokovatelná věc je veliká 16B)), to může způsobit špatné využití paměti
- External
## Dynamic memmory allocation
- je potřeba souvislej úsek paměti potřebné velikosti
- je ppotřeba udžovat co je využité
- Free blocks evidence
  - Linked List, na nevyužitém místě je odkaz na další nevyužité místo, stejně tam jsou odkazy na násobky 16, aby bylo vše správně zarovnané
  - Bitmap

## Alocation algorithms
### first fit
Začíná se od začátku a hledá se první díra kam se požadovaná velikost vejde a upravím bitmapu nebo linked list
### next fit
- stejný jako first fit, ale začíná vždy tam, kde nakonec skončil, pokud dojede nakonec, tak začne od začátku
- next fit a first fit můžou dát malá data do moc velké díry, takže se zaplní zbytečně velké místo kam by se ohlo dát něco velkého
### Best fit
- začíná od začátku, najde nejmenší možnou mezeru


