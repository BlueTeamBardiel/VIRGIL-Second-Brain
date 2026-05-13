# VLAN — Virtual LAN

## What it is

In **Metroid**, Samus can see the door but she can't open it. The red door needs missiles. The green door needs super missiles. The ice door needs the Ice Beam. You can stand in the room, look right at the next area, ping the door with your power beam all day — nothing happens. The map of Zebes isn't really one map. It's a stack of overlapping zones gated by what you're carrying, and progression means earning the right capability to enter each one.

That's exactly what a **VLAN** does — it takes one physical network and splits it into logical zones where you can see the wire but you can't talk across it without the right credentials and the right routing.

Technically: a **Virtual LAN** is a Layer-2 broadcast domain defined logically rather than physically. Switches tag Ethernet frames with a 12-bit VLAN ID (802.1Q) — values 1 through 4094 — and only ports configured for that VLAN see those frames. Hosts on VLAN 10 and hosts on VLAN 20 can be plugged into the same switch, the same patch panel, the same rack — but they live on different broadcast domains and can't reach each other without a Layer-3 device (router, L3 switch, firewall) doing inter-VLAN routing. The firewall is the door, and the ACL is the missile.

## Why it matters

VLANs are the cheapest, oldest, most reliable form of [[network segmentation]] in the playbook. Every enterprise network you will ever touch as a SOC analyst runs them. When the IR lead screams "isolate that segment" at 3am, they mean "drop the VLAN, shut the SVI, kill the trunk." If you don't know which VLAN your crown jewels live on, you can't contain anything.

CySA+ objective 1.1 lists network segmentation, infrastructure concepts, and zero trust as core architecture knowledge for security operations. VLANs sit underneath all three. They're the substrate that lets you say "the PCI [[cardholder data (CHD)]] environment is logically separated from the corporate user LAN" with a straight face during a [[PCI DSS]] audit.

