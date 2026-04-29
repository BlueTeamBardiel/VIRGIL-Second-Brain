# media-access-control

## What it is
Think of a MAC address like a serial number stamped onto a network card at the factory — unlike a street address (IP), which can change when you move, this hardware identifier is burned into the device itself. A Media Access Control (MAC) address is a 48-bit hardware identifier assigned to a network interface card (NIC), used by Layer 2 protocols (like Ethernet) to deliver frames within the same local network segment. The first 24 bits identify the manufacturer (OUI), and the last 24 bits are the unique device identifier.

## Why it matters
Attackers exploit MAC addresses through a technique called **MAC spoofing**, where they clone the MAC address of a trusted device to bypass network access controls — for example, defeating 802.1X port-based authentication or MAC address filtering on a wireless router. Defenders counter this by implementing dynamic ARP inspection (DAI) and 802.1X with certificate-based authentication, which makes spoofing alone insufficient to gain access.

## Key facts
- MAC addresses are written in six octets of hex: `AA:BB:CC:DD:EE:FF` (or with hyphens/dots depending on OS)
- **MAC filtering** is considered a weak control — it is trivially bypassed using tools like `macchanger` on Linux
- **ARP poisoning** attacks manipulate the mapping between IP addresses and MAC addresses to intercept traffic (MITM)
- MAC addresses operate at **OSI Layer 2** (Data Link layer) and are stripped and re-written at each router hop
- **CAM table overflow attacks** flood a switch with fake MACs to exhaust its memory, forcing it to broadcast traffic like a hub, enabling passive sniffing

## Related concepts
[[arp-poisoning]] [[802.1x-authentication]] [[network-access-control]]