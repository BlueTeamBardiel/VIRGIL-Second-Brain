# OneFS

## What it is
Think of OneFS like a single enormous hard drive that secretly spans hundreds of physical machines — applications see one unified volume while the complexity hides underneath. OneFS is Dell EMC Isilon's distributed file system operating system, designed to manage petabyte-scale NAS clusters as a single namespace with built-in data protection, tiering, and access controls.

## Why it matters
In 2021, attackers targeting large media and healthcare organizations specifically hunted Isilon clusters running OneFS because a single compromised admin account could expose the entire petabyte-scale storage pool — there's no segmentation by default between shares. Defenders must harden OneFS by enforcing role-based access control (RBAC), enabling SMB signing, and auditing the built-in "root" and "admin" accounts which are frequent lateral movement targets.

## Key facts
- OneFS runs on top of a hardened FreeBSD kernel and uses a proprietary journaling file system with erasure coding (N+M protection) instead of traditional RAID
- Default administrative interfaces include the OneFS WebUI (port 8080/8443) and SSH — both are common attack surfaces requiring MFA enforcement
- OneFS supports multi-protocol access (SMB, NFS, HDFS, S3), meaning a misconfiguration in one protocol can expose data accessible through others
- The built-in `SyncIQ` replication feature, if misconfigured, can replicate ransomware or malicious data to disaster-recovery targets, destroying backup integrity
- CVE-2022-34459 and related OneFS vulnerabilities have involved privilege escalation via local exploits — patching cadence on clustered storage is often neglected by ops teams

## Related concepts
[[NAS Security]] [[SMB Signing]] [[Privilege Escalation]] [[Ransomware Defense]] [[Role-Based Access Control]]