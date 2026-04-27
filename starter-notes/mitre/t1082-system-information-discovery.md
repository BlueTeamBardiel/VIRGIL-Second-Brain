# T1082: System Information Discovery

Adversaries gather detailed information about operating systems and hardware (version, patches, hotfixes, service packs, architecture) to inform payload development, concealment decisions, and post-exploitation actions. This is distinct from [[Local Storage Discovery]].

## Overview

**Tactic:** [[Discovery]]
**Platforms:** ESXi, IaaS, Linux, Network Devices, Windows, macOS
**ID:** T1082 | **Version:** 3.0 | **Created:** 2017-05-31 | **Last Modified:** 2025-10-24

## Methods

- **Windows/Linux:** [[systeminfo]], command-line utilities
- **macOS:** [[systemsetup]] configuration tool (requires privileged access)
- **Network Devices:** Network Device CLI (e.g., `show version`)
- **ESXi:** [[esxcli]] utilities (`system hostname get`, `system version get`)
- **IaaS (AWS, GCP, Azure):** Authenticated API calls returning instance metadata, OS platform, VM model information

## Tools & Techniques

- [[Systeminfo]] – gather detailed system configuration
- [[systemsetup]] – macOS system data extraction
- IaaS APIs – cloud infrastructure reconnaissance
- esxcli utilities – hypervisor enumeration

## Related Concepts

- [[Discovery]] (parent tactic)
- [[Local Storage Discovery]] (sibling technique)
- Payload development and evasion planning

## Tags

#attack #discovery #t1082 #reconnaissance #osfingerprinting #iaas

---
_Ingested: [[2026-04-15]] 22:02 | Source: https://attack.mitre.org/techniques/T1082/_
