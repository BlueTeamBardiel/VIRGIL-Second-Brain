# DKIM

## What it is
Like a wax seal on a medieval letter — anyone can verify the seal is genuine without needing the king's private signet ring — DKIM lets receiving mail servers verify that an email genuinely came from the claimed domain and wasn't altered in transit. DomainKeys Identified Mail (DKIM) is an email authentication protocol that uses asymmetric cryptography: the sending server signs outgoing messages with a private key, and the public key is published in DNS for anyone to verify.

## Why it matters
In a Business Email Compromise (BEC) attack, an attacker spoofs the CFO's email domain to trick an employee into wiring funds. A properly configured DKIM signature would cause the receiving server to flag or reject that spoofed message, because the attacker cannot produce a valid signature without the private key. DKIM is one layer in a defense-in-depth email security stack alongside SPF and DMARC.

## Key facts
- DKIM adds a **DKIM-Signature** header containing a cryptographic hash of specific email headers and body, signed with the domain's RSA or Ed25519 private key
- The public key is stored as a **TXT record** in DNS at a selector-based subdomain (e.g., `selector._domainkey.example.com`)
- DKIM verifies **integrity and authenticity** — it confirms the message wasn't modified and originated from an authorized server, but it does NOT encrypt the message
- DKIM alone does **not prevent spoofing of the From: header** visible to users; DMARC is required to enforce alignment and policy
- A minimum recommended key length is **2048-bit RSA**; 1024-bit keys are considered deprecated and weak

## Related concepts
[[SPF]] [[DMARC]] [[Email Spoofing]] [[Public Key Infrastructure]] [[DNS Security]]