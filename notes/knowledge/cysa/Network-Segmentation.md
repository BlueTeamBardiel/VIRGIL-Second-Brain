# Network Segmentation

## What it is

In **BioShock**, Rapture is a city under the sea broken into sealed bulkhead districts — Medical Pavilion, Neptune's Bounty, Arcadia, Fort Frolic. When a Splicer riot breaks out in Medical, the bathysphere doors lock, the bulkheads seal, and the chaos stays in Medical. You don't lose the whole city because Ryan engineered the place to fail in pieces, not all at once. Now imagine if every district shared one big open hallway — one Splicer with a wrench takes Rapture in an afternoon.

That's network segmentation. You break the network into zones with controlled doors between them so a compromise in one zone doesn't become a compromise everywhere.

**Technical definition:** Network segmentation is the practice of dividing a network into isolated subnetworks (segments, zones, enclaves) enforced by Layer 3 controls — firewalls, ACLs, VLANs, SDN policy — so that traffic between segments must traverse an inspection point. The goal is to limit blast radius, contain lateral movement, enforce least-privilege at the network layer, and reduce the scope of compliance audits.

## Why it matters

When an attacker lands on a workstation through a phishing email, the next thing they do is move sideways — credential dump, scan the subnet, find the file share, find the domain controller. Flat networks are why ransomware actors can hit one VDI host on Monday and own every server by Wednesday. Segmentation is the single highest-leverage architectural control against lateral movement. It is also the most-deferred one, because nobody wants to refactor the network they inherited.

For the CySA+ exam, segmentation lives in **Objective 1.1** (system and network architecture) and bleeds into 1.2 (logging and monitoring), 3.0 (incident response — containment), and 4.0 (vulnerability scope reduction). Expect questions on zone design, jump boxes, [[Zero Trust]], [[SDN]], [[SASE]], and segmentation as a containment mechanism during IR.

## Key facts

### The zones you should know

| Zone | Purpose | Typical occupants |
|---|---|---|
| **Internet / untrusted** | Anything you don't control | Public users, threat actors, the entire IPv4 space |
| **DMZ (perimeter)** | Public-facing services with controlled inbound | Web servers, reverse proxies, public DNS, MX relays |
| **Internal / corporate** | User workstations, productivity | Endpoints, print servers, internal apps |
| **Datacenter / server** | Production servers and databases | Domain controllers, file servers, app tier, DB tier |
| **Management** | Admin access plane | Jump boxes, [[PAM]] vaults, SIEM, monitoring |
| **OT / ICS** | Operational technology | SCADA, PLCs, HMIs — never on the same flat as IT |
| **Guest / IoT** | Untrusted-but-tolerated | BYOD, printers, cameras, the CEO's smart fridge |

### Triple-homed firewall

A firewall with three (or more) interfaces — typically **untrusted (Internet), DMZ, trusted (internal)**. Each interface gets its own zone and its own ruleset. Traffic from Internet to DMZ is allowed on specific ports; Internet to internal is denied; DMZ to internal is tightly restricted and inspected. It's the cheapest way to do real segmentation and still the dominant design in mid-size shops.

The CySA+ exam will draw a diagram with a firewall, a DMZ network with a web server, and an internal network with a database. Expect a question like "the web server needs to query the database — which rule is most secure?" The answer is always the **most specific** rule: source = web server IP, destination = DB server IP, port = the DB port, action = allow. Never `any/any`.

### Jump box (bastion host)

A hardened intermediary host that admins must connect through to reach sensitive zones. No direct RDP/SSH from a user workstation to a domain controller — you RDP into the jump box, the jump box RDPs into the DC. Properties of a real jump box:

- Dedicated to admin use only — no email, no browsing, no Office
- [[MFA]] required to log in (smart card, FIDO2, push)
- All sessions logged, often video-recorded
- Privileged credentials checked out from a [[PAM]] vault, never typed by hand
- Hardened OS, minimal services, EDR loud and tuned
- Time-limited access — credentials rotate after each session

> **CompTIA exam trap:** A jump box is *not* the same as a [[VPN]] concentrator. The VPN gets the admin onto the network; the jump box is the only host on the management network that accepts inbound admin sessions. Both exist in a mature design. CompTIA will offer "VPN" as the wrong answer when the question asks how an admin securely reaches a production server.

### VLANs are not segmentation by themselves

A VLAN is a Layer 2 broadcast domain. It separates traffic logically on a switch but does **nothing** to inspect traffic between VLANs unless you route them through a firewall or ACL. A VLAN with an unfiltered inter-VLAN routing interface on the core switch is segmentation theater. Real segmentation requires an enforcement point — a firewall, a [[SDN|software-defined]] policy engine, or a host-based microsegmentation agent.

### Microsegmentation

Traditional segmentation puts a firewall between zones. **Microsegmentation** puts a policy enforcement point in front of every workload — usually a host agent or hypervisor-level policy. Two web servers in the same subnet can be denied from talking to each other. This is the [[Zero Trust]] network model: no implicit trust based on network location, every flow authorized explicitly.

