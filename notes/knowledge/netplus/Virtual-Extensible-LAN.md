# Virtual Extensible LAN

## What it is

In **Persona 5**, the Phantom Thieves enter the Metaverse and walk through Palaces — entire cognitive worlds layered on top of regular Tokyo. To a salaryman on the street, nothing exists. To Joker holding the Meta-Nav, there's a castle, a pyramid, a casino — fully realized Layer 2 worlds tunneled on top of the same physical city. The subway underneath is just transport. The Palace on top is its own self-contained reality with its own rules, residents, and exits.

That's exactly what **VXLAN** does — it builds entire Layer 2 networks on top of an existing Layer 3 network, so a VM in Dallas and a VM in Frankfurt can think they're on the same LAN even though they're separated by the real internet.

**Technical definition:** Virtual Extensible LAN (VXLAN) is a Layer 2 overlay technology defined in RFC 7348 that encapsulates Ethernet frames inside UDP packets (destination port 4789) and tunnels them across a Layer 3 underlay. It uses a 24-bit VXLAN Network Identifier (VNI), allowing ~16 million segments versus the 4,094-segment ceiling of traditional 802.1Q VLANs.

## Why it matters

Traditional [[VLAN]]s ran out of room. 12 bits of VLAN ID = 4,094 usable segments. Fine for one company. A disaster for a cloud provider running thousands of tenants on shared hardware. VXLAN gives you 16 million segments and lets you stretch a Layer 2 broadcast domain across data centers without lighting metro Ethernet on fire.

This is the **data center interconnect (DCI)** problem. You have VMs in two facilities. You want to vMotion a VM from one to the other without changing its IP. You need them on the same broadcast domain. Running an actual L2 cable between data centers is fragile, expensive, and propagates broadcast storms across cities. VXLAN tunnels the L2 traffic inside L3, so the underlay can be anything — MPLS, the public internet, a private fiber ring. **Transport agnostic.**

For N10-009 (Objective 1.8), VXLAN shows up as one of the cornerstone evolving-use-case technologies alongside [[SDN]], [[Zero Trust Architecture]], and [[SASE]]. CompTIA wants you to know what it is, what it solves, and which port it uses.

## Key facts

### The encapsulation

VXLAN wraps an entire Ethernet frame inside UDP. The full stack on the wire:

| Layer | Header |
|---|---|
| Outer | Ethernet (underlay MAC) |
| Outer | IP (underlay routing) |
| Outer | **UDP — destination port 4789** |
| Overlay | **VXLAN header (24-bit VNI)** |
| Inner | Original Ethernet frame (with its own 802.1Q tag if present) |
| Inner | Original IP, TCP/UDP, payload |

The overhead is ~50 bytes. This is why VXLAN environments care about jumbo frames (MTU 9000) on the underlay — you don't want fragmentation eating performance.

### VTEP — the tunnel endpoint

A **VTEP (VXLAN Tunnel Endpoint)** is the device that wraps and unwraps VXLAN traffic. It can be a physical switch (hardware VTEP) or a hypervisor's virtual switch (software VTEP). The VTEP has a real IP on the underlay. When a VM sends a frame to another VM in the same VNI but on a different host, the local VTEP encapsulates it, sends it as a UDP packet to the remote VTEP's IP, and the remote VTEP unwraps it and delivers the original frame.

The VMs never know the L3 underlay exists. To them it's a flat LAN. Just like the Phantom Thieves don't worry about which Tokyo subway line is under their feet when they're in a Palace.

### VNI vs VLAN ID

| | VLAN | VXLAN |
|---|---|---|
| ID bits | 12 | **24** |
| Max segments | 4,094 | **~16 million** |
| Scope | Single broadcast domain on L2 | L2 overlay across L3 underlay |
| Defined by | 802.1Q | RFC 7348 |
| Encapsulation | Tag inserted into Ethernet frame | Full Ethernet frame wrapped in UDP |

### Where VXLAN actually lives

- **Cloud providers** — AWS, Azure, GCP use VXLAN (or close variants like Geneve) to isolate tenant networks on shared physical fabric
- **Spine-leaf data centers** — L3 routed underlay with VXLAN overlay is the standard modern design; replaces the legacy core-distribution-access L2 spaghetti
- **Data center interconnect** — stretching subnets between sites for VM mobility and disaster recovery
- **EVPN-VXLAN** — BGP EVPN as the control plane for MAC address learning across VTEPs, replacing flood-and-learn

### How VXLAN fits the modern network stack

VXLAN doesn't live alone. It's part of a family of technologies CompTIA groups under "evolving use cases":

