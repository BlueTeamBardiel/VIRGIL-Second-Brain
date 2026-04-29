# GNS3

## What it is
Like a flight simulator that lets pilots crash planes without real consequences, GNS3 is a network simulation platform that lets you build, configure, and break complex network topologies entirely in software. It emulates real router and switch hardware (Cisco IOS, Juniper, etc.) by running actual device images in virtual machines, making it functionally indistinguishable from physical lab equipment.

## Why it matters
Security professionals use GNS3 to safely rehearse attacks and defenses before touching production infrastructure. A red team preparing to exploit a BGP hijacking vulnerability can build a replica of a target's routing architecture in GNS3, test their attack chain, and verify that defensive ACLs actually block malicious route advertisements — all without risking a real network outage or triggering IDS alerts during practice.

## Key facts
- GNS3 integrates with **Wireshark** natively, allowing packet capture on any virtual link for traffic analysis and protocol inspection
- Supports **Docker containers** and **VMs** alongside emulated routers, enabling full-stack lab environments with attacker tools (Kali), firewalls (pfSense), and servers together
- Requires **actual IOS/firmware images** from Cisco and other vendors — GNS3 does not provide them, raising legal/licensing considerations relevant to compliance discussions
- Commonly used to practice **network segmentation**, **VLAN configuration**, and **firewall rule validation** — all testable domains in Security+ and CySA+
- Differs from **Packet Tracer** (Cisco's simplified simulator) by emulating real hardware behavior rather than approximating it, making it more accurate for security testing

## Related concepts
[[Network Segmentation]] [[Wireshark]] [[Packet Tracer]] [[Virtual Machines]] [[BGP Hijacking]]