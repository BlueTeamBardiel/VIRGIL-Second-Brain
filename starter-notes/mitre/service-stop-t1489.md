# Service Stop (T1489)

Adversaries stop or disable services to render them unavailable, inhibit incident response, or facilitate data destruction. This [[ATT&CK]] technique (T1489) covers stopping critical services across Windows, Linux, macOS, ESXi, and IaaS platforms.

## Overview

**Tactic:** [[Impact]]
**Platforms:** ESXi, IaaS, Linux, Windows, macOS
**Impact Type:** Availability
**ID:** T1489
**Created:** 29 March 2019
**Last Modified:** 24 October 2025

## Description

Adversaries may accomplish service disruption by:
- Disabling individual high-value services (e.g., [[MSExchangeIS]]) to block access
- Stopping many or all services to render systems unusable
- Stopping services before [[Data Destruction]] or [[Data Encrypted for Impact]] operations on data stores ([[Exchange]], [[SQL Server]], [[ESXi]] VMs)
- Leveraging cloud APIs (e.g., AWS `DisableAPIServiceAccess`) to prevent service-linked role creation

## Known Malware & Groups

- **Ransomware families:** [[Akira]], [[Avaddon]], [[AvosLocker]], [[Babuk]], [[BlackByte 2.0]], [[BlackCat]], [[Cheerscrypt]], [[Clop]], [[Conti]], [[Cuba]], [[Diavol]], [[EKANS]], [[Embargo]], [[Hannotog]], [[HermeticWiper]], [[HotCroissant]], [[INC Ransomware]]
- **Threat Groups:** [[Indrik Spider]]
- **Methods:** [[Service Control Manager]] (SCM) API, `net stop`, `esxcli vm process kill`, [[PsExec]]

## Mitigation & Detection

- Monitor service stop commands and SCM API calls
- Restrict permissions on service management utilities
- Implement defense-in-depth for critical services

## Tags

#attack-technique #impact #malware #ransomware #service-disruption

---
_Ingested: [[2026-04-15]] 22:02 | Source: https://attack.mitre.org/techniques/T1489/_
