# STP Manipulation

## What it is
Imagine a highway authority that lets any driver submit a form claiming to own a faster road — and the entire traffic system instantly reroutes through that "road" without verification. Spanning Tree Protocol (STP) manipulation is a Layer 2 attack where an attacker injects crafted Bridge Protocol Data Units (BPDUs) to trick switches into electing a malicious device as the root bridge, forcing all VLAN traffic to flow through it. This gives the attacker a man-in-the-middle position on the entire switched network segment.

## Why it matters
An attacker with a laptop plugged into a wall port sends superior BPDUs with a lower bridge priority (e.g., priority 0), causing legitimate switches to recalculate the spanning tree topology and redirect all traffic through the attacker's machine. At that point, the attacker silently captures credentials, session tokens, or unencrypted data from every device on the network — without triggering any firewall alerts because the traffic is flowing "normally."

## Key facts
- STP was designed for loop prevention in 802.1D, not security — it has zero authentication by default
- **BPDU Guard** shuts down a port immediately if any BPDU is received on it; typically applied to access (end-user) ports
- **Root Guard** prevents a port from becoming a root port, protecting the legitimate root bridge from being displaced
- A successful STP attack grants full Layer 2 visibility — effective for ARP spoofing, credential harvesting, and session hijacking
- PortFast should always be paired with BPDU Guard; PortFast alone bypasses listening/learning states but does NOT block malicious BPDUs

## Related concepts
[[VLAN Hopping]] [[ARP Spoofing]] [[Man-in-the-Middle Attack]] [[802.1Q Trunking]]