# DES

## What it is
Imagine a combination lock with only 10,000 possible combinations — technically a lock, but any determined thief can try every combination in minutes. DES (Data Encryption Standard) is a symmetric block cipher adopted by NIST in 1977 that encrypts 64-bit blocks of data using a 56-bit key. That key length, once considered sufficient, became its fatal flaw.

## Why it matters
In 1998, the Electronic Frontier Foundation built "Deep Crack" for $250,000 and broke a DES-encrypted message in 56 hours by brute-forcing all 2⁵⁶ possible keys. This demonstrated that any well-funded attacker — a government, criminal organization, or corporation — could crack DES-protected data in real time, forcing the industry to retire it and accelerate adoption of AES.

## Key facts
- Uses a **56-bit key** with a 64-bit block size; the effective security is far weaker than 56 bits due to key parity bits
- Employs a **Feistel network** with 16 rounds of substitution and permutation
- **Triple DES (3DES/TDEA)** was the stopgap: applying DES three times (EDE mode) to achieve ~112 bits of effective security, but it is now also deprecated by NIST (as of 2023)
- DES was officially withdrawn as a federal standard in **2005**, replaced by AES
- Vulnerable to **differential cryptanalysis** and **linear cryptanalysis** in addition to brute force; meet-in-the-middle attacks apply to double DES, reducing its security to barely more than single DES

## Related concepts
[[AES]] [[Triple DES]] [[Symmetric Encryption]] [[Brute Force Attack]] [[Block Cipher]]