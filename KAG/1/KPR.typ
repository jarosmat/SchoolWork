#import "@preview/theorion:0.4.0": *
#import cosmos.fancy: *
#show: show-theorion
#let ol(content) = math.overline(content)
#let pc = text(font: "Allura")[P]

= Konečné projektivní roviny

#definition(title: "Konečná projektivní rovina")[
  Konečná projektivní rovina (KPR) je dvojice $(X, pc)$, kde $X$ je konečná množina ("body") a $pc subset.eq 2^X$ je sada podmnožin $X$ taková, že:
  + $forall x!= y in X: exists ! P in pc$, že $x,y in P$ (každé dva body určí přímku)
  + $forall P != Q in pc: exists ! x in X$, že $x in P inter Q$ (každé 2 přímky se protínají)
  + $ exists C subset.eq X, |C| = 4$, že $forall P in pc$ platí $|P inter C| <= 2$ (existuje čtveřice bodů v obecné poloze)
]

#example[
  Fannova rovina
  
]

#example(title: "Značení")[
   - Pro $x != y in X$ označme $ol(x y)$ tu jedinou přímku skrz body $x, y$
]

#lemma(title: "2 přímky nepokrývají")[
  Ať $(X, pc)$ je KRP a $P,Q in pc$. Pak $exists x in X$ mimo $P$ i $Q$
]
#proof[
  Ať $C subset.eq X$ je čveřice z třetího bodu definice. Pokud v $C$ je bod mimo $P$ i $Q$ je hotovo.
  Pokud ne búno ať $P=ol(a b)$ a $Q = ol(c d)$. Díky prvnímu bodu definice KPR se podívejme na přímky $ol(a d)$ a $ol(b c)$ a označme jejich průsečík $x$. Ten neleží na $P$: Sporem, kdyby ano, pak by na $P$ ležely $a$ i $x$, takže $P$ by byla $ol(a x)$, takže by na $P$ ležel i $d$. Pak by $|P inter C| >= 3 $, což je spor. Analogicky se vyvrátí $x in Q$. Takže $x$ leží mimo $P$ i $Q$.
]

#proposition(title: "přímky jsou stejně velké")[
  Ať $(X, pc)$ je KPR a $P,Q in pc$. Pak $|P| = |Q|$
]

#proof[
  Soupeř nám dal $P,Q$. Vezmeme $x in.not (P union Q)$. Označme $P = {p_1, p_2, ... , p_n}$. Uvažme $n$ přímek $ol(x p_i)$. Označme $q_i = ol(x p_i) inter Q$. Pak každé 2 body $q_i$ jsou různé (protože kdyby $Q inter p_i = q_i = Q inter p_j$, pak by skrz dvojici bodů $x, q_i$ vedly 2 přímky, což je spor s prvním bodem z definice KPR). Takže $|P| <= |Q|$. Zcela analogicky dokážeme $|Q| <= |P|$. Takže $|P| = |Q|$
]

#definition(title: "Řád KPR")[
  Řád KPR $(X, pc)$ je velikost každé její přímky mínus jedna
]

#proposition[
  Ať $(X,pc)$ je KPR řádu $n$. Pak:
  + každý bod $x in X$ leží na přesně $n+1$ přímkách
  + celkový počet bodů je $|X| = n^2 + n + 1$
  + celkový počet přímek je $|pc| = n^2 + n + 1$
]