- **[[Software-Defined Networking|SDN]]** — VXLAN is the data plane underlay/overlay separation; SDN controllers (NSX, ACI) program VTEPs centrally
- **[[Infrastructure as Code|IaC]]** — VXLAN fabrics are deployed via Ansible, Terraform; the entire fabric config lives in git
- **Zero-touch provisioning (ZTP)** — new leaf switches PXE-boot, pull config from a central repo, join the VXLAN fabric without a human plugging in a console cable
- **Central policy management** — one controller pushes VNI mappings, ACLs, and segmentation policy across thousands of VTEPs
- **[[Configuration drift]] / compliance** — IaC pipelines detect when a switch's running config diverges from the source-of-truth in git
- **Source control / version control / branching** — the network engineer's git workflow: branch, change, peer-review pull request, merge, CI/CD pipeline pushes to fabric

### VXLAN and IPv6

VXLAN runs on whatever underlay you have. **Dual stack** environments tunnel both IPv4 and IPv6 inside the overlay frames. The 24-bit VNI also helps with **address exhaustion mitigation** indirectly — you can run overlapping IPv4 spaces in different VNIs because they're isolated broadcast domains. Tenant A's 10.0.0.0/8 and Tenant B's 10.0.0.0/8 never see each other. **NAT64** can sit at the overlay edge to translate between IPv6-only overlays and legacy IPv4 services.

### CompTIA exam traps

> **CompTIA exam trap:** VXLAN uses **UDP port 4789**, not TCP. CompTIA loves protocol/port confusion. The legacy/Linux default was sometimes 8472 (pre-standardization); the IANA-registered standard port is 4789. Pick 4789 on the exam.

> **CompTIA exam trap:** VXLAN is **Layer 2 encapsulation transported over Layer 3**. If the question asks "what layer does VXLAN operate at," the answer depends on framing — it carries L2 frames (overlay is L2) but the tunnel itself runs over L3/UDP. CompTIA usually wants "L2 over L3" or specifically "Layer 2 encapsulation."

> **CompTIA exam trap:** VNI is **24 bits = ~16 million**, VLAN is **12 bits = 4,094**. Memorize both numbers. The "why VXLAN exists" question almost always points to scaling past the 4,094 VLAN limit.

> **CompTIA exam trap:** VXLAN is **transport agnostic** — it doesn't care what's under it. Don't pick "VXLAN requires MPLS" or "VXLAN requires a dedicated fiber link." Wrong. It needs IP reachability between VTEPs. That's it.

## The multiplayer angle — why this maps to gaming

Think about how Discord works. You and your raid group are on a private voice channel. Underneath, your packets are flowing over the public internet through dozens of routers you'll never see. Discord doesn't care which ISP you have. The voice channel is the overlay. The internet is the underlay. You're isolated from the guild next door even though you're sharing the same physical infrastructure.

VXLAN is that, but for entire Ethernet networks. Two VMs on a private overlay don't know — and don't need to know — that their "LAN cable" is actually a UDP tunnel across three data centers.

*The first time you see a vMotion happen across a WAN link with zero packet loss because VXLAN is doing the heavy lifting, you understand why nobody runs flat L2 between sites anymore.*

## Helpdesk reality

You will not configure VXLAN on a tier-1 helpdesk shift. You will, however:

- Get tickets that say "my VM can't reach the other VM" when the actual problem is a VTEP misconfiguration two layers above you. Escalate to network engineering with the source/destination IPs and VNI if you can find it.
- See `udp/4789` show up on firewall logs and need to recognize it as VXLAN, not malware.
- Hear sentences like *"we need to stretch this VLAN to the DR site"* and know that means VXLAN, EVPN, or some flavor of L2 DCI — not literally running a cable.
- Never promise an L2 stretch across sites is "the same as local." Latency between sites still exists; broadcast storms still propagate inside a VNI. **VXLAN moves the problem, it doesn't delete it.**
- If a hypervisor host loses connectivity to its VTEP peers, every VM on it goes dark for east-west traffic — even though the underlay shows green. Check overlay before you blame the physical switch.

## Related concepts

[[VLAN]] · [[Software-Defined Networking]] · [[Infrastructure as Code]] · [[Zero Trust Architecture]] · [[SASE]] · [[Tunneling]] · [[GRE]] · [[MPLS]] · [[Spine-Leaf Architecture]] · [[Data Center Interconnect]] · [[IPv6 Addressing]] · [[Dual Stack]] · [[NAT64]] · [[Configuration Drift]] · [[Central Policy Management]] · [[Zero-Touch Provisioning]]

*Source: VIRGIL knowledge base — 2026-05-11*