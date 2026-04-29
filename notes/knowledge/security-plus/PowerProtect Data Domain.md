# PowerProtect Data Domain

## What it is
Think of it like a bank vault with a built-in counterfeit detector — it stores your backups while continuously verifying every byte is exactly what it should be. PowerProtect Data Domain is Dell's purpose-built backup and deduplication appliance that provides immutable, air-gapped storage for enterprise data recovery, featuring inline deduplication ratios up to 65:1 and cryptographic verification of stored data integrity.

## Why it matters
Ransomware operators increasingly target backup infrastructure first — destroy the backups, then encrypt production data, leaving victims with no recovery path. Data Domain's **Retention Lock** feature (WORM — Write Once, Read Many) prevents even administrators with privileged credentials from deleting or modifying backup copies within a defined retention window, directly defeating ransomware attempts to corrupt recovery points. This makes it a critical last line of defense in a defense-in-depth backup strategy.

## Key facts
- **Retention Lock** operates in two modes: *Governance* (privileged users can override) and *Compliance* (no one can delete — mirrors SEC/FINRA regulatory requirements)
- Supports **Virtual Air Gap** via Dell's CyberSense integration, which performs 99%+ content inspection to detect corruption from ransomware inside backup data
- Deduplication occurs **inline** (before writing to disk), reducing storage footprint and attack surface simultaneously
- Integrates with **Zero Trust** architectures by supporting MFA and role-based access control (RBAC) for backup administrator accounts
- Data Domain uses **end-to-end encryption** (AES-256) both in-flight and at-rest, satisfying NIST SP 800-111 storage encryption guidance

## Related concepts
[[Immutable Backups]] [[Air Gap Strategy]] [[Ransomware Recovery]] [[WORM Storage]] [[Data Integrity Verification]]