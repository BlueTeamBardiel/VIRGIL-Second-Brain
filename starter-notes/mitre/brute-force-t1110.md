# Brute Force (T1110)

Adversaries use brute force techniques to gain access to accounts by systematically guessing passwords or using obtained password hashes. This technique can occur at various breach stages and is often combined with other tactics like [[External Remote Services]] for initial access.

## Overview

**Tactic:** [[Credential Access]]

**ID:** T1110

**Platforms:** Containers, ESXi, IaaS, Identity Provider, Linux, Network Devices, Office Suite, SaaS, Windows, macOS

**Last Modified:** 24 October 2025

## Sub-techniques

- [[T1110.001]] - Password Guessing
- [[T1110.002]] - Password Cracking
- [[T1110.003]] - Password Spraying
- [[T1110.004]] - Credential Stuffing

## Description

Adversaries may brute force credentials via:
- Interactive service validation (real-time authentication attempts)
- Offline attacks against acquired password hashes or dumps
- Integration with [[OS Credential Dumping]], [[Account Discovery]], or [[Password Policy Discovery]] for informed guessing
- Combinations with [[External Remote Services]] during initial access

If location-based conditional access policies block login, adversaries may change infrastructure to match victim locations and bypass these controls.

## Related Techniques

- [[OS Credential Dumping]]
- [[Account Discovery]]
- [[Password Policy Discovery]]
- [[Valid Accounts]]
- [[External Remote Services]]

## Procedure Examples

Notable threat actors and tools:
- [[APT28]], [[APT38]], [[APT39]], [[APT41]] - Various brute force campaigns
- [[Sandworm Team]] - RPC authentication attacks (2016 Ukraine Electric Power Attack)
- [[Agrius]] - SMB brute forcing
- [[CrackMapExec]] - Network credential brute forcing
- [[Chaos]] - SSH service brute forcing
- [[Ncrack]] - Credential revelation tool

## Tags

#mitre-attack #credential-access #brute-force #T1110 #defense-evasion

---
_Ingested: [[2026-04-15]] 22:02 | Source: https://attack.mitre.org/techniques/T1110/_
