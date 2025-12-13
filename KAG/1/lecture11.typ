#import "@preview/theorion:0.4.0": *
#import cosmos.fancy: *
// #import cosmos.rainbow: *
// #import cosmos.clouds: *
#import "@preview/diagraph:0.3.6": *
#show: show-theorion
#show link: underline

#let ol(content) = math.overline(content)
#let pc = text(font: "Allura")[P]
#let kv(content) = $k_v (content)$
#let ke(content) = $k_e (content)$

#lemma(title: "Königovo")[
  Každý nekonečný (má nekonečně mnoho vrcholů), lokálně konečný (každý vrchol má konečný stupeň) zakořeněný strom $T$ s kořenem $r$ obsahuje nekonečnou posloupnost vecholů: $r, v_1, v_2,...$, kde platí:
  - všechny vrcholy v posloupnosi jsou po dvou rozdílné
  - pokud $v_0 = r$, tak $forall i>= 0: {v_i, v_(i+1)} in E$
]
#proof[
  nějak s tím, že existuje nekonečně mnoho cest s koncem v $r$ a pak nekonečně mnoho cest s koncem $r,x_1$ atd..
]

#theorem(title:"Ramseyovo pro p-tuply (hypergrafy)")[
  Pro všechna $p,t,k_1,...,k_t in NN$, číslo $R^p (k_1,...,k_t)$ existuje 
]

#proof[
  Bez důkazu
]

#theorem(title: "Ramseyovo pro p-tuply (hypergrafy) (nekonečná verze)")[
  Pro všechny $t,p in NN$, pro všechny nekonečné množiny $X$ a všechna obarvení: $c: binom(X,p) arrow [t]$ existuje nekonečná množina $A subset.eq X$ taková, že platí: 
  $ forall a,b in binom(A,p): c(b) = c(a) $
  Neboli pro všechny $p$-prvkové podmnožiny množiny $A$ má funkce $c$ stejnou hodnotu (jsou obarvené stejně)
]
#proof[
  Bez důkazu
]


#theorem(title:"Happy ending problem")[
  Každá množina $5$ bodů v rovině, pro kterou platí, že žádná trojice bodů neleží na přímce, obsahuje $4$ body v konvexní poloze 
]

#proof[
  Nejlepší důkaz ve skripech od I. Penev: #link("https://iuuk.mff.cuni.cz/~ipenev/KGLectureNotes.pdf"), Lemma 7.3.1
]

#theorem(title: "Erdös-Szekeres")[
  
]

#proof[
  
]

- Erdős-Szekeres theorem (wiki)





= Samoopravné kódy

- kód je množina $C subset Sigma^n$
  - $Sigma$ je abeceda (důležitá často ${0,1}$)
  - $n in NN$ je délka kódu
  - $|C|$ je velikost kódu

#definition(title: "Hammingova vzdálenost")[
  Mějme množinu $Sigma^n$, a $x,y in Sigma^n$ potom Hammingova vzálenost je funkce:
  $ d(x,y) = |{i in [n] | x_i eq.not y_i }| $
]

#remark[
  Je snadné ověřit, že Hammingova vzdálenost je metrika nad množinou $Sigma^n$
]

#remark[
  Minimální vzdálenost v kódu $C$ je nejmenší Hammingova vzdálenost 2 různých prvků $C$
]

#definition(title: "Hamming weight")[
  Hammingova váha $w t(x)$ je rovna počtu nenulových souřadnic v $x in C subset Sigma^n$ 
]

#definition(title: "(n,k,d) - code")[
  $(n,k,d)_q$ kód je kód, kde:
  - $n$ je délka kódu (délka jednoho prvku $C$)
  - $k = |C|$ je velikost kódu, většinou se délka kódu vyjadřuje jako $k = log_q |C|$
  - $d$ je nejmenší Hammingova vzdálenost v $C$
  - $q$ je velikost abecedy $Sigma$ 
]

#proposition[
 Kód s minimální vzdálenstí $d$ je schopen opravit maximálně $floor((d-1)/2)$ chyb 
]
#proof[
  víme, že $d$ je min vzdálenost mezi nějakými prvky, búno mezi $x,y$, pokud bychom posílali $x$ a udělali $floor(d/2)$ chyb, tak už nevíme kterým směrem se při opravě vydat, jestli k $x$ nebo k $y$
]

#example[
  
  - *Repetition code*
    - $(n,log_q |C| = 1, n)_q$ kód, kde každý prvek $C$ je pouze $n$-tice jednoho prvku z $Sigma$ (například (0,...,0))
  - *Parity code*
    - kód nad konečným tělesem, pro každý $x in C$, že součet souřadnic v $x$ je roven $0$
  - *Fann code*
    - kód z Fannovy roviny
      - je to nad abecedou ${0,1}$, je to $(7, log_2 16, d)$ kód
      - $C$ je tvořeno prvky, které reprezentují všechny přímky Fannovy roviny ($i$-tý bit je $1$, pokud $i$ leží na dané přímce), dále je tvořen negacemi těchto přímek a vektory s pouze $1$ a pouze $0$
]

= Hamard code

