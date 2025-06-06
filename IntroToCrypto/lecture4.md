# Lecture 4
- IV - initialization vector, some random, pseudorandom, unpredictable or unique value used as initial value for encryption process

## Handling of a message length not being divisible by block size
- padding
- block cipher modes

### Padding
- the last part, that is not complete block is completed by padding
  - padding must be reversible and recipient should be able to tell it is padding and recipient should be able to do so
  without transporting the message length
- there must be P bytes added at the end
  1. repeat P times byte of value P at the end
  2. P value at the end and $P - 1$ random bytes before it
  3. also nonzero hexadecimal byte (f.e. 0x80) and then $P - 1$ zero bytes
- padding can be used as security - recipient checks if the padding has the right syntax
  - if the length of message is divisible by block size, there must be padding block added at the end

## Modes of block ciphers
- ECB — electronic code book
  - encrypt every block using encryption function independently
    - every block is encrypted independently on others
    - can be parallelized
    - two identical messages are encrypted the same
    - if there are two same blocks in message, then both blocks have the same cipher text block
    - changing one bit in a block propagates only in one block
    - its not good, should not be used

![ECB](./pictures/ECB.png)

- CBC - cipher block chaining
  - before encrypting block using encryption function, block is xored with cipher text block of previous block, first
  block is xored with unique random IV
  - CPA secure - is secure against chosen plain text attacks
    - but can leak some info, especially when message is long
  - flipping a bit in cipher text results in destruction of corresponding plain text and flip one bit in next plain text 
  block (this plain text block will be xored with cipher text block with flipped bit as last step of decryption)
  - swapping two cipher blocks destroys four blocks - block that are swapped and blocks that are decrypted using swapped blocks
 
![CBC](./pictures/CBC.png)

- CTR - Counter
  - some random IV is encrypted using block cipher (encryption function) and first block is xored with encrypted IV
    - next block is xored with encrypted IV + 1
  - blocks can be encrypted and decrypted independently
  - IV must not be reused
  - flipping bit in cipher text flips one bit in plain text
  - swapping two cipher blocks destroys plain text block

![CTR](./pictures/CTR.png)

- Output FeedBack
  - simmilar to CTR, but it first encrypts IV and then encrypts encrypted IV
  - blocks cannot be decrypted and encrypted independently

![Output FeedBack](./pictures/Output_FeedBack.png)

## Attacking block cipher
### Attacking Padding
- needs padding oracle
  - message is padded, encrypted and sent, recipient recieves cipher text, decrypts and removes padding, padding removal
  may fail, padding oracle is back channel that tells sender or attacker that the padding removal failed
  - protocol has padding oracle if we can tell, that the message recieved by sender had incorrect padding
  - connection must be closed at some point - and when reciever gets message with incorrect padding, then he just dumps the message and closes connection
    - time it takes recipient to close the connection can be measured and after having the time there is possibility to tell
    if the connection was closed because of incorrect padding

#### Padding oracle attack for CTR
- multiple block message, last block padded using first padding mode
- using padding oracle recognize size of padding (this size will be known as P)
  - recognizing padding size is 1 byte - modifing second to last byte wont give padding error (because that byte is not part of padding - padding wont be incorrect)
  - recognizing padding size grater than 1 - try to modify all combinations of last byte, every modification will give padding error apart from
  modifing that gives decrypted byte of value 1 - valid padding, because in CTR bit flip in cipher text flips bit in plain text - from mask, that modified
  byte to 1 in plain text i can derive padding value
- i know size of padding (P) - i know what value are the last P bytes - modify final block that last P bytes have value P + 1
  - if no padding error - last value of plain text is P + 1, otherwise try all combinations of bit flips on last byte of text till no
  padding error - we have mask that changes last plain text byte to value P + 1, so because bit flip in cipher text flips bit in plain text,
  wh have value of last byte of message
- same trick can be played on all bytes in last block, every byte can be recovered in 256 attempts (all possible bit masks for flipping)
- last block can be chopped of and same thing can be applied on remaining blocks (last byte in block that is now last will be guessed by changing it to 1)
- iterate this until whole message is intercepted

35