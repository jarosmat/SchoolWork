# Lecture 1

- message is stream of bits
- all information about message cant be hidden
  - usually we cant hide size of message
- cryptography algorithms are not kept secret, but are parametrized
- designing a strong cryptographic algorithms is hard
- we don't know how to prove security of cipher
- best thing is to use widely studied cryptographical algorithms
- confidentiality - the message will be kept secret
  - confidential protocols prevent anybody but intended recipient from reading the message 
- integrity - the message won't be changed
  - protocols providing integrity ensure that when the message is modified it will fail and recipients will be able to tell
- NONCE - number used once
  - value that will be used only once by the same protocol

## Cryptography primitives
- symmetric cipher
- asymmetric cipher
- hash function
- random number generator

## Symmetric Cipher
- algorithms have same key for encrypting and decrypting message
- confidential, does not provide integrity (we cant tell if the message was changed)
- symmetric cyphers are fast

## Kerckhoffs' Principle
Crypto-system should be secure even if everything apart from the key is public 

## Asymmetric Cipher
- one encryption and one decryption key
- keys are generated in pairs
- it should not be possible to derive one key from the knowledge of the other one
- there is a problem with this when encrypting using encryption key you must trust the origin of encryption key
- confidential, does not provide integrity (we cant tell if the message was changed)
- asymmetric ciphers are usually very slow

## Digital Signature
- uses asymmetric key-pair
- encryption key is private and decryption key is public
- people can verify that the owner of private key has signed something by decrypting the encrypted message that was 
attached
- is not confidential (anybody can read encrypted message), provides integrity - when encrypted message is modified, 
signing fails

## Cryptographic Hash function
- encrypt input (stream of bits) to fingerprint of fixed size
- hash functions should not be reversible when having fingerprint
- it should be difficult to find two input streams of bits that produce the same fingerprint
  - it is possible (encrypting infinite input into finite number of fingerprints)

## Random Generator
- function that generates infinite sequence of bits
- it should be nearly impossible to predict next bit with the knowledge of all previous bits
  - this should be true under some limited computing power

## Challenge Response Authentication protocol
- when authenticating server sends client random string (string is called challenge)
- client send back hash of password concatenated with challenge and server compares with what it has
- challenge must be different every time

## Symmetric signature
- used when two sides trust each other but not anybody else
- uses Symmetric signature
- encrypt hash of symmetric key concatenated with message

## Hybrid Cipher
- generate random symmetric key, encrypt message with this key
- encrypt symmetric key with asymmetric encryption key of the recipient
- needs strong asymmetric, symmetric ciphers and strong random number generator

## Auction Protocol
- Alice at home, watching auction broadcast
- Bob at auction bidding on Alice's behalf
- two messages
  - increase bid by certain amount of dollars
  - stop bidding

### Version 1
- symmetric cipher
- in person they generate random secret
- text messages
  - add n
  - stop

#### Problems
- the size of encrypted message can reveal the message - symmetric cipher does not change length
  - solution: add padding to the end of messages to make the messages fixed size
- if Alice sends same message twice (f.e. add 1000) attacker will be able to decipher the message
  - add a nonce to a start of the message
- attacker can send the message again
  - add a sequence number to message
    - just a counter, that is incremented before sending next message
    - Bob will set his counter to a number in a message he just received every time he receives a message with counter
    higher that current value and then compare it to all incoming messages, if counter of incoming message is lower 
    that current counter Bob discards the message
- attacker modifying the encrypted message
  - if the encrypted message is changed, the decrypted message will be probably some garbage
    - Bob can check every incoming message if it has right format if not discard it
- many real world symmetric ciphers propagate bit flips - one bit flipped in encrypted message result in that bit being
flipped in decrypted message, otherwise the message stays the same
  - attacker can change the sequence numbers to anything - even all ones, then all next messages will ignored, change
  the amount of next bid (if attacker guesses the format of message)
  - solution - add hash of original message (hash wont be encrypted)
- this protocol cant be used more that one time - attacker could just record all mesegas at one auction and replay them
at the next one
  - solutions
    - add session id to the message
      - f.e. timestamp of start of auction
    - use different key for each auction

## Cryptographic Attacks
- ciphertext only attack
  - attacker has collection of encrypted messages and he tries to decrypt the messages
- known plaintext
  - attacker has one encrypted messages together with the content of that message and tries to get the key
- chosen plaintext
  - attacker injects his plaintext into protocol and tries the defender to send the encrypted chosen plaintext

## Security level
- measured in number ($l$)
- security level $l$ means that for breaking the protocol the attacker needs $2^l$ operations