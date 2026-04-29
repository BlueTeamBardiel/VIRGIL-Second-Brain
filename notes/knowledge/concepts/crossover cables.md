# crossover cables

## What it is
Like two people talking by both speaking *and* listening at the same time — a crossover cable flips the transmit and receive wires so two similar devices can communicate directly without a middleman. Precisely, it's an Ethernet cable where the TX (transmit) pins on one end are wired to the RX (receive) pins on the other, enabling direct device-to-device connections (e.g., PC-to-PC or switch-to-switch) without a hub or switch.

## Why it matters
In a physical penetration test or insider threat scenario, an attacker with brief physical access can connect a laptop directly to a server or workstation using a crossover cable, bypassing network switches, monitoring infrastructure, and IDS/IPS sensors entirely. This creates a blind spot — traffic never traverses the monitored network, so SIEM and network taps see nothing. Defenders counter this by enforcing 802.1X port-based authentication and physically securing server room access.

## Key facts
- Crossover cables use the TIA/EIA 568-A standard on one end and 568-B on the other — the standard straight-through cable uses 568-B on *both* ends
- Modern switches and NICs with **Auto-MDI/MDIX** automatically detect and correct cable polarity, making crossover cables largely obsolete in contemporary networks — but legacy environments still use them
- A crossover cable is required for direct connections between: PC↔PC, switch↔switch, hub↔hub, and router↔router
- In exam contexts, crossover cable = "same type of device connecting directly"; straight-through = "different device types" (PC to switch)
- Knowing cable types is tested under **Network+ and Security+** in the domain of network infrastructure and physical security

## Related concepts
[[physical security]] [[network taps]] [[802.1X port authentication]] [[out-of-band management]] [[network segmentation]]