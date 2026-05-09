# Firewalls

## What it is

In Mass Effect, the Normandy's IES stealth system and kinetic barriers don't just hide the ship — they decide what gets through the hull. Hostile rounds bounce off shields; friendly transmissions pass; the Reaper IFF gets scrutinized before it's bolted in. That's exactly what a firewall does — it inspects traffic crossing a boundary and decides what's allowed through based on rules.

A **firewall** is a network security device or software that enforces an access control policy on traffic between trust zones, permitting or denying packets based on rules applied to headers, state, application context, or identity.

## Why it matters

Without a firewall, every internal host is directly reachable from the internet — every unpatched service is one Shodan query from compromise, and lateral movement after an initial breach has nothing to slow it down. Compliance frameworks (PCI DSS, HIPAA, NIST 800-53 SC-7) explicitly require boundary protection, so a missing or misconfigured firewall fails audits before it fails defensively. Exam angle: Objective 4.5 expects you to distinguish **WAF**, **UTM**, **NGFW**, and **Layer 4 firewalls**, know **screened subnets** vs. flat networks, and understand **rule order, implicit deny, and ACL construction**. CompTIA's favorite trap is mixing up **NGFW** (does application-layer inspection plus IPS) with **WAF** (only protects HTTP/HTTPS apps), and asking which sits where.

## Key facts

### Firewall types by inspection depth

| Type | Layer | What it inspects | Use case |
|------|-------|------------------|----------|
| **Packet filter** | 3-4 | Source/dest IP, port, protocol | Cheap, fast, stateless [[ACL]] enforcement |
| **Stateful** | 3-4 | Above + connection state table | Tracks established sessions; blocks unsolicited replies |
| **[[Proxy firewall]]** | 7 | Full session, terminates connection | Inspects payload, hides internal hosts |
| **[[Next-Generation Firewall]] (NGFW)** | 3-7 | App-ID, user-ID, IPS, TLS decrypt | Modern enterprise perimeter |
| **[[Web Application Firewall]] (WAF)** | 7 (HTTP only) | HTTP requests, payloads, headers | Stops [[SQL injection]], [[XSS]], OWASP Top 10 |
| **[[Unified Threat Management]] (UTM)** | 3-7 | Firewall + AV + IDS + spam + URL filter | SMB all-in-one appliance |

### Form factors

- **[[Hardware firewall]]** — dedicated appliance (Palo Alto, Fortinet, Cisco ASA) at the network edge.
- **[[Host-based firewall]]** — software on the endpoint (Windows Defender Firewall, iptables, pf).
- **[[Cloud firewall]] / FWaaS** — virtual appliance or managed service ([[AWS Network Firewall]], Azure Firewall).
- **[[Virtual firewall]]** — hypervisor-level enforcement between VMs ([[microsegmentation]]).

### Rule construction

Firewall rules are evaluated **top-down, first-match-wins**. A typical rule contains:

| Field | Example |
|-------|---------|
| Source IP/zone | `10.0.0.0/24` |
| Destination IP/zone | `any` |
| Protocol | `TCP` |
| Destination port | `443` |
| Action | `permit` / `deny` / `log` |

The final rule is **[[implicit deny]]** — anything not explicitly allowed is dropped. CompTIA loves asking why traffic is being blocked when no rule mentions it; the answer is always implicit deny.

### Architectural placement

- **[[Screened subnet]]** (formerly DMZ) — public-facing servers between two firewalls or between firewall zones.
- **[[Bastion host]]** — hardened jump box reachable from outside, the only path inward.
- **[[East-west traffic]]** filtering — firewalls between internal segments, not just at the edge.
- **[[Defense in depth]]** — perimeter + segment + host firewalls layered.

### Important capabilities to know

- **[[Stateful inspection]]** — tracks TCP three-way handshake state.
- **[[Deep packet inspection]] (DPI)** — examines payload, not just headers.
- **[[Application-aware]]** filtering — identifies Skype vs. generic TCP/443.
- **[[TLS inspection]]** / SSL decryption — NGFW terminates and re-encrypts to inspect ciphertext.
- **[[Geo-IP filtering]]** — block by country.
- **[[Content filtering]] / URL filtering** — block categories (gambling, malware C2 domains).

### Common exam distinctions

- **WAF vs. NGFW**: WAF protects a *web application*; NGFW protects a *network*.
- **IDS vs. firewall**: IDS detects, firewall enforces. An [[IPS]] inline can do both.
- **Stateless ACL vs. stateful firewall**: ACL on a [[router]] doesn't track sessions; stateful firewall does.

## Related concepts

[[ACL]] · [[Screened subnet]] · [[Next-Generation Firewall]] · [[Web Application Firewall]] · [[Unified Threat Management]] · [[Proxy firewall]] · [[Stateful inspection]] · [[Implicit deny]] · [[Microsegmentation]] · [[IDS/IPS]] · [[Defense in depth]] · [[Network segmentation]]

---
*Source: VIRGIL knowledge base — 2026-05-08*