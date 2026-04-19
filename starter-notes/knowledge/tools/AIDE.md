---
domain: "endpoint security"
tags: [integrity-monitoring, ids, linux, hids, file-monitoring, forensics]
---
# AIDE

**AIDE (Advanced Intrusion Detection Environment)** is a free, open-source **host-based intrusion detection system (HIDS)** that detects unauthorized changes to the filesystem by comparing the current state against a cryptographically secured [[Integrity Baseline|baseline database]]. Originally developed as a replacement for [[Tripwire]], AIDE operates on [[Linux]] and Unix-like systems and is widely deployed in hardened server environments, compliance frameworks, and [[Security Operations Center|SOC]] workflows.

---

## Overview

AIDE was created in 1999 by Rami Lehti and Pablo Virolainen to fill the gap left when Tripwire moved to a proprietary licensing model. The tool operates on a simple but powerful principle: take a snapshot of the filesystem at a known-good state, store cryptographic checksums and metadata for every monitored file, and then periodically re-scan the filesystem to detect any deviations from that baseline. This approach directly addresses the threat of **rootkits**, **backdoors**, **supply chain tampering**, and **insider threats** that modify system binaries, configuration files, or sensitive data without triggering network-based detection.

Unlike network-based intrusion detection systems such as [[Snort]] or [[Suricata]], which analyze traffic flowing through the network, AIDE focuses entirely on the **host filesystem state**. This makes it uniquely effective at catching attacks that have already succeeded in gaining local access — an attacker who replaces `/bin/login` with a backdoored version, modifies `/etc/sudoers`, or plants a cron job cannot easily hide these changes from a properly configured AIDE deployment.

AIDE is particularly prominent in compliance frameworks. The **Center for Internet Security (CIS) Benchmarks** for RHEL, Ubuntu, and Debian all include requirements to deploy filesystem integrity monitoring, and AIDE is the default tool cited. Similarly, **PCI DSS Requirement 11.5** explicitly mandates file integrity monitoring for cardholder data environments, and **NIST SP 800-53 SI-7** (Software, Firmware, and Information Integrity) maps directly to what AIDE provides. Many organizations running AIDE export its reports to a [[SIEM]] for centralized alerting and long-term retention.

AIDE stores its database as a flat file (by default `/var/lib/aide/aide.db`) containing records for every monitored file path. The database is indexed by file path and stores a configurable set of attributes including multiple hash algorithms, inode number, file permissions, ownership, size, link count, and timestamps. Because the database itself is a target for attackers who want to cover their tracks, best practice mandates storing the baseline database on **read-only media** or an external, trusted system — a principle that is fundamental to AIDE's threat model.

The tool integrates naturally with scheduled task systems. Most production deployments run AIDE checks via **cron** or **systemd timers** on a nightly or weekly cadence, and pipe the diff output to email, syslog, or a centralized log aggregation platform. More advanced deployments combine AIDE with [[auditd]] and [[SELinux]] or [[AppArmor]] to create defense-in-depth coverage of both file changes and the processes that made them.

---

## How It Works

### Installation

On Debian/Ubuntu-based systems:
```bash
sudo apt update && sudo apt install aide -y
```

On RHEL/CentOS/Rocky Linux:
```bash
sudo dnf install aide -y
```

### Configuration File

AIDE's behavior is controlled by `/etc/aide/aide.conf` (Debian) or `/etc/aide.conf` (RHEL). The configuration file defines:

1. **Database paths** — where to read the baseline and write new databases
2. **Rules** — named groups of attributes to check
3. **Watch directives** — which directories/files to monitor and with which rules

Example configuration snippet:
```ini
# Database locations
database=file:/var/lib/aide/aide.db
database_out=file:/var/lib/aide/aide.db.new

# Log output
report_url=file:/var/log/aide/aide.log
report_url=stdout

# Define rule groups
FIPSR = p+i+n+u+g+s+m+c+acl+selinux+xattrs+sha512
CONTENT = sha512
CONTENT_EX = sha512+ftype
ALLXTRAHASHES = sha1+rmd160+sha256+sha512

# Directories to monitor
/boot  FIPSR
/bin   FIPSR
/sbin  FIPSR
/lib   FIPSR
/usr   FIPSR
/etc   FIPSR

# Directories to explicitly ignore
!/proc
!/sys
!/dev
!/run
!/tmp
!/var/log
```

### Attribute Codes

The rule attributes map to specific properties:

| Code | Attribute |
|------|-----------|
| `p`  | Permissions |
| `i`  | Inode number |
| `n`  | Number of links |
| `u`  | User ID |
| `g`  | Group ID |
| `s`  | File size |
| `m`  | Modification time (mtime) |
| `c`  | Change time (ctime) |
| `sha256` | SHA-256 hash |
| `sha512` | SHA-512 hash |
| `acl` | POSIX ACLs |
| `selinux` | SELinux context |
| `xattrs` | Extended attributes |

