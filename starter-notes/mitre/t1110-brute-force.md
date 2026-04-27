# T1110 — Brute Force

Adversaries use brute force techniques to gain access to accounts when passwords are unknown or when password hashes are obtained. This technique involves systematically guessing passwords via service interaction or offline against previously acquired credential data.

## Overview

Brute forcing can occur at various points during a breach, often combined with:
- [[OS Credential Dumping]]
- [[Account Discovery]]
- [[Password Policy Discovery]]
- [[External Remote Services]] (for Initial Access)
- [[Valid Accounts]] (post-compromise)

Adversaries may also change infrastructure to bypass location-based conditional access policies.

## Sub-techniques

| ID | Name |
|----|-----------|
| [[T1110.001]] | Password Guessing |
| [[T1110.002]] | Password Cracking |
| [[T1110.003]] | Password Spraying |
| [[T1110.004]] | Credential Stuffing |

## Notable Groups & Tools

### Threat Groups
- [[APT28]], [[APT38]], [[APT39]], [[APT41]]
- [[Sandworm Team]] (2016 Ukraine Electric Power Attack)
- [[Agrius]], [[DarkVishnya]], [[Dragonfly]], [[Fox Kitten]], [[HEXANE]]

### Tools
- [[CrackMapExec]] — brute force credentials across network ranges
- [[Chaos]] — SSH brute force
- [[Ncrack]] — credential discovery
- [[GET2 Penetrator]]
- su-bruteforce
- Caterpillar WebShell

## Context

**Tactic:** [[Credential Access]]
**Platforms:** Containers, ESXi, IaaS, Identity Provider, Linux, Network Devices, Office Suite, SaaS, Windows, macOS
**Created:** 31 May 2017
**Last Modified:** 24 October 2025
**ID:** T1110
**Version:** 2.8

## Tags

#mitre-attack #credential-access #brute-force #password-attacks

---
_Ingested: [[2026-04-10]] 14:20 | Source: https://attack.mitre.org/techniques/T1110/_
