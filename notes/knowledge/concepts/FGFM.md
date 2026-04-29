# FGFM

## What it is
Like a master key that silently copies itself onto every keyring in a building without the locksmith's knowledge, FGFM (Forged GitHub Flow Manipulation) — more precisely known in threat intelligence as **Fake Global Forwarding Module** or, in its most documented context, **FortiGate FortiManager** exploitation — refers to a critical authentication bypass vulnerability (CVE-2024-47575) allowing unauthenticated remote code execution against Fortinet's FortiManager centralized management platform. An attacker can register a rogue FortiGate device to a target FortiManager instance using a spoofed but valid-format serial number, gaining full management-plane access.

## Why it matters
In late 2024, threat actors exploited CVE-2024-47575 (nicknamed "FortiJump") at scale against managed security service providers (MSSPs), leveraging compromised FortiManager consoles to push malicious configurations to thousands of downstream FortiGate firewalls simultaneously. Because FortiManager sits above the devices it controls, one foothold effectively handed attackers the keys to entire enterprise network perimeters across multiple organizations.

## Key facts
- **CVE-2024-47575** carries a CVSS score of **9.8 (Critical)** — unauthenticated, network-exploitable, no user interaction required.
- The attack abuses the **FGFM protocol** (FortiGate-to-FortiManager), which uses TCP port **541** for device registration and communication.
- Attackers only need a **valid FortiGate serial number format** (not a legitimately registered device) to initiate the rogue registration.
- Indicators of compromise include unauthorized entries in `/var/log/fortimanager/` and unexpected device registrations in the FortiManager device list.
- Mitigation includes restricting port 541 access via allowlists, enabling **"unknown device" rejection** policies, and patching to FortiManager 7.6.1+ or equivalent.

## Related concepts
[[Fortinet CVE-2024-47575]] [[Management Plane Security]] [[Lateral Movement]] [[Centralized Management Exploitation]] [[Authentication Bypass]]