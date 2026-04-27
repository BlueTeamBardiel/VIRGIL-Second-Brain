# T1490: Inhibit System Recovery

Adversaries delete or disable system recovery features to prevent recovery of corrupted systems and deny access to backups. This technique augments [[Data Destruction]] and [[Data Encrypted for Impact]] attacks.

## Overview

**ATT&CK ID:** T1490  
**Tactic:** [[Impact]]  
**Platforms:** Containers, ESXi, IaaS, Linux, Network Devices, Windows, macOS  
**Impact Type:** Availability

## Description

Adversaries may delete or remove built-in data and turn off services designed to aid in recovery of corrupted systems. Operating systems contain features like backup catalogs, [[volume shadow copies]], and automatic repair that adversaries disable or delete to augment destructive attacks and prevent recovery. Adversaries may also disable recovery notifications before corrupting backups.

## Windows Recovery Techniques

Native Windows utilities commonly abused:

- **vssadmin.exe**: Delete all [[volume shadow copies]] — `vssadmin.exe delete shadows /all /quiet`
- **wmic**: Delete volume shadow copies via [[Windows Management Instrumentation]]
- **wbadmin.exe**: Delete Windows Backup Catalog — `wbadmin.exe delete catalog -quiet`
- **bcdedit.exe**: Disable automatic recovery by modifying boot configuration — `bcdedit.exe /set {default} bootstatuspolicy ignoreallfailures & bcdedit /set {default} recoveryenabled no`
- **REAgentC.exe**: Disable [[Windows Recovery Environment]] (WinRE)
- **diskshadow.exe**: Delete volume shadow copies — `diskshadow delete shadows all`

## Multi-Platform Variants

**Network Devices:** Leverage [[Disk Wipe]] to delete backup firmware images and reformat file system, followed by [[System Shutdown/Reboot]] to reload device — may render devices inoperable.

**ESXi Servers:** Delete or encrypt [[VM snapshots]] to block disaster recovery backups (e.g., `vim-cmd vmsvc/snapshot.removeall`).

**Cloud Environments:** Disable versioning, backup policies, delete snapshots, database backups, machine images, and prior object versions.

**Online Backups:** Delete connected network backups and cloud-synced folders.

## Known Threat Actors

| ID   | Name  | Activity |
|------|-------|----------|
| S1129 | [[Akira]] | Deletes [[volume shadow copies]] via PowerShell |

## Related Techniques

- [[T1561 - Disk Wipe]]
- [[T1565 - Data Manipulation]]
- [[T1491 - Data Encrypted for Impact]]
- [[T1531 - Account Access Removal]]

## Tags

#ATT&CK #Impact #Malware #Ransomware #Destructive #Recovery #Backup #T1490

---
_Ingested: [[2026-04-15]] 22:02 | Source: https://attack.mitre.org/techniques/T1490/_
