# DFA

## What it is
Like a lockpicker who shines a heat lamp on a safe's keypad to see which buttons are warm from frequent use, Differential Fault Analysis attacks a cryptographic device by intentionally injecting physical faults and observing how the outputs differ from correct ones. DFA is a side-channel attack technique that introduces errors into a cryptographic computation mid-operation — through voltage glitches, laser pulses, or electromagnetic interference — then mathematically compares faulty outputs against correct outputs to reverse-engineer secret key material. It exploits the fact that partial, corrupted computations leak structural information about internal cryptographic state.

## Why it matters
In 2011, researchers demonstrated DFA against AES implementations on smart cards used in banking and access control systems, recovering full 128-bit keys with as few as two faulty ciphertext pairs. This showed that even mathematically unbreakable algorithms become physically vulnerable when deployed in hardware without fault-injection countermeasures — a critical gap between theoretical security and real-world implementation.

## Key facts
- DFA targets **implementations**, not the algorithm itself — AES, RSA, and ECC are all theoretically sound but vulnerable if hardware lacks protections
- Requires **physical access** (or very close proximity) to the target device — not a remote attack vector
- Works by comparing **correct vs. faulty ciphertext pairs** to deduce key bits through differential analysis
- Common fault injection methods: **voltage glitching, clock glitching, laser fault injection, electromagnetic pulses**
- Countermeasures include **redundant computation checks, error-detection codes, randomized execution order**, and sensors that detect abnormal operating conditions
- Relevant to **FIPS 140-2/140-3** certification, which requires physical security mechanisms against fault attacks for higher assurance levels

## Related concepts
[[Side-Channel Attack]] [[Power Analysis]] [[Differential Cryptanalysis]] [[Hardware Security Module]] [[Fault Injection]]