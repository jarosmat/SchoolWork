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
#let wt = $w t$
#let ker = $K e r$
#let rank = $r a n k$

= Lineární kódy

#definition(title: "Lineární kód")[
  Lineární kód je podprostor $C$ vektorového prostoru $TT_q^n$, kde $TT_q$ je konečné těleso velikosti $q = p^n$, kde $p$ je prvočíslo a $n>= 1 in NN$
]
#remark[
  Každý lineární kód obsahuje $o$ (nulový vektor)
]
#remark[
  Pokud lineární kód $C$ je n $(n,k,d)_q$ kód, značíme, že $C$ je $[n,k,d]_q$ (hranaté závorky značí lineární kód)
]

#proposition[
  Nechť $C$ je $[n,k,d]_q$ kód, potom $dim C = k$
]
#proof[
  Bez důkazu
]

#proposition[
  Ať $C subset.eq TT^n_q$ je $[n,k,d]_q$ kód, kde platí $0<k<n$, potom platí:
  $ d = min{wt(x) | x in C and x eq.not o} $
]

#proof[
  Nechť $x in C\\ {o}$ je takové, že má minimální Hammingovu váhu, je potřeba ukázat, že platí:
  $ d = wt(x) $
    #enum(numbering:"a)")[
    Napřed ukážeme nerovnost $wt(x) >= d$

    Víme, že $o in C and o eq.not x$, z toho lze usoudit, že platí: $d(x,o) >= d$, ale jelikož platí: $d(x,0) = wt(x)$, platí: $wt(x) >= d$
    
  ][
    Dále ukážeme nerovnost $wt(x) <= d$

    Uvažme $y,z$ takové, že platí: $d(y,z) = d$, víme že platí:
    - $y - z in C$
    - $wt(y-z) >= wt(x)$
    Lze usoudit:
    $ d = d(y,z) underbrace(=, "vynulují se pouze hodnoty" \ " ve kterých se rovnají") wt(y - z) >= wt(x) $
  ]
]

#proposition[
  $C^perp = {x in TT_q^n | forall y in C: chevron x,y chevron.r = 0}$ je podprostor vektorového prostoru $TT^n_q $
]

#proposition[
  Nechť $C$ je $[n,k,d]_q$ a $C$ je podporostor vektorového prostoru $TT_q^n$, jehož dimenze je $n$, potom platí:
  $ dim C + dim C^perp = n $
]

#definition(title: "Generátorová a parity check matice lineárního kódu")[
  Nechť $C subset.double TT_q^n$ je $[n,k,d]_q$ kód, potom: 
  - matice $G in TT_q^(k times n)$ je #underline[genrátorová matice kódu $C$], pokud její řádky jsou tvořené nějakou bází prostoru $C$
  - matice $P in TT_q^(n times (n - k))$ je #underline[parity check matice kódu $C$], pokud její sloupce jsou tvořeny bází prostoru $C^perp$
]

#theorem[
  Pokud $C$ je $[n,k,d]_q$ kód $P in TT_q^(n times (n-k))$ jeho parity check matice a $x in TT_q^(1 times n)$, pak platí že: 
  $ x in C <==> x dot.op P = 0 $
]
#proof[
  Bez důkazu
]

= Hammingovy kódy
#definition(title: "Hammingův kód")[
  Mějme $l >= 2, n = 2^l - 1, k = 2^l - l - 1, d = 3$, potom Hammingův kód je kód jehož Parity check matice $P in TT_2^(n times l)$ je definována následovně:

  $P = vec(h_1,dots.v,h_n)$

  Kde $h_i in TT_2^(1 times l)$ je $l$-bitová reprezentace čísla $i$ v binární soustavě $((h_i)_n)$ je least significat bit.

  Potom Hammingův kód $C = {x in TT_2^(1 times n) | x dot.op P = o}$ je $[n,k,d]_2$ kód
]

#theorem[
  Hamingův kód $H_r$ je $[n = 2^r - 1, k = 2^r - r - 1, d = 3]_2$ kód
]

#proof[

  *V plánu přednášky nebyl - je tady navíc*
  #enum()[
    Určitě platí: $C subset.double TT_2^n$, jelikož se jedná o jádro matice $P^T$
  ][
    Dále je potřeba ukázat, že platí: $dim C = k$

    Jednotkové vektory $e_1,...,e_l in TT_2^(1 times l)$ jsou určitě řádky matice $P$ (jsou to binární reprezentace nějakého čísla), tudíž: $rank(P) = l$, ale z lineární algebry víme, že platí: $dim ker (P) + rank (P) = n$, takže platí:
    $ dim ker (P) = n - rank (P) = n - l = 2^l - l - 1 = k $
  ][
    Jako poslední je potřeba ukázat: $d = 3$

    Víme, že $d = min {wt (x)| x in C}$,

    Vektory pro které platí $wt (x) = 1$, jsou jednotkové vektory a ty určitě neptří do $ker (P)$

    Vektory pro které platí $wt (x) = 2$ také nepatří do $ker (P)$, jelikož pro takové vektory platí: $x = e_i + e_j$, kde $j eq.not i$, pro něž platí:

    $ (e_i + e_j)P = h_i + h_j underbrace(eq.not, h_i eq.not h_j) o $

    Naopak některé vektory $x$, pro které platí: $wt (x) = 3$, například $e_1 + e_2 + e_3$ už náleží $ker (P)$:

    $ (e_1 + e_2 + e_3)P = vec(0,0,dots.v,0,1)^T + vec(0,0,dots.v,1,0)^T + vec(0,0,dots.v,1,1)^T = o $
  ]
]

#example[
  Hammingův kód je schopen úspěšne opravit maximálně jednu chybu - z velikosti $d$.

  Předpokládejme, že jsme přijali $w in TT_2^(1 times n)$ takové, že se liší od nějakého $x in C$ pouze v jedné souřadnici $i$, potom platí:

  $ w = x + e_i $
  $ w dot.op P = (x + e_i) dot.op P = underbrace(x dot.op P, = o) + underbrace(e_i dot.op P, = h_i) = h_i $

  Takto jsme schopni získat binární reprezentaci souřadnice na které se $w$ liší od $x$ 
]