#definition(title: "Hammardova matice")[
  Hammardova matice je matice $H in RR^(n times n)$ taková, že platí:
  - $forall i,j in [n]: H_(i,j) = 1 or H_(i,j) = -1$
  - všechny sloupce $H$ jsou navzájem otrogonální
    - jejich standartní skalární součin je roven $0$
]
#example[
  Hammardova matice řádu $2$:
  $ mat(1,1;1,-1) $
]
#example[
 pokud $H$ je Hammardova matice řádu $n$, pak Hammardova matice řádu $2n$ má tvar:
 $ mat(H,H;H,-H) $
]
#proposition[
  Pokud $H$ je Hammardova matice řádu $n$, potom platí:
  - $H dot.op H^T = n dot.op I_n$
  - $H^T$ je také Hammardova matice
]
#example[
 *Hammardův kód*

 Pokud $H$ je Hammrdova matice řádu $n$, potom Hammardův kód určený $H$ je kód tvořen řádky $H$ a řádky $-H$

 Jedná se $(n, 1 + log_2 n, n/2)_2$ kód
]

#definition(title: "Kombinatorická koule")[
  Nechť $n,t,q in NN$, $Sigma$ je abeceda o velikosti $q$, potom $forall w in Sigma^n$ množina $B_t^(Sigma^n) (w)$ je #underline[Kombinatorická koule o poloměru $t$ okolo $w$], pro kterou platí:

  $ B_t^(Sigma^n)(w) = {x in Sigma^n | d(x,w) <= t} $ 
]

#definition[
  Nechť $q,n,d, n>=d, q >= 2$, potom $A_q (n,d)$ je velikost největšího kódu, kde:
  - $q$ je velikost abecedy
  - $n$ je délka kódu (délka jednoho slova v kódu)
  - $d$ je nejmenší minimální Hammingova vzdálenost mezi prvky kódu (minimální vzdálenost může být i větší)
]

#theorem(title: "Hammingova mez (bound)")[
  Nechť $n,d,q in NN, n >= d, q >= 2$ a $t=floor((d-1)/2)$, potom platí:
  $ A_q (n,d) <= q^n/(sum_(k=0)^t binom(n,k)(q-1)^k) $
]

#proof[
  Nechť $C subset Sigma^n$ je kód, $|Sigma| = q$ a minimální vzdálenost v $C$ je $>= d$.

  Dále $m = |C|$ a $C={c_1,...,c_m}$.

  Dále platí, že kombinatorické koule: $B_t (c_1),...,B_t (c_m)$ jsou po dvou disjunktní

  Potom platí:
  $ |Sigma^n| = q^n >= |union.big_(i=1)^(m) B_t (c_i)| = sum_(i=1)^m |B_t (c_i)| = m dot.op sum_(k = 0)^t binom(n,k) dot.op (q - 1)^k = |C| dot.op sum_(k = 0)^t binom(n,k) dot.op (q - 1)^k $

  Z čehož plyne:

  $ q^n >= |C| dot.op sum_(k = 0)^t binom(n,k) dot.op (q - 1)^k $
  $ |C| <= q^n/(sum_(k = 0)^t binom(n,k) dot.op (q - 1)^k) $
]

#theorem(title: "Gilbert-Varsamova mez (bound)")[
  Nechť $n,d,q in NN, n>=d, q>= 2$, potom platí:
  $ A_q (n,d) >= q^n/(sum_(k=0)^(d-1) binom(n,k)(q-1)^k) $
]

#proof[
  Nechť $C subset Sigma^n$ je kód, pro který platí: $|C| = A_q (n,d)$, $|Sigma| = q$ a minimální vzdálenost v $C$ je $>= d$.

  Dále $m = |C|$ a $C={c_1,...,c_m}$.

  Napřed je potřeba ukázat, že platí:
  $ Sigma^n = union.big_(i = 1)^m B_(d-1) (c_i) $
  Pokud by nějaké $w in Sigma^n$ nebylo v $union.big_(i = 1)^m B_(d-1) (c_i)$, znamenalo by to, že není v $C$ (pokud by tam bylo, byla by tam i koule okolo něj, tudíž by tam byl), takže ho  můžeme přidat do $C$, jelikož jeho vdálenost od všech prvků $C$ je alespoň $d$, takže vytvoříme kód o velikosti $|C| + 1 = A_q (n,d) + 1$, což je spor

  Dále je potřeba ukázat, že nerovnost platí:

  $ q^n = |Sigma^n| = |union.big_(i = 1)^m B_(d-1) (c_i)| <= sum_(i=1)^m |B_(d-1) (c_i)| = m dot.op sum_(k=0)^(d-1) binom(n,k) dot.op (q - 1)^k = |C| dot.op sum_(k=0)^(d-1) binom(n,k) dot.op (q - 1)^k $

  Z čehož plyne:

  $ q^n <= |C| dot.op sum_(k=0)^(d-1) binom(n,k) dot.op (q - 1)^k $
  $ A_q (n,d) =  |C| <= q^n/(sum_(k=0)^(d-1) binom(n,k) dot.op (q - 1)^k) $
]

