# T1087: Account Discovery

Adversaries enumerate valid accounts, usernames, or email addresses on systems or within compromised environments to aid follow-on attacks like brute-forcing, spear-phishing, or account takeovers. This [[ATT&CK]] technique spans multiple platforms and leverages built-in tools, misconfigurations, and cloud interfaces.

## Tactic
- [[Discovery]]

## Platforms
ESXi, IaaS, Identity Provider, Linux, Office Suite, SaaS, Windows, macOS

## Sub-techniques
- **T1087.001** – [[Local Account]] discovery
- **T1087.002** – [[Domain Account]] discovery
- **T1087.003** – [[Email Account]] discovery
- **T1087.004** – [[Cloud Account]] discovery

## Attack Methods
- Abuse of existing tools and built-in commands (e.g., PowerShell)
- Cloud environment APIs and interfaces
- File system searching for email/account metadata
- Exploitation of misconfigurations leaking account names, roles, or permissions

## Notable Threat Actors & Malware
| ID | Name | Technique |
|----|------|----------|
| G0143 | [[Aquatic Panda]] | Linux `last` command for user enumeration |
| G1016 | [[FIN13]] | Enumerated users and roles from treasury systems |
| S1229 | [[Havoc]] | Identify privileged user accounts |
| G1015 | [[Scattered Spider]] | vSphere administrator account identification |
| S0445 | [[ShimRatReporter]] | List privileged/non-privileged accounts |
| C0024 | [[SolarWinds Compromise]] | APT29 extracted user roles via `Get-ManagementRoleAssignment` |
| S1239 | [[TONESHELL]] | User account retrieval functionality |
| S1065 | [[Woody RAT]] | Administrator account identification |
| S0658 | [[XCSSET]] | Discover accounts from Evernote, AppleID, Telegram, Skype, WeChat |

## Mitigations
- **M1028 – Operating System Configuration**: Disable UAC admin enumeration via `HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\CredUI\EnumerateAdministrators` (GPO: Computer Configuration > Administrative Templates > Windows Components > Credential User Interface)
- **M1018 – User Account Management**: Manage account creation, modification, permissions, and lifecycle

## Metadata
- **ID**: T1087
- **ATT&CK Version**: 2.6
- **Created**: 31 May 2017
- **Last Modified**: 24 October 2025
- **Contributors**: Daniel Stepanic (Elastic), MSTIC, Travis Smith (Tripwire)

## Tags
#discovery #account-enumeration #reconnaissance #attck-technique #t1087

---
_Ingested: [[2026-04-15]] 22:02 | Source: https://attack.mitre.org/techniques/T1087/_
