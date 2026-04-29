# cryptanalysis

## What it is
Like a detective reconstructing a shredded document by finding patterns in the paper fragments, cryptanalysis is the science of breaking encryption without knowing the key. It involves studying ciphertext — and sometimes plaintext/ciphertext pairs — to expose weaknesses in cryptographic algorithms or their implementations.

## Why it matters
In 2008, researchers used differential cryptanalysis to demonstrate weaknesses in reduced-round versions of AES, accelerating the cryptographic community's push toward larger key sizes and stronger modes of operation. Defenders use the same techniques to validate that new ciphers are resistant to known attack classes before standardization — NIST's post-quantum algorithm competition explicitly required candidates to survive cryptanalytic scrutiny.

## Key facts
- **Brute force** is the baseline attack — trying every possible key; AES-256 makes this computationally infeasible (~2²⁵⁶ operations)
- **Frequency analysis** exploits the fact that letters in natural language appear at predictable rates; it broke substitution ciphers like Caesar and Vigenère
- **Known-plaintext attack (KPA)** — attacker has matching plaintext/ciphertext pairs and uses them to deduce the key (relevant to WEP's fatal flaw)
- **Chosen-plaintext attack (CPA)** — attacker can feed arbitrary plaintext into the cipher; public-key systems must be CPA-secure by design
- **Differential cryptanalysis** — compares how small, specific input differences affect output differences to infer key bits; birthday attacks on hash functions follow similar logic
- Weak implementations (side-channel attacks using timing or power consumption) often break cryptography faster than mathematical attacks against the algorithm itself

## Related concepts
[[symmetric encryption]] [[asymmetric encryption]] [[side-channel attack]] [[hash functions]] [[brute force attack]]