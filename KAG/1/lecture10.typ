#import "@preview/theorion:0.4.0": *
#import cosmos.fancy: *
// #import cosmos.rainbow: *
// #import cosmos.clouds: *
#import "@preview/diagraph:0.3.6": *
#show: show-theorion

#let ol(content) = math.overline(content)
#let pc = text(font: "Allura")[P]
#let kv(content) = $k_v (content)$
#let ke(content) = $k_e (content)$

#example(title: "Pozorování")[
  $K_(n/2, n/2)$ (bipartitní graf o partitách velikostí $n/2$) má $approx 1/4 n^2$ hran a neobsahuje $K_3$ jako podgraf
]

#definition[
  Pro graf $H$ a $n$ označme $e x(H,n)$ nejvyšší počet hran, který může mít graf na $n$ vrcholech, aby neobsahoval $H$ jako podgraf
]
#example[
  Minule: $e x(C_4,n) <= 1/2 (n dot.op sqrt(n) + n)$
]

#theorem(title: "Mantel")[
  Platí $e x(K_3,n) <= 1/4 n^2$
]
#proof[
  Indukcí podle $n$
  
  Pro $n in {1,2}$ platí.

  Ať platí pro $n - 2$, dokazujeme pro $n$. Nepřítel zadal graf $G$ na $n$ vrcholech.

  - Pokud $G$ nemá hranu: OK
  - Jinak vezmeme libovolnou hranu ${u,v}$. Pak:
  $|E(G)| <= underbrace(1/4 (n - 2)^2, "hrany v " G\{u\,v}) + underbrace(1, u v) + underbrace(n - 2,) = 1/4 (n^2 - 4n + 4 + 4n - 4) = 1/4 (n^2)$
]

#theorem(title: "Turán")[
  Platí $e x(K_(r+1),n) <= (1- 1/r) dot.op n^2/2$
]
#proof[
  bez důkazu
]
#definition[
  #underline[Klika] je úplný graf, typicky když je to podgraf většího grafu
]

= Ramseyovy věty

== Dirichletův princip
#example[
  Alice, Bob a Charlie mají dohromady $a + b + c + 1$ hraček. Ať si je rozdělí jakkoliv, bude mít Alice $>= a + 1$ hraček nebo Bob $>= b + 1$ hraček nebo Charlie $>= c + 1$ hraček
]

#proof[
  Sporem, kdyby ne, bylo by hraček nejvýše $a + b + c$, spor
]

#proposition[
  V každé skupině $6$ lidí je trojice, ve které se buď každí $2$ znají nebo žádní $2$ neznají (známosti jsou vzájemné - je to symetrická relace)
]
#proof[
  Uvažme úplný graf $G = (V,E)$ na $6$ vrcholech
  - žlutá hrana: znají se
  - modrá hrana: neznají se

  Vezmeme libovolný vrchol $v in V$. Podíváme se na hrany co z něj vedou. Z Dirichletova principu mají některé $3$ stejnou barvu, búno žlutou.

  Podíváme se na ty $3$ sousedy
  - Pokud $exists 2$ které jsou spojeni žlutě, máme spolu s $v$ žlutý trjúhelník
  - Pokud každá dvojice sousedů je spojená modře, tvoří dohromady modrý trojúhelník
]

#definition[
  Ať $k,l >= 1$. Pak #underline[Ramseyovo číslo] $R(k,l)$ je nejmenší $n$, že ať obarvíme hrany $K_n$ libovolně žlutě a modře, bude existovat celá žlutá $K_k$ nebo celá modrá $K_l$
]
#example[
  příklad ukazuje $R(3,3) <= 6$
]

#theorem[
  Ať $k,l >= 1$. Pak $R(k,l) <= binom(k-1 + l - 1, k - 1) =  binom(k + l - 2, l - 1)$
]
#proof[
  Indukcí podle $k + l$

  Pokud $k=1$, tvrzení říká:
  - pro každé obarvení $K_n$, kde $n = binom(l-1,l-1) = 1$, existuje žlutá $1$-tice nebo ...

  Podobně pro $l = 1$.

  Dále ať $k,l >= 2$ 

  Ať $n = R(k - 1,l) + R(k, l - 1)$. Vezmeme $K_n$ a libovolný $v in V$. $v$ má $n - 1 =(R(k - 1,l)-1) + (R(k, l - 1)-1) + 1$ sousedů, tak podle Dirichletova principu má buď 
  #enum(numbering: "a)")[
    $R(k - 1, l)$ žlutých sousedů
  ][
    $R(k, l - 1)$ modrých sousedů
  ]

  Pokud a), pak mezi žlutými sousedy $v$ existuje buď žlutá $K_(k - 1)$ (přidej $v$ a hotovo) nebo modrá $K_l$ (rovnou hotovo)

  Pokud b), pak podobně

  Zbývá ukázat, že $n <= binom(k + l - 2, k - 1)$. 
  
  Platí:
  $ n = R(k-1,l) + R(k,l-1) <= (k + l - 3)!/((k-2)! dot.op (l - 1)!) dot.op (k - 1)/(k - 1) + (k + l - 3)!/((k-1)! dot.op (l - 2)!) dot.op (l - 1)/(l - 1) = \ =  ((k + l - 3)! ((k - 1) + (l - 1)))/((k - 1)! dot.op (l - 1)!) = (k + l - 2)!/((k - 1)! (l - 1)!) = binom(k + l - 2, k - 1) $
]

#theorem[
  Pro $k >= 5$ platí $R(k,k) >= 2^(k/2)$.
]
#proof[
  Vezmeme náhodné obarvení $K_n$, kde $n = 2^(k/2)$ a ukážeme, že s kladnou pravděpodobností zafunguje.

  Obarvíme každou hranu náhodně žlutě nebo modře s pravděpodobností $1/2$, nezávisle na všech ostatních hranách.

  Ať $X subset.eq V, |X| = k$. Pak
  $ p = P["v náhodném obarvení mají všechny spojnice v" X " stejnou bravu"] = 2/(2^(binom(k,2))) $

  Podle #quote[Union Bound] platí (pro $k >= 5$ platí $k! >= 2^(k+1)$):
  $ P["selžeme"] <= ["počet" k "-tic"] dot.op p = binom(n,k) dot.op p <= (n^k)/(k!) dot.op p <= (n^k)/ (2^(k+1)) dot.op p = (2^(k dot.op (k/2)))/(2^(k+1)) dot.op 2/(2^((k(k-1))/2)) = 1/(2^(k/2)) < 1 $

  Takže $P["selžeme"] < 1$, takže existují obarvení, kde žádná $K_k$ není celá jednobarevná
]

#corollary[
  $(sqrt(2))^k <= R(k,k) <= binom(2k - 2,
k -1 )<= 4^k$
]
