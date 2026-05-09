# Secure Infrastructures

## What it is

In Skyrim, you don't just dump your gold in the middle of Whiterun and hope for the best — you store it in a chest inside Breezehome, behind a locked door, in a city with guards at the gates, behind walls patrolled by archers. Every layer assumes the previous one might fail. That's exactly what a secure infrastructure does — it arranges network components, devices, and traffic flows so that compromise of one layer doesn't hand an attacker the whole hold.

**Secure infrastructure** is the deliberate design of network architecture — physical placement, logical segmentation, control points, and traffic flow — to enforce security objectives across confidentiality, integrity, and availability.

## Why it matters

Flat networks die loudly. One phishing click on an HR workstation reaches the domain controller, the database, and the backup server because nothing was between them. SY0-701 Objective 3.2 explicitly requires you to "compare and contrast security implications of different architecture models," which means knowing **device placement**, **security zones**, **attack surface**, **connectivity**, and **failure modes** (fail-open vs. fail-closed). The CompTIA trap: confusing the *device* (firewall, IPS) with the *placement decision* (screened subnet, internal segmentation), and confusing **fail-open** (availability wins, security loses) with **fail-closed** (security wins, business stops).

## Key facts

### Architecture considerations (the SY0-701 checklist)

| Consideration | What it means | Trade-off |
|---|---|---|
| **Availability** | Will it stay up? | More HA = more cost + complexity |
| **Resilience** | Can it survive failure? | Redundancy increases attack surface |
| **Cost** | CapEx + OpEx | Cheap designs leak |
| **Responsiveness** | Latency, throughput | Inline inspection adds delay |
| **Scalability** | Grows with demand | Cloud scales; closets do not |
| **Ease of deployment** | Time to stand up | Pre-built = less control |
| **Risk transference** | Push risk to a provider | You can outsource work, not blame |
| **Ease of recovery** | RTO/RPO posture | Backups untested = backups missing |
| **Patch availability** | Vendor support lifespan | EOL gear = standing vulnerability |
| **Inability to patch** | OT, ICS, embedded | Compensating controls required |
| **Power** | UPS, generator, dual-feed | Single PDU = single death |
| **Compute** | CPU/GPU/memory headroom | Sized for peak, not average |

### Security zones and device placement

- [[Trust zones]] — group assets by sensitivity. Guest Wi-Fi ≠ payroll VLAN.
- [[Screened subnet]] (formerly DMZ) — public-facing services live here, between two firewalls or behind one with strict rules. Web servers, reverse proxies, public DNS.
- [[Intranet]] — internal trusted segment.
- [[Extranet]] — partner/B2B segment, semi-trusted.
- **East-west traffic** = server-to-server inside the data center. **North-south** = client-to-internet. Most breaches pivot east-west; segmentation is the answer.

### Attack surface

The sum of every exposed entry point: open ports, listening services, APIs, user accounts, physical jacks, wireless SSIDs. Reduce by **disabling unused services**, closing ports, removing default accounts, and **network segmentation**.

### Connectivity and control points

| Device | Layer | Job |
|---|---|---|
| **[[Firewall]]** | L3/L4 (or L7 NGFW) | Allow/deny by rule |
| **[[IDS]]** | Passive | Alert on bad traffic |
| **[[IPS]]** | Inline | Block bad traffic |
| **[[Jump server]]** | Hardened bastion | Single chokepoint for admin access |
| **[[Proxy server]]** | App layer | Mediate client→server requests |
| **[[Load balancer]]** | L4/L7 | Distribute, also hide backend |
| **[[Sensors]]** | Various | Telemetry collection |

### Failure modes

- **[[Fail-open]]** — on failure, traffic passes. Availability preserved, security gone. Acceptable for IDS, dangerous for firewalls.
- **[[Fail-closed]]** — on failure, traffic stops. Security preserved, business halts. Default for serious control points.
- **[[Active-active]]** vs. **[[active-passive]]** HA — both nodes serving vs. one standing by.

### Network appliance modes

- **Inline / in-band** — appliance sits in the traffic path; can block. Latency and a failure point.
- **Out-of-band / tap / SPAN** — appliance sees a copy; can only alert. No latency, no blocking.

### Infrastructure architecture models

| Model | Strength | Weakness |
|---|---|---|
| **On-premises** | Full control | Full cost, full responsibility |
| **[[Cloud]]** (IaaS/PaaS/SaaS) | Elastic, fast | Shared responsibility confusion |
| **[[Hybrid]]** | Flexibility | Two attack surfaces, one team |
| **[[SDN]]** (software-defined networking) | Centralized policy, agility | Controller is a high-value target |
| **[[Serverless]]** | No server mgmt | Cold-start, vendor lock-in, opaque logging |
| **[[Microservices]]** | Decoupled scaling | Service-to-service auth becomes the new perimeter |
| **[[IoT]]** | Cheap sensing | Rarely patched, often hardcoded creds |
| **[[ICS/SCADA]]** | Runs the physical world | Decade-old protocols, no auth |
| **[[RTOS]]** | Deterministic timing | Niche patching pipeline |
| **[[Embedded systems]]** | Purpose-built | Firmware = forever |
| **[[Air-gapped]]** | Maximum isolation | Sneakernet, USB risk (see Stuxnet) |
| **High availability** | Uptime | Cost, complexity |

### Centralized vs. decentralized

- **Centralized** — one pane of glass, one place to compromise.
- **Decentralized** — resilient, harder to govern, easier to drift out of compliance.

### The shared responsibility model (cloud)

You always own: **data**, **identities**, **access policies**. Provider owns the floor of the stack. Where the line falls depends on IaaS vs. PaaS vs. SaaS. CompTIA loves this question.

## Related concepts

[[Network segmentation]] · [[Zero Trust]] · [[Defense in depth]] · [[VLAN]] · [[VPN]] · [[Firewall]] · [[Screened subnet]] · [[Jump server]] · [[SDN]] · [[Shared responsibility model]] · [[Fail-open]] · [[Fail-closed]] · [[Attack surface]] · [[High availability]]

---
*Source: VIRGIL knowledge base — 2026-05-08*