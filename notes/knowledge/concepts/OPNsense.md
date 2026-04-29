# OPNsense

## What it is
Like a Swiss Army knife bolted to your network's front door, OPNsense is an open-source firewall and routing platform built on FreeBSD's HardenedBSD fork. It provides stateful packet inspection, VPN termination, IDS/IPS, and traffic shaping through a unified web GUI, replacing expensive proprietary appliances like Cisco ASA or Palo Alto for budget-conscious organizations.

## Why it matters
A small business deploys OPNsense at their network perimeter and enables the Suricata-based IDS/IPS integration. When an attacker attempts a known exploit against an unpatched internal web server, OPNsense's inline IPS detects the malicious signature, drops the connection, and logs the source IP — stopping lateral movement before it begins, all without a $50,000 next-gen firewall license.

## Key facts
- Built on **HardenedBSD** (a security-hardened FreeBSD fork), giving it exploit mitigations like ASLR and SafeStack by default
- Integrates **Suricata** for IDS/IPS functionality — rules can be sourced from ET Open, Abuse.ch, or custom feeds
- Supports **WireGuard, OpenVPN, and IPsec** natively, making it a common VPN gateway in zero-trust perimeter designs
- **pfSense** is its direct fork ancestor; OPNsense branched in 2015 over licensing and code quality concerns — both appear in enterprise environments
- Weekly security updates and a plugin architecture (OPNsense "os-" plugins) allow feature expansion without compromising the base system integrity

## Related concepts
[[pfSense]] [[Suricata]] [[Stateful Packet Inspection]] [[IDS vs IPS]] [[Network Segmentation]] [[WireGuard]]