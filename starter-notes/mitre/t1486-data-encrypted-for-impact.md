# T1486: Data Encrypted for Impact

Adversaries encrypt data on target systems or networks to interrupt availability and extract ransom or render data permanently inaccessible. This is a core [[Impact]] tactic technique affecting system and network resources across multiple platforms.

## Overview

Encryption-based attacks typically target common user files (Office documents, PDFs, images, videos, audio, text, source code) and may also affect critical system files, disk partitions, MBR, or virtual machines on [[ESXi]] hypervisors. Adversaries may rename or tag encrypted files with specific markers.

## Attack Methods

- **File Encryption**: Local and remote drives, often requiring [[File and Directory Permissions Modification]] or [[System Shutdown/Reboot]] first
- **System-Level Encryption**: Critical system files, disk partitions, MBR
- **VM Encryption**: Virtual machines on hypervisors like [[ESXi]]
- **Network Propagation**: Worm-like features leveraging [[Valid Accounts]], [[OS Credential Dumping]], [[SMB/Windows Admin Shares]]
- **Cloud Encryption**: AWS [[Server-Side Encryption]] with Customer Provided Keys (SSE-C) in compromised accounts
- **Intimidation Tactics**: [[Internal Defacement]], wallpaper changes, ESXi login message modifications, ransom notes, print bombing

## Platforms Affected

[[ESXi]], [[IaaS]], [[Linux]], [[Windows]], [[macOS]]

## Related Techniques

- [[File and Directory Permissions Modification]]
- [[System Shutdown/Reboot]]
- [[Valid Accounts]]
- [[OS Credential Dumping]]
- [[SMB/Windows Admin Shares]]
- [[Internal Defacement]]

## Procedure Examples

| Malware | Description |
|---------|-------------|
| [[S1129 - Akira]] | Encrypts victim filesystems using ChaCha20 and ChaCha8 stream ciphers for financial extortion |

## Tags

#att&ck #impact #ransomware #encryption #t1486

---
_Ingested: [[2026-04-15]] 22:02 | Source: https://attack.mitre.org/techniques/T1486/_
