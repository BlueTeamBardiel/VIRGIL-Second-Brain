# Capacity Planning

## What it is

In Tetris, the well fills faster than you can clear lines, the stack creeps toward the ceiling, and you realize four moves ago you should have been holding I-pieces for the wells you knew were coming. That's exactly what capacity planning does — it forecasts how much room, compute, staff, and bandwidth you'll need before the stack hits the top.

**Capacity planning** is the disciplined process of determining the people, technology, and infrastructure resources required to meet projected demand without compromising security, availability, or compliance.

## Why it matters

When capacity is under-provisioned, [[availability]] collapses: services degrade, [[SLA]] penalties trigger, [[failover]] paths overload, and incident response slows because the SOC is staffed for Tuesday and the breach happened during Black Friday. Over-provisioning bleeds budget that should fund actual controls. SY0-701 Objective 3.4 explicitly lists capacity planning as a [[resilience]] consideration alongside **people, technology, and infrastructure** — CompTIA's favorite trap is asking which category a given example falls under (e.g., "hiring more SOC analysts" is *people*, not *technology*), and pairing capacity with [[high availability]] vs. [[fault tolerance]] distractors.

## Key facts

### The three capacity dimensions (memorize these)

| Dimension | What you plan for | Examples |
|---|---|---|
| **People** | Staffing levels, skills, succession | SOC analysts, on-call rotations, cross-training, [[separation of duties]] coverage |
| **Technology** | Compute, storage, software licenses | Server CPU/RAM, [[load balancer]] throughput, EDR license seats, [[SIEM]] EPS ingest |
| **Infrastructure** | Physical and network capacity | Bandwidth, rack space, power/cooling (kW per rack), [[data center]] floor |

### Why each dimension fails

- **People underrun**: alert fatigue, missed [[incident response]] windows, single-points-of-knowledge.
- **Technology underrun**: SIEM drops logs (compliance gap), backups don't finish their window, [[autoscaling]] hits a hard cap mid-incident.
- **Infrastructure underrun**: [[DDoS]] saturates the pipe you didn't oversize, generators undersized for new rack density, cooling fails before compute does.

### Methods and inputs

- **Baseline measurement** — current utilization across CPU, memory, storage IOPS, bandwidth, ticket volume.
- **Trend analysis / forecasting** — historical growth + projected business demand.
- **[[Load testing]]** — synthetic stress to find the break point before users do.
- **Headroom targets** — typically plan for peak + 20–40% buffer; security-critical systems higher.
- **Dependency mapping** — capacity of upstream services (auth, DNS, [[PKI]]) limits dependent services.

### Capacity vs. adjacent resilience concepts

| Concept | Focus |
|---|---|
| **Capacity planning** | Sizing resources to meet demand |
| **[[High availability]]** | Uptime via redundancy |
| **[[Scalability]]** | Ability to grow capacity (horizontal/vertical) |
| **[[Fault tolerance]]** | Surviving component failure |
| **[[Site resiliency]]** | Hot/warm/cold alternate sites |

CompTIA distinction: capacity is *how much*; scalability is *how easily you add more*; HA is *how you stay up when something dies*.

### Security-specific capacity considerations

- **Log retention**: storage sized to compliance window ([[PCI DSS]] = 1 year, often 90 days online).
- **[[Backup]] windows**: full + incremental must complete inside the maintenance window.
- **Crypto compute**: TLS termination, [[HSM]] transactions per second.
- **Identity systems**: [[IdP]] auth/sec ceilings during MFA rollouts or outage stampedes.
- **Incident surge**: forensic storage and analyst hours reserved for the bad day.

## Related concepts

[[High availability]] · [[Scalability]] · [[Fault tolerance]] · [[Load balancing]] · [[Site resiliency]] · [[Business impact analysis]] · [[RTO]] · [[RPO]] · [[SLA]] · [[Resilience]]

---
*Source: VIRGIL knowledge base — 2026-05-08*