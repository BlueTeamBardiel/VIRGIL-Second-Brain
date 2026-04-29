# MAC Flooding

## What it is
Imagine cramming a restaurant's reservation book with thousands of fake names until the host gives up and just seats everyone anywhere — that's MAC flooding. An attacker sends thousands of fake MAC address frames into a switch, exhausting its Content Addressable Memory (CAM) table, which forces the switch to broadcast all traffic out every port like a hub.

## Why it matters
An attacker on a switched network uses a tool like `macof` (part of the dsniff suite) to flood the CAM table with ~155,000 fake entries per minute. Once the table overflows, the switch enters "fail-open" mode, broadcasting unicast frames to all ports — allowing the attacker to run Wireshark and capture credentials, session tokens, or PII from other users' traffic.

## Key facts
- The CAM table stores MAC-to-port mappings; typical tables hold 4,000–16,000 entries before overflowing
- MAC flooding enables **passive eavesdropping** on a switched network by degrading it to hub behavior
- Primary defense is **Port Security** on managed switches — limiting the number of MACs allowed per port (e.g., `switchport port-security maximum 2`)
- **Dynamic ARP Inspection (DAI)** and **802.1X port-based authentication** further harden switch infrastructure against layer 2 attacks
- MAC flooding is a **Layer 2 attack** in the OSI model and is a precursor technique often used before ARP poisoning

## Related concepts
[[ARP Poisoning]] [[Port Security]] [[CAM Table]] [[Network Sniffing]] [[VLAN Hopping]]