# Smart Card

## What it is
Think of a smart card like a tiny bank vault you carry in your wallet — it doesn't just store your credentials, it actively performs cryptographic operations internally so your secrets never leave the card. Precisely, a smart card is a tamper-resistant physical token containing an embedded microprocessor and memory that can store certificates, keys, and authentication data while executing cryptographic functions on-chip.

## Why it matters
In a 2011 breach of RSA SecurID, attackers stole seed values for hardware tokens — but smart card-based systems would have been resilient because the private key literally cannot be extracted from a properly implemented smart card. This "key never leaves the card" property makes smart cards one of the strongest defenses against credential theft in enterprise environments, which is why DoD Common Access Cards (CACs) and PIV cards rely on this architecture.

## Key facts
- Smart cards implement **two-factor authentication**: something you have (the card) + something you know (PIN), never transmitting the PIN to the reader
- The embedded chip performs **RSA/ECC cryptographic operations internally** — the private key is generated on-card and is mathematically unextractable
- **Contact vs. Contactless**: Contact cards (ISO 7816) require physical insertion; contactless (ISO 14443) use RFID — both carry the same security model
- Smart cards are vulnerable to **side-channel attacks** (power analysis, timing attacks) — a fact tested on Security+ and relevant to hardware security modules
- CAC and PIV cards are federally mandated under **HSPD-12** for U.S. government employee authentication

## Related concepts
[[Multi-Factor Authentication]] [[Public Key Infrastructure]] [[Hardware Security Module]] [[Side-Channel Attack]] [[Certificate-Based Authentication]]