### Initializing the Baseline Database

Before AIDE can detect changes, a baseline must be established on a known-clean system:

```bash
sudo aide --init
```

This command scans all monitored paths according to the config and writes the new database to the `database_out` path. On RHEL-based systems this creates `/var/lib/aide/aide.db.new.gz`. The file must then be renamed to become the active database:

```bash
sudo mv /var/lib/aide/aide.db.new.gz /var/lib/aide/aide.db.gz
```

**Critical:** This baseline operation should be performed immediately after OS installation and hardening, before the system is placed into production.

### Running a Check

To compare the current filesystem state against the baseline:

```bash
sudo aide --check
```

AIDE will re-hash every monitored file and compare against the stored values. Output categorizes findings into:

- **Added files** — new files not in baseline
- **Removed files** — files present in baseline that no longer exist
- **Changed files** — files where one or more attributes differ from baseline

Example output excerpt:
```
AIDE found differences between database and filesystem!!
Start timestamp: 2024-03-15 02:30:01 +0000

Summary:
  Total number of entries:    52847
  Added entries:              2
  Removed entries:            0
  Changed entries:            3

---------------------------------------------------
Changed entries:
---------------------------------------------------

f   ...    : /etc/passwd
 Mtime    : 2024-03-10 10:15:33              | 2024-03-15 01:47:22
 SHA512   : abc123...                        | def456...

f   ...    : /usr/bin/sudo
 SHA512   : 789abc...                        | 000111...
```

### Updating the Database

After applying legitimate system updates (e.g., `apt upgrade`), the baseline must be updated to reflect the new state of patched files:

```bash
sudo aide --update
sudo mv /var/lib/aide/aide.db.new.gz /var/lib/aide/aide.db.gz
```

Failing to update the baseline after authorized changes will cause persistent false positives and **alert fatigue**.

### Automating with Systemd Timer

```ini
# /etc/systemd/system/aide-check.timer
[Unit]
Description=AIDE filesystem integrity check

[Timer]
OnCalendar=daily
Persistent=true

[Install]
WantedBy=timers.target
```

```ini
# /etc/systemd/system/aide-check.service
[Unit]
Description=AIDE filesystem integrity check

[Service]
Type=oneshot
ExecStart=/usr/bin/aide --check
StandardOutput=journal
StandardError=journal
```

```bash
sudo systemctl enable --now aide-check.timer
```

---

## Key Concepts

- **Baseline Database**: The cryptographically secured snapshot of filesystem state taken at a known-good point in time. All subsequent checks compare live filesystem attributes against this reference. The integrity of the baseline itself is paramount — if an attacker can modify the database, the entire detection capability is compromised.

- **Rule Groups**: Named collections of attributes (e.g., `FIPSR`, `NORMAL`, `CONTENT`) defined in the configuration file that specify exactly which filesystem properties are tracked for a given path. Different paths may warrant different rule granularity — for example, log directories are often excluded entirely or monitored only for permission changes to avoid noise.

- **Inode Monitoring**: AIDE tracks inode numbers alongside content hashes. An unchanged file binary-copied to a new inode (as some rootkit replacement techniques do) will show an inode change even if the content hash matches, providing an additional detection signal.

- **Database Rotation**: The practice of maintaining versioned AIDE databases over time, enabling forensic comparison of filesystem state across multiple points in time. This is critical for incident response to establish a timeline of when a change first appeared.

- **False Positive Management**: Legitimate system events — package updates, log rotation, configuration management runs — all modify files and generate AIDE findings. Mature deployments implement suppression rules, post-check filters, or integration with [[Configuration Management]] tooling (e.g., [[Ansible]], [[Puppet]]) that automatically updates the baseline after authorized changes.

- **FIPS Compliance Mode**: AIDE supports FIPS 140-2 compliant hash algorithms. The `FIPSR` built-in rule group uses only FIPS-approved algorithms (SHA-256, SHA-512), making it suitable for use in U.S. federal environments subject to [[FIPS 140-2]] requirements.

- **Report Verbosity Levels**: AIDE supports configurable output verbosity via the `report_level` directive (0–20), controlling how much detail appears in diff reports. Level 20 shows all attribute changes in full; lower levels summarize findings, which is useful for high-volume environments.

---

## Security Implications

### Attack Vectors Against AIDE Itself

AIDE's effectiveness depends entirely on the integrity of its own database and binary. Several well-documented attack patterns target the tool:

**Database Tampering**: If an attacker achieves root access, they can modify the AIDE database (`/var/lib/aide/aide.db.gz`) to incorporate their malicious changes, eliminating the evidence. This is why the CIS Benchmark explicitly requires storing the database on read-only media or a separate trusted host.

**Binary Replacement**: An attacker with root access could replace the `aide` binary itself with a version that always reports a clean filesystem. This can be partially mitigated by storing AIDE on immutable infrastructure or verifying the binary against a trusted hash before running checks.

