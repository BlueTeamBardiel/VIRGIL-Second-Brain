# Public Key Cryptography

## What it is
Imagine a mailbox on a street corner: anyone can drop a letter through the slot (public key), but only you have the key to open the box and retrieve it (private key). Public key cryptography is an asymmetric encryption system where two mathematically linked keys are generated in a pair — anything encrypted with one key can only be decrypted by the other, making secure communication possible without ever sharing a secret in advance.

## Why it matters
In 2011, attackers compromised RSA's SecurID tokens partly by exploiting weaknesses in how seed values were protected — a reminder that the *implementation* of public key infrastructure is as critical as the math itself. More broadly, every TLS handshake you initiate with a website uses public key cryptography to negotiate a session key, meaning a misconfigured certificate or weak key length exposes millions of connections to interception or impersonation attacks.

## Key facts
- Uses two keys: a **public key** (shared openly) and a **private key** (never transmitted); what one encrypts, only the other decrypts
- RSA security relies on the computational difficulty of **factoring large prime numbers**; minimum recommended key length is **2048 bits** (3072+ for long-term security)
- **Digital signatures** reverse the process: sender encrypts a hash with their *private* key; anyone with the public key can verify authenticity and integrity
- Elliptic Curve Cryptography (ECC) achieves equivalent security to RSA with **much shorter key lengths** (256-bit ECC ≈ 3072-bit RSA), reducing computational overhead
- Public key cryptography is used for **key exchange**, not bulk encryption — symmetric keys (e.g., AES) handle the actual data once a secure channel is established

## Related concepts
[[Asymmetric Encryption]] [[Digital Signatures]] [[PKI (Public Key Infrastructure)]] [[TLS Handshake]] [[RSA Algorithm]]