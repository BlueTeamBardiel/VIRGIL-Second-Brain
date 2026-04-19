# T1498: Network Denial of Service

Adversaries perform Network DoS attacks to degrade or block availability of targeted resources. These attacks exhaust network bandwidth by flooding connections with malicious traffic, affecting websites, email services, DNS, and web applications.

## Overview

**ATT&CK ID:** T1498  
**Tactic:** [[Impact]]  
**Platforms:** Containers, IaaS, Linux, Windows, macOS  
**Impact Type:** Availability

## Description

Network DoS occurs when bandwidth capacity is exhausted through high-volume malicious traffic. A single attacker or distributed systems (DDoS) can send more traffic than the target's connection can handle (e.g., 10Gbps traffic to a 1Gbps connection).

Key techniques include:
- **IP address spoofing** — makes attacks harder to trace
- **Botnets** — distribute attack across multiple systems
- Exhaustion of network bandwidth services

## Sub-techniques

- [[T1498.001]] — Direct Network Flood
- [[T1498.002]] — Reflection Amplification

## Related

- For direct system attacks, see [[Endpoint Denial of Service]]

## Procedure Examples

| Actor/Tool | Description |
|---|---|
| [[APT28]] | Conducted DDoS attack against World Anti-Doping Agency (2016) |
| [[Lucifer]] (S0532) | Executes TCP, UDP, and HTTP DoS attacks |
| [[NKAbuse]] (S1107) | Multi-protocol network DoS capabilities |

## Mitigations

- **Filter Network Traffic** (M1037) — Filter malicious traffic before it reaches target capacity

## Tags

#attack #impact #dos #ddos #network #availability

---
_Ingested: [[2026-04-15]] 22:02 | Source: https://attack.mitre.org/techniques/T1498/_
