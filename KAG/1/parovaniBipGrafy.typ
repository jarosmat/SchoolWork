#import "@preview/theorion:0.4.0": *
#import cosmos.fancy: *
#show: show-theorion
#let ol(content) = math.overline(content)
#let pc = text(font: "Allura")[P]

= Párování (matching) v bipartitních grafech

#definition[
  Párování v bipartitním $G = (V,E)$ je podmnožina $M subset.eq E$ disjunktních hran. Označme $m(G)$ velikost největšího párování v $G$
]

#example(title: "Otázky")[
  - Jak velké je $m(G)$?
  - Kdy lze napárovat celou levou paritu? (Hallova věta)
]

== Toky v sítích
#definition(title: "Síť")[
  Síť je pětice $(V,E,z,s,c)$, kde:
  - $(V,E)$ je graf
  - $z in V$ je zdroj
  - $s eq.not z in V$ je stok
  - $c: E arrow RR_0^+$ je kapacita
]

#definition(title: "Tok")[
  Tok je $f: E arrow RR_0^+$, že platí:
  - $forall e in E$ je $f(e) <= c(e)$
  - $forall v in V\\ {z,s}$ platí Kirchhoffův zákon
    - $underbrace(sum_(e = (u,v)) f(e), "přítok") = underbrace(sum_(e = (v,w)) f(e), "odtok") $

  Velikost toku je $|f| = sum_(e = (z,u)) f(e)$
]

#theorem[
  Ford-Fulkersonův algoritmus najde rychle největší tok. A pokud kapacity byly celá čísla, pak i tok bude celočíselný
]

#definition(title: "Řez sítě")[
  Řez sítě je rozklad $V = A union B$, kde $z in A, s in B$. Kapacitou řezu je $R(A,B) = sum_(e=(u,v), u in A, v in B) c(e)$
]

#theorem[
  Velikost největšího toku je roven kapacitě nejmenšího řezu. (Maxflow je roven mincut)
]

#example(title:"Otázka")[
  Jak souvisí párování s toky?

  Největší párování v bipartitním $G, V(G) = A union B$ lze získat pomocí algoritmu na hledání největšího toku - z grafu $G$ vytvoříme síť, kde platí:
  - $S = (V,E,z,s,c)$
  - $V = V(G) union {z,s}$
  - $E = E(G) union {{z,a} | a in A} union {{b,s} | b in B}$
  - $forall e in E: c(e) = 1$

  Pak díky celočíselnosti je největší tok vlastně několik disjunktních cest, kde po každé teče $1$. Jejich prostřední segmenty tvoří párvání. A největšímu toku odpovídá největší párování
]

#definition(title: "Vrcholové pokrytí")[
  Vrcholové pokrytí grafu $G$ je podmnožina $X subset.eq V$ vrcholů, které "společně vidí do každé hrany", tj:
  $ forall e=(u,v) in E "platí" |{u,v} inter X| >= 1 $

  Velikost nejmenšího vrcholového pokrytí v $G$ značíme $v c(G)$ (vertex cover)
]

#theorem(title: "König-Egerrary")[
  V bipartitním grafu $G$ platí $m(G) = v c(G)$.
]
#proof[
  Pro každé párování $M subset.eq E$ a každé vrcholové pokrytí $X subset.eq V$ platí $|M| <= |X|$, protože do každé hrany z $M$ se musí dívat jiný vrchol z $X$

  Ať $M$ je teď největší párování. Zkonstruujeme síť $S$ jako předtím a najdeme v ní největší tok $f$. Víme $|M| = |f|$. Z věty o tocích existuje řez $R$, který má kapacitu $|f| = |M|$.

  Abychom se vyhnuli hranám z $A$ do $B$, zadefinujeme $c(e)$ jako:

  $ c(e) = cases(1 ", pokud " e "vede ze zdroje nebo do stoku",
                  |A| + 1 ", pokud " e " vede z "A " do " B) $
  Pak hrany "indukované" řezem jsou všechny buď ze zdroje nebo do stoku (žádná není z $A$ do $B$) a je jich dohromady $|f| = |M|$.

  Zkonstruujeme $Y subset.eq V$ tak, že $forall (z,a) in E$ dáme: $a in Y$, $forall (b,s) in E$ dáme: $b in Y$.

  Pak $|Y| = |f| = |M|$ a $Y$ je vrcholové pokrytí v $G$.

  Sporem $Y$ je vrcholové pokrytí $G$: ať má $G$ hranu $(u,v)$, do které nevidí žádný vrchol z $Y$, pak ale $(z,u,v,s)$ je cesta ze $z$ do $s$v síti $S$, takže $Y$ nebyl řez
]

