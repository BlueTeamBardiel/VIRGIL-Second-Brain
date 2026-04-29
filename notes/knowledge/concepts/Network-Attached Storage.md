# Network-Attached Storage

## What it is
Think of NAS like a communal refrigerator in an office break room — it's a dedicated storage appliance plugged directly into the network so everyone on the floor can grab what they need without going through a central server. Precisely, NAS is a file-level storage device connected to a network that provides shared storage access to multiple clients using protocols like SMB, NFS, or AFP. Unlike SAN (block-level storage), NAS operates at the file system layer and handles its own authentication and permissions.

## Why it matters
In 2021, attackers exploiting QNAP NAS devices running vulnerable firmware used the QLocker ransomware to encrypt files on thousands of internet-exposed units, demanding Bitcoin ransoms. NAS devices frequently hold backup data and sensitive files, making them high-value targets — especially when administrators expose management interfaces directly to the internet or leave default credentials unchanged.

## Key facts
- NAS devices commonly use **SMB (port 445)** and **NFS (port 2049)** — both historically riddled with vulnerabilities (e.g., EternalBlue targets SMB)
- Default credentials on NAS appliances (e.g., admin/admin on many QNAP and Synology units) are a leading cause of compromise
- NAS is a critical component in the **3-2-1 backup rule**: 3 copies, 2 media types, 1 offsite — but ransomware can encrypt network-accessible backups if shares are mounted
- **Ransomware defense**: NAS backups should use immutable snapshots or air-gapped replication to survive ransomware attacks
- Misconfigured NFS exports with `no_root_squash` allow a remote root user to access files as root on the NAS — a critical privilege escalation risk

## Related concepts
[[SMB Protocol]] [[Ransomware]] [[Backup and Recovery]] [[Least Privilege]] [[Network File System]]