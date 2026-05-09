# Infrastructure Considerations

## What it is

In Rainbow Six Siege, before round start the defenders walk the building deciding which walls to reinforce, which hatches to drop, where to place Mira windows, and which rotates to open. Get it wrong and Thermite cuts your whole strategy in half. That's exactly what **infrastructure considerations** are — the architectural decisions made *before* deployment that determine whether your environment can be defended, scaled, and recovered at all.

Technically: the set of design-time tradeoffs — placement, availability, resilience, cost, compute, responsiveness, and patch posture — that shape a secure network architecture per SY0-701 Objective 3.1.

## Why it matters

Bad infrastructure choices are unfixable post-deployment without rebuilds. A flat network with no segmentation guarantees lateral movement after the first phish; a single-region cloud deployment fails the moment AWS us-east-1 sneezes; an unpatchable IoT camera becomes a permanent Mirai recruit. The exam expects you to map a *scenario* (cost, latency, regulatory, scale) to the correct architectural choice — CompTIA's favorite trap is offering two technically valid answers and forcing you to pick the one the *scenario* dictates, not the one that's "most secure" in isolation.

## Key facts

### The core considerations (memorize this list)

| Consideration | What it means | Exam trigger phrase |
|---|---|---|
| **[[Availability]]** | Uptime, redundancy, [[high availability]] | "must remain operational" |
| **[[Resilience]]** | Recovery from failure, [[fault tolerance]] | "tolerate disruption" |
| **[[Cost]]** | CapEx vs OpEx, licensing, bandwidth | "budget-constrained" |
| **[[Responsiveness]]** | [[Latency]], user experience | "real-time" / "low-latency" |
| **[[Scalability]]** | Handle growth in load | "rapid expansion" |
| **[[Ease of deployment]]** | Time-to-stand-up | "quickly provision" |
| **[[Risk transference]]** | Push risk to vendor (cloud, [[insurance]]) | "shift liability" |
| **[[Ease of recovery]]** | RTO/RPO friendliness | "minimize downtime" |
| **[[Patch availability]]** | Vendor support lifecycle | "[[end-of-life]] / EOL" |
| **[[Inability to patch]]** | OT/ICS/legacy that can't be touched | "[[SCADA]]" / "medical device" |
| **[[Power]]** | UPS, generators, dual feeds | "[[data center]] continuity" |
| **[[Compute]]** | CPU/GPU/memory headroom | "processing capacity" |

### Device placement

- **[[Security zones]]**: separate trust levels — [[DMZ]] (public-facing), internal, [[management network]], [[guest network]], [[OT network]].
- **[[Screened subnet]]** (modern term for DMZ): public services like web/mail sit between two firewalls.
- **East-west vs north-south traffic**: north-south crosses the perimeter; east-west moves laterally — most ransomware lives east-west, which is why [[microsegmentation]] exists.

### Attack surface

Every exposed service, port, protocol, API, and human is part of the **[[attack surface]]**. Reduce by:
- Disabling unused services and ports
- [[Network segmentation]] / [[VLAN]]s
- [[Jump server]]s for admin access
- Removing default accounts

### Connectivity & failure modes

- **[[Fail-open]]**: device fails into "pass traffic" state — preserves availability, kills security. Typical of inline IPS where uptime > inspection.
- **[[Fail-closed]]**: device fails into "block everything" state — preserves security, kills availability. Typical of firewalls protecting crown-jewel data.
- Pick based on whether **safety/availability** or **confidentiality** matters more. A hospital network fails open. A classified enclave fails closed.

### Device attributes

| Attribute | Meaning |
|---|---|
| **[[Active device]]** | Takes action — [[IPS]], firewall, [[load balancer]] |
| **[[Passive device]]** | Observes only — [[IDS]], [[network tap]], [[SPAN port]] |
| **[[Inline]]** | Sits in the traffic path — can block |
| **[[Out-of-band (tap/monitor)]]** | Off the path — can alert but not block |

### Common CompTIA trap

"Inability to patch" is the giveaway for **[[OT]]/[[ICS]]/[[SCADA]]/legacy medical**. The answer is never "patch it anyway" — it's **compensating controls**: network isolation, [[VLAN]] segregation, strict ACLs, [[jump box]] access only.

## Related concepts

[[Network segmentation]] · [[Zero Trust]] · [[High availability]] · [[Defense in depth]] · [[Screened subnet]] · [[Microsegmentation]] · [[Fail-open vs fail-closed]] · [[SCADA]] · [[Cloud deployment models]] · [[Software-defined networking]]

---
*Source: VIRGIL knowledge base — 2026-05-08*