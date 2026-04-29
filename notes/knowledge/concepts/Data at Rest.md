# Data at rest

## What it is
Like a letter locked inside a safe deposit box — it's not going anywhere, but that doesn't mean it's automatically safe from someone with bolt cutters. Data at rest refers to any data stored persistently on a medium (hard drives, SSDs, USB drives, databases, tape backups) rather than actively moving across a network or being processed in memory. It is the stationary target in the CIA triad's confidentiality equation.

## Why it matters
In 2017, an NSA contractor left classified data on an unencrypted personal laptop that was then seized by Kaspersky antivirus software — the data was at rest, unprotected, and accessible. Had full-disk encryption been enforced, the physical access would have meant nothing. This is the core defense argument: encryption transforms stolen hardware into useless metal.

## Key facts
- **Full Disk Encryption (FDE)** tools like BitLocker (Windows) or FileVault (macOS) protect data at rest by encrypting entire volumes; keys are often tied to a TPM chip
- **AES-256** is the current NIST-recommended symmetric algorithm for encrypting data at rest in government and enterprise environments
- Data at rest is distinct from **data in transit** (moving over a network) and **data in use** (actively in RAM/CPU)
- **Database Transparent Data Encryption (TDE)** protects data at rest at the database layer without requiring application changes — used in SQL Server and Oracle
- Compliance frameworks including **HIPAA, PCI-DSS, and GDPR** explicitly require encryption of sensitive data at rest; failure is a direct audit finding

## Related concepts
[[Full Disk Encryption]] [[Data in Transit]] [[Transparent Data Encryption]] [[AES]] [[TPM]]