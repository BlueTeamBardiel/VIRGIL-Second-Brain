# Segmentation Enforcement

## What it is

In **Call of Duty: Modern Warfare**, the mission *Clean House* drops you into a dark London flat with night vision and an MP5. The building is segmented by design — rooms, hallways, stairwells, doors. You clear room by room because the layout *forces* engagements into small, controllable boxes. You never fight the whole building at once. If a hostile breaches one room, the walls and doors give you time to contain it before it spreads to the next floor. That's exactly what network segmentation enforcement does — it carves the network into rooms so a breach in one doesn't compromise the whole building.

**Plain English:** segmentation enforcement is the set of controls that *actually keep traffic from crossing between network zones*. Drawing the segments on a diagram is design. Enforcing them with VLANs, ACLs, firewalls, and policy is enforcement. The exam loves this distinction.

**Technical (N10-009 4.1):** network segmentation enforcement is the application of logical and physical controls — VLANs, [[Subnetting]], [[ACLs]], firewall rules, private VLANs, micro-segmentation, and air-gaps — that restrict communication between defined security zones. Enforcement points are at Layer 2 (VLAN tagging, port security), Layer 3 (routing controls, ACLs), and Layer 7 (next-gen firewall application policies). The goal is to limit lateral movement, contain blast radius, and reduce the attack surface available to any single compromised host.

## Why it matters

Flat networks die loud. One compromised IoT camera on the same broadcast domain as your domain controllers means the attacker pivots in minutes. Segmentation enforcement is what makes the difference between *"one workstation got ransomware"* and *"the entire hospital is on paper charts for two weeks."*

For the **N10-009 exam**, Objective 4.1 lists segmentation enforcement explicitly alongside [[Least Privilege]], the [[CIA Triad]], and physical security. CompTIA tests this as a *defense-in-depth* concept — they want you to recognize that segmentation is one layer, not the whole strategy.

For your career: every audit framework — **[[PCI DSS]]**, **[[HIPAA]]**, **[[GDPR]]** — requires segmentation. PCI DSS in particular reduces audit scope dramatically if cardholder data lives in a properly segmented zone. Fail the segmentation test and your entire corporate network becomes "in scope" for the audit. That's a million-dollar mistake.

*Segmentation enforcement is the difference between a fire in one room and a fire in the whole building.*

## Key facts

### The zones you'll actually segment

| Zone | What lives here | Why isolate it |
|------|-----------------|----------------|
| **User LAN** | Employee workstations | Largest attack surface — phishing victims live here |
| **Server / DC** | Domain controllers, file servers, databases | The crown jewels |
| **DMZ** | Public-facing web, mail relay, reverse proxies | Internet-exposed = assumed-hostile |
| **Guest** | Visitor Wi-Fi, BYOD | Untrusted devices, no business traffic ever |
| **[[IoT]] / [[IIoT]]** | Cameras, badge readers, smart thermostats | Vendors patch these never |
| **[[OT]] / [[SCADA]] / [[ICS]]** | PLCs, HMIs, plant floor | Cannot tolerate scans, cannot be patched on a normal cycle |
| **Management** | Switch/router mgmt IPs, iLO/iDRAC, vCenter | Compromise here = total network ownership |
| **PCI / cardholder** | POS terminals, payment processors | Scoped for [[PCI DSS]] audit |

### Layer 2 enforcement — VLANs and port controls

- **VLANs** ([[802.1Q]]) tag frames so a switch knows which broadcast domain a port belongs to. Same physical switch, multiple logical networks.
- **Private VLANs (PVLANs)** isolate hosts *within* the same VLAN — guest Wi-Fi clients can reach the gateway but not each other.
- **Port security** locks a switchport to specific MAC addresses. Useful at the edge but trivially bypassed by a determined attacker — *don't rely on it as your only L2 control*.
- **DHCP snooping**, **Dynamic ARP Inspection**, and **BPDU Guard** stop the L2 attacks (rogue DHCP, ARP poisoning, switch-impersonation) that defeat VLAN trust.

> **CompTIA exam trap:** VLAN ≠ subnet. A VLAN is a Layer 2 broadcast domain; a subnet is a Layer 3 IP range. They're commonly 1:1 in practice, but the exam will give you a scenario where they aren't. A VLAN with no SVI and no router still segments traffic — hosts in different VLANs can't ARP each other regardless of IP.

### Layer 3 enforcement — ACLs and routing

- **ACLs** on routers/L3 switches filter traffic between VLANs at the routing boundary. Standard ACLs filter by source IP; extended ACLs filter by source, dest, protocol, port.
- **Inter-VLAN routing** is what makes VLANs talk to each other. *Not configuring inter-VLAN routing* is a form of enforcement — the segments are isolated by default.
- **Stateful firewalls** between zones (user → server, DMZ → internal, OT → corporate) track connection state and only allow return traffic for established sessions.
- **Next-gen firewalls (NGFW)** add Layer 7 inspection — they can enforce "user VLAN can reach the database server on port 1433, but only via the approved app, not via raw SQL clients."

### Micro-segmentation — the modern answer

Traditional segmentation gives you zones. **Micro-segmentation** gives you per-workload policy. Every VM or container gets its own firewall policy, regardless of which subnet it lives on. Implemented via:

