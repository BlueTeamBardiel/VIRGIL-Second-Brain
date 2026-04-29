# CAM Table

## What it is
Think of it like a seating chart a maître d' memorizes — "Table 7 is MAC address AA:BB:CC:DD:EE:FF, port 3" — so food goes directly to the right guest instead of being shouted across the whole restaurant. A Content Addressable Memory (CAM) table is a network switch's internal database that maps MAC addresses to specific physical ports, allowing frames to be forwarded only to the correct destination rather than flooded to all ports.

## Why it matters
In a **CAM table overflow attack** (MAC flooding), an attacker sends thousands of frames with spoofed, randomized MAC addresses, exhausting the table's finite memory. Once full, the switch can no longer learn new entries and degrades into behaving like a hub — broadcasting all traffic to every port — allowing the attacker to passively capture credentials, session tokens, or sensitive data traversing the network.

## Key facts
- CAM tables have a fixed memory limit; typical enterprise switches hold ~16,000–128,000 entries depending on hardware
- The attack tool **macof** (part of the dsniff suite) can generate ~155,000 MAC entries per minute, overwhelming most switches rapidly
- **Port security** is the primary defense — configuring a maximum number of allowed MAC addresses per port and setting violation actions (shutdown, restrict, protect)
- When a CAM table entry is not refreshed, it ages out after a default timer (commonly **300 seconds** on Cisco gear)
- Dynamic ARP Inspection (DAI) and 802.1X port authentication work alongside port security to harden Layer 2 environments against related attacks

## Related concepts
[[MAC Spoofing]] [[ARP Poisoning]] [[Port Security]] [[Layer 2 Attacks]] [[Network Sniffing]]