#proof[
  + Soupeř nám dal $x in X$. Tvrdíme, že $exists$ přímka $P$, co míjí $x$. Vezměme $C = {a,b,c,d} subset.eq X$ z třetího bodu definice KPR. Pokud $x in C$, stačí za $P$ vzít přímku skrz libovolné 2 jiné body $C$, na této již z definice nesmí ležet třetí bod trojice. Pokud $x in.not C$, uvažme $ol(a b)$ a $ol(a c)$. Kdyby $x$ ležel na obou, pak by skrz $a, x$ vedly 2 přímky, spor. Takže jedna z $ol(a b)$, $ol(a c)$ zafunguje. Označme $p = { p_1, p_2, ..., p_(n+1)}$ pak přímky $ol(x p_i)$ jsou všechny různé a navíc každá přímka skrz $x$ protíná někde přímku $P$. Takže skrz $x$ vede právě $n+1$ přímek
  + Vezmeme libovolný bod $x in X$. Z něj vede $n+1$ přímek. Ty už se dále neprotínají (díky prvnímu axiomu z definice KPR) a navíc pokrývají všechny body (díky prvnímu axiomu z definice KPR). Na každé z $n+1$ přímek je kromě $x$ celkem $n$ dalších bodů, takže celkem $1 + (n +1)n = n^2 + n + 1$
  + Vyjádřeme dvěma způsoby počet $Z$ dvojic ($x in X, P in pc$) takových, že $x in P$. Pak $Z = |X| dot.op (n+1)$, protože každý z $|X|$ bodů leží na $n+1$ přímkách. Zároveň $Z = |pc| dot.op (n+1)$, protože na každé přímce leží $n+1$ bodů. Porovnáním:
  $ |X| dot.op (n+1) = Z = |pc| dot.op (n+1) $
  $ |pc| = |X| = n^2 + n +1 $
]

#example[
  + Dobble - hra Obrázky hraj roli bodů a karty hrajou roli přímek, z toho každé 2 karty mají jeden společný symbol, jelikož na každé kartičce je 8 symbolů, je to projektivní rovina řádu $7$, celkový počet různých obrázků je $57$ a karet je v Dobblu $55$, ale šlo by přidat ty 2, autoři to tam ale z nějakého důvodu nedali
  + Co je zajímavého na ${0,1,3,13,32,36,43,52} mod 57$
  + Incidenční graf KPR, je to graf, kde za každý prvek $X$ je vrchol v grafu a za každý prvek $P$ je také vrchol v grafu a hrana v grafu vede mezi vrcholem reprezentujícím bod z $X$ a všema přímkama obsahujícíma tento prvek $X$
]

= Informativně 
- Fannova rovina: KRP řádu 2, je jediná taková (až na izomorfismus)
- existují KPR pro čísla $4,5,7,8,9$

#proposition[
  Pokud $n = p^alpha$, kde $p$ je prvočíslo a $alpha >= 1$, pak $exists$ KPR řádu $n$
]

#proposition[
  Pokud $n in {6,10}$, paj KPR neexistuje. Jinak se neví, patří to k otevřeným problémům
]

#definition[
  $ZZ_p$ je těleso (field/pole), tj. množina a operace $plus, minus, dot.op,$ dělené (až na dělení nulou)
]

#theorem[
  Konečné těleso na $n$ prvncích existuje, když $n= p^k$, kde $p$ prvočíslo a $k>=1$
]

#proof[
  Z lingebry
]
#figure(caption: [Pro Egora])[
#rect[
#figure(
  image("../index.jpg"),
)
#theorem[
  Pokud $exists$ konečné těleso na $n$ prvcích, pak $exists$ KPR řádu $n$
]

#proof[
  === Idea (algebra)
  Označme těleso $K$. Uvažme všechny trojice $T = K^3 \\ (0,0,0)$ co mají alespoň 1 nenulový prvek. 
  
  Definujme relaci $~$ jako $(a,b,c) ~ (t dot.op a, t dot.op b, t dot.op c)$, kde $t eq.not 0, t in K$. 
  
  Pak $~$ je ekvivalence (bez důkazu), takže získáváme rozklad na třídy ekvivalence $T_~$. Označme $ol((a,b,c))$ třídu ekvivalence trojice $(a,b,c)$. Pak každá třída má právě $n minus 1$ prvků.

  $|T| = n^3 minus 1$, takže tříd je $(n^3 minus 1)/(n minus 1) = n^2 + n + 1$. Každá třída bude odpovídat jednomu bodu KPR

  Pro každou třídu $ol((a,b,c))$ definujeme jednu přímku jako všechny trojice $(x,y,z) in T$ takové, že $a x plus b y plus c z = 0$.

  Pak platí:
  - přímky příslušející $(a,b,c)$ a $(a', b', c') in ol((a,b,c))$ jsou totožné
  - pokud $(x,y,z)$ leží na přímce příslušné $(a,b,c)$, pak i $(x' = t x, y' = t y, z' = t z)$ tam leží

  Zbývá ověřit axiomy z definice KPR:
  + Pokud $(a,b,c), (d,e,f)$ jsou z různých přihrádek, pak jádro $mat(a , b, c ; d, e, f)$ má dimenzi $"[počet sloupců]" minus "[hodnots matice]" = 1$, takže až na násobení konstantou $t$ existuje jediné řešení $(x,y,z)$, tj. jediná přímka
  + podobně
  + podobně
]]]

