# Capacity Planning

## What it is
Like a restaurant that seats 50 people but tries to serve 500 on Valentine's Day — systems have hard limits, and ignoring them invites collapse. Capacity planning is the process of forecasting, measuring, and provisioning sufficient computing resources (CPU, memory, bandwidth, storage) to meet current and future operational demands while maintaining acceptable performance and availability.

## Why it matters
During a volumetric DDoS attack, a 10 Gbps pipe flooded with 40 Gbps of traffic becomes completely saturated — no legitimate traffic passes through. Organizations that have performed capacity planning will have pre-negotiated upstream scrubbing agreements or overprovisioned bandwidth headroom, meaning the attack threshold is much harder to reach and response options exist before total outage occurs.

## Key facts
- **Baseline measurement** is the foundation — you cannot plan capacity without knowing your normal utilization patterns (CPU, memory, network throughput) across peak and off-peak periods.
- Capacity planning directly supports **availability** in the CIA triad; under-provisioning is a passive vulnerability that attackers can exploit with minimal effort.
- **Scalability thresholds** should be documented in the Business Continuity Plan (BCP) and Disaster Recovery Plan (DRP) — both are tested on Security+.
- Cloud environments use **auto-scaling** as a compensating control, but without configured upper limits, runaway scaling can become a denial-of-wallet attack vector.
- Capacity planning outputs feed into the **risk assessment process** — resource constraints that cannot be remediated become accepted risks requiring formal documentation.

## Related concepts
[[Availability]] [[DDoS Mitigation]] [[Business Continuity Planning]] [[Risk Assessment]] [[Scalability]]