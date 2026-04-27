---
domain: "Security Operations"
tags: [backup, recovery, data-protection, business-continuity, resilience, disaster-recovery]
---
# Backup and Recovery

**Backup and recovery** is the practice of creating redundant copies of data and systems so that they can be restored following data loss, corruption, ransomware attack, hardware failure, or disaster. **Recovery objectives** define acceptable data loss ([[Recovery Point Objective]]) and acceptable downtime ([[Recovery Time Objective]]), forming the contractual backbone of any [[Business Continuity Plan]]. Together, backup and recovery are foundational controls in both [[Disaster Recovery]] planning and everyday [[Data Protection]] strategy.

---

## Overview

Backup and recovery exists because data is volatile. Hard drives fail, humans delete things accidentally, ransomware encrypts file systems, and datacenters flood. Before any data exists in a usable state after an incident, there must have been a deliberate act of copying that data somewhere safe — a backup. Without it, recovery is impossible. Organizations that lack tested backup strategies face either catastrophic data loss or enormous ransom payments with no guarantee of functional data return.

The practice evolved significantly from early magnetic tape rotation schemes in the 1970s and 1980s, when operators physically managed tape libraries using strategies like the **Grandfather-Father-Son (GFS)** rotation. Modern backup infrastructure spans on-premises disk targets, cloud object storage, and hybrid architectures. Enterprise solutions like Veeam, Commvault, and Cohesity automate the entire lifecycle from snapshot scheduling to offsite replication, while cloud-native tools like AWS Backup and Azure Backup integrate directly with platform services.

A **backup strategy** is not merely a technical artifact; it is a policy decision with legal, financial, and operational dimensions. Regulatory frameworks such as HIPAA, PCI-DSS, and GDPR impose retention requirements on specific categories of data. HIPAA requires covered entities to maintain retrievable exact copies of electronic protected health information. PCI-DSS Requirement 12.10 mandates documented incident response procedures that include data restoration capabilities. Failure to recover data within regulatory timelines can result in fines, breach notifications, and liability.

The critical failure mode of most backup programs is **untested recovery**. Organizations that back up diligently but never attempt restoration frequently discover that backups are corrupted, incomplete, or rely on software versions that no longer exist. Industry guidance — including NIST SP 800-34 and ISO 22301 — consistently emphasizes scheduled, realistic recovery drills as a non-negotiable component of any backup program. A backup that has never been restored is not a backup; it is an assumption.

---

## How It Works

### Backup Types

Backup operations differ in what data they capture relative to a previous state:

| Type | Description | Speed | Storage |
|---|---|---|---|
| **Full** | Complete copy of all selected data | Slowest write | Largest |
| **Incremental** | Only data changed since last backup (any type) | Fastest write | Smallest |
| **Differential** | All data changed since last *full* backup | Medium write | Medium |
| **Synthetic Full** | Full backup assembled from prior full + incrementals without re-reading source | Medium | Medium-large |
| **Mirror** | Exact real-time replica; deletions replicated immediately | Continuous | Exact copy |

**Restore speed trade-off:** A full restore from a full backup is fastest (one tape/set). An incremental restore requires the last full backup plus every incremental since — slower but storage-efficient. A differential restore requires only the last full plus the most recent differential.

### The 3-2-1 Rule

The most widely cited backup architecture principle:

- **3** copies of data (1 primary + 2 backups)
- **2** different storage media types (e.g., disk + tape, or disk + cloud)
- **1** copy offsite (geographically separated from primary)

An extended variant, **3-2-1-1-0**, adds:
- **1** copy air-gapped or immutable
- **0** errors verified on restore testing

### Backup Protocols and Technologies

**Agent-based backup:** Software installed on the target system intercepts I/O or reads file systems directly. Common agents communicate over TCP to a backup server:
- Veeam uses its own proprietary protocol over TCP/443 (HTTPS) or TCP/9392–9401
- Bacula uses TCP/9101–9103
- Amanda uses TCP/10080

**Agentless backup:** Hypervisor-level snapshots (VMware vSphere APIs for Data Protection — VADP) capture VM disk state without in-guest agents. Uses VMware's VDDK (Virtual Disk Development Kit) over TCP/902 (vSphere management).

**Snapshot-based backup:** Storage-level (SAN/NAS) or OS-level (LVM, ZFS, VSS) point-in-time snapshots. On Linux with LVM:

```bash
# Create a snapshot of the logical volume
lvcreate -L10G -s -n data_backup /dev/vg0/data

# Mount the snapshot read-only
mount -o ro /dev/vg0/data_backup /mnt/snapshot

# Tar the snapshot to a backup destination
tar czf /backup/data_$(date +%Y%m%d).tar.gz /mnt/snapshot

# Remove snapshot when done
umount /mnt/snapshot
lvremove /dev/vg0/data_backup
```

