#import "@preview/theorion:0.4.0": *
#import cosmos.fancy: *
// #import cosmos.rainbow: *
// #import cosmos.clouds: *
#show: show-theorion

#let ol(content) = math.overline(content)
#let pc = text(font: "Allura")[P]
#let kv(content) = $k_v (content)$
#let ke(content) = $k_e (content)$


= Měření souvislostí grafů

- Jak moc jsou různé grafy souvislé?
- Jak těžké je je znesouvislit
- $K_n$ je úplný graf o $n$ vrcholech

#definition(title: "Hranová souvislost")[
  Ať $G = (V,E)$ je graf. Pak:
  - $F subset.eq E$ je $underline("hranový řez")$, pokud  $G minus F := (V, E\\F)$ je nesouvislý.
  - #underline[Hranová souvislost G] je velikost nejmenšího hranového řezu, značíme $k_e (G)$, ale klademe $k_e (K_1) = 1$
  - $G$ je hranově ("alespoň") $k$-souvislý, pokud $k_e (G) >= k$

  Pro nesouvislé $G$ je $k_e (G) = 0$
]

#definition(title:"Vrcholová souvislost")[
  Ať $G = (V,E)$ je graf. Pak:
  - #underline[vrcholový řez] je $A subset.eq V$ taková, že $G - A:= (V \\A, E inter binom(V\\A, 2))$ je nesouvislý
  - #underline[Vrcholová souvislost] $G$, značíme $k_v (G)$ je velikost nejmenšího vrcholového řezu, ale klademe $k_v (K_1) = 1$ a pro $n >= 2$ klademe $k_v (K_n) = n - 1$
  - $G$ je vrcholově ("alespoň") $k$-souvislý, pokud $k_v (G) >= k$
]

#example(title: "Poznámka")[
  Nesouvislé grafy mají hranovou i vrcholovou souvislost 0. Souvislé jsou hranově/vrcholově $1$- souvislé
]

#example(title: "Poznámka")[
  Budou nás zajímat grafy s $n >= 2$ vrcholy.
]

#lemma(title:"Horní odhad")[
  Ať $G = (V,E)$ je graf s minimálním stupněm $delta (G)$. Pak $k_e (G) <= delta (G)$ a $k_v (G) <= delta (G)$
]

#proof[
  Označme $v$ vrchol s minimálním stupněm $delta$. Pak hrany vycházející z $v$ tvoří hranový řez, takže $k_e (G) <= delta$

  Pokud $G = K_n$ pro $n >= 2$, pak $k_v (G) = n -1 = delta (G)$ a tvrzení platí.

  Jinak označme $n = |V|$ počet vrcholů v $G$. Pak $delta(G) <= n-2$. Pak opět vezmeme $v$ se stupněm $delta(G)$ a smažeme $A = N_G ({v})$.

  Tím mažeme $delta$ vrcholů a výsledek je nesouvislý, protože kromě $v$ alespoň jeden vrchol zbyde
]

#lemma(title:"mazání hrany")[
  Ať $G = (V,E)$ a $|V| >= 2$. Pak:
  $ k_e (G) - 1 <= k_e (G - e) <= k_e (G) $
]
#proof[
  Pokud $F$ je řez v $G$, pak je i řezem v $G - e$ (nebo $F \\ {e}$, je řez v $G - e$), takže $k_e (G - e) <= k_e (G)$.

  A naopak, pokud $F'$ je řez v $G - e$, pak $F' union {e}$ je řez v $G$, $k_e (G - e) >= k_e (G) - 1$
]

#lemma[
  Platí $kv(G) <= ke(G)$
]
#proof[
  Ať $F subset.eq E$ je nejmenší hranový řez velikosti $|F| = k$.

  Plán: Místo každé hrany $F$ smažeme jeden její konec. Pozor nesmíme smazat celou "jednu půlku".
  
  Označme $C_1,C_2$ části vzniklé smazáním $F$ (smazáním hran). Ať $|C_1| = a$, $|C_2| = b$, kde $a + b = n$. Dva případy:
  + $|F| = n - 1$. Pak $delta(G) >= n - 1$, takže $G = K_n$ a tvrzení platí
  + $|F| <= n-2$. Pak zleva smažeme některých $a - 1$ vrcholů a zprava: $|F| - (a - 1)$ vrcholů od zbylých hran $F$. Tím vznikne vrcholový řez
]

