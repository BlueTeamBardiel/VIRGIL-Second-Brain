# MAC address filtering

## What it is
Think of it like a nightclub bouncer with a guest list — only MAC addresses written on the list get through the door, everyone else is turned away. MAC address filtering is a network access control mechanism where a router or access point permits or denies devices based on their hardware-level Media Access Control (MAC) address. It operates at Layer 2 of the OSI model and is commonly used on wireless networks as an additional authentication layer.

## Why it matters
A network administrator at a small office enables MAC filtering on their Wi-Fi router, believing only their known laptops and phones can connect. An attacker runs `airodump-ng` to passively observe legitimate MAC addresses in the air, then uses `macchanger` to clone a trusted device's MAC address — bypassing the filter entirely within minutes. This illustrates why MAC filtering is considered a weak control and should never be relied upon as a primary security mechanism.

## Key facts
- MAC addresses are transmitted in **plaintext** in 802.11 wireless frames, making them trivially observable by passive sniffing
- MAC spoofing is built into most operating systems natively (e.g., `ip link set dev eth0 address XX:XX:XX:XX:XX:XX` on Linux) — no special tools required
- MAC filtering is classified as **security through obscurity** — it creates friction, not real security
- For Security+: MAC filtering is a **compensating control**, not a preventive one, and provides no protection against an attacker who can observe network traffic
- MAC addresses are **Layer 2 (Data Link)** identifiers and are not routable — they change at each network hop, which limits their usefulness beyond the local segment

## Related concepts
[[Network Access Control]] [[802.1X Authentication]] [[Wireless Security Protocols]] [[Packet Sniffing]] [[Spoofing Attacks]]