**VSS (Volume Shadow Copy Service) on Windows:**
```powershell
# List existing shadow copies
vssadmin list shadows

# Create a shadow copy of C:
wmic shadowcopy call create Volume='C:\'

# Restore previous version of a file via robocopy from shadow copy
$shadow = (Get-WmiObject Win32_ShadowCopy | Sort-Object InstallDate -Descending | Select-Object -First 1).DeviceObject
cmd /c mklink /d C:\ShadowMount "$shadow\"
robocopy C:\ShadowMount\Users\admin\Documents C:\Users\admin\Documents_restored
```

**Rsync-based backup (Linux/Unix):**
```bash
# Full sync of /data to remote backup server over SSH
rsync -avz --delete /data/ backup@192.168.10.50:/backups/server01/full/

# Incremental with hard links (mimics incremental behavior with full file access)
rsync -avz --link-dest=/backups/server01/latest /data/ \
  backup@192.168.10.50:/backups/server01/$(date +%Y%m%d_%H%M)/

# Update symlink to latest
ssh backup@192.168.10.50 \
  "ln -sfn /backups/server01/$(date +%Y%m%d_%H%M) /backups/server01/latest"
```

**Cloud backup (AWS CLI to S3 with versioning):**
```bash
# Enable versioning on S3 bucket
aws s3api put-bucket-versioning \
  --bucket my-backups \
  --versioning-configuration Status=Enabled

# Sync local backup directory to S3
aws s3 sync /backups/server01 s3://my-backups/server01/ \
  --storage-class STANDARD_IA \
  --sse AES256

# List versions of a specific file
aws s3api list-object-versions \
  --bucket my-backups \
  --prefix server01/data.tar.gz
```

**Backup verification:**
```bash
# Verify tar archive integrity
tar -tzf /backup/data_20241201.tar.gz > /dev/null && echo "Archive OK" || echo "CORRUPT"

# SHA256 checksum on backup creation
sha256sum /backup/data_20241201.tar.gz > /backup/data_20241201.tar.gz.sha256

# Verify on restore
sha256sum -c /backup/data_20241201.tar.gz.sha256
```

### Recovery Process

Recovery follows a defined sequence:
1. **Declare** the recovery event (incident ticket, stakeholder notification)
2. **Identify** target recovery point (which backup version satisfies the RPO)
3. **Provision** restore environment (clean system, isolated network if ransomware)
4. **Restore** data from backup media in correct sequence (full first, then incrementals in order)
5. **Verify** integrity of restored data against checksums and application functionality
6. **Reconnect** to production network only after malware scanning and validation
7. **Document** actual RTO vs. objective; update procedures

---

## Key Concepts

- **Recovery Point Objective (RPO):** The maximum tolerable amount of data loss measured in time. An RPO of 4 hours means the organization accepts losing up to 4 hours of data. RPO drives backup *frequency* — a 4-hour RPO requires backups at least every 4 hours.

- **Recovery Time Objective (RTO):** The maximum acceptable downtime after a disruption before services must be restored. An RTO of 2 hours means systems must be operational within 2 hours of declaring a disaster. RTO drives recovery *infrastructure* investment — meeting a 2-hour RTO may require hot standby systems rather than tape restoration.

- **Grandfather-Father-Son (GFS) Rotation:** A classic tape rotation scheme maintaining daily (son), weekly (father), and monthly (grandfather) backups, allowing recovery to multiple historical points while controlling media cost.

- **Air Gap:** Physical or logical isolation of backup media from production networks and the internet. Air-gapped backups cannot be encrypted by ransomware that propagates over the network. Can be physical (offline tape) or logical (immutable object storage with object lock).

- **Immutable Backup:** A backup written once and locked against modification or deletion for a defined retention period. Cloud implementations use S3 Object Lock (WORM — Write Once Read Many) or Azure Blob immutability policies. Prevents ransomware actors with stolen credentials from deleting backups.

- **Mean Time to Recover (MTTR):** Average time required to restore a system or service after failure. Distinct from RTO (target) — MTTR is the measured historical performance metric.

- **Backup Window:** The scheduled time period during which backup jobs are allowed to run. Constrained by production system availability, network bandwidth, and storage throughput. Modern continuous data protection (CDP) systems eliminate the traditional window entirely.

- **Deduplication:** A storage optimization technique that identifies and eliminates redundant data blocks across multiple backups, storing unique blocks once and referencing them. Dramatically reduces storage consumption for backup datasets with high similarity across time.

- **Replication vs. Backup:** Replication provides continuous synchronization between two systems (useful for RTO) but replicates corruptions and deletions immediately. Backup provides point-in-time recovery capability (useful for RPO). Both are needed; neither alone is sufficient.

---

## Exam Relevance

**SY0-701 Domain Mapping:** Backup and recovery appears primarily under **Domain 2 (Threats, Vulnerabilities, and Mitigations)** in the context of ransomware resilience, and **Domain 5 (Security Program Management and Oversight)** under business continuity and data classification.

**High-Probability Exam Scenarios:**

