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

= Náhodné grafy

#definition(title:"Erdos-Rényi náhodný graf")[
  Uvažme $n$ vrcholů $v_1,v_2,...,v_n$. Pak $G(n,p)$ je náhodný graf, kde každá hrana ${v_i, v_j}$ je s pravděpodobností $p in [0,1]$ nezávislé na ostatních hranách
]
#example[
  - $G(n, p = 1)$ je vždy $K_n$
  - $G(n, p=0)$ je vždy graf bez hran
  - $G(n, p = 1/2)$ je uniformně náhodný ze všech $2^(binom(n,2))$ grafů 
  - $EE[deg(v_i)] = p dot.op (n - 1)$
  - $EE["počet hran"] = p dot.op (n(n-1))/2$
]

#remark[
  Jak velké musí být $p$, aby $G(n,p)$ byl #quote[typicky] (skoro jistě) souvislý
]
#remark[
  Že $G(n,p)$ je #quote[typicky] (skoro jistě) souvislý znamená, že pravděpodobnost souvislosti jde k $1$, když $n$ jde k $oo$
]

#theorem[
  Pro $p = (1,1)/n$ bude typicky existovat velká komponenta, co obsahuje $c_1 dot.op n$ vrcholů a všechny ostatní komponenty mají $<= c_2 dot.op log(n)$ vrcholů
]
#example[
  - Pro $p = (1.1 dot.op log(n))/n$ je $G(n,p)$ typicky souvislý
]

= Počítání dvěma způsoby

#example[

  Na párty je $8$ kluků a $6$ holek. Každý kluk zná přesně $3$ holky (vlastnost #quote[znát někoho je symetrické - když $k_1$ zná $h_1$, pak $h_1$ zná $k_1$]) a každá holka zná $x$ kluků. Kolik může být $x$

  *Řešení*

  Ať $Z$ je počet dvojic kluk-holka, kteří se znají. 

  Pak $8 dot.op 3 = Z = 6 dot.op x => x = 24/6 = 4$
]

