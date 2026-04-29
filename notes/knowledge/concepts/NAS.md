# NAS

## What it is
Think of a NAS like a shared refrigerator in an office break room — everyone on the network can grab what they need without going through a central chef. A Network-Attached Storage device is a dedicated file server connected directly to a network, providing shared storage to multiple clients using file-level protocols like SMB, NFS, or AFP. Unlike a SAN, which speaks block-level storage language, a NAS is plug-and-play file sharing at the network layer.

## Why it matters
In 2021, attackers exploited vulnerabilities in QNAP NAS devices running outdated firmware to deploy the Qlocker ransomware, encrypting thousands of home and small business units using 7-Zip to lock files behind attacker-controlled passwords. This attack succeeded because NAS devices are frequently internet-exposed with default credentials and delayed patching cycles — a perfect storm of misconfiguration and neglect. Properly segmenting NAS devices behind a firewall and disabling remote access when unnecessary would have neutralized most of these compromises.

## Key facts
- NAS devices commonly use **SMB (port 445)** and **NFS (port 2049)** — both historically rich attack surfaces for credential theft and lateral movement
- Default credentials on NAS firmware are a top exploitation vector; always change them immediately upon deployment
- NAS devices should be treated as **data repositories requiring the same hardening** as servers: patching, encryption-at-rest, and access controls
- Ransomware frequently targets NAS shares because they often contain unversioned backups — making the **3-2-1 backup rule** critical (3 copies, 2 media types, 1 offsite)
- **Misconfigured SMB shares** on NAS can enable unauthenticated access, a common finding in penetration tests and a CySA+ exam favorite

## Related concepts
[[SMB Protocol]] [[Ransomware]] [[Data-at-Rest Encryption]] [[Network Segmentation]] [[Backup Strategies]]