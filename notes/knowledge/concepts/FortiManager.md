# FortiManager

## What it is
Think of it as an air traffic control tower for a fleet of Fortinet firewalls — instead of each pilot (firewall) operating independently, one centralized controller coordinates all routing decisions and policy updates simultaneously. FortiManager is Fortinet's centralized network security management platform that allows administrators to configure, monitor, and push policy updates to hundreds of FortiGate firewalls from a single console. It supports both on-premises and cloud-based deployment models.

## Why it matters
In October 2024, threat actors exploited **CVE-2024-47575** (CVSS 9.8), a critical zero-day in FortiManager's FGFM daemon that allowed unauthenticated remote code execution — attackers registered rogue FortiGate devices to the manager and exfiltrated configuration files containing credentials and firewall policies. This incident illustrates the "blast radius" problem: compromise one management plane, and every downstream device it controls becomes a target. Defenders must treat management infrastructure as crown jewels, isolating it from general network access.

## Key facts
- FortiManager communicates with FortiGate devices over **port 541** using the FGFM (FortiGate-to-FortiManager) protocol
- CVE-2024-47575 required **zero authentication** to exploit — attackers only needed network access to the FGFM port
- Supports management of **FortiGate, FortiCarrier, and FortiSwitch** devices within a single pane of glass
- Uses **Administrative Domains (ADOMs)** to segment device management by geography, department, or customer — critical for MSSPs
- Compromise of FortiManager can expose **configuration backups, VPN credentials, and network topology** — a goldmine for lateral movement planning

## Related concepts
[[FortiGate]] [[Centralized Security Management]] [[CVE Exploitation]] [[Network Segmentation]] [[Privileged Access Management]]