= Latinské čtverce

#definition[
  Latinské čtverce $(L_(i,j))_(n times n)$ je čtvercová tabulka vyplněna čísly $1 ... n$ tak, že v žádném řádku a ani sloupci se žádné číslo neopakuje. 
]

// #example[
//   #grid(
//     rows: 3,
//     columns: 3,
//      content: 1
//   )
// ]

#definition[
  Dva $n times n$ čtverce $L, L'$ jsou #underline[ortogonální] pokud $forall 2$ hodnoty $a,b in [n]$ existují indexy $i,j$ takové, že $L_(i,j) = a, L^'_(i,j) = b$
]

#example(title: "Pozorování")[
  #enum(numbering: "a)")[
    2 čtverce jsou ortogonální, když se žádná kombinace $(a,b)$ neopakuje
  ][
   Propermutování symbolů v latinském čtverci vyrobí latinský čtverec  
  ][
    Propermutování symbolů neovlivní ani zda je čtverec ortogonální s jiným
  ]
]

// #example(title: "Otázka")[
//   Kdy existuje ortogonální 
//]

#definition[
  Pro $n >= 2$ označme $N O L Č (n)$ maximální možný počet navzájem ortogonálních latinských čtverců $n times n$ (navzájem = každé 2 jsou)
]

#proposition[
  Pro $n >= 2$ platí $N O L Č(n) <= n minus 1$ 
]
#proof[
  Díky pozorování c) búno předpokládejme, že 1. řádek každého čtverce je $1, 2, ... , n$.

  Podívejme se na políčko $(i,j) = (2,1)$. Pak každé $2$ čtverce tam mají jiné číslo (kdyby 2 čtverce měly stejné číslo $k$, byla by kombinace $(k,k)$ na políčkách $(2,1) and (1, k)$). 
  
  Zároveň žádný čtverec tam nemá jedničku (protože ta už v tom sloupci je). Takže je jen $n minus 1$ možností, co tam napsat, takže max $n minus 1$ čtverců
]

#theorem[
  Platí $N O L Č(N) = n minus 1$, když $exists$ KPR řádu $n$.
]
#proof[
  Ukážeme jen $<=$. Vezmeme KPR a jednu její přímku $p = (a_0, a_1, a_2, ... , a_n)$. Pak zbylých $n$ přímek skrz $a_0$ a zbylých $n$ přímek skrz $a_n$ tvoří čtvercovou mřížku. Pomocí každého $a_i, i in {1,2, ... n minus 1}$ teď vyrobíme 1 latinský čtverec. Díky druhému bodu z definice KRP každá přímka skrz $a_i$ protne každý sloupec a řádek mřížky jednou. A (taky pomocí druhého bodu z definice KRP) různé přímky skrz $a_i$ procházejí různými průsečíky. Každá přímka skrz $a_i$ udá všechny pozice jednoho symbolu

  Je těchto $n minus 1$ latinských čtverců navzájem ortogonálních?

  Sporem kdyby ne, pak by čtverce odpovídající řekněme bodům $a_i, a_j$ měly nějakou kombinaci zopakovanou, řekněme $underline(a), underline(b)$. Pak ale přímka skrz $a_i$, co udává pozice symbolů #underline[a] protíná dvakrát přímku skrz $a_j$, co udává pozice symbolů #underline[b]. což je spor s druhým bodem definice KPR
]
