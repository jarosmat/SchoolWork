#import "@preview/theorion:0.4.0": *
#import cosmos.fancy: *
#show: show-theorion
#let ol(content) = math.overline(content)
#let pc = text(font: "Allura")[P]

= Vytvorujici funkce

#example[
  Kolik je ruznych sad 7 kulicek, pokud mame 5 cervenych, 4 zelene a 3 modre?

  Plati, ze odpoved je koeficient u $x^7$ v polynomu:
  $ (sum_(i=0)^5 x^i) (sum_(i=0)^4 x^i) (sum_(i=0)^3 x^i) $
]

#definition(title: "Vytvorujici funkce dane posloupnosti")[
  Vytvořující funkce posloupnosti $A = (a_0, a_1, a_2, a_3, ...)$ je funkce $f_A : RR arrow RR$ dana předpisem $f_A (x) = sum_(n=0)^infinity a_n x^n$
]

#example[
  pokud $A = (1, 1, 1, 1, ... , 1, 0, ... )$, kde je $n$ jednicek, pak
  $f_A = 1 + x + x^2 + ... + x^(n-1) = (1 - x^n)/(1 - x)$
]
#example[
  Pokud $A = (1,1,1,1, ... )$, pak $f_A (x) = 1 + x + x^2 ... = 1/(1 -x)$, pokud $abs(x) < 1$
]

#theorem(title: "z analyzy")[
  Pokud $exists k$ takove, ze $A = (a_n)^infinity_(n=0)$ splnuje $forall n : a_n < k^n$, pak $exists c in R$, ze $f_A (x) = sum_(n=0)^infinity a_n x^n$ absolutne konverguje pro kazde $x in (-1/c, 1/c)$ a navic plati $f(0) = a_0, f'(0) = a_1, f''(0) = 2 a_2$, obecne $a_n = (f^((n)) (0))/n!$
]
#proof[
  patri do analyzy
]

== Plán
- Kombinatorickou ulohu ("kolik je množství, jak") řešíme tak
  + uvážíme vytvořující fci
  + použijeme analýzu
  + přeložíme zpátky na kombinatoriku

== Slovník
 Ať $(a_0, a_1, a_2, ...)$ ma vytvr funkci $f(x)$, $(b_0, b_1, b_2, ...)$ ma vytvorujici fci $g(x)$, at $c in R$. Pak:
+ Soucet: $(a_0 + b_0, a_1 + b_1, a_2 + b_2, ...)$ ma vytvorujici fci: $f(x) + g(x)$
+ Nasobeni konstantou: $(c a_0, c a_1, c a_2, ...)$ ma vytvorujici fci: $c f(x)$
+ Pravy posun: $(0, 0, 0, ..., 0, a_0, a_1, a_2, ...)$, kde je $k$ nul ma vytvorujici fci: $x^k f(x)$
+ Levy posun: $(a_k, a_(k+1), a_(k+2), ...)$ ma vytorujici fci: $(f(x) - sum_(i=0)^(k-1) a_i x^i)/x^k$
  - odectu od toho prvnich k clenu a pak to vydelym potrebnou mocninou $x$
+ Substituce $x$ za $c x$: $(a_0, a_1 c, a_2 c^2, a_3 c^3, ...)$ ma vytvorujici fci $f(c x)$
+ Substituce $x$ za $x^k$, coz je fce: $f(x^k) = a_0 + a_1 (x^k) + a_2 (x^k)^2$, ktera vytvoruje posloupnost:
  $(a_0,0, ..., 0, a_1, 0, ..., 0, a_2, ...)$, kde je mezi kazdym cislem $k - 1$ nul
+ Derivace: $(a_1, 2a_2, 3 a_3, ...)$ ma vytvorujici fci $f'(x)$
+ Integral: $integral f(x) $ patri posloupnosti $(0, a_0, a_1/2, a_2/3, ...)$
+ Soucin: $f(x) g(x)$ odpovida posloupnosti: $(a_0 b_0, a_0 b_1 + a_1 b_0, ...)$

#example[
  vytvorujici fce pro $(2,1,4,3,6,5,8,7, ...) = (1,2,3,4,5,6, ...) + (1, -1, 1, -1, 1, -1, ...)$.
  Prvni clen souctu pres derivace pravidlo, druhy pres substituci $x$ za $c x$
]

= Vzorec pro Fibonacciho cisla
#definition(title: "Fibonnaciho cisla")[
  $a_0 = 0, a_1 = 1, a_(n+2) = a_(n+1) + a_n$
]

