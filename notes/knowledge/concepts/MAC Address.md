# MAC Address

## What it is
Like a serial number stamped into a device at the factory — permanently etched, not assigned by anyone later — a MAC (Media Access Control) address is a 48-bit hardware identifier burned into a network interface card (NIC). It operates at Layer 2 (Data Link) of the OSI model and is used to deliver frames within a local network segment, not across routers.

## Why it matters
Attackers use **MAC spoofing** to impersonate a trusted device on a network — for example, cloning the MAC of an authorized workstation to bypass 802.1X port-based network access control (NAC). Defenders counter this by combining MAC filtering with certificate-based authentication, since MAC addresses alone are trivially forged with a single terminal command on any OS.

## Key facts
- Format is six pairs of hexadecimal octets (e.g., `00:1A:2B:3C:4D:5E`); the first three octets are the **OUI (Organizationally Unique Identifier)** identifying the manufacturer
- MAC addresses are **Layer 2** identifiers — they are stripped and rewritten at each router hop, meaning they never cross network boundaries
- **MAC spoofing** is a technique used in both rogue access point attacks and NAC bypass scenarios
- Modern OSes (iOS, Android, Windows 10+) implement **MAC randomization** by default for probe requests, complicating device tracking and rogue DHCP correlation
- Switches build **CAM tables** (Content Addressable Memory) mapping MACs to ports; flooding this table with fake MACs causes the switch to fail open and broadcast all traffic — a **MAC flooding attack**

## Related concepts
[[ARP Poisoning]] [[802.1X Authentication]] [[Network Access Control]] [[CAM Table Overflow]] [[OSI Model]]