**Timestamp Manipulation**: Some sophisticated rootkits (e.g., components of the **Azazel** rootkit family) attempt to restore original timestamps after file modification using `utimes()` system calls, potentially defeating mtime-based detection. AIDE's use of cryptographic hashes (SHA-512) is immune to this — only the hash values matter for content verification.

**Exclusion Abuse**: Overly broad exclusion rules (e.g., excluding all of `/var` or `/tmp`) create blind spots. Attackers familiar with AIDE configurations may place malicious files in known-excluded directories.

### Real-World Incidents and CVEs

- **CVE-2021-44142 (Samba)**: Following disclosure of this Samba vulnerability, organizations using AIDE detected unauthorized modifications to Samba-related libraries on unpatched systems — demonstrating AIDE's value in post-compromise detection.

- **SolarWinds SUNBURST (2020)**: This supply chain attack involved modifying the SolarWinds Orion update package. On Linux systems with AIDE deployed and configured to monitor application directories, the introduction of modified binaries would have generated AIDE alerts — though the attack specifically targeted Windows environments where FIM deployment was less consistent.

- **Rootkit Detection**: AIDE has been the primary detection mechanism in multiple published incident response reports where Linux rootkits (notably **Diamorphine** and **Reptile**) were deployed via web shell access. The rootkit modified kernel module loading infrastructure and replaced system binaries; AIDE checks run from a clean boot environment (or via a read-only live OS) detected the changes.

### Limitations

- AIDE is **not real-time**. Changes are detected only when a check is run. For real-time detection, [[inotify]]-based tools like **auditd** with file watch rules, **Falco**, or **Wazuh** (which includes its own FIM engine) provide lower-latency alerting.
- AIDE has **no response capability** — it only detects and reports. Response must be handled by external orchestration.
- On large filesystems (millions of files), initial scans can take significant CPU and I/O resources, potentially impacting production workloads.

---

## Defensive Measures

### Protect the Database

Store the AIDE database on a remote, read-only location:

```bash
# Copy baseline to a trusted, remote read-only NFS mount or object storage
scp /var/lib/aide/aide.db.gz backup-server:/secure/aide-baselines/$(hostname)-$(date +%Y%m%d).db.gz
```

Alternatively, use a hardware write-protect mechanism (USB drive in read-only mode, or a WORM storage solution).

### Verify AIDE Binary Integrity

Before running checks, verify the AIDE binary hasn't been tampered with:

```bash
# On Debian/Ubuntu
debsums aide
# On RHEL
rpm -V aide
```

### Integrate with SIEM

Forward AIDE reports to [[Splunk]], [[Elastic Stack]], or [[Wazuh]] for centralized alerting:

```bash
# In /etc/aide/aide.conf, enable syslog output
report_url=syslog:LOG_AUTH
```

Or pipe check output to a log aggregation agent:

```bash
/usr/bin/aide --check 2>&1 | logger -t aide -p security.warning
```

### Combine with auditd

Use [[auditd]] to capture **who** made changes that AIDE **detects**:

```bash
# /etc/audit/rules.d/aide-complement.rules
-w /etc/passwd -p wa -k passwd_changes
-w /etc/shadow -p wa -k shadow_changes
-w /usr/bin/sudo -p wa -k sudo_binary
-w /bin/ -p wa -k bin_directory
```

When AIDE flags a change, the corresponding auditd log will identify the UID, PID, and syscall responsible.

### Deployment Checklist

1. Install AIDE immediately after OS build, before any application deployment
2. Apply all OS hardening (CIS Benchmark), then initialize baseline
3. Store baseline database off-host or on read-only media
4. Configure systemd timer or cron for regular checks
5. Route AIDE output to centralized SIEM or log management
6. Establish a **change management process** that includes AIDE database updates as part of the approved change workflow
7. Exclude dynamic directories (`/proc`, `/sys`, `/dev`, `/run`, `/tmp`, `/var/log`) from content hashing
8. Review and tune exclusions quarterly to minimize false positives without creating blind spots

---

## Lab / Hands-On

### Lab Environment

This lab works on any Linux VM — a fresh Ubuntu 22.04 or Rocky Linux 9 VM is ideal.

### Step 1: Install and Configure

```bash
# Ubuntu
sudo apt install aide -y

# Inspect default config
sudo less /etc/aide/aide.conf

# Add a custom rule to monitor a test directory
echo "/home/labuser/critical  FIPSR" | sudo tee -a /etc/aide/aide.conf
```

### Step 2: Create Test Files and Initialize Baseline

```bash
# Create test content
mkdir -p ~/critical
echo "sensitive configuration data" > ~/critical/config.txt
echo "important script content" > ~/critical/deploy.sh
chmod 700 ~/critical/deploy.sh

# Initialize baseline database
sudo aide --init

# Activate the database
sudo mv /var/lib/aide/aide.db.new /var/lib/aide/aide.db
# (On RHEL: