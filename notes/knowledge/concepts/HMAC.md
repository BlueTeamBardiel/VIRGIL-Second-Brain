# HMAC

## What it is
Think of HMAC like a wax seal on a medieval letter — but the wax is mixed with a secret ingredient only the sender and recipient know, so anyone can verify the seal wasn't forged or tampered with. Technically, HMAC (Hash-based Message Authentication Code) combines a cryptographic hash function (like SHA-256) with a secret key to produce a fixed-length tag that verifies both the **integrity** and **authenticity** of a message. Unlike a plain hash, an attacker who doesn't know the secret key cannot forge a valid HMAC even if they can see the message.

## Why it matters
In 2011, researchers demonstrated a **length extension attack** against APIs using raw SHA-1 or MD5 hashes for authentication — attackers could append data to a signed message without knowing the secret. HMAC's double-hashing construction (key is mixed at both the inner and outer hash stages) defeats this attack entirely, which is why modern APIs like AWS Signature Version 4 use HMAC-SHA256 to authenticate every request.

## Key facts
- HMAC formula: **HMAC(K, m) = H((K ⊕ opad) || H((K ⊕ ipad) || m))** — the key is XORed with inner and outer padding constants
- Provides **authentication + integrity**, but NOT confidentiality — the message is not encrypted
- Security depends entirely on the secrecy of the key; the hash algorithm can be swapped (HMAC-MD5, HMAC-SHA1, HMAC-SHA256)
- HMAC-SHA256 is the current recommended choice; HMAC-MD5 is considered weak but still used in legacy protocols (e.g., RADIUS)
- Used in **TLS, IPsec, JWT token signing, and API authentication schemes** — appears frequently on Security+ as the answer for "verifying message integrity with a shared secret"

## Related concepts
[[Hash Functions]] [[Digital Signatures]] [[Message Authentication Code]] [[TLS Handshake]] [[Length Extension Attack]]