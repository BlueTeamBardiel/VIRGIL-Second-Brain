# DomainKeys Identified Mail

## What it is
Like a wax seal on a medieval letter that only the sender's signet ring could produce, DKIM lets a mail server cryptographically sign outgoing emails so recipients can verify the message genuinely came from the claimed domain and wasn't altered in transit. It works by attaching a digital signature in the email header, derived from a private key held by the sending server, while the corresponding public key is published in the domain's DNS TXT record.

## Why it matters
In a business email compromise (BEC) attack, an adversary spoofs a CFO's email address to trick accounting into wiring funds. DKIM defeats simple spoofing because a forged email from a domain with DKIM enforcement will fail signature verification at the recipient's mail server — the attacker doesn't possess the private key to produce a valid signature, exposing the fraud before the wire transfer happens.

## Key facts
- DKIM signatures are stored in the **`DKIM-Signature`** email header and reference a **selector** that tells the recipient which DNS TXT record to fetch for the public key (e.g., `selector._domainkey.example.com`)
- DKIM validates **message integrity and sender domain authenticity** but does NOT encrypt message content
- A DKIM pass alone doesn't prevent phishing — attackers can legitimately sign email from their own lookalike domain (e.g., `paypa1.com`)
- Works alongside **SPF** (which validates the sending IP) and **DMARC** (which enforces policy when SPF/DKIM fail) to form a complete email authentication stack
- DKIM uses **RSA or Ed25519** asymmetric cryptography; key lengths below 1024-bit RSA are considered weak and rejectable by modern mail servers

## Related concepts
[[Sender Policy Framework]] [[DMARC]] [[Email Spoofing]] [[DNS TXT Records]] [[Business Email Compromise]]