#definition[
  Párování v bipartitním grafu $G = (V = A union B, E)$ #underline[nasycuje] $A$, pokud má velikost $|A|$
]

#definition[
  Pro $A^' subset.eq A$ označme $N_G (A^')$ okolí (neighborhood) množiny $A^'$, tj podmnožinu těch vrcholů $B$, které sousedí s aspoň jedním vrcholem z $A^'$
]

#example[
  příklad z tabule
]

#theorem(title: "Hallova")[
  Bipartitní $G = (V = A union B, E)$ má párování nasycující $A$, právě když platí takzvaná Hallova podmínka, tj pokud $forall A^' subset.eq A : |N_G (A^')| >= |A^'|$
]

#proof[
  Pokud je podmínka porušena pro nějaké $A^'$, pak takové párování neexistuje, protože každý vrchol z $A^'$ potřebuje jiného souseda v $N_G (A^')$.
  
  Proč je postačující?
  
  Ať Hallova podmínka platí. Stačí ukázat (díky König-Egerrary větě), že každé vrcholové pokrytí má velikost alespoň $|A|$

  Sporem ať existuje vrcholové pokrytí $X, |X| < |A|$.

  Označme $C = X inter A$. Uvažme zbylé vrcholy v $A$, tj vrcholy v $A^' = A \\ C$.

  Do hran z $A^'$ musí někdo koukat a musí to dělat zprava. Hrany z $A^'$ vedou v $B$ do $N_G (A^')$ vrcholů, takže kromě $|C|$ vrcholů vlevo je potřeba ještě $|N_G (A^')| underbrace(>=,"Hallova podmínka") |A^'| = |A\\C|$ dalších vrcholů v $X$. Takže $|X| >= |C| + |A\\C| = |A|$
]

== Aplikace Hallovy věty

#definition[
  Graf je $k$- regulární, pokud všechny vrcholy mají stupeň $k$
  - obecně regulární graf: všechny vrcholy mají stejný stupeň
]

#theorem(title: "regulární bipartitní grafy")[
  Ať $k >= 1$ a $G = (A union B, E)$ je $k$-regulární bipartitní graf, Pak $G$ má párování nasycující $A$
]

#proof[
  Z Hallovy věty stačí ověřit Hallovu podmínku. Ať $A'$ je libovolná podmnožina vrcholů z $A$.

  Pak z $A'$ do $B$ vede $e = k dot.op |A'|$ hran. Ale každý vrchol v $B$ má stupeň roven $k$, takže těchto $e$ hran musí vést do alespoň $e/k = |A'|$ vrcholů v $B$
]

#corollary[
  Po odebrání párování zbyde $(k-1)$-regulární graf na který lze opět použít větu $=>$ $k$-regulární bipartitní graf lze "rozložit" na $k$ návzájem disjunktních párování
]

#proposition[
  Každý "latinský obdélník" $k times n, k < n$, lze doplnit na latinský čtverec $n times n$
]

#proof[
  Uvažme bipartitní graf $G = (A union B, E)$, kde:
  - $|A| = n$, odpovídá sloupcům
  - $|B| = n$, odpovídá čtvercům
  - $E$ - hrana mezi sloupcem a číslem, pokud do toho sloupce lze napsat to číslo, (ještě tam není)

  Pak z každého vrcholu $u in A$ vede $n - k$ hran, protože v každém sloupci je $n-k$ volných polí.

  Do každého vrcholu $v in B$ vede $n-k$ hran, protože $v$ je zatím v $k$ různých sloupcích.
  
  Takže $G$ je $(n-k)$ regulární, takže ho lze rozložit na párování. Každé párování udává, jak vyplnit jeden další řádek
]

=== Alternativní verze Hallovy věty (pro systémy podmnožin)

#definition(title: "tranzvenzála")[
  Ať $X$ je konečná množina prvků a $I$ je konečná množina indexů. Pak systém $(A_i)_(i in I)$ podmnožin $X$ má $underline("systém různých reprezentantů")$ (SRR nebo tranzvenzála), pokud $exists f: I arrow X$ takové, že:
  - $forall i in I: f(i) in A_i$
  - $f$ je prosté

  SSR je konkrétně funkce $f$
  (tohle je možná basically páování na bip. grafu, ale nejsem si jistej)
]

#theorem(title: "Hallova pro SRR/tranzvenzály")[
  Ať $X$ je konečná množina prvků a $I$ je konečná množina indexů. Uvažme systém $(A_i)_(i in I)$ podmnožin $X$. Pak $(A_i)_(i in I)$ má SRR, právě tehdy když:
  $ forall J subset.eq I:  |union.big_(j in J) A_j | >= |J| $
]
#proof[
  Ekvivalentní s Hallovou větou
]