== Aplikace
#enum()[
  *Kostry*

  #definition(title: "Kostra grafu")[
    Kostra grafu $G = (V,E)$ je strom $T = (V, E' subset.eq E)$, Označme $t(G)$ počet koster grafu $G$
  ]
  #example[
    - $t(K_2) = 1$
    - $t(K_3) = 3$
    - $t(K_4) = 16$
  ]

  #theorem(title:"Cayley")[
    Pro $n >= 2$ platí $t(K_n) = n^(n-2)$
  ]
  #proof[
    Ať $Z =$ #quote[počet postupů výstavby zakořeněného stromu]

    Dva způsoby jak spočítat $Z$ 
    #enum(numbering: "a)")[
      $Z = underbrace(["# stromů"], t(K_n)) dot.op underbrace(["# kořenů"], n) dot.op underbrace(["# orientací hran"], 1) dot.op underbrace(["# pořadí kreslení hran"], (n-1)!)$
    ][
      Postupně kreslíme hrany. Na první hranu máme $n dot.op (n - 1)$ možností.

      Pokud jsme už nakreslili $k in {0,1,2,..., n-2}$ hran, tak máme $n - k$ komponent, z nichž každá je zakořeněný strom

      Na #underline[konec] další hrany máme $n$ možností a na její #underline[začátek] pak $n - k - 1$ možností (totiž kořeny všech ostatních komponent).

      Takže $Z = n(n-1) dot.op n(n-2) dot.op n(n-3) dot.op ... dot.op (n dot.op 1) = n^(n - 1) dot.op (n - 1)!$
    ]

    Porovnáním způsobů nám vyjde $t(K_n) = Z/(n dot.op 1 dot.op (n-1)!) = n^(n-2)$
  ]
][
  *Antiřetězce*
  #definition(title:"Antiřetězec")[
    Ať $[n]$ a $cal(P)([n])$ je systém všech podmnožin $[n]$.
    
    #underline[Antiřetězec] je $A subset.eq cal(P)([n])$ taková, že $forall M_1,M_2 in A$ neplatí $M_1 subset.eq M_2$ ani $M_2 subset.eq M_1$
  ]
  #theorem(title:"Sperner")[
    Velikost největšího antiřetězce v $cal(P)([n])$ je $binom(n, #math.floor($n/2$))$
  ]
  #proof[
    Tak velký antiřetězec existuje - stačí do $A$ vzít všechny $floor(n/2)$- prvkové podmnožiny $[n]$.

    Ať $A subset.eq cal(P)([n])$ je libovolný antiřetězec.

    Ať $Z =$ #quote[počt dvojic $(M,C)$], kde $M in A$ a $C$ je nějaký maximální řetězec skrz $M$, tedy posloupnost $emptyset = M_0 subset.eq M_1 subset.eq ... subset.eq M_n$, kde $|M_k| = k$

    Dva způsoby, jak spočítat $Z$:
    #enum(numbering: "a)")[
      Nejdřív zvolíme $C$ ($n!$ možností), v něm je pak nejvýše $1$ prvek $A$. Tedy $Z <= n! dot.op 1$
    ][
      Nejdříve zvolíme $M in A$. Pokud $|M| = i$, tak řetězců skrz $M$ je $i! dot.op (n - i)!$. Takže:

      $ Z = sum_(M in A) i! dot.op (n-i)! = sum_(M in A) (n!)/(binom(n,i)) >= sum_(M in A) (n!)/ (binom(n, #math.floor($n/2$))) = |A| dot.op (n!)/(binom(n, #math.floor($n/2$))) $
      Takže $n! >= Z >= |A| dot.op (n!)/(binom(n, #math.floor($n/2$)))$, takže 
      $ |A| <= binom(n, #math.floor($n/2$)) $
    ]
  ]
][
  *4 cykly*
  #theorem(title:"Graf bez $C_4$")[
    Pokud $G = (V,E)$ na $n$ vrcholech neobsahuje $C_4$ jako podgraf, pak $|E| <= 1/2 dot.op (n dot.op sqrt(n) + n)$
  ]
  #remark[
    KPR řádu $p$ má incidenční graf, co má $2 dot.op (p^2 + p + 1)$ vrcholů a $(p^2 + p + 1) dot.op (p + 1)$ hran, což je asymptoticky těsné
  ]
  #remark[
    Budeme potřebovat, že $forall x_1,..., x_n in RR$ platí:
    $ n dot.op (x_1^2 + ... + x_n^2) >= (x_1 + ... + x_n)^2 $
    Plyne z Cauchy Schwarze:
    $ |<u,v>| <= ||u|| dot.op ||v|| $
    Což pro $v = (1,...,1)$ dělá:
    $ (u_1 + u_2 + ...+ u_n)^2 <= (u_1^2 + ... + u_n^2) dot.op underbrace(1 + ... + 1, n) $
  
    Jensen: 
    $f((x_1 + ... + x_n)/n) <= 1/n sum_(i = 1)^n f(x_i)$, pro $f(x) = x^2$
  ]
  #proof[
    Ať $Z = $ #quote[počet třešní v $G$]

    *Třešeň:*
    Visí z vrcholu 1 a vede do vrcholů 2,3
    #align(center)[
      #adjacency(
        vertex-labels:("1", "2", "3"),
        (
          (none, "", ""),
        ),
        directed: false,
        node:(
          shape: "circle",
          width: 0.3,
          fixedsize: true
        ),
      )
  ]

    Z předpokladu každé 2 třešně vedou do jiné dvojice vrcholů (jinak tvoří $C_n$), takže $Z <= (n(n-1))/2$.

    Z vrcholu stupně $d$ visí $(d(d-1))/2$ třešní, takže celkem:

    $ Z = sum_(v in V) (deg v dot.op (deg v - 1))/2 >= sum_(v in V) (deg v - 1)^2/2 >= 1/(2n) (sum_(v in V) (deg v - 1))^2 = 1/(2n) dot.op (2 |E| - n)^2 $
   Tady nějaká algebra, přes kvadratické rovnice vypadne $|E| <= (sqrt(n^2 (n -1)) + n)/2 <= (n sqrt(n) + n)/2$ 
  ]
]

