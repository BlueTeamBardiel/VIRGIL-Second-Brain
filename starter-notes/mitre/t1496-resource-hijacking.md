# T1496: Resource Hijacking

Adversaries leverage co-opted system resources to complete resource-intensive tasks, impacting system and/or hosted service availability. This [[ATT&CK]] technique encompasses cryptocurrency mining, bandwidth resale, SMS pumping, and cloud service abuse.

## Overview

**Tactic:** [[Impact]]

**Platforms:** Containers, IaaS, Linux, SaaS, Windows, macOS

**Impact Type:** Availability

**ID:** T1496 | **Version:** 2.0 | **Last Modified:** 24 October 2025

## Sub-techniques

- **T1496.001** – [[Compute Hijacking]]: Mine cryptocurrency using co-opted compute resources
- **T1496.002** – [[Bandwidth Hijacking]]: Sell network bandwidth to proxy networks
- **T1496.003** – [[SMS Pumping]]: Generate SMS traffic for profit
- **T1496.004** – [[Cloud Service Hijacking]]: Abuse cloud-based messaging services for spam campaigns

## Common Attack Methods

- Leveraging compute resources for cryptocurrency mining
- Selling network bandwidth to proxy networks
- Generating SMS traffic for profit
- Abusing cloud messaging services to send large quantities of spam
- Combining multiple resource hijacking types simultaneously

## Mitigations

This technique cannot be easily mitigated with preventive controls as it abuses legitimate system features.

## Detection Strategy (DET0267)

| Analytic ID | Description |
|---|---|
| AN0741 | Persistent high CPU utilization with suspicious command-line execution (mining tools, obfuscated scripts) and outbound connections to mining/proxy networks |
| AN0742 | Abnormal CPU/memory usage by unauthorized processes with outbound connections to known mining pools or persistence via cron jobs/scripts |
| AN0743 | Background launch agents/daemons with high CPU use and network access to external mining services |
| AN0744 | Sudden spikes in cloud VM CPU usage with outbound traffic to mining pools and unauthorized instance creation |
| AN0745 | High CPU usage by unauthorized containers running mining binaries or public proxy tools |
| AN0746 | Abuse of cloud messaging platforms for mass spam or quota resource consumption |

## Tags

#attack #impact #resource-hijacking #cryptojacking #detection

---
_Ingested: [[2026-04-15]] 22:02 | Source: https://attack.mitre.org/techniques/T1496/_
