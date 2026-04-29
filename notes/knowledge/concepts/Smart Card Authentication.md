# Smart Card Authentication

## What it is
Think of a smart card like a tiny bank vault you carry in your wallet — it doesn't just hold your identity, it actively *proves* it using a private key that never leaves the card. Technically, a smart card is a physical token containing an embedded microprocessor and cryptographic keys, used to authenticate users through a challenge-response mechanism rather than transmitting static credentials.

## Why it matters
In 2011, RSA SecurID tokens were compromised when attackers stole seed records from RSA's servers — but smart cards resist this class of attack because the private key is generated and stored *on the card itself*, never exported. Even if an attacker intercepts every packet during authentication, they capture only the signed challenge response, which is cryptographically useless without the card physically present.

## Key facts
- Smart cards implement **two-factor authentication** by combining something you have (the card) with something you know (a PIN) — losing either factor alone is insufficient for compromise
- The **private key never leaves the card**; all cryptographic operations happen on the embedded chip, making key extraction require physical tampering
- Uses the **PIV (Personal Identity Verification)** standard (FIPS 201) — mandatory for U.S. federal employee access
- Authentication follows **asymmetric cryptography**: the card signs a server-issued challenge with its private key; the server verifies with the stored public key
- Smart cards are vulnerable to **relay attacks** and **shoulder surfing for PINs**, but resist replay attacks since each challenge is unique

## Related concepts
[[Multi-Factor Authentication]] [[Public Key Infrastructure]] [[Certificate-Based Authentication]] [[PIV/CAC Cards]] [[Challenge-Response Authentication]]