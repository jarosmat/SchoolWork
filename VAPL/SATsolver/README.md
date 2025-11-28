# Graph Kernel

Mějmě orientovaný graf $G(V,A)$, platí: $n = \left| V \right|, m = \left| A \right|$. Množinu $V$ je možné převést na množinu $\left[n\right]$ a potom $(i,j) \in A$ pokud
mezi vrcholy, které jsou reprezentované čísly $i,j$ vede hrana.

## Problém

Má graf $G$ jádro? Jádro je množina $W \subseteq V$ taková, že platí:
+ $ \forall u,v \in W: (u,v) \notin A \wedge (v,u) \notin A $
+ $ \forall v \in V / W: \exists w \in W: (w,v) \in A $

## Jazyk

$\mathbb{P} = \{p_1, p_2, ..., p_n \}$, kde $p_i = 1$ pokud vrchol $i$ je v jádru grafu.

## Teorie
$ T = \left\{ \neg(p_i \land p_j) \sim (\neg p_i \lor \neg p_j)  | (i,j) \in A \right\} \cup 
\left\{ p_i \lor \bigvee_{l : (l,i) \in A} p_l \right\} $