They also matter because they fail in specific, testable ways. CompTIA will ask you about VLAN hopping. They will ask why the native VLAN matters. They will ask whether a flat /16 is segmentation (it isn't).

## Key facts

### How the tag works

The 802.1Q standard inserts a 4-byte tag into the Ethernet frame between the source MAC and the EtherType field. Inside that tag:

- **TPID** (Tag Protocol Identifier) — 0x8100, says "this is a tagged frame"
- **PCP** (Priority Code Point) — 3 bits, QoS priority 0–7
- **DEI** (Drop Eligible Indicator) — 1 bit
- **VID** (VLAN Identifier) — 12 bits, 0–4095. VID 0 and 4095 are reserved. **VID 1 is the default VLAN** and you should never leave anything important on it.

Frames leave a host untagged, hit an access port, and the switch slaps the tag on internally. When the frame leaves the switch on a **trunk port** toward another switch, the tag rides with it. When it exits an **access port** toward an end host, the tag is stripped off. End hosts almost never see tags. The tag lives between switches.

### Port modes

| Mode | What it carries | Where you see it |
|------|-----------------|------------------|
| **Access** | One VLAN, untagged toward host | User desk, printer, IP phone (sometimes with voice VLAN) |
| **Trunk** | Multiple VLANs, tagged (802.1Q) | Switch-to-switch, switch-to-firewall, switch-to-hypervisor |
| **Native VLAN** | The one untagged VLAN on a trunk | Default 1 — **change this** |
| **Voice VLAN** | Cisco-ism, lets a phone tag voice traffic while the PC behind it stays untagged | Desk phones |

### The native VLAN trap

On a trunk, exactly one VLAN is **native** — frames in that VLAN cross the trunk untagged. By default, that's VLAN 1. If an attacker plugs into an access port that's also VLAN 1, and the trunk's native VLAN is 1, they can craft a double-tagged frame (outer tag 1, inner tag 20) — the switch strips the outer tag because it matches the native, and forwards the inner-tagged frame into VLAN 20. This is **VLAN hopping (double-tagging attack)**.

Defense: set the native VLAN to an unused, dead-end VLAN ID (e.g., 999), put no access ports in it, and explicitly tag the native on the trunk (`vlan dot1q tag native`).

The other hopping flavor is **switch spoofing** — attacker negotiates DTP (Dynamic Trunking Protocol) with a misconfigured port and convinces the switch the attacker is a peer switch. Defense: disable DTP, hard-code access ports as access, hard-code trunks as trunk with no negotiation.

### Inter-VLAN routing

VLANs don't talk to each other on their own. To cross VLANs, traffic hits a Layer-3 device:

- **Router-on-a-stick** — one router interface, multiple sub-interfaces, one per VLAN
- **Layer-3 switch with SVIs** — Switched Virtual Interfaces, one IP per VLAN
- **Firewall on a trunk** — every inter-VLAN packet gets policy-inspected. This is what you want for security-relevant boundaries.

The firewall option is where VLANs stop being just network engineering and start being security architecture. If your [[PCI]] segment and your user segment are both behind SVIs on the same L3 switch with no ACLs, that's not segmentation — it's an org chart drawn in IP space.

### VLANs in the security architecture

| Use case | VLAN layout |
|----------|-------------|
| **User segmentation** | Finance VLAN, HR VLAN, Engineering VLAN — limits lateral broadcast scope |
| **Server segmentation** | DMZ VLAN, internal app VLAN, database VLAN — DB never talks to internet |
| **CHD / PCI scope reduction** | Cardholder VLAN behind firewall — anything outside it is out of audit scope |
| **OT/ICS isolation** | SCADA VLAN with strict egress, no internet routing |
| **Guest/BYOD** | Captive-portal VLAN, internet-only, no internal routing |
| **Management** | Switch/firewall mgmt interfaces on a dedicated, unrouted VLAN — out-of-band |
| **Voice** | VoIP VLAN with QoS priority |

### CompTIA exam traps

> **CompTIA exam trap:** A flat network with multiple subnets is not segmentation. Subnets are Layer 3; VLANs are Layer 2. Two subnets on the same VLAN share a broadcast domain. Two VLANs without an ACL between them at the L3 boundary are routed and reachable. Segmentation requires both **logical separation** (VLAN) and **enforced policy** (ACL or firewall rule).

> **CompTIA exam trap:** VLAN 1 is the default VLAN and the default native VLAN. CompTIA loves to ask about hardening. The answer is: move all access ports off VLAN 1, set the trunk native to an unused VLAN, and disable DTP. "Leave it on default" is always wrong on the exam.

> **CompTIA exam trap:** VLAN hopping has two forms. **Double-tagging** exploits the native VLAN — one-way attack, attacker can send but not easily receive. **Switch spoofing** exploits DTP auto-negotiation — full bidirectional access. Know which defense addresses which attack.

> **CompTIA exam trap:** VLANs are not a substitute for [[zero trust]]. A VLAN trusts every host inside it implicitly — same broadcast domain, same ARP table, same Layer-2 reachability. Zero trust assumes the host next to you on the same VLAN is hostile. The exam-correct answer when asked "best segmentation for sensitive data" is usually **microsegmentation** (per-host policy, often [[SDN]]-driven), not VLANs alone.

### VLAN vs VXLAN vs microsegmentation

- **VLAN** — 4094 usable IDs, Layer 2, single-site or stretched with effort. Cheap, universal, limited scale.
- **VXLAN** — encapsulates Ethernet over UDP, 24-bit VNI (16M segments), scales across data centers. The cloud and modern DC standard. Often paired with [[SDN]] controllers.
- **Microsegmentation** — policy follows the workload, not the wire. Enforced at the hypervisor (NSX, Hyper-V) or the host agent (Illumio, [[zero trust]] platforms). Default-deny between every pair of hosts.

VLANs are the floor. VXLAN scales them. Microsegmentation replaces the trust model entirely.

## SOC reality

- **Containment call sounds like:** "Move the host to the quarantine VLAN" — usually VLAN 666 or some agreed dead-end with internet-deny and a forensic-imaging server reachable. The NAC tool or the switch admin shuts the port or reassigns it. If your IR plan doesn't name the quarantine VLAN, write one tonight.
- **The 3am alert:** EDR fires on a suspicious binary on a finance workstation. First L1 questions: what VLAN is it on, what else is in that VLAN, is the VLAN routed to the DB segment. You answer those three in IPAM and the firewall config — not by guessing.
- **The CISO question after a breach:** "Was the cardholder data segment isolated?" The honest answer is rarely yes — it's "logically yes, via VLAN 50 behind firewall rule set X, but VLAN 50 trunks across switches A/B/C and we have not audited the trunk configs in 14 months." Write that down before you need it.
- **What never to promise:** "The VLAN is air-gapped." VLANs are not air gaps. A misconfigured trunk, a rogue L3 SVI, a server with two NICs in two VLANs — any of these collapse the boundary. If leadership asks for air gap, they need physical separation, not 802.1Q.
- **Handoff to network engineering:** SOC owns "what traffic is suspicious." NetEng owns the trunk, the native VLAN, the SVI, the ACL. If you don't have a standing relationship and a shared change window for emergency VLAN moves, your containment SLA is fiction.

*Segmentation is the bones of the network. VLANs are the cheapest bones you can buy, and like all cheap bones, they break if you don't maintain them.*

## Related concepts

[[Network segmentation]] · [[Zero trust]] · [[SDN]] · [[Microsegmentation]] · [[Firewall ACL]] · [[802.1X]] · [[NAC]] · [[DMZ]] · [[VXLAN]] · [[Lateral movement]] · [[Cardholder data (CHD)]] · [[PCI DSS]] · [[Containment]] · [[Out-of-band management]]

*Source: VIRGIL knowledge base — 2026-05-11*