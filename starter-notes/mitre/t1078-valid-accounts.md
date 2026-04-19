# T1078: Valid Accounts

Adversaries obtain and abuse credentials of existing accounts to gain [[Initial Access]], [[Persistence]], [[Privilege Escalation]], or [[Defense Evasion]]. Compromised credentials bypass access controls and enable persistent remote access to systems, [[VPN]]s, email services, network devices, and RDP.

## Overview

**Technique ID:** T1078  
**Tactics:** Defense Evasion, Persistence, Privilege Escalation, Initial Access  
**Platforms:** Containers, ESXi, IaaS, Identity Provider, Linux, Network Devices, Office Suite, SaaS, Windows, macOS  
**Last Modified:** 24 October 2025

## Key Points

- Compromised credentials may grant increased privilege and access to restricted network areas
- Adversaries often avoid malware/tools to evade detection alongside legitimate credential use
- Inactive/dormant accounts are frequently abused to avoid detection by original account owners
- Permission overlap across local, domain, and cloud accounts enables lateral movement and privilege escalation to domain/enterprise administrator

## Sub-techniques

| ID | Name |
|----|------|
| [[T1078.001]] | Default Accounts |
| [[T1078.002]] | Domain Accounts |
| [[T1078.003]] | Local Accounts |
| [[T1078.004]] | Cloud Accounts |

## Notable Use Cases

- **[[APT28]]**: Stolen spearphishing credentials, default manufacturer passwords on IoT devices (VoIP, printers, video decoders)
- **[[APT29]]**: Compromised account for [[VPN]] infrastructure access
- **[[Sandworm Team]]** (2015 Ukraine Electric Power Attack): Lateral movement, privilege escalation, persistence
- **[[AppleJeus]]** (3CX Supply Chain): Legitimate [[VPN]] credentials
- **[[Akira]]**: Remote network access via valid account information

## Tags

#attack-framework #credential-abuse #persistence #privilege-escalation #initial-access #defense-evasion

---
_Ingested: [[2026-04-10]] 13:54 | Source: https://attack.mitre.org/techniques/T1078/_
