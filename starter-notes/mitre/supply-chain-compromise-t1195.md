# Supply Chain Compromise (T1195)

Adversaries manipulate products or delivery mechanisms before reaching final consumers to compromise data or systems. This ATT&CK technique covers attacks across the entire supply chain, from development tools to hardware distribution.

## Overview

**Tactic:** Initial Access
**Platforms:** Linux, SaaS, Windows, macOS
**ID:** T1195
**Created:** 18 April 2018
**Last Modified:** 24 October 2025

## Attack Vectors

Supply chain compromise can occur at multiple stages:

- Manipulation of [[development tools]] and environments
- Compromised [[source code repositories]] (public or private)
- Malicious code injected into [[open-source dependencies]]
- Tampered [[software update mechanisms]]
- Factory-infected system images on removable media
- Replacement of legitimate software with modified versions
- Counterfeit products sold to legitimate distributors
- Shipment interdiction

## Attack Patterns

Adversaries often focus on malicious additions to legitimate software in distribution or update channels. Targeting may be:
- **Selective:** Limited to specific victim sets
- **Broad:** Distributed widely with selective follow-up on targets
- **Second-order:** Leveraging initial compromise to further compromise downstream components, spreading impact to additional victims

Open-source projects used as dependencies in many applications are attractive targets for adding malicious code to large user bases.

## Sub-techniques

- **T1195.001:** Compromise Software Dependencies and Development Tools
- **T1195.002:** Compromise Software Supply Chain
- **T1195.003:** Compromise Hardware Supply Chain

## Associated Groups & Malware

| Entity | Type | Notes |
|--------|------|-------|
| [[Ember Bear]] | Group | Compromised IT providers and software developers serving target organizations |
| [[Lumma Stealer]] | Malware | Delivered via cracked software downloads |
| [[OilRig]] | Group | Leveraged compromised organizations for supply chain attacks on government entities |
| [[Raccoon Stealer]] | Malware | Distributed through cracked software downloads |
| [[Sandworm Team]] | Group | Staged compromised software installers on forums for untargeted initial access |

## Mitigations

**M1013 — Application Developer Guidance:** Developers should carefully vet third-party libraries before integration and lock software dependencies to specific versions where possible.

## Tags

#attack #initial-access #supply-chain #software #hardware #mitre-att&ck

---
_Ingested: [[2026-04-15]] 22:02 | Source: https://attack.mitre.org/techniques/T1195/_