At $f(x) = a_0 + a_1 x +a_2 x^2 + ...$ je vytvrojuci fce Fibonnaciho cisel.
$ f(x) - x f(x) - x^2 f(x) = $  
$ = a_0 + (a_1 - a_0)x + (a_2 - a_1 - a_0)x^2 + (a_3 - a_2 - a_1)x^3 + (a_4 - a_3 - a_2)x^4 $
$ = a_0 + (a_1 - a_0)x = x $ jelikoz $a_0 = 0, a_1 = 1$ a $a_(n+2) = a_(n+1) + a_n arrow.double a_(n+2) - a_(n+1) - a_n = 0$

Z toho lze odvodit, že:
$ f(x) = x/(1 - x - x^2) = x/((1 - (1 + sqrt(5))/2 x)(1 + (sqrt(5) -1)/2 x)) = (1/sqrt(5))/(1 - (1 + sqrt(5))/2 x) + (-1)/sqrt(5) / (1 + (sqrt(5) -1)/2 x) = $
$ = 1 / sqrt(5) dot.op 1 / (1 - (1 + sqrt(5))/2 x) - 1/sqrt(5) dot.op 1/(1- (1 -sqrt(5))/2 x) = 1/sqrt(5)  sum_(k=0)^oo ((1+sqrt(5))/2 x)^k - 1/sqrt(5)  sum_(k=0)^oo ((1 - sqrt(5))/2 x)^k = $
$ = sum_(k=0)^oo (1/sqrt(5) ((1+ sqrt(5))/2)^k - 1/sqrt(5) ((1 - sqrt(5))/2)^k) dot.op x^k $

Z toho, že to je vytvořující funkce fibonaciho posloupnosti:
$ a_n = 1/sqrt(5) ((1+ sqrt(5))/2)^n - 1/sqrt(5) ((1 - sqrt(5))/2)^n  = 1/sqrt(5) dot.op ((1+sqrt(5))^n - (1 - sqrt(5))^n)/2^n $

= Zobecnění binomické věty

#proposition[
  Pro $x in RR$ a $n in NN$ platí 
  $ (1 + x)^n = sum_(i=0)^n binom(n,i) dot.op x^i $
  Takže $(1 + x)^n$ je vytvořující funkce posloupnost: $(1, binom(n,1), binom(n,2), ..., binom(n,n), 0, 0,...)$
]

#definition(title: "zobecněná kombinační čísla")[
  Pro $r in RR$ a $i in NN$ položme:
  Pokud $i = 0: binom(r,i) = 1$ jinak platí:
  $ binom(r,i) = (r (r - 1)(r -2)...(r - i + 1))/i! $
  
]

#theorem(title: "zobecnění binomické")[
  Pro $r in RR$ a $x in (-1, 1)$ platí:
  $ (1 + x)^r = binom(r, 0) + binom(r,1)x + binom(r,2)x^2 + ... = sum_(i=0)^oo binom(r, i) x^i $
]
#proof[
  Patří do analýzy, idea je přes taylorův polynom funkce $f(x) = (1+x)^r$ v bodě $x = 0$, pokud v Taylorův polynom získáme v tomto bodě, vypadne nám z toho hledaná rovnost. U polynomu je potřeba ověřit nějaké podmínky
]

#corollary(title: "Ze zobecněné binomické věty")[
  Pro $x in (-1,1)$ platí:
  $ 1/(1-x)^n = (1 -x)^(-n) = sum_(i=0)^oo binom(-n,i) (-x)^i = sum_(i=0)^oo ((-n)(-n -1)... (-n -i + 1))/i! (-x)^i = $
  $ = sum_(i=0)^oo (-1)^i ((n + i -1) ... (n + 1)(n))/i! (-1)^i x^i  = sum_(i=0)^oo binom(n - 1 + i, i) x^i = sum_(i=0)^oo binom(n - 1 + i, n - 1) x^i $
]

#example[
  
  Pro $n = 2$: $1/(1 - x)^2 = 1 + 2x + 3x^2 + 4x^3$ je vytvořující fce pro $(1,2,3,4,...)$
  
  Pro $n = 3$ $1/(1-x)^3 = 1 + 3x + 6x^2 + 10x^3$ je vytvořující funkce pro $(1,3,6,10,15)$
]

#definition(title: "Binární strom")[
  Binární strom je buď prázdná množina nebo má kořen a dva podstromy (levý a pravý), z nichž každý je binární strom
]

