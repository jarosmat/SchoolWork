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
\left\{ p_i \lor \bigvee_{l : (l,i) \in A} p_l | i \in V\right\} $

# Použití skriptu

```
kernel.py [-h] [-i INPUT] [-f FORMULA_OUTPUT]
```

- `-h`, `--help` - vypíše návod pro použití
- `-i`, `--input` - soubor se vstupem
- `-f`, `--formula-output` - soubor kam se má vypsat Teorie v DIMACS formátu
- `-s`, `--solver` - cesta ke spustitelnému SAT solveru

## Vstup

Vstup je ve formátu TGF - trivial graph format.

Prvních $n$ řádků je ve formátu:

```[id] [label vrcholu]```

Řádky popisují vrcholy grafu, `[id]` je id vrcholu, `[label vrcholu]` je popis vrcholu.

Na řádku $n + 1$ je `#`.

Dalších $m$ řádků je ve tvaru.

```
[id1] [id2] [label hrany] 
```

Řádky popisují orientované hrany, `[id1]` je id počátečního vrcholu, `[id2]` je id vrcholu kam vede
hrana, `[label hrany]` je popis hrany.

# Příklady vstupů 
Příklady vstupů jsou ve složce `instances/`
- `simpleSat.tfg` je příklad jednoduchého grafu o $8$ vrcholech a $4$ hranách pro který je problém splnitelný
- `simpleUnsat.tfg` je příklad jednoduchého grafu o $3$ vrcholech a $3$ hranách (jedná se o úplný graf na $3$ vrcholech
nebo kružnice na $3$ vrcholech), pro který není problém splnitelný
- `nontrivialSat.tfg` je příklad rozsáhlejšího grafu na $300$ vrcholech, pro který je problém splnitelný, graf byl náhodně
vygenerován pomocí skriptu `lib/GraphGenerator.py`

## `lib/GraphGenerator.py`
- skript generuje náhodný graf podle parametrů na vstupu

### Použití
- `-h`, `--help` - vypíše návod pro použití
- `-n` - počet vrcholů v grafu
- `-m` - počet hran v grafu, pokud počet hran není určen uživatelem, je zvolen náhodně z intervalu $[1, n^2]$,
skript nezaručuje, že náhodně vygenerované hrany budou rozdílné
- `-o`, `--outpu-file` - soubor kam zapsat vygenerovaný graf ve formátu TGF 