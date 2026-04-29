# digital signatures

## What it is
Like a wax seal on a medieval letter — anyone can verify it's authentic, but only the king's signet ring could have made it. A digital signature is a cryptographic mechanism where a sender hashes a message and encrypts that hash with their **private key**; recipients decrypt it with the sender's **public key** to verify both integrity and authenticity.

## Why it matters
In 2020, the SolarWinds supply chain attack succeeded partly because attackers compromised the build system and signed malicious updates with a legitimate certificate — victims' systems trusted the signature and installed malware without question. This illustrates that digital signatures guarantee *who signed*, not that the signer is trustworthy; certificate chain validation and code-signing policy enforcement are equally critical defensive layers.

## Key facts
- Digital signatures provide **authentication**, **integrity**, and **non-repudiation** — but NOT confidentiality
- The sender signs with their **private key**; verification uses their **public key** (opposite of encryption flow)
- Common algorithms: **RSA**, **DSA** (Digital Signature Algorithm), and **ECDSA** (Elliptic Curve DSA)
- Non-repudiation means the signer **cannot later deny** signing — legally significant in contracts and audit logs
- Hash algorithms used in signing (e.g., SHA-256) ensure even a 1-bit change in the message produces a completely different hash, defeating tampering

## Related concepts
[[public key infrastructure]] [[hashing]] [[certificates]] [[asymmetric encryption]] [[non-repudiation]]