# Graph Kernel

Mějmě graf $G(V,A)$, platí: $n = \left| V \right|, m = \left| A \right|$  množinu $V$ je možné převést na množinu $\left[n\right]$ a potom $(i,j) \in A$ pokud
mezi vrcholy, které jsou reprezentované čísly $i,j$ vede hrana.

Dále jazyk $\mathbb{P} = \{p_1, p_2, ..., p_n \}$, kde $p_i = 1$ pokud vrchol $i$ je v jádru grafu.
Teorie $T$:

$ T = \left\{ \neg(p_i \land p_j) \equiv (\neg p_i \lor \neg p_j)  | (i,j) \in A \right\} \cup 
\left\{ p_i \lor \bigvee_{l : (l,i) \in A} p_l \right\} $