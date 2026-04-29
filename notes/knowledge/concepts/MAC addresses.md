# MAC addresses

## What it is
Think of a MAC address like a serial number stamped into a device's network card at the factory — unlike an IP address (which is like a hotel room number that changes), the MAC address is supposed to be permanently burned in hardware. Precisely, a Media Access Control (MAC) address is a 48-bit (6-byte) hardware identifier assigned to a network interface card (NIC), expressed as six pairs of hexadecimal digits (e.g., `00:1A:2B:3C:4D:5E`). The first three bytes identify the manufacturer (OUI — Organizationally Unique Identifier), and the last three bytes are device-specific.

## Why it matters
Attackers use **MAC spoofing** to bypass network access controls — for example, if a corporate switch uses MAC filtering to allow only approved devices, an attacker can sniff the network, capture a legitimate device's MAC address, and clone it onto their own NIC to gain unauthorized access. Defenders counter this by combining MAC filtering with 802.1X port-based authentication, which requires cryptographic credentials rather than trusting a spoofable identifier alone.

## Key facts
- MAC addresses operate at **Layer 2 (Data Link)** of the OSI model; IP addresses operate at Layer 3
- The first 3 bytes are the **OUI (Organizationally Unique Identifier)** — useful in forensics to identify device manufacturers
- MAC addresses are **only relevant within a local network segment** — routers strip and rewrite them at each hop
- **MAC spoofing** is trivial on most operating systems (one terminal command) — making MAC-only filtering a weak control
- ARP poisoning attacks exploit the MAC-to-IP mapping process to redirect traffic at Layer 2

## Related concepts
[[ARP Poisoning]] [[802.1X Authentication]] [[Network Access Control]] [[OSI Model]] [[Packet Sniffing]]