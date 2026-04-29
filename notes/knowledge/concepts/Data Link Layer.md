# Data Link Layer

## What it is
Think of it like a postal worker who only knows how to deliver mail within your neighborhood — they don't know about cross-country routing, just the local street addresses. The Data Link Layer (OSI Layer 2) handles node-to-node delivery of frames within the same network segment using MAC addresses, providing error detection and managing access to the physical medium.

## Why it matters
ARP spoofing (ARP poisoning) operates entirely at Layer 2 — an attacker broadcasts fake ARP replies to poison neighboring devices' ARP caches, associating their own MAC address with a legitimate IP address. This allows a man-in-the-middle position on the local segment, intercepting traffic before it ever reaches Layer 3 routing. Tools like `arpwatch` or dynamic ARP inspection (DAI) on managed switches are the primary defenses.

## Key facts
- **Sublayers**: Divided into LLC (Logical Link Control) and MAC (Media Access Control) sublayers
- **MAC addresses** are 48-bit hardware identifiers (e.g., `00:1A:2B:3C:4D:5E`) used for local frame delivery — they are *not* routable across networks
- **Switches** operate at Layer 2 and use MAC address tables; **VLAN hopping** attacks exploit Layer 2 misconfiguration to jump between network segments
- **802.1X** port-based authentication lives at Layer 2, blocking unauthorized devices from accessing the network before they can reach upper layers
- **Ethernet frames** include a CRC/FCS field for error detection — not encryption or integrity protection, just transmission error checking

## Related concepts
[[ARP Spoofing]] [[MAC Address Flooding]] [[802.1X Authentication]] [[VLAN Security]] [[Man-in-the-Middle Attack]]