# Použití

```
kernel.py [-h] [-i INPUT] [-o OUTPUT]
```
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