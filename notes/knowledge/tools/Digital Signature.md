# Digital Signature

## What it is
Like a wax seal on a medieval letter — it proves both *who sent it* and that *nobody tampered with it in transit* — a digital signature is a cryptographic mechanism where a sender hashes a message and encrypts that hash with their **private key**. Anyone with the sender's public key can decrypt and verify the hash, confirming authenticity and integrity simultaneously.

## Why it matters
In 2020, the SolarWinds supply chain attack succeeded partly because malicious updates were **signed with legitimate certificates**, meaning defenders saw valid signatures and trusted the software. This illustrates that signature verification only proves *who signed*, not that the signer itself wasn't compromised — a critical distinction for threat analysts evaluating code signing in software pipelines.

## Key facts
- Digital signatures provide **authentication, integrity, and non-repudiation** — but NOT confidentiality
- The process: sender hashes the message → encrypts the hash with their **private key** → receiver decrypts with sender's **public key** → compares hashes
- Non-repudiation means the sender **cannot deny** sending the message, since only their private key could have produced that signature
- Common algorithms: **RSA, DSA (Digital Signature Algorithm), and ECDSA** (Elliptic Curve variant — smaller keys, same strength)
- Digital signatures are distinct from digital certificates: a **certificate** binds a public key to an identity via a CA; a **signature** uses that key pair to sign data
- Hashing algorithms used alongside signatures include **SHA-256** — if the hash output doesn't match, the data was altered

## Related concepts
[[Public Key Infrastructure]] [[Asymmetric Encryption]] [[Hashing]] [[Certificate Authority]] [[Non-Repudiation]]