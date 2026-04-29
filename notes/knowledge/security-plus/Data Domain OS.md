# Data Domain OS

## What it is
Think of it like a specialized chef who only knows one cuisine — but knows it perfectly: Data Domain OS (DDOS) is a purpose-built operating system developed by Dell EMC that runs exclusively on Data Domain deduplication storage appliances. It is hardened and optimized specifically for backup, archival, and data protection workloads rather than general-purpose computing.

## Why it matters
In ransomware recovery scenarios, Data Domain appliances running DDOS serve as immutable backup targets — attackers who compromise a primary network often attempt to destroy backup repositories to prevent recovery. DDOS supports features like DD Retention Lock (WORM compliance), which prevents even privileged users from deleting or modifying backup data within a defined retention period, making it a critical last line of defense.

## Key facts
- **DD Retention Lock** enforces Write Once, Read Many (WORM) protection at the filesystem level, directly countering ransomware attempts to corrupt or delete backups
- DDOS uses **inline deduplication** — data is deduplicated before being written to disk, achieving typical ratios of 10:1 to 55:1 for backup workloads
- The OS exposes storage via multiple protocols: **NFS, CIFS/SMB, DD Boost, NDMP, and VTL (virtual tape library)**, making it relevant in mixed-environment audits
- **Role-based access control (RBAC)** in DDOS separates administrative duties — security administrators, storage administrators, and users have distinct privilege boundaries
- DD Boost protocol allows backup software (like NetWorker or Veeam) to perform **client-side deduplication**, reducing network traffic and a potential data exfiltration surface

## Related concepts
[[Immutable Backups]] [[WORM Storage]] [[Ransomware Recovery]] [[Role-Based Access Control]] [[Data Loss Prevention]]