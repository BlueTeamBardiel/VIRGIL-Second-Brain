# SHA-1

## What it is
Imagine a meat grinder that takes any document — one page or one thousand — and always produces exactly the same size sausage. SHA-1 (Secure Hash Algorithm 1) is a cryptographic hash function developed by the NSA and published by NIST in 1995 that takes arbitrary input and produces a fixed 160-bit (40 hex character) digest. Like the meat grinder, the process is one-way — you cannot reconstruct the original document from the sausage.

## Why it matters
In 2017, Google's Project Zero team executed **SHAttered** — the first practical SHA-1 collision attack — producing two different PDF files with identical SHA-1 hashes for roughly $110,000 in cloud computing costs. This meant a malicious actor could forge digital certificates or code signatures, making tampered files appear legitimate. Certificate Authorities had already been deprecating SHA-1 in TLS certificates since 2015, but SHAttered proved the threat was no longer theoretical.

## Key facts
- Produces a **160-bit hash** (40 hexadecimal characters); longer than MD5's 128-bit output but shorter than SHA-256's 256-bit
- Officially **deprecated by NIST in 2011**; browsers stopped accepting SHA-1 TLS certificates by 2017
- Vulnerable to **collision attacks** (two inputs producing the same hash) — NOT preimage attacks in practice
- Still found in **legacy systems**, Git (transitioning away), and older HMAC implementations — a common audit finding
- SHA-1 is part of the **SHA-1 family**; replaced by SHA-2 (SHA-256, SHA-384, SHA-512) and eventually SHA-3 for modern use

## Related concepts
[[SHA-256]] [[MD5]] [[Digital Certificates]] [[Hash Collision]] [[PKI]]