# Single Point of Failure

## What it is
Like a suspension bridge held by a single cable — the whole structure collapses the moment that one cable snaps. A Single Point of Failure (SPOF) is any individual component in a system whose failure alone can bring down the entire system, with no backup or redundancy to absorb the impact.

## Why it matters
In 2003, a software bug in an Ohio power grid monitoring system (a SPOF) caused operators to miss cascading overloads, triggering the largest blackout in North American history — 55 million people lost power. In security architecture, defenders identify SPOFs through failure mode analysis to ensure that no single compromised server, certificate authority, or network link can fully disable critical operations.

## Key facts
- **Redundancy eliminates SPOFs**: RAID arrays, failover clusters, and hot standby systems are architectural countermeasures specifically designed to remove single points of failure.
- **High Availability (HA) systems** are explicitly designed around SPOF elimination, targeting metrics like 99.999% uptime ("five nines").
- **A single root CA** in a PKI chain is a classic SPOF — if it's compromised, all issued certificates become untrustworthy; intermediate CAs distribute this risk.
- **Geographic diversity** matters: two redundant servers in the same data center still represent a SPOF at the facility level (fire, flood, power failure).
- On the **Security+ exam**, SPOF awareness appears under business continuity, resilience, and redundancy topics — expect scenario questions about eliminating SPOFs via load balancers, UPS systems, or multi-path networking.

## Related concepts
[[Redundancy]] [[High Availability]] [[Business Continuity Planning]] [[Fault Tolerance]] [[RAID]]