# T1078.003: Valid Accounts - Local Accounts

Adversaries abuse local account credentials for [[Initial Access]], [[Persistence]], [[Privilege Escalation]], or [[Defense Evasion]]. Local accounts configured for users, remote support, services, or administration can be exploited through credential dumping, password reuse, and lateral movement across networked systems.

## ATT&CK Details

**ID:** T1078.003  
**Parent:** [[T1078]] (Valid Accounts)  
**Tactics:** Defense Evasion, Persistence, Privilege Escalation, Initial Access  
**Platforms:** Containers, ESXi, Linux, Network Devices, Windows, macOS  
**Version:** 1.5  
**Created:** 13 March 2020  
**Last Modified:** 24 October 2025  

## Related Sub-techniques

- [[T1078.001]] Default Accounts
- [[T1078.002]] Domain Accounts
- [[T1078.004]] Cloud Accounts

## Threat Groups & Software Using This Technique

### Groups
- [[APT29]] — Targets dormant/inactive user accounts for persistence
- [[APT32]] — Uses legitimate local admin credentials
- [[FIN10]] — Lateral movement via Local Administrator account
- [[FIN7]] — Compromised SYSTEM account credentials on Exchange
- [[HAFNIUM]] — Uses NT AUTHORITY\SYSTEM on Exchange servers
- [[Kimsuky]] — GREASE tool adds Windows admin accounts for RDP access
- [[Play]] — Valid local accounts for initial access
- [[PROMETHIUM]] — Creates admin accounts on compromised hosts
- [[Sea Turtle]] — Compromised cPanel accounts
- [[Tropic Trooper]] — Known administrator credentials for backdoor execution
- [[Turla]] — Reused local account passwords across networks
- [[Velvet Ant]] — Accessed vulnerable Cisco systems

### Software
- [[Cobalt Strike]] — Runs commands as local user account
- [[Emotet]] — Brute forces local admin passwords for lateral movement
- [[LockBit 3.0]] — Uses compromised local accounts for lateral movement
- [[NotPetya]] — Uses valid credentials with PsExec/WMIC for propagation
- [[Umbreon]] — Creates valid local users for system access

## Attack Flow

1. **Initial Access** — Obtain valid local account credentials (guessing, dumping, phishing)
2. **Privilege Escalation** — Abuse local admin accounts to escalate rights
3. **Lateral Movement** — Reuse credentials across multiple systems
4. **Persistence** — Create or abuse dormant accounts for continued access
5. **Defense Evasion** — Use legitimate accounts to blend with normal activity

## Tags

#attack #t1078 #valid-accounts #local-accounts #initial-access #persistence #privilege-escalation #defense-evasion #credential-abuse #lateral-movement

---
_Ingested: 2026-04-15 20:21 | Source: https://attack.mitre.org/techniques/T1078/003/_
