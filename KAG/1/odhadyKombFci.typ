#import "@preview/theorion:0.4.0": *
#import cosmos.fancy: *
#show: show-theorion
#let ol(content) = math.overline(content)
#let pc = text(font: "Allura")[P]

- proposition = tvrzení 
- corollary = dusledek

= Odhady kombinatorických funkcí

#example[
Je víc funkcí $f: [n] arrow [n]$, kde čísla $f(1), f(2), ..., f(n)$:

1. všechna různá, je jich $n!$
2. všechna sudá, je jich $(n/2)^n$
]


#proposition[

Pro $n >= 1$ platí $n^(n/2) <= n! <= n^n$
]
#proof[
- Upper bound: $ n * (n-1) *...*1 <= n^n $
- lower bound: $ (n!)^2 $
]
#theorem[
  Pro $n>=1$ platí $e (n/e)^n <= n! <= e n (n/e)^n$
]
#proof[
Uvažme $ ln (n!) = sum_(i=1)^n ln(i) = sum_(i=2)^n ln(i) >= integral _(x=1)^n ln(n) = [x ln (x) - x]_(x=1)^(x=n) = n ln(n) - n +1 $
- To s tím integrálem lze odvodit z grafu funkce, levá strana nerovnosti jsou obdelníky mezi jednotlivými hodnotami $i$, z Riemannových sum


Takže: 
$ n! = e^(ln(n!)) >= e^(n ln(n) - n + 1) = n^n * e^(-n) * e = e(n/e)^n $

Podobně

$ integral _(x=1)^n ln(n) >= ln ((n-1)!) $

Takže $e(n/e)^n >= (n-1)! = n!/n$ a $n! <= n e(n/e)^n$
]

#definition(title: "Kombinační číslo")[
Pro $0<= k <= n$ je $binom(n,k) = n!/(k!(n-k)!)$
]

== Víme
+ $binom(n,k)$ je počet $k$-prvkových podmnožin $n$-prvkové množiny
+ $binom(n,k) = binom(n,n-k)$
+ $sum_(k=0)^n binom(n,k) = 2^n$
+ $1 = binom(n,0) <'binom(n,1) <= binom(n, é)$

#proposition[
Pro $n,k >= 1$ platí $(n/k)^k <= binom(n,k) <= (e n /k)^k$
]
#proof[

- lover bound
$ binom(n,k) = (n (n-1) ... (n - k +1))/(k (k-1) ... 1) >= (n/k)^k $

- upper bound 
$ binom(n,k) = (n (n-1) ... (n - k + 1))/k! <= n^k/(e(k/e)^k) <= (n e/k)^k $
]
#proposition[
Pro $n = 2 m, m >= 1$ platí $2^(2m)/(2m + 1) <= binom(2m, m) <= 2^(2m)$
]
#proof[

- upper bound z 

]
#theorem[
Pro $n = 2 m, m >= 1$ platí $2^(2m)/(2sqrt(m)) <= binom(2m, m) <= 2^(2m)/(sqrt(2m))$
]

#proof[
- upper bound
Položme $P_m = binom(2m,m) / 2^(2m) = (2m)! / (m! * m! * 2^m * 2 ^ m) = (2m)! / ((2 * 4 * ... * 2m) * (2 * 4 * ... * 2m)) = (1 * 3 * 5 * ... * (2m - 1))/(2 * 4 * ... * 2m)$

Platí $ P_m^2 = (1 * 1 * 3)/ 2^2 * (3 * 5)/4^2 * (5 * 7)/ 6^2 * ... * ((2m - 3)(2m - 1))/(2m-2)^2 * (2m -1)/((2m)^2)   <= 2m/(2m)^2 = 1 / (2m) $

nerovnost platí protože každý zlomek je menší nebo roven $1$ a poslední zlomek je menší než $2m/(2m)^2$

- lower bound

$P_m^2 = 1/2 * 3^2/(2*4) * (5^2)/(4 * 6) * 7^2/(6*8) * ... * (2m - 1)^2/((2m - 2) * 2m) * 1/(2m) >= 1/(4m)$, takze $P_m >= 1/(2sqrt(m))$
]
