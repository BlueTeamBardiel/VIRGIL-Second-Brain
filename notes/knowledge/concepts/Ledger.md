# Ledger

## What it is
Like a notary's bound book where every transaction is witnessed, stamped, and impossible to quietly erase, a ledger in cybersecurity is an append-only, tamper-evident record of events or transactions. In distributed systems like blockchain, a ledger is replicated across many nodes so no single party can alter history without consensus detection.

## Why it matters
During a supply chain attack investigation, forensic teams rely on cryptographically signed ledger entries to prove *when* a software package was signed and by whom — if an attacker backdates a malicious binary, the ledger's hash chain exposes the inconsistency. This is precisely why tools like Certificate Transparency logs (a public ledger of issued TLS certificates) caught rogue certificates issued by compromised CAs like DigiNotar in 2011.

## Key facts
- **Append-only design**: Entries can be added but not modified or deleted, making ledgers naturally resistant to log tampering
- **Cryptographic chaining**: Each record includes a hash of the previous entry; altering any entry invalidates all subsequent hashes (the same principle used in blockchain and WORM audit logs)
- **Distributed vs. centralized**: Distributed ledgers (blockchain) remove single points of failure and trust; centralized ledgers (SIEM log databases) are faster but require strict access controls
- **Non-repudiation**: Ledger entries signed with private keys provide legal-grade proof of *who* performed an action and *when*, satisfying audit requirements (PCI-DSS, SOX)
- **Certificate Transparency (CT)**: A public ledger standard (RFC 6962) requiring all publicly trusted TLS certs to be logged, enabling detection of misissued certificates within hours

## Related concepts
[[Blockchain]] [[Non-Repudiation]] [[Certificate Transparency]] [[Audit Logging]] [[Hash Chain]]