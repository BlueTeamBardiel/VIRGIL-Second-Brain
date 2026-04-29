# write-once storage

## What it is
Like carving words into stone — you can read them forever, but you can't erase or overwrite them. Write-once storage (also called WORM: Write Once, Read Many) is a data storage mechanism that allows data to be written a single time and then becomes permanently immutable, preventing any modification or deletion by any user, including administrators.

## Why it matters
Ransomware operators increasingly target backup systems first, knowing that destroying backups forces victims to pay. Organizations that store backups on WORM-compliant storage (such as AWS S3 Object Lock or NetApp SnapLock) render ransomware's deletion and encryption attacks useless against those copies — the malware literally cannot overwrite the data, preserving a clean recovery point regardless of how deeply the attacker has compromised the environment.

## Key facts
- WORM storage satisfies regulatory compliance requirements under SEC Rule 17a-4, HIPAA, and FINRA, which mandate tamper-proof record retention for financial and medical data.
- Two WORM modes exist: **Compliance mode** (not even the storage admin can delete data before retention expiry) and **Governance mode** (privileged users can override retention with special permissions).
- Hardware WORM uses optical media (CD-R, DVD-R) or specialized drives; software/cloud WORM enforces immutability through policy at the platform level.
- Retention lock policies specify a minimum retention period — data cannot be deleted until that period expires, even by root or cloud account owners in compliance mode.
- Write-once storage supports **non-repudiation** by ensuring logs and audit trails cannot be altered after the fact, preserving forensic integrity.

## Related concepts
[[immutable backups]] [[data retention policy]] [[ransomware resilience]] [[object storage]] [[non-repudiation]]