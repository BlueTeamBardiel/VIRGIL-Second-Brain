# Network Infrastructure Concepts

## What it is

In Tears of the Kingdom, the Sky Islands, the Surface, and the Depths are three distinct realms — each with its own terrain, hazards, and inhabitants — connected only by specific transit points like Skyview Towers and chasms. You don't wander between them; you pass through controlled gates. That's exactly what network infrastructure does — it carves a network into zones with deliberate chokepoints so traffic between them can be inspected, restricted, or denied.

**Network infrastructure concepts** are the architectural patterns — physical, logical, and virtual — that determine how systems are segmented, where trust boundaries live, and how data flows are controlled across an enterprise network.

## Why it matters

Flat networks are how ransomware turns one phished accountant into a company-wide outage; once inside, an attacker pivots laterally because nothing told them to stop. SY0-701 Objective 3.1 expects you to know **physical isolation (air gap)**, **logical segmentation**, **SDN**, **on-premises vs. cloud**, **virtualization**, **containerization**, **serverless**, **microservices**, **IoT**, **ICS/SCADA**, and **embedded/RTOS systems** — and the security trade-offs of each. CompTIA's favorite trap: confusing **segmentation** (logical, via VLAN/ACL) with **isolation** (physical, no shared medium), or assuming "cloud" automatically means "someone else's problem."

## Key facts

### Architecture models

| Model | What it is | Security implication |
|---|---|---|
| [[On-premises]] | You own the hardware, building, power | Total control, total responsibility |
| [[Cloud]] | Provider owns infra; you rent | [[Shared Responsibility Model]] applies |
| [[Hybrid]] | Mix of on-prem + cloud | Identity federation and data-flow complexity |
| [[Air-gapped network]] | Physically disconnected from other networks | Defeats most remote attacks; defeated by USBs (see Stuxnet) |

### Segmentation vs. isolation

- **[[Physical isolation]]** — separate cabling, switches, no shared medium. The [[Air gap]] is the extreme case.
- **[[Logical segmentation]]** — same physical hardware, separated by configuration: [[VLAN]] (802.1Q tags), [[VRF]], subnetting, [[ACL|ACLs]], [[Firewall]] zones.
- **[[Screened subnet]]** (formerly DMZ) — sandwiched zone for public-facing services between two firewalls.
- **[[Zero Trust]]** — segmentation taken to the host level; no implicit trust based on network location.

### Software-Defined Networking (SDN)

[[SDN]] decouples the **control plane** (decides where packets go) from the **data plane** (forwards packets). A central controller programs switches via APIs (e.g., OpenFlow). Adds a **management plane** for orchestration.

- **Benefit:** policy changes pushed instantly across the fabric.
- **Risk:** the controller is a single high-value target. Compromise it, own the network.

### Virtualization & compute models

| Model | Granularity | Shared with host | Notable risk |
|---|---|---|---|
| [[Virtual Machine]] | Full OS per guest | [[Hypervisor]] | [[VM escape]] |
| [[Container]] | Process-level (Docker, Kubernetes) | Host kernel | Kernel exploit = full breakout |
| [[Serverless]] (FaaS) | Function execution | Provider runtime | Cold-start data leakage, IAM misconfig |
| [[Microservices]] | App architecture pattern | Network fabric | Massive east-west traffic; needs mTLS |

### Specialized network types

- **[[IoT]]** — consumer/enterprise smart devices. Default credentials, no patching, infrequent updates. Mirai botnet territory.
- **[[ICS]] / [[SCADA]]** — industrial control. Long lifecycles (20+ years), proprietary protocols (Modbus, DNP3), patching breaks safety certifications. Segment ruthlessly via the [[Purdue Model]].
- **[[Embedded systems]]** — purpose-built (medical devices, printers, HVAC). Often the soft target on a "secure" network.
- **[[RTOS]]** — Real-Time Operating System. Determinism over features; common in avionics, automotive, ICS. Limited security tooling available.
- **[[High availability]]** — clustering, load balancing, redundant paths. Availability is the third leg of the [[CIA Triad]] and CompTIA loves to test it.

### Infrastructure considerations (Objective 3.1 checklist)

- **Device placement** — sensors at chokepoints, firewalls at trust boundaries.
- **Security zones** — group by trust level, not by department.
- **Attack surface** — every exposed port, API, and service is a door.
- **Connectivity** — wired vs. wireless, VPN, leased line; each has different threat models.
- **Failure modes** — **fail-open** (availability priority, security risk) vs. **fail-closed** (security priority, availability risk).
- **Device attribute** — **active** (inline, can block) vs. **passive** (out-of-band, observes only).

## Related concepts

[[VLAN]] · [[Zero Trust]] · [[Shared Responsibility Model]] · [[Hypervisor]] · [[Container Security]] · [[Purdue Model]] · [[Network Segmentation]] · [[SDN]] · [[Air gap]] · [[Screened subnet]] · [[Microservices]] · [[IoT Security]]

---
*Source: VIRGIL knowledge base — 2026-05-08*