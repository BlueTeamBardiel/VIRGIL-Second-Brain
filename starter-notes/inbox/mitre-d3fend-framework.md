# MITRE D3FEND Framework

D3FEND is a knowledge graph of cybersecurity countermeasures developed by MITRE in collaboration with NSA. It provides a structured taxonomy of defensive techniques mapped against adversary tactics and techniques.

## Overview

D3FEND (version 1.4.0) organizes defensive countermeasures across multiple domains including:
- **Artifacts** — digital evidence and indicators
- **Taxonomies** — structured categorization of defensive techniques
- **CAD** — Cyber Analytics Dashboard

## Key Defensive Domains

### Data Protection
- [[Data Obfuscation]] (T1001): Junk Data, Steganography, Protocol Impersonation
- [[Data Encryption]] (T1022, T1032)
- [[OS Credential Dumping]] (T1003): LSASS Memory, SAM, NTDS, DCSync, /etc/passwd

### Network & System Discovery
- [[System Network Configuration Discovery]] (T1016)
- [[Remote System Discovery]] (T1018)
- [[Network Service Discovery]] (T1046)
- [[Process Discovery]] (T1057)

### Remote Access Defense
- [[Remote Desktop Protocol]] (T1021.001)
- [[SMB/Windows Admin Shares]] (T1021.002)
- [[SSH]] (T1021.004)
- [[VNC]] (T1021.005)
- [[Windows Remote Management]] (T1021.006)

### Obfuscation & Evasion
- [[Obfuscated Files or Information]] (T1027): Software Packing, HTML Smuggling, Dynamic API Resolution, Command Obfuscation, Polymorphic Code
- [[Masquerading]] (T1036): Signature Spoofing, RTL Override, Legitimate Utility Renaming, File Extension Tricks

### Exfiltration Defense
- [[Exfiltration Over C2 Channel]] (T1041)
- [[Exfiltration Over Alternative Protocol]] (T1048): Encrypted/Unencrypted variants
- [[Exfiltration Over Physical Medium]] (T1052)

### Process & Injection Defense
- [[Process Injection]] (T1055): DLL Injection, PE Injection, Thread Hijacking, Process Hollowing, Process Doppelgänging

### Persistence & Execution
- [[Boot or Logon Initialization Scripts]] (T1037): Logon Scripts, RC Scripts, Startup Items
- [[Scheduled Task/Job]] (T1053): Cron, Launchd, Systemd Timers, Container Orchestration Jobs

### Input Capture Defense
- [[Input Capture]] (T1056): Keylogging, GUI Input Capture, Credential API Hooking

## Resources

- **Website**: https://d3fend.mitre.org/
- **Collaboration**: NSA partnership
- **Navigation**: Domains, CAD, Artifacts, Taxonomies, Blog, Search
- **Community**: Contribute, FAQ sections available

## Tags

#defensive-framework #mitre #cybersecurity #threat-intelligence #countermeasures #tactics-techniques #nsa

---
_Ingested: [[2026-04-15]] 22:04 | Source: https://d3fend.mitre.org/_
