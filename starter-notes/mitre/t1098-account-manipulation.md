# T1098 Account Manipulation

Adversaries manipulate accounts to maintain and/or elevate access to victim systems through credential modification, permission group changes, and actions that subvert security policies. Account manipulation requires sufficient permissions but can lead to privilege escalation.

## Overview
- **ID**: T1098
- **Tactics**: [[Persistence]], [[Privilege Escalation]]
- **Platforms**: Containers, ESXi, IaaS, Identity Provider, Linux, Network Devices, Office Suite, SaaS, Windows, macOS
- **Created**: 31 May 2017
- **Last Modified**: 24 October 2025
- **Version**: 2.8

## Sub-techniques
- [[T1098.001]] - Additional Cloud Credentials
- [[T1098.002]] - Additional Email Delegate Permissions
- [[T1098.003]] - Additional Cloud Roles
- [[T1098.004]] - SSH Authorized Keys
- [[T1098.005]] - Device Registration
- [[T1098.006]] - Additional Container Cluster Roles
- [[T1098.007]] - Additional Local or Domain Groups

## Common Techniques
- Modifying credentials or permission groups
- Iterative password updates to bypass duration policies
- Manipulating domain accounts and admin accounts
- Using [[Skeleton Key]] domain controller authentication bypass
- Abusing credential dumper tools like [[Mimikatz]]

## Known Threat Actors
- [[Scattered Spider]] - Added accounts to ESX Admins group for vSphere admin rights
- [[Lazarus Group]] - WhiskeyDelta-Two malware renames administrator accounts
- [[HAFNIUM]] - Granted privileges to domain accounts and reset default admin passwords
- [[Sandworm Team]] - Used sp_addlinkedsrvlogin in MS-SQL for cross-server account linking

## Mitigations
- **M1042**: Disable or remove unnecessary authentication and authorization mechanisms
- **M1032**: Implement [[Multi-factor Authentication]] for user and privileged accounts
- **M1030**: Network segmentation and firewall controls to limit access to critical systems
- **M1028**: Operating system configuration hardening

## Tags
#attack #persistence #privilege-escalation #account-compromise #credential-manipulation

---
_Ingested: [[2026-04-15]] 22:02 | Source: https://attack.mitre.org/techniques/T1098/_
