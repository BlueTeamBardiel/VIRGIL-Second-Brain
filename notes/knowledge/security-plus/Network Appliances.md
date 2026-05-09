# Network Appliances

## What it is

In Halo, the bridge of the *Pillar of Autumn* isn't one console — it's Cortana running navigation, weapons officers running guns, comms officers running radio, and Captain Keyes giving orders. Each station does one job, exceptionally well, and they hand off to each other across the ship's network. That's exactly what network appliances do — they're purpose-built boxes that each handle one specialized network function instead of cramming everything onto a general-purpose server.

A **network appliance** is a dedicated hardware (or virtualized) device engineered to perform a specific network or security function — inspection, filtering, balancing, proxying, or aggregation — at line speed.

## Why it matters

Pile every function onto one router and you get a single point of failure, terrible performance, and a security architecture that collapses the moment one rule is misconfigured. SY0-701 Objective 3.2 explicitly enumerates the appliances a candidate must distinguish — **jump server**, **proxy**, **load balancer**, and the various **sensor** placements — and CompTIA's favorite trap is making you choose between two appliances that *sound* similar (forward proxy vs. reverse proxy, IDS vs. IPS, active vs. passive sensor). Pick wrong on the exam and you also pick wrong in production, where the consequence is either a breach you didn't see or traffic you accidentally blocked.

## Key facts

### The core appliances (Objective 3.2)

| Appliance | Job | Sits Where | Watch For |
|---|---|---|---|
| [[Jump Server]] | Hardened admin gateway into secure zones | DMZ → internal | Must be MFA-protected and heavily logged |
| [[Forward Proxy]] | Client-side intermediary for outbound traffic | Between users and internet | Caches, filters URLs, anonymizes clients |
| [[Reverse Proxy]] | Server-side intermediary for inbound traffic | Between internet and servers | TLS termination, hides backend, [[WAF]] integration |
| [[Load Balancer]] | Distributes traffic across server pool | In front of app tier | Round-robin, least-connection, weighted |
| [[Sensor]] | Captures traffic for inspection | Span port / inline tap | Passive observes, active can drop |

### Jump server (a.k.a. jump box / bastion host)

- A **hardened** [[bastion host]] used as the *only* path admins take to reach sensitive systems.
- Reduces attack surface: lock down one box, monitor one box.
- Requires [[MFA]], session recording, and minimal installed software.
- Exam trap: a jump server is for **administrative access**, not user traffic.

### Proxy servers — forward vs. reverse

- **Forward proxy**: protects/controls the **clients**. Employees browse out through it. Used for [[content filtering]], [[URL filtering]], caching, DLP egress.
- **Reverse proxy**: protects/controls the **servers**. Internet users hit it to reach internal apps. Used for [[TLS termination]], [[load balancing]], hiding backend topology, integrating a [[Web Application Firewall|WAF]].
- Mnemonic: forward proxy points *out*, reverse proxy points *in*.

### Load balancer

- Distributes connections across multiple backend servers for **availability** and **scalability**.
- Algorithms: **round-robin**, **least connections**, **weighted**, **source IP affinity** (sticky sessions).
- Modes: **active/active** (all nodes serving) vs. **active/passive** (standby takes over on failure).
- Operates at Layer 4 (TCP/UDP) or Layer 7 (HTTP-aware).
- Health checks remove dead backends from rotation automatically.

### Sensors

- **Passive sensor**: tap or [[SPAN port]] receives a copy of traffic — cannot block. Common for [[IDS]] and [[NetFlow]] collectors.
- **Active sensor**: sits **inline** — can drop, reset, or modify. Required for [[IPS]] and inline [[DLP]].
- Placement matters: sensors at the perimeter see north-south traffic; sensors at internal aggregation points see east-west.

### Where they typically live

```
Internet
   │
[Firewall] ── [Reverse Proxy / WAF] ── [Load Balancer] ── [Web Servers]
   │
[IPS Sensor — inline]
   │
[DMZ: Jump Server]
   │
[Internal LAN] ── [Forward Proxy] ── outbound web
```

### Common CompTIA traps

- **Forward vs. reverse proxy** confusion — read the question for *who* is being protected.
- **IDS vs. IPS** — detection only vs. prevention; passive vs. inline.
- **Jump server** is not a proxy and not a [[VPN concentrator]] — it's an administrative pivot point.
- **Load balancer ≠ failover cluster** — though they overlap, the exam treats balancing as a distribution function, not a redundancy mechanism per se.

## Related concepts

[[Firewall]] · [[Web Application Firewall]] · [[IDS]] · [[IPS]] · [[VPN Concentrator]] · [[DMZ]] · [[Network Segmentation]] · [[TLS Termination]] · [[High Availability]] · [[SPAN Port]] · [[Bastion Host]]

---
*Source: VIRGIL knowledge base — 2026-05-08*