- **RPO vs. RTO confusion** is the most common trick question. Remember: RPO = data loss tolerance (drives backup frequency), RTO = downtime tolerance (drives recovery infrastructure). A question describing "maximum acceptable data loss" is asking about RPO.

- **3-2-1 rule questions** often ask which element satisfies the "offsite" requirement. Cloud storage, tape stored at a secondary facility, and colocation all satisfy the "1 offsite" requirement. External hard drive in the same building does NOT.

- **Backup types and restore sequences:** Know that an incremental restore requires the full backup PLUS all incrementals in order. A differential restore requires only the full backup PLUS the most recent differential. Exam questions frequently use scenarios asking "what is the MINIMUM number of backups needed to restore?"

- **Ransomware scenarios:** Questions about ransomware mitigation almost always have "immutable/air-gapped backup" as the correct answer over antivirus or network segmentation alone.

- **Hot, Warm, Cold sites:** Recovery site types map to RTO:
  - **Hot site:** Fully operational, near-instant failover (minutes). Highest cost.
  - **Warm site:** Partially configured, hours to days to bring online. Moderate cost.
  - **Cold site:** Empty facility with power/connectivity, days to weeks. Lowest cost.

**Common Gotchas:**
- "Backup" does not imply "tested recovery" — exam questions about backup *best practices* always include testing as a required element
- RAID is **not** a backup — it provides redundancy against disk failure but does not protect against deletion, corruption, or ransomware
- Snapshots alone are not backups if they reside on the same storage system as primary data

---

## Security Implications

### Backup Infrastructure as an Attack Target

Backup systems have become primary targets for ransomware operators because destroying backups eliminates the victim's ability to recover without paying. The **Conti ransomware** group's leaked playbooks explicitly documented procedures for locating and deleting Veeam and Backup Exec databases before deploying encryption. Groups including **BlackCat/ALPHV**, **LockBit**, and **BlackMatter** all include backup destruction as a standard pre-encryption step.

**CVE-2021-27876 / CVE-2021-27877 / CVE-2021-27878 (Veritas Backup Exec):** A set of critical vulnerabilities in Veritas Backup Exec agents allowing unauthenticated remote code execution via the NDMP service (TCP/10000). Exploited by the ALPHV/BlackCat ransomware group. Backup agents running on backup servers with privileged domain access represent a massive attack surface — compromise of the backup server yields access to all backed-up systems.

**CVE-2022-26134 (Confluence)** and similar initial-access vulnerabilities are frequently exploited not just for ransomware deployment but to establish persistence for future backup deletion. Threat actors commonly wait weeks between initial access and ransomware deployment, spending the interim locating and mapping backup infrastructure.

**Credential harvesting from backup databases:** Backup software often stores credentials for connecting to target systems. Veeam's configuration database (SQL Server) stores encrypted credentials. **CVE-2023-27532** in Veeam Backup & Replication allowed unauthenticated extraction of plaintext credentials from the configuration database via TCP/9401. These credentials typically include domain admin accounts, enabling lateral movement far beyond the backup infrastructure itself.

### Backup Data as a Sensitivity Risk

Backup archives contain snapshots of production data including databases with PII, credential stores, application secrets, and private keys. A stolen backup tape or misconfigured S3 bucket containing backups can expose the entire historical dataset of an organization. The 2012 **Utah Department of Technology Services** breach exposed 780,000 Medicaid records that were being transferred via an inadequately secured backup process.

### Ransomware and the Backup Race

Modern ransomware operates on a "double extortion" model: encrypt files AND exfiltrate data, threatening publication. Even perfect backups do not neutralize the extortion threat for data theft. This has elevated backup strategy from a pure availability control to an element of a broader data loss prevention program.

---

## Defensive Measures

### Immutable Backup Implementation

**AWS S3 Object Lock:**
```bash
# Create bucket with Object Lock enabled
aws s3api create-bucket \
  --bucket immutable-backups-prod \
  --region us-east-1 \
  --object-lock-enabled-for-bucket

# Set default retention rule (COMPLIANCE mode prevents ANY deletion including root)
aws s3api put-object-lock-configuration \
  --bucket immutable-backups-prod \
  --object-lock-configuration \
  '{"ObjectLockEnabled":"Enabled","Rule":{"DefaultRetention":{"Mode":"COMPLIANCE","Days":30}}}'
```

**Note:** `COMPLIANCE` mode cannot be overridden even by the account owner. Use `GOVERNANCE` mode for recoverable immutability (privileged users can override with specific IAM permissions).

### Backup Access Control

- Create a **dedicated backup service account** with least privilege — read access to source systems, write access only to backup destination. Never use domain admin credentials.
- Implement **MFA for backup console access** and all administrative backup operations
- Store backup encryption keys in a **separate key management system** (AWS KMS, HashiCorp Vault) not accessible from the backup server itself
- **Network segment** backup infrastructure — backup servers should not be reachable from general user networks (VLAN separation, firewall ACLs)
- Disable unnecessary services on backup servers (e.g., SMB, RDP if