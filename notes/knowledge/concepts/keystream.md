# keystream

## What it is
Like a one-time pad of random digits you XOR against your message — except generated algorithmically from a key rather than written on a paper pad. A keystream is a sequence of pseudorandom bits produced by a stream cipher (or a block cipher in stream mode) that is combined, typically via XOR, with plaintext to produce ciphertext. The security of the entire scheme hinges on that keystream never being reused with the same key.

## Why it matters
The WEP Wi-Fi protocol catastrophically reused keystreams because its 24-bit IV space was too small — after ~5,000 packets, IVs began repeating, allowing attackers to XOR two ciphertexts encrypted with the same keystream and cancel it out, exposing plaintext relationships. This "keystream reuse" attack (also called a two-time pad attack) broke WEP in minutes and is the foundational reason WPA2 replaced it entirely.

## Key facts
- **XOR is the core operation**: `plaintext XOR keystream = ciphertext`; `ciphertext XOR keystream = plaintext` — symmetry means the same operation encrypts and decrypts.
- **Reuse is catastrophic**: If the same keystream encrypts two plaintexts, `C1 XOR C2 = P1 XOR P2`, completely eliminating the key from the equation.
- **RC4 produces a keystream** and was used in WEP, TLS 1.0, and WPA-TKIP — all now deprecated due to keystream biases and reuse vulnerabilities.
- **CTR mode converts block ciphers** (like AES) into keystream generators by encrypting sequential counter values, making AES-CTR functionally a stream cipher.
- **Nonces prevent reuse**: Modern stream ciphers like ChaCha20 require a unique nonce per key per message specifically to guarantee a fresh keystream every time.

## Related concepts
[[stream cipher]] [[RC4]] [[initialization vector (IV)]] [[XOR encryption]] [[AES-CTR mode]]