- Host-based firewalls pushed by a central controller (VMware NSX, Illumio, Cisco ACI)
- Cloud security groups (AWS SGs, Azure NSGs) — every instance has its own L4 firewall
- Service mesh policy (Istio, Linkerd) for east-west container traffic

The principle: **deny by default, allow only the specific flows the application actually needs.** This is [[Least Privilege]] applied to network reachability.

### Air-gap and physical segmentation

The strongest enforcement is no wire at all. Classified networks, nuclear plant control systems, and the most paranoid OT deployments are **air-gapped** — physically disconnected from any other network. Stuxnet proved air-gaps aren't bulletproof (USB sticks cross them), but they raise the cost of attack by orders of magnitude.

### Enforcement validation — segmentation testing

Designing zones is easy. Proving they hold is the hard part. PCI DSS requires **segmentation testing** at least annually (every six months for service providers). The test is exactly what it sounds like: a pentester sits on the *outside* of the cardholder zone and tries to reach in. If they can ping, port-scan, or pivot into the scoped segment, segmentation failed and the whole network is in scope.

Tools and techniques:
- `nmap` from each zone toward every other zone — document what gets through
- Firewall rule reviews — look for `any/any` rules that someone added "temporarily" three years ago
- Flow log analysis (NetFlow, sFlow, VPC flow logs) — confirm actual traffic matches policy
- Honeypots ([[Honeynet]]) inside segments to detect lateral movement attempts

### How segmentation supports other 4.1 concepts

| Concept | How segmentation enforces it |
|---------|------------------------------|
| **[[Least Privilege]]** | Hosts can only reach what their role requires |
| **[[CIA Triad]]** — Confidentiality | Sensitive zones aren't reachable from untrusted ones |
| **[[CIA Triad]]** — Integrity | Management plane isolated from data plane |
| **[[CIA Triad]]** — Availability | DDoS in one zone doesn't take down others |
| **[[PCI DSS]]** | Scope reduction — only the CDE is audited |
| **[[GDPR]]** | [[Data Locality]] — EU subject data stays in EU-located segments |
| **[[Zero Trust]]** | Micro-segmentation is the network plane of zero trust |
| **[[Defense in Depth]]** | One layer of many — pairs with [[MFA]], [[Encryption]], physical security |

### CompTIA exam traps

> **Trap 1:** Segmentation does not encrypt traffic. A packet on the wrong VLAN is still cleartext if you didn't also use TLS/IPsec. Segmentation controls *reachability*, not *confidentiality on the wire*. [[Encryption]] is a separate control.

> **Trap 2:** Guest Wi-Fi on its own SSID is not segmented unless the SSID is mapped to its own VLAN *and* an ACL prevents guest → internal routing. CompTIA will hand you a scenario where guest and corporate share VLAN 1 — that's the wrong answer hiding in plain sight.

> **Trap 3:** A DMZ is a segment, not a security strategy. Stuffing every internet-facing service into one flat DMZ means a compromised web server can pivot to the mail relay. Segment *within* the DMZ.

> **Trap 4:** SCADA/ICS networks should be segmented from corporate IT, but the exam expects you to know they often need *one-way* data flows (data diodes, unidirectional gateways) — plant floor → historian → corporate, never the reverse.

## Helpdesk reality

- User says: *"I can't reach the printer."* — Check whether the printer is on a different VLAN than the user's laptop. Helpdesk tickets generated by segmentation are constant; the segments are working as designed and someone forgot to add the firewall rule.
- User says: *"My personal phone won't connect to the work Wi-Fi."* — Correct. Personal devices belong on the [[BYOD]] or guest SSID, which maps to a segment with no internal reachability. Don't bridge them "just this once."
- Never promise: *"I'll just open it up for you."* — Every "temporary" firewall exception becomes permanent. Open a change ticket, route through security review, document the business justification. If you can't articulate why the rule exists, you can't defend it during the next audit.
- Escalation point: if you've confirmed L1 (cable, link), L2 (correct VLAN, port up), and L3 (correct IP, correct gateway, can ping gateway) on the client side and traffic still won't cross zones, it's a firewall/ACL ticket for the network security team. Bring the source IP, destination IP, port, and timestamp — they need all four to find your dropped flow in the logs.
- The audit reality: when the PCI assessor shows up, every undocumented exception is a finding. The clean answer to *"why does this rule exist?"* is a ticket number, an approver, and a date. *"It was already there when I got here"* is not an answer.

## Related concepts

[[VLANs]] · [[Subnetting]] · [[ACLs]] · [[Firewalls]] · [[DMZ]] · [[Zero Trust]] · [[Least Privilege]] · [[CIA Triad]] · [[Defense in Depth]] · [[PCI DSS]] · [[GDPR]] · [[HIPAA]] · [[IoT]] · [[SCADA]] · [[ICS]] · [[OT]] · [[Honeypot]] · [[Honeynet]] · [[BYOD]] · [[802.1Q]] · [[Port Security]] · [[DHCP Snooping]] · [[Dynamic ARP Inspection]] · [[Micro-segmentation]] · [[Air Gap]]

*Source: VIRGIL knowledge base — 2026-05-11*