# T1201: Password Policy Discovery

Adversaries discover password policy details to craft targeted brute-force and dictionary attacks that comply with organizational complexity requirements. This [[ATT&CK]] technique (Discovery tactic) helps attackers understand lockout thresholds, minimum lengths, and complexity rules.

## Overview

Password policies enforce complex passwords resistant to cracking. By discovering these policies, adversaries can:
- Create candidate password lists matching minimum length requirements
- Avoid triggering account lockouts by respecting attempt limits
- Tailor attacks to organizational standards

## Discovery Methods

### Windows
- `net accounts` / `net accounts /domain`
- `Get-ADDefaultDomainPasswordPolicy` (PowerShell)
- Registry: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa\Notification Packages`

### Linux/macOS
- `chage -l` (Linux)
- `cat /etc/pam.d/common-password` (Linux)
- `pwpolicy getaccountpolicies` (macOS)

### Cloud & Network Devices
- AWS API: `GetAccountPasswordPolicy`
- Network device CLIs: `show aaa`, `show aaa common-criteria policy all`

## Procedure Examples

| Threat Actor/Tool | Method |
|---|---|
| [[Chimera]] | NtdsAudit utility for account/password reconnaissance |
| [[CrackMapExec]] | Automated password policy discovery |
| [[Kwampirs]] | `net accounts` command |
| [[OilRig]] | `net accounts /domain` in scripts |
| [[Turla]] | `net accounts` and domain variants |
| [[PoshC2]] | `Get-PassPol` enumeration |

## Mitigation

**M1027 — Password Policies**: Register only valid password filters in `C:\Windows\System32\` with corresponding registry entries. Prevent unauthorized filter installation.

## Platforms
IaaS, Identity Provider, Linux, Network Devices, Office Suite, SaaS, Windows, macOS

## Tags
#mitre-attack #discovery #password-policy #reconnaissance #t1201

---
_Ingested: [[2026-04-15]] 22:02 | Source: https://attack.mitre.org/techniques/T1201/_
