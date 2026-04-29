# Device Partition

## What it is
Like dividing a single apartment building into separately locked units — each tenant isolated from the others — a device partition is a logically separated section of a storage device (HDD, SSD, USB) that the OS treats as a distinct volume. Each partition has its own file system, can have independent permissions, and may be invisible to other partitions depending on configuration.

## Why it matters
Attackers frequently hide malicious payloads in unallocated space or secondary partitions that the host OS never mounts — a technique used in advanced rootkits and bootkit malware like LoJax. Forensic investigators must image the *entire physical device*, not just visible partitions, to capture evidence that lives in these hidden or unallocated regions. Missing a partition during acquisition can mean missing the entire attack.

## Key facts
- **MBR vs. GPT**: Master Boot Record supports up to 4 primary partitions and 2 TB drives; GUID Partition Table (GPT) supports up to 128 partitions and drives >2 TB — GPT is required for UEFI Secure Boot.
- **Hidden partitions** (e.g., OEM recovery partitions) don't appear in standard OS drive explorers but are fully visible in disk forensics tools like Autopsy or FTK.
- **Full-disk encryption** (e.g., BitLocker) encrypts at the partition level — an unencrypted second partition on the same disk leaks data even if the primary partition is locked.
- **Slack space** within partitions — the gap between actual file data and the end of its allocated cluster — is a classic steganography and anti-forensics hiding location.
- Security baselines (CIS, NIST) recommend placing `/tmp`, `/var`, and `/home` on **separate Linux partitions** to prevent a full-disk attack from crashing critical services.

## Related concepts
[[Full Disk Encryption]] [[File System Forensics]] [[Bootkit Malware]] [[Slack Space]] [[Disk Imaging]]