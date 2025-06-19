# Lecture 5
## Hash function
- mapping $h: \{0,1\}^* → \{0,1\}^b$
- requirements:
1. function should be effectively collision-free
   - nobody should be able to efficiently find collision (it should be impossible to find two different strings of bits 
   that map to the same value using mapping h)
2. second preimage collision 
   - when given value, we cannot find a value that has the same hash
3. function should not be invertible
   - given hash we cannot find value that hashes to given hash
- $1\Rightarrow2\Rightarrow3$

### Merkle-Damgård Construction of hash function
- suppose we have a compression function $f: \{0,1\}^b \times \{0,1\}^b → \{0,1\}^b$
- when hashing sequence of blocks $x_1,...x_n$ (if size is not multiple of block size, the sequence is padded, everything
that is true about padding in symmetric ciphers is true here)
- we take $IV$ (initial value - fixed) and $x_1$, compress them together, creating first intermediate result: 
$I_1 = f(IV, x_1)$, then take $I_1$ and compress it with next block: $I_2 = f(I_1, x_2)$, basically: \
$I_1 = f(IV, x_1)$\
$\forall i \in [n]/\{1\}:  I_i = f(I_{i-1}, x_1)$
- last product $P = h(x_1,...x_n) =f(I_n, n)$, this means $I_n$ is compressed with value $n$ (number of blocks)
  - $n$ usually does not span over one block (its size in bits), then it can be added to the last block as padding

![Merkle-Damgård](./pictures/Merkle_Damgard.png)

### Theorem
- if $f$ (compression function) is collision-free, so is $h$ (hash function)
#### Proof 
- if $h$ is not collision-free neither is $f$ - that is being proven, it is inverse of theorem
- suppose $h(x_1,....x_n) = h(x_1',....x_m')$
1. if $n\neq m$, this means there is a collision at last application of $f$. The Last application of $f$ produces the 
same product, but at least one input must be different (because to one value $m$ is added and to other value $n$ is 
added) $\Rightarrow$ collision found in the last application of $f$
2. if $n = m$, then collision either last $f$ or  the same internal state one step earlier - inductively we can continue
until we find $i$ such that there are different internal states ($I_i \neq I_i'$) or input blocks for given $i$ are 
different ($x_i \neq x_i'$)

### Length extension Property
- we have a hash of some message, but don't know the content of the message ($x$), but we know the length of the message
- with knowledge of hash, we can compute hash of the message with some suffix added
- we know that the result of function $h$ is the result of last compression. 
This means we can add more blocks and compress those blocks
with the result of last compression (our known hash), this extends the original message that was hashed. 
In the end, we must compress it with some padding and new length of the message. 
Essentially, we behave as if the message had not ended before, and we just continue its hashing.
- the extension is not under our full control, there is some information added we did not want to have there (original 
padding and original length of the message)

### Birthday attack
- take messages $x_1,…,x_n$, compute hashes $h(x_1),…,h(x_n)$, hashes are random values
- if $n \approx 2^{\frac{b}{2}}$, then with probability > then some constant there exist some $x_i, x_j, i < j$ and $h(x_i) = h(x_j)$
  - $b$ is the size of result of the hash function $h$ in bits
- this implies that security level is at most $\frac{b}{2}$
- for this attack needs $2^{\frac{b}{2}}\times b$ bits of memory

### Tortoise and hare attack
- imagine graph 
  - vertices are strings
  - edge goes from $v_1$ to $v_2$ only if $v_2$ is hash of $v_1$
- edges go from string to its hash
- while going through the graph at some point, we must hit cycle because there is a finite number of results of hash function,
this results in collision in hash function
- we have two pointers, both pointers start at the same vertex ($v_0$), one pointer moves two vertices per unit of time the other
moves only to the next vertex per unit of time (its known algorithm), at some point pointers meet
  - proof: in finite time both enter cycle, the one pointer traverses the cycle faster so they must meet
- at time $n$ both pointers point to the same vertex, it does not specify where is collision
- remove faster pointer and slower pointer continues for another $n$ steps, after $n$ steps another pointer starts at the
initial vertex ($v_0$), the pointer has the same speed as the slower pointer, new slow pointer and original slow pointer meet
at some point, then just go backwards and at some point they will go in other direction, we have found collision
- this attack needs constant memory and asymptotic time complexity

### Parametrized messages
- function $m$, that is parametrized message

no idea what he is talking about

### COmpresion function



