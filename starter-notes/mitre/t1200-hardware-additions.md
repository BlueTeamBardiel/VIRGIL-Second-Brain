# T1200: Hardware Additions

Adversaries may physically introduce computer accessories, networking hardware, or other computing devices into a system or network as an initial access vector. These hardware additions enable attackers to introduce new functionalities—such as passive network tapping, keystroke injection, DMA attacks, or wireless access points—that can be abused to compromise systems.

## Overview

**Tactic:** Initial Access
**Platforms:** Linux, Windows, macOS
**ID:** T1200
**Created:** 18 April 2018
**Last Modified:** 24 October 2025

## Attack Description

While red teams and penetration testers frequently leverage hardware additions, public threat actor examples remain limited. Attackers may use:

- Keystroke injection devices
- [[DMA]] (Direct Memory Access) readers via kernel memory
- [[Man-in-the-Middle|Adversary-in-the-Middle]] network modification tools
- Wireless access point injection
- Passive network tapping hardware

This technique differs from [[Replication Through Removable Media]] by introducing persistent or interactive hardware capabilities rather than merely distributing payloads.

## Threat Actor Examples

| Actor | Method |
|-------|--------|
| [[DarkVishnya]] | Physically connected [[Bash Bunny]], [[Raspberry Pi]], netbooks, and inexpensive laptops to target network infrastructure for local network access |

## Mitigations

- **M1035 — Limit Access to Resource Over Network:** Use device certificates and [[802.1x]] standard; restrict DHCP to registered devices only
- **M1034 — Limit Hardware Installation:** Block unknown devices via endpoint security configuration and monitoring agents

## Detection Strategy

### DET0069 — Unauthorized Hardware Additions

**AN0185 (Windows):** Monitor for (1) new USB/Thunderbolt/PCIe device recognition; (2) process spawning or volume mounting within short window; (3) HID keystroke injection, DMA driver load, or new network MAC on DHCP. Correlate Security EID 6416, Kernel-PnP, sysmon, and DHCP metadata.

**AN0186 (Linux):** Monitor (1) udev/kernel hot-plug logs; (2) udisks block device creation; (3) new network interface or DHCP lease. Correlate /var/log/messages, auditd SYSCALL events on /dev, and DHCP/Zeek.

**AN0187 (macOS):** Monitor (1) unified logs for IOUSBHost/IOThunderbolt device arrival; (2) diskarbitrationd volume attachment; (3) config profile manipulation or new network MAC DHCP lease. Correlate unified logs.

## Tags

#attack #t1200 #initial-access #hardware #physical-security #persistence #detection

---
_Ingested: [[2026-04-15]] 22:02 | Source: https://attack.mitre.org/techniques/T1200/_