#definition[
  Označnme $b_n$ počet binárních stromů na $n$ vrcholech, potom platí:
  $ b_0 = 1 $
  $ b_1 = 1 $
  $ b_2 = 2 $
  $ b_3 = 5 $
  $ b_4 = 14 $
  $ b_5 = 42 $
]

#definition(title: "Catalanova čísla")[
  Pro $n >= 0$ označme $C_n = 1/(n+1) binom(2n, n)$ jako $n$-té Catalanovo číslo
]

#theorem[
  Označnme $b_n$ počet binárních stromů na $n$ vrcholech, potom platí:
  $ b_0 = 1 $
  $ b_1 = 1 $
  $ b_2 = 2 $
  $ b_3 = 5 $
  $ b_4 = 14 $
  $ b_5 = 42 $
  Potom pro $n>= 0$ platí: $b_n = C_n$
]
#proof[
  Pozorování: $b_n = b_0 b_(n-1) + b_1 b_(n-1) + ... + b_(n-2) b_1 + b_(n-1) b_0$, protože pokud uvážíme, že máme kořen a pak dva podstromy, kde jeden bude mít $i$ vrcholů a druhý $n-1-i$ vrcholů, tak potom počet takových stromů je $b_i dot.op b_(n-1-i)$

  Označme: $B(x) = b_0 + b_1 x + b_2 x^2 + ...$ 

  Platí: $(B(x))^2 = (b_0 + b_1 x + b_2 x^2 + ...) dot.op (b_0 + b_1 x + b_2 x^2 + ...) = b_0^2 + (b_0 b_1 + b_1 b_0)x + (b_0 b_2 + b_1 b_1 + b_2 b_0)x^2 + ... = b_1 + b_2 x + b_3 x^2 + ...$

  Z čeho plyne, že platí:
  $ (B(x))^2 = b_1 + b_2 x + b_3 x^2 + ... $
  $ x dot.op (B(x))^2 + 1 = 1 + b_1 x + b_2 x^2 + b_3 x^3 + ... = B(x) $
  Takže platí:
  $ x (B(x))^2 - B(x) + 1 = 0 $
  Dle kv. rovnice: $B(x) = (1 plus.minus sqrt(1 - 4x))/(2x)$, z úvahy, že $x$ se blíží $0$ vyplívá, že chceme $B(x) = (1 minus sqrt(1 - 4x))/(2x)$

  Zbývá rozvinout $B(x) = (1 minus sqrt(1 - 4x))/(2x)$ do mocninné řady

  Platí: 
  $ sqrt(1 - 4x) = (1 - 4x)^(1/2) = sum_(i=0)^oo binom(1/2, i) dot.op (-4x)^i = 1 + sum_(i=1)^oo binom(1/2, i) (-4x)^i $

  Takže:
  $ B(x) = (- sum_(i=1)^oo binom(1/2, i) (-4x)^i) / (2x) = - 1/2 dot.op sum_(i=1)^oo binom(1/2, i) (-4)^i x^(i - 1) = - 1/2 dot.op sum_(i=0)^oo binom(1/2, i+1) (-4)^(i+1) x^(i) $

  Koeficient před $x^i$ je:
  $ - 1/2 binom(1/2, i+1) (-4)^(i+1) = - 1/2 (1/2 dot.op (-1/2) dot.op (-3/2) dot.op (-5/2) dot.op ... dot.op ((1-2i)/2))/(i + 1)! dot.op (-1)^(i+1) dot.op (2)^(i+1) dot.op (2)^(i+1) =  $
  $ = (-1)^(2i + 2) dot.op ((2i -1)(2i - 3) ... 5 dot.op 3 dot.op 1 dot.op 1)/((i + 1)!) 2^i dot.op (i!)/(i!) = (2 i)! /((i+1)! dot.op i!) = 1/(i+1) dot.op binom(2i, i) $

  Takže $b_i = 1/(i+1) dot.op binom(2i, i)$
]


#definition[
  Rozklad $n in NN$ je zápis $n$ jako součet několika kladných celých čísel. Počet rozkladů $n$ značíme $p(n)$
]
#example[
  $ 4 = 4 = 3 + 1 = 2 + 2 = 2 + 1 + 1 = 1 + 1 + 1 +1 $
]

#proposition[
  Platí, že počet rozkladů $n$ na liché části, značíme $o(n)$, je stejný jako počet rozkladů $n$ na navzájem různé části, značíme $d(n)$
  
  #example[
    $ o(5) = |{5, 3+1+1, 1+1+1+1+1}| = 3 $  
    $ d(5) = |{5, 4 + 1, 3 + 2}| = 3 $
  ]
]
