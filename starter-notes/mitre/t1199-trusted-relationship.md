# T1199: Trusted Relationship

Adversaries breach or leverage organizations with access to intended victims, exploiting trusted third-party relationships that receive less scrutiny than standard access mechanisms. This technique abuses existing connections through IT contractors, managed security providers, and infrastructure vendors.

## Overview

**Tactic:** Initial Access

**Platforms:** IaaS, Identity Provider, Linux, Office Suite, SaaS, Windows, macOS

**ID:** T1199 | **Version:** 2.4 | **Last Modified:** 12 November 2025

## Attack Methods

### Third-Party Provider Compromise
Organizations grant elevated access to external providers for system and cloud management. Compromised [[Valid Accounts]] used by these parties can be leveraged for internal network access.

### Office 365 Partner Delegation
Adversaries compromise [[Microsoft]] partners or resellers with delegated administrator permissions, enabling:
- Leverage of existing delegated admin relationships
- Sending new delegated admin offers to victim clients
- Administrative control over victim [[Office 365]] tenants

## Procedure Examples

| Actor | Example |
|-------|----------|
| [[APT28]] | Compromised DCCC network, pivoted to DNC network |
| [[APT29]] | Compromised IT, cloud services, and MSPs for multi-customer access |
| [[HAFNIUM]] | Used stolen credentials from PAM and cloud app providers |
| [[LAPSUS$]] | Accessed [[Azure Active Directory]] and [[Okta]] |
| [[menuPass]] | Leveraged legitimate MSP access against victims |
| [[Sandworm Team]] | Used dedicated network connections between victim organizations; targeted ISPs and telecom providers |
| [[Sea Turtle]] | Targeted DNS registrars, telecom companies, and ISPs in supply chain |
| [[SolarWinds Compromise]] | APT29 used compromised cloud solution partner accounts and Mimecast certificates |

## Mitigations
- Implement strict access controls and least-privilege for third-party accounts
- Monitor and audit third-party account activity
- Segment networks to limit third-party lateral movement
- Require multi-factor authentication for privileged third-party access
- Maintain inventory of delegated permissions

## Detection
- Monitor for unusual activity from third-party accounts
- Track changes to delegated administrator permissions
- Alert on access from unexpected third-party sources
- Review cloud audit logs for suspicious partner actions

## References
- https://attack.mitre.org/techniques/T1199/

## Tags
#initial-access #supply-chain #third-party #trusted-relationship #cloud-security #office365

---
_Ingested: [[2026-04-15]] 22:02 | Source: https://attack.mitre.org/techniques/T1199/_
