# T1083 — File and Directory Discovery

Adversaries enumerate files and directories on a host or network share to gather information during discovery, often shaping follow-on attack behaviors. This technique leverages common utilities like `dir`, `tree`, `ls`, `find`, and `locate`, or custom tools that interact with the Native API.

## Overview
- **ATT&CK ID:** T1083
- **Tactic:** [[Discovery]]
- **Platforms:** ESXi, Linux, Network Devices, Windows, macOS
- **Last Modified:** 24 October 2025

## Description

File and Directory Discovery is a foundational reconnaissance technique used by adversaries to:
- Enumerate files and directories on local or remote systems
- Search for specific information within file systems
- Identify files meeting certain criteria (e.g., document types, antivirus folders)
- Gather metadata to inform subsequent actions

Some files and directories may require elevated or specific user permissions to access.

## Common Tools & Methods

- **CLI utilities:** `dir`, `tree`, `ls`, `find`, `locate`
- **Native APIs:** Custom tools leveraging OS-level file enumeration functions
- **Network Device CLI:** Commands like `dir`, `show flash`, `nvram` on network devices

## Example Threat Actors & Malware

Numerous groups and malware families use this technique:
- [[APT28]] — Forfiles for locating PDFs, Excel, Word documents
- [[admin@338]] — `dir` commands to enumerate drives and directories
- [[3PARA RAT]], [[4H RAT]], [[Action RAT]] — File listing capabilities
- [[AcidRain]], [[AcidPour]] — Linux file/directory identification for storage devices
- [[Akira]] — File examination prior to encryption via Windows API functions
- [[AppleSeed]] — Targeted search for document file types (.txt, .ppt, .hwp, .pdf, .doc)

## Detection Considerations

Monitor for:
- Execution of file enumeration commands (especially bulk `dir` or `find` operations)
- API calls related to file discovery (e.g., `FindFirstFileW`, `GetFileAttributesW`)
- Unusual file system queries on network shares
- Processes spawning with high frequency of directory listing operations

## Tags

#mitre-attack #discovery #reconnaissance #t1083

---
_Ingested: [[2026-04-15]] 22:02 | Source: https://attack.mitre.org/techniques/T1083/_
