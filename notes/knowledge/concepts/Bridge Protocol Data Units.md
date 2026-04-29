# Bridge Protocol Data Units

## What it is
Think of BPDUs as the gossipy town criers of a switched network — constantly circulating announcements about who holds authority over the roads (network paths). A Bridge Protocol Data Unit is a control frame used by the Spanning Tree Protocol (STP) to elect a Root Bridge and calculate loop-free paths across Layer 2 networks. BPDUs are sent every 2 seconds by default and carry information like Bridge ID, path cost, and port roles.

## Why it matters
An attacker on a corporate LAN can craft malicious BPDUs with a superior Bridge ID to force their machine to be elected as the Root Bridge — a classic attack called STP manipulation or "Root Bridge hijacking." Once elected, all traffic flows through the attacker's device, enabling trivial man-in-the-middle interception without any ARP spoofing required. Defending against this means enabling **BPDU Guard** on access ports, which shuts down any port that receives an unexpected BPDU.

## Key facts
- BPDUs are sent to the multicast MAC address `01:80:C2:00:00:00` and are never forwarded by properly configured switches
- Two types exist: **Configuration BPDUs** (path election) and **Topology Change Notification (TCN) BPDUs** (alerting the network to topology changes)
- **BPDU Guard** disables a port (err-disable state) immediately upon receiving any BPDU — critical protection for end-user access ports
- **BPDU Filter** suppresses BPDU sending/receiving on a port entirely — useful but dangerous if misconfigured, as it can re-introduce loops
- Root Bridge election is won by the switch with the **lowest Bridge ID** (priority + MAC address), making default priority values an easy attack vector

## Related concepts
[[Spanning Tree Protocol]] [[VLAN Hopping]] [[Man-in-the-Middle Attacks]]