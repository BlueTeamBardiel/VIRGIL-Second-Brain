# Uptime Percentage

## What it is
Like a heart monitor measuring what percentage of the day a patient's heart beat normally, uptime percentage measures what fraction of scheduled time a system remained operational and accessible. It is calculated as `(Total Time - Downtime) / Total Time × 100` and is the primary metric for quantifying system availability in SLAs and continuity planning.

## Why it matters
During a DDoS attack against a financial institution, incident responders track uptime percentage in real time to determine whether SLA thresholds are being breached — triggering contractual penalties and escalation procedures. Defenders use historical uptime data to calculate Mean Time Between Failures (MTBF) and justify investment in redundant infrastructure before the next attack.

## Key facts
- **The Nines framework** defines availability tiers: 99% ("two nines") = ~3.65 days downtime/year; 99.9% = ~8.76 hours; 99.99% = ~52.6 minutes; 99.999% ("five nines") = ~5.26 minutes
- Uptime percentage directly maps to **Availability**, the "A" in the CIA triad, and is a core metric in Business Impact Analyses (BIA)
- SLAs for critical systems (banking, healthcare) typically require **99.9% or higher**; missing this triggers financial penalties or contract termination
- Planned maintenance windows **count against uptime** unless specifically excluded in SLA language — a common exam trick
- Recovery Time Objective (RTO) is operationally linked: a shorter RTO directly supports achieving higher uptime percentages after an incident

## Related concepts
[[Availability (CIA Triad)]] [[Service Level Agreement (SLA)]] [[Recovery Time Objective (RTO)]] [[Business Impact Analysis (BIA)]] [[Mean Time Between Failures (MTBF)]]