Common implementations: VMware NSX, Illumio, Cisco ACI, Azure NSGs at the NIC level, AWS security groups per instance.

### Zero Trust and segmentation

[[Zero Trust]] assumes the network is already compromised. There is no trusted interior. Every request — user-to-app, app-to-app, service-to-service — is authenticated, authorized, and logged at the moment of access. Segmentation becomes per-workload and per-identity rather than per-subnet. The phrase to remember: **"never trust, always verify."**

[[SASE]] (Secure Access Service Edge) is the cloud-delivered version — identity-aware proxy, [[CASB]], SWG, ZTNA, and SD-WAN bundled into one control plane. Useful when your "perimeter" is 8,000 remote workers and a hundred SaaS apps.

### SDN — segmentation that doesn't require rewiring

[[Software-Defined Networking]] decouples the control plane (what the policy is) from the data plane (the switches forwarding packets). You define segmentation policy centrally and push it to virtual switches across the fabric. The win: you can re-segment a datacenter on a Tuesday afternoon without touching cabling.

### Why segmentation matters for compliance

[[PCI DSS]] explicitly recognizes segmentation as a way to **reduce scope** of the [[CHD|cardholder data]] environment. If your payment processing systems sit on an isolated segment with documented controls between it and everything else, only that segment is in PCI scope. Flat network = entire network in PCI scope = audit hell. Same logic applies for [[PII]], HIPAA PHI, and most regulated data classes.

### Segmentation as a containment tool

During [[Incident Response]], segmentation is your fastest containment lever. Block VLAN-to-VLAN at the firewall, kill the SDN policy, isolate the host's port at the switch. The faster you can sever segments, the smaller the [[Blast Radius]]. Containment plans should be pre-staged — you do not want to be writing firewall rules during an active ransomware event.

> **CompTIA exam trap:** CompTIA distinguishes **segmentation** (architectural, permanent zones) from **isolation** (incident-time, surgical host quarantine). A host in isolation has been pulled out of its normal segment, usually onto a quarantine VLAN or by EDR network containment. Don't conflate the two on the exam.

### Defense in depth — segmentation is one layer

Segmentation is necessary, not sufficient. Layer it with:

- [[Identity and Access Management|IAM]] and [[MFA]] at every zone boundary
- [[Encryption]] in transit between zones ([[TLS]], IPsec)
- [[Logging|Log ingestion]] at every enforcement point — east-west traffic is invisible if you don't log it
- [[Time Synchronization|NTP]] so logs from different segments correlate in the SIEM
- [[EDR]] on every endpoint, because the moment a host moves inside a segment, the firewall stops helping

### The east-west problem

Most firewalls were bought to inspect **north-south** (client ↔ Internet) traffic. Once an attacker is inside, their lateral movement is **east-west** (server ↔ server, workstation ↔ server). If you have no enforcement point between internal hosts, you have no detection on the most dangerous traffic in the breach. Microsegmentation and [[SDN]] inspection exist specifically to fix this.

*East-west blindness is how a phished marketing assistant becomes a domain admin in 72 hours.*

## SOC reality

- The SIEM dashboard you actually care about is **denied east-west flows** at the segmentation firewall. A workstation suddenly hammering SMB against the DC subnet at 2am is what catches lateral movement. Tune for it; alert on it.
- When IR calls containment, your fastest move is **port isolation at the switch** (shut the access port or move it to a quarantine VLAN) or **EDR network isolation** (the agent dumps every connection except the EDR console). Both are reversible. Pulling the cable is not, and the executive whose laptop you bricked will remember.
- The CISO's first question during an incident is *"is it contained to that segment?"* The honest answer is almost never a clean yes. You say: *"We've isolated the known-compromised hosts. We're hunting for lateral movement east-west now. I'll have scope in two hours."* Never promise containment you haven't verified.
- 80% of segmentation tickets in your queue are "open this port between these two zones for this new app." Your job is to push back: which source IP, which destination IP, which port, for how long, who owns the rule, when does it get reviewed. `any/any temporary` rules become permanent in 48 hours and forever in 48 weeks.
- Segmentation policy lives in version control if you're mature, in a spreadsheet if you're average, and in the senior network engineer's head if you're young. The handoff problem is real — document or die.

## Related concepts

[[Zero Trust]] · [[SASE]] · [[CASB]] · [[SDN]] · [[Microsegmentation]] · [[DMZ]] · [[Jump Box]] · [[PAM]] · [[MFA]] · [[Identity and Access Management]] · [[Firewall]] · [[VLAN]] · [[Lateral Movement]] · [[Blast Radius]] · [[Incident Response]] · [[Containment]] · [[PCI DSS]] · [[CHD]] · [[PII]] · [[System Hardening]] · [[Defense in Depth]]

*Source: VIRGIL knowledge base — 2026-05-11*