# pfSense

## What it is
Think of pfSense as a Swiss Army knife stuffed inside a cardboard box PC — it turns commodity hardware into a full-featured network security appliance. Precisely, pfSense is an open-source firewall and router distribution based on FreeBSD, offering stateful packet inspection, VPN termination, traffic shaping, and IDS/IPS integration through a web-based GUI. It replaces expensive commercial appliances like Cisco ASA or Fortinet for small-to-medium environments.

## Why it matters
A small business uses pfSense as its perimeter firewall with Snort installed as an IDS package. When an attacker begins port-scanning the internal network after compromising a vendor's VPN credentials, pfSense's stateful firewall rules combined with Snort signatures detect the lateral movement pattern and block the offending IP — containing the breach before it reaches the domain controller.

## Key facts
- pfSense uses **stateful packet inspection (SPI)** by default, tracking the full state of TCP connections rather than just matching individual packets
- Supports **site-to-site and remote access VPNs** via OpenVPN and IPsec, making it relevant to network segmentation and remote access security controls
- Can host **Snort or Suricata** as add-on packages, transforming it from a pure firewall into a **NGFW/IDS-IPS hybrid**
- pfSense operates on the **defense-in-depth** principle; it is commonly deployed as a perimeter firewall, internal segmentation firewall, or DMZ boundary device
- Relevant to **CySA+ and Security+** topics including firewall rule management, network segmentation, VPN architecture, and traffic analysis

## Related concepts
[[Stateful Packet Inspection]] [[Network Segmentation]] [[Intrusion Detection System]] [[DMZ]] [[OpenVPN]]