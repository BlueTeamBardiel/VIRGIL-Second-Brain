# Database Encryption

## What it is
Like a bank vault where every individual safety deposit box has its own lock — even if a thief gets inside the vault, they can't read the contents without each box's key. Database encryption is the process of transforming stored data into ciphertext at rest, ensuring that raw database files or backups are unreadable without the appropriate decryption keys.

## Why it matters
In the 2017 Equifax breach, attackers exfiltrated unencrypted personal records for 147 million people directly from database tables. Had column-level encryption been applied to fields like SSNs and credit card numbers, the stolen data would have been cryptographic garbage without the keys — dramatically reducing the breach's real-world impact.

## Key facts
- **Transparent Data Encryption (TDE)** encrypts the entire database at the file/page level automatically; SQL Server, Oracle, and MySQL all support it natively — but it doesn't protect against a privileged insider who queries the database normally
- **Column-level encryption** targets specific high-sensitivity fields (SSNs, passwords, PII), offering finer control but with higher performance overhead and complexity
- **Encryption at rest** protects data stored on disk; it does NOT protect data **in transit** (that's TLS) or **in use** (that's a separate concern requiring technologies like homomorphic encryption)
- **Key management is the critical attack surface** — storing encryption keys in the same database they protect is equivalent to locking a house and hiding the key under the same doormat
- For Security+/CySA+: TDE satisfies many compliance requirements (PCI-DSS, HIPAA) for protecting data at rest, but auditors will also check key management practices (HSM usage, key rotation policies)

## Related concepts
[[Encryption at Rest]] [[Key Management]] [[Transparent Data Encryption]] [[Data Loss Prevention]] [[SQL Injection]]