#theorem(title: "Ford Fulkersonova/Mengerova věta")[
  $G$ je hranově $k$-souvislý (tj. $ke(G) >= k$), právě tehdy když $forall u,v in V(G): exists "alespoň" k$ hranově disjunktních cest z $u$ do $v$
]
#proof[
  
  *$<==$*

  Ať $forall u,v in V(G) exists k$ cest.
  
  Pak smazání $< k$ hran naruší maximálně $k$ z těchto cest, takže se stále bude dát dostet z $u$ do $v$

  *$==>$*
  
  Ať $G$ je hranově $k$-souvislý.

  Zkonstruujeme tokovou síť $S$:
  - vrcholy $V(S) = V(G)$
  - hrany $E(S) = E(G)$, obousměrné, kapacity vše $1$
  - zdroj $u$, stok $v$
  Platí: $exists$ řez v $S$ velikosti $< k$ $==> exists$ řez v $G$ velikosti $<k$.

  Také platí: velikost nejmenšího řezu v $S$ je rovna velikosti maximálního toku

  Z předpokladu $exists.not$ řez $G$ velikosti $< k$, takže $exists.not$ řez $S$ velikosti $<k$. Takže $S$ je tok velikosti $=> k$

  BÚNO ten tok je celočíselný.

  Z toku odstraníme všechny hrany, které tok prochází obousměrně, vznikne opět tok velikosti alespoň $k$. Ten indukcí rozložíme na $k$ jednotlivých hranově disjunktních cest (vždy vybereme libovoulnou vycházející šipku až dojdeme ze $z$ do $s$, čímž zbyde tok velikosti $k - 1$)
]

#theorem(title: "Mengerova")[
  $G$ je vrcholově $k$-souvislý, právě tehdy když $forall u,v in V(G): exists >= k$ vnitřně vrcholově disjunktních cest z $u$ do $v$
]
#proof[
  
  *$<==$*

  Podobně jako u předchozí věty

  *$==>$*

  Jen idea

  Podobně jako pro hranovou souvislost, ale pomocí jiné sítě, v síti bude vrchol rodvojen na vstupní a výstupní vrchol, mezi nimi hrana o kapacitě $1$ viz ADS vrcholově disjunktní cesty domácí úkol. 
]

#definition(title:"most")[
  Ať $ke(G) = 1$, pak řez $e in E$ velikosti $1$ se nazývá most
]
#definition(title:"artikulace")[
  Ať $kv(G) = 1$, pak řez $v in V$ velikosti $1$ se nazývá artikulace
]
#definition(title:"Lepení uší")[
  Ať $G$ je graf. Přilepení ucha je krok:
  - vyber $u,v in V(G), u != v$
  - přidej vrcholy $z_1, z_2, ..., z_d$, $d >= 0$
  - přidej hrany $(u, z_1), (z_1, z_2), (z_2, z_3), ..., (z_d, v)$
]

#theorem(title:"Ušaté lemma")[
  $G$ je vrcholově $2$- souvislý (tj $kv(G) >= 2$), právě tehdy když ho lze dostat z kružnice přilepováním uší
]
#proof[

  *$<==$*
  
  Ať $G$ vznikl z kružnice přidáváním uší. Pak $G$ je vrcholově $2$-souvislý (indukcí, původní kružnice je $2$-souvislá a přidání ucha k $2$-souvislému grafu neporuší $2$ souvislost)

  *$==>$*

  Sporem, ať $G_0 = (V_0,E_0)$ je maximální podgraf $G$, který se dá zkonstruovat přidáváním uší (Jelikož $G$ je $2$-souvislý, není to strom, tedy obsahuje alespoň $1$ kružnici).

  2 případy:
  + $V_0 = V$, tj. chybí jen dokreslit nějaké hrany $arrow$ to lze (hrana je legální ucho)
  + $V_0 subset V$. Pak $exists v in V(G) \\ V_0$ a hrana $(u,v)$, kde $u in V_0$ (díky tomu, že $G$ je $1$-souvislý). Představíme si, že smažeme $u$ Pak z $v$ se stále dá dostat do $V_0$, řekněme do $w in V_0$. Takže lze přidat ucho z $u$ do $w$ přes $v$

  Spor s tím, že $G_0$ je maximální podgraf získaný přidáváním uší
]

