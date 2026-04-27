# Domain or Tenant Policy Modification

Adversaries modify configuration settings of domains or identity tenants to evade defenses and escalate privileges in centrally managed environments. This technique encompasses modifications to [[Group Policy Objects]] (GPOs), trust relationships, and federated identity configurations.

## Overview

**MITRE ATT&CK ID:** T1484  
**Tactics:** Defense Evasion, Privilege Escalation  
**Platforms:** Identity Provider, Windows  
**Version:** 3.2 (Last Modified: 24 October 2025)

## Sub-techniques

- **T1484.001** – [[Group Policy Modification]]
- **T1484.002** – [[Trust Modification]]

## Attack Examples

- Modifying GPOs to push malicious [[Scheduled Task|Scheduled Tasks]] across the domain
- Modifying domain trusts to include adversary-controlled domains, enabling forged access tokens
- Changing [[Active Directory]] (AD) configuration to implement a [[Rogue Domain Controller]]
- Adding adversary-controlled federated identity providers to allow authentication as any managed user
- Temporary modifications followed by reversion to remove suspicious indicators

## Mitigations

| ID | Strategy | Description |
|---|---|---|
| M1047 | [[Audit]] | Identify GPO permission abuse using tools like [[BloodHound]] |
| M1026 | [[Privileged Account Management]] | Use least privilege; protect Domain Controller and [[Active Directory Federation Services]] (AD FS) |
| M1018 | [[User Account Management]] | Implement WMI and security filtering for GPO scope |

## Detection

**DET0270:** Detection of Domain or Tenant Policy Modifications via AD and Identity Provider
- Monitor creation/modification of GPOs, delegation permissions, trust objects
- Track rogue domain controller registration via GUI, CLI, or programmatic APIs
- Monitor federation configuration and identity provider additions

## Tags

#attack #privilege-escalation #defense-evasion #active-directory #identity #gpo

---
_Ingested: [[2026-04-15]] 22:02 | Source: https://attack.mitre.org/techniques/T1484/_
