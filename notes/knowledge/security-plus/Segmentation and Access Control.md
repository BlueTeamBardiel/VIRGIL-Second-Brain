# Segmentation and Access Control

## What it is

In Pac-Man, the maze isn't one open room. It's a grid of corridors, dead ends, and the ghost house in the center where Blinky, Pinky, Inky, and Clyde respawn behind a gate that only ghosts can pass. Pac-Man cannot enter the ghost house. The ghosts cannot enter through walls. Each entity is restricted to specific paths, and the power pellets only work because the maze forces predictable routes. That's exactly what segmentation and access control do — they break a network into zones with walls and gates so that intruders can't roam freely and every passage requires permission.

**Segmentation** is the practice of dividing a network into isolated zones to limit lateral movement and contain threats. **Access control** is the enforcement mechanism that determines which subjects (users, devices, processes) may interact with which objects (data, systems, services) and under what conditions.

## Why it matters

A flat network is a buffet for attackers — one phished credential and they wander to the domain controller, the backup server, and the finance database without resistance. Segmentation forces the attacker to break through additional walls; access control ensures even authenticated users only see what their role permits. Both are foundational for **PCI-DSS** (cardholder data must be isolated), **HIPAA** (PHI access must be least-privilege), and **zero trust** architectures.

**Exam angle (Objective 2.5):** Know the difference between **physical, logical (VLAN), and virtual segmentation**; recognize **screened subnets (DMZ)**; distinguish the **access control models** (DAC, MAC, RBAC, ABAC, rule-based). CompTIA's favorite trap: confusing **RBAC (role-based)** with **rule-based** access control — they share an acronym in the wild but Security+ treats them as distinct, and the exam will dangle both in the same answer set.

## Key facts

### Segmentation types

| Type | Mechanism | Example |
|------|-----------|---------|
| **Physical** | Separate hardware, separate cables | Air-gapped SCADA network |
| **Logical** | [[VLAN]] tags (802.1Q) on shared switches | Finance VLAN 10, Guest VLAN 20 |
| **Virtual** | Hypervisor-enforced isolation | [[VMware NSX]] microsegmentation |
| **Screened subnet** | DMZ between two firewalls | Public web servers isolated from LAN |
| **Microsegmentation** | Per-workload firewall policy | [[Zero Trust]] east-west enforcement |

- **[[East-west traffic]]** = lateral, server-to-server inside the data center. Traditional perimeter firewalls miss it. Microsegmentation catches it.
- **[[North-south traffic]]** = client-to-server crossing the perimeter.
- **[[Air gap]]** = total physical isolation. Defeated by USB drives and human stupidity ([[Stuxnet]]).

### Access control models

| Model | Who decides | Best for |
|-------|-------------|----------|
| **[[DAC]]** (Discretionary) | Object owner | File shares, home directories |
| **[[MAC]]** (Mandatory) | System policy via labels (Top Secret, Secret, Confidential) | Military, intelligence |
| **[[RBAC]]** (Role-Based) | Roles assigned to users; permissions assigned to roles | Enterprise apps, HR systems |
| **[[Rule-Based Access Control]]** | ACL rules evaluated regardless of identity | Firewalls, time-of-day restrictions |
| **[[ABAC]]** (Attribute-Based) | Policy engine evaluates user, resource, environment attributes | Cloud, dynamic authorization |

### Supporting controls

- **[[Principle of Least Privilege]]** — grant the minimum needed, nothing more.
- **[[Separation of Duties]]** — no single person controls a full sensitive process.
- **[[Implicit deny]]** — anything not explicitly permitted is blocked. The default last rule of every firewall ACL.
- **[[ACL]]** (Access Control List) — ordered rule set; first match wins. Order matters.
- **[[Jump server]] / bastion host** — single hardened gateway into a segmented zone.
- **[[NAC]]** (Network Access Control) — enforces posture (patches, AV, compliance) before granting network access. 802.1X is the dot-on-the-line standard.

### Common port/protocol context

- **802.1X** — port-based authentication at the switch.
- **RADIUS** UDP **1812/1813** — authenticates users for NAC, VPN, Wi-Fi.
- **TACACS+** TCP **49** — Cisco's preferred device admin auth.

### Where it fails

- **VLAN hopping** ([[double-tagging]], [[switch spoofing]]) — defeats lazy VLAN segmentation. Mitigation: disable DTP, change native VLAN, prune trunks.
- **Privilege creep** — users accumulate permissions across role changes. Mitigation: periodic [[access reviews]] / recertification.
- **Misconfigured ACLs** — order errors and missing implicit deny. The most common audit finding in existence.

## Related concepts

[[Zero Trust]] · [[VLAN]] · [[Firewall]] · [[NAC]] · [[Principle of Least Privilege]] · [[Separation of Duties]] · [[Microsegmentation]] · [[Jump Server]] · [[802.1X]] · [[Screened Subnet]]

---
*Source: VIRGIL knowledge base — 2026-05-08*