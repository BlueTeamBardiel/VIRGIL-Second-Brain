# CBC-MAC

## What it is
Like a notary who stamps each page of a contract with a seal that incorporates every previous page's stamp — so a forged or reordered page breaks the entire chain — CBC-MAC processes each message block through a block cipher, feeding each encrypted output as the IV into the next block, producing a final authentication tag. It is a Message Authentication Code (MAC) construction built on top of block ciphers like AES in Cipher Block Chaining mode, used to verify both integrity and authenticity of a message.

## Why it matters
CBC-MAC has a critical vulnerability when used with variable-length messages: an attacker who has two valid message-tag pairs (m₁, t₁) and (m₂, t₂) can forge a valid tag for a crafted combined message without knowing the key. This length-extension attack was practically exploited in early implementations of network protocols, which is why CMAC (a fixed variant) was developed and standardized to replace naive CBC-MAC in real deployments.

## Key facts
- CBC-MAC is **only secure for fixed-length messages**; using it for variable-length inputs without length-binding opens the door to existential forgery attacks
- The final ciphertext block serves as the authentication tag — intermediate blocks are **not** output
- **CMAC** (Cipher-based MAC, NIST SP 800-38B) fixes CBC-MAC by incorporating derived subkeys into the final block, preventing length-extension attacks
- Unlike a hash function, CBC-MAC requires a **secret key** — without it, an attacker cannot produce a valid tag
- AES-CBC-MAC with a 128-bit key is widely used in **IEEE 802.11i (WPA2)** and **EMV payment card** authentication

## Related concepts
[[CMAC]] [[Message Authentication Code]] [[AES-CBC]] [[Length Extension Attack]] [[HMAC]]