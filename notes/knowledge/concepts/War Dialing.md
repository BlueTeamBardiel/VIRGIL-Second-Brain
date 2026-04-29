# War Dialing

## What it is
Like a fisherman dragging a net across the entire ocean floor instead of casting a single line, war dialing systematically calls every phone number in a range to find modems, fax machines, or other dial-up systems that answer. It is an automated reconnaissance technique that scans telephone number ranges by dialing sequentially, cataloging any numbers that respond with a carrier tone indicating a computer or modem on the other end.

## Why it matters
In the 1990s and early 2000s, corporations often installed rogue or forgotten modems on employee workstations for remote access, completely bypassing the organization's hardened network perimeter. An attacker using a tool like ToneLoc or THC-SCAN could discover these "back doors" and gain unauthorized access to internal systems that never touched the internet-facing firewall — essentially walking through the side door of a vault while security watched the front.

## Key facts
- Named after the 1983 film *WarGames*, where the character David Lightman uses the technique to find a military computer
- Classic tools include **ToneLoc** (DOS-based) and **THC-SCAN**; modern equivalent is **WarVOX**, which works over VoIP
- Targets **POTS (Plain Old Telephone Service)** lines and identifies carrier tones, voicemail systems, PBX entry points, and fax machines
- Represents a **physical/logical perimeter bypass** — modems could circumvent firewalls entirely, making them a critical audit target
- Still relevant for **PCI-DSS compliance audits**, which require organizations to inventory and control all modem connections to cardholder data environments

## Related concepts
[[War Driving]] [[Footprinting]] [[PBX Hacking]] [[OSINT]] [[Network Enumeration]]