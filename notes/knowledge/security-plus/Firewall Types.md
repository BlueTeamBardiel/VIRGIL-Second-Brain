# Firewall Types

## What it is

In Pokemon, you don't send Pikachu against everything. Against Onix you bring Squirtle; against Psychic-types you bring a Dark-type; in a Gym battle the leader stops you at the door if you lack the badge. That's exactly what firewall types do — different firewalls inspect traffic at different layers, with different rules, for different threats.

A **firewall** is a network or host security control that permits or denies traffic based on a defined ruleset, operating at one or more layers of the OSI model.

## Why it matters

Pick the wrong firewall type and you either bleed performance or miss the attack entirely. A packet filter happily passes malware-laden HTTPS because it only reads headers; an application-layer firewall catches it but chokes a 40 Gbps backbone if undersized. SY0-701 Objective 3.2 explicitly lists **WAF**, **UTM**, **NGFW**, and **Layer 4/Layer 7** firewalls — and CompTIA's favorite trap is the WAF-versus-NGFW question, where the scenario describes SQL injection or XSS (always WAF) versus broad enterprise edge filtering (NGFW). Know the layer each one operates at, or watch the points evaporate.

## Key facts

### The five types you must know cold

| Type | OSI Layer | Inspects | Best at |
|---|---|---|---|
| [[Packet Filtering Firewall]] | 3–4 | IP, port, protocol headers | Fast, cheap, dumb ACLs |
| [[Stateful Firewall]] | 3–4 | Connection state table | Tracking established sessions |
| [[Web Application Firewall]] (WAF) | 7 | HTTP/HTTPS payloads | [[SQL Injection]], [[XSS]], [[OWASP Top 10]] |
| [[Next-Generation Firewall]] (NGFW) | 3–7 | Apps, users, deep packets | Enterprise edge, app-ID, [[IPS]] integration |
| [[Unified Threat Management]] (UTM) | 3–7 | Everything, in one box | SMB all-in-one with [[antivirus]], [[VPN]], [[content filtering]] |

### Layer 4 vs Layer 7 — the CompTIA gotcha

- **[[Layer 4 Firewall]]**: filters by **port** and **IP**. Sees TCP/UDP. Does not understand HTTP verbs, URLs, or SQL.
- **[[Layer 7 Firewall]]**: filters by **application content**. Sees `GET /admin?id=1' OR 1=1--` and blocks it.
- A firewall that blocks port 1433 is Layer 4. A firewall that blocks SQL injection strings on port 443 is Layer 7.

### Stateless vs Stateful

- **[[Stateless Firewall]]**: each packet judged in isolation. Fast, but blind to connection context. Vulnerable to spoofed packets pretending to be replies.
- **[[Stateful Inspection]]**: maintains a **state table** of active connections. A return packet is allowed only if it matches an established session. Defeats most spoofing at the transport layer.

### NGFW specifics

A [[Next-Generation Firewall]] adds to stateful filtering:
- **Application awareness** (identifies Facebook vs Salesforce on port 443)
- **User identity integration** ([[Active Directory]], [[LDAP]])
- **Integrated [[IPS]]** signatures
- **[[Deep Packet Inspection]]** (DPI)
- **[[TLS Inspection]]** / SSL decryption

### WAF specifics

A [[Web Application Firewall]] sits in front of web servers, reverse-proxy style, and inspects HTTP/HTTPS application data. It defends against:
- [[SQL Injection]]
- [[Cross-Site Scripting]] (XSS)
- [[Cross-Site Request Forgery]] (CSRF)
- [[Directory Traversal]]
- API abuse and credential stuffing

WAFs run in **detection** (alert only) or **prevention** (block) mode. Examples: Cloudflare, AWS WAF, F5, ModSecurity.

### UTM — the SMB Swiss Army knife

A [[Unified Threat Management]] appliance bundles firewall, [[IDS]]/[[IPS]], [[antivirus]], anti-spam, [[VPN]], [[content filtering]], and [[DLP]] into one device. Cheap and convenient; single point of failure and a performance bottleneck if any one engine is overwhelmed. Fortinet FortiGate is the canonical example.

### Form factors

- **[[Hardware Firewall]]**: dedicated appliance at the network edge.
- **[[Software Firewall]]** / [[Host-Based Firewall]]: runs on the endpoint (Windows Defender Firewall, iptables, pf).
- **[[Cloud Firewall]]** / Firewall-as-a-Service: AWS Security Groups, Azure NSGs, GCP firewall rules.
- **[[Virtual Firewall]]**: deployed inside a hypervisor for east-west traffic between VMs.

### Deployment placement

- **Screened subnet** (formerly [[DMZ]]): firewall isolates public-facing servers from the internal LAN.
- **Internal segmentation firewall**: enforces [[Zero Trust]] between internal zones.
- **East-west firewall**: inspects lateral traffic inside the data center — where ransomware actually spreads.

## Related concepts

[[Access Control List]] · [[IDS]] · [[IPS]] · [[Proxy Server]] · [[Network Segmentation]] · [[Zero Trust]] · [[Deep Packet Inspection]] · [[Screened Subnet]] · [[Stateful Inspection]] · [[OWASP Top 10]]

---
*Source: VIRGIL knowledge base — 2026-05-08*