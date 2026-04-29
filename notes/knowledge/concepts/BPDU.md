# BPDU

## What it is
Think of BPDUs as the "I'm still here" heartbeat messages that switches whisper to each other to elect a traffic cop (the root bridge) and prevent loops on a network. Bridge Protocol Data Units are Layer 2 control frames used by the Spanning Tree Protocol (STP) to discover network topology, elect a root bridge, and block redundant paths that would otherwise cause broadcast storms. They are sent every 2 seconds by default and carry information like bridge ID, path cost, and port roles.

## Why it matters
An attacker on a guest VLAN can craft and inject malicious BPDUs to trigger a root bridge re-election — a technique called **STP manipulation** or a **BPDU injection attack**. By becoming the root bridge, the attacker forces traffic to flow through their device, enabling a man-in-the-middle position on a switched network without touching a single firewall rule. The defense is enabling **BPDU Guard** on access ports, which immediately shuts down (err-disables) any port that receives a BPDU, since end-user devices should never send them.

## Key facts
- BPDUs are sent to the multicast MAC address `01:80:C2:00:00:00` and are never forwarded by routers
- Default hello timer is **2 seconds**; max age is **20 seconds** before a topology change is assumed
- **BPDU Guard** shuts down access ports receiving BPDUs — critical on ports connected to end hosts
- **BPDU Filter** suppresses sending/receiving BPDUs on a port — use carefully, as it can re-enable loops
- STP manipulation attacks can grant an attacker **Layer 2 visibility** across VLANs sharing the same STP instance, making VLAN segmentation insufficient alone

## Related concepts
[[Spanning Tree Protocol]] [[VLAN Hopping]] [[Man-in-the-Middle Attack]] [[Network Segmentation]]