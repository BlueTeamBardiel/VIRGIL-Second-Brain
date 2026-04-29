# Uptime

## What it is
Like a hospital's emergency room that must never close — not for lunch, not for storms, not for maintenance — uptime measures the percentage of time a system remains operational and available. Precisely, it is the ratio of actual service availability to total scheduled time, expressed as a percentage (e.g., 99.9% = "three nines"). It is a core metric of the **Availability** pillar in the CIA Triad.

## Why it matters
Denial-of-Service (DoS) and Distributed DoS (DDoS) attacks are direct attacks on uptime — adversaries flood a target with traffic until legitimate users are locked out, dropping availability to 0%. A 2016 DDoS against Dyn DNS knocked major platforms including Twitter and Netflix offline for hours, costing millions in revenue and demonstrating that availability failures have cascading real-world consequences.

## Key facts
- **Five nines (99.999%)** allows only ~5.26 minutes of downtime per year — the gold standard for critical infrastructure.
- Uptime is formally guaranteed through **Service Level Agreements (SLAs)**, which define penalties when thresholds are missed.
- **Mean Time Between Failures (MTBF)** and **Mean Time To Recover (MTTR)** are the engineering metrics that directly drive uptime calculations.
- Redundancy mechanisms — **failover clustering, load balancing, and hot/warm/cold sites** — are primary technical controls used to maintain uptime.
- Security+ frames uptime as an **Availability** concern; threats to it include DDoS, ransomware, power failure, and hardware faults.

## Related concepts
[[CIA Triad]] [[Denial of Service (DoS)]] [[High Availability]] [[Disaster Recovery]] [[Service Level Agreement (SLA)]]