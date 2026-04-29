# MDC

## What it is
Like a one-way meat grinder that accepts any size of beef but always outputs the same size patty, an MDC (Manipulation Detection Code) takes variable-length data and produces a fixed-length fingerprint that reveals any tampering. Precisely, an MDC is a hash-based construct designed purely to detect unauthorized modifications to data — providing integrity assurance without any secret key involved. Unlike a MAC (Message Authentication Code), an MDC requires no shared secret and therefore provides no authentication of the sender.

## Why it matters
During a software supply chain attack, an adversary replaces a legitimate installer with a malicious one on a vendor's download server. If the vendor publishes an MDC (such as a SHA-256 hash) on a separate, trusted channel, users can independently compute the hash of their downloaded file and compare it — catching the substitution before execution. This is exactly how Linux distribution repositories verify package integrity before installation.

## Key facts
- MDCs provide **integrity only** — not confidentiality, not authentication; if the hash is stored alongside the data it protects, an attacker can replace both
- Common MDC constructions include **SHA-256, SHA-3, and BLAKE2** — MD5 and SHA-1 are considered broken for this purpose due to collision vulnerabilities
- MDCs are a subset of cryptographic hash functions; they must satisfy **preimage resistance, second preimage resistance, and collision resistance**
- Unlike HMACs, MDCs require **no key management**, making them simpler to deploy but weaker against active attackers who control the transmission channel
- MDCs are used in **file integrity monitoring (FIM) tools** like Tripwire to baseline system files and detect unauthorized changes

## Related concepts
[[Cryptographic Hash Functions]] [[HMAC]] [[Message Authentication Code]] [[File Integrity Monitoring]] [[Digital Signatures]]