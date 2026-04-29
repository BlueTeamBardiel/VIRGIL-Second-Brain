# non-repudiation

## What it is
Like a notarized contract where the notary's seal proves *you* signed it and you can't later claim you didn't — non-repudiation is the cryptographic guarantee that a sender cannot deny having sent a message or performed an action. It binds identity to an action in a way that is verifiable by a third party.

## Why it matters
In a financial wire transfer dispute, an employee claims they never authorized a $500,000 transfer. If the system uses digital signatures tied to the employee's private key, the signed transaction log proves irrefutably that their key — and only their key — authorized it. Without non-repudiation, organizations are vulnerable to insider fraud where actors perform malicious actions and deny involvement.

## Key facts
- **Digital signatures** are the primary technical mechanism for non-repudiation: the sender signs with their private key, and anyone with the public key can verify authenticity and origin.
- Non-repudiation is one of the five pillars of security alongside confidentiality, integrity, availability, and authentication (sometimes framed as part of the CIA+ model).
- **Symmetric encryption alone cannot provide non-repudiation** — if two parties share the same secret key, either party could have created the message, so neither can be proven as the sole author.
- Certificate Authorities (CAs) and Public Key Infrastructure (PKI) underpin non-repudiation by binding public keys to verified identities through digital certificates.
- Audit logs achieve *behavioral* non-repudiation (who did what and when) but require tamper-evident storage (e.g., write-once media, cryptographic log chaining) to be trustworthy.

## Related concepts
[[digital signatures]] [[public key infrastructure]] [[authentication]] [[integrity]] [[audit logging]]