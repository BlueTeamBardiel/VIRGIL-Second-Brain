# MTBF

## What it is
Think of MTBF like a car engine rated for 150,000 miles — it's the manufacturer's statistical promise of how long it runs before breaking down. Mean Time Between Failures (MTBF) is a reliability metric expressing the average operational time expected between two consecutive failures of a repairable system or component. It's a predictive measure, not a guarantee, derived from historical failure data across large populations of devices.

## Why it matters
When designing a high-availability security infrastructure, a SOC architect choosing between two firewall models will compare MTBF values — a firewall with an MTBF of 100,000 hours is a far safer bet for a critical network chokepoint than one rated at 20,000 hours. An attacker aware that aging hardware is approaching its MTBF window might time a physical or logical attack during a scheduled maintenance window, when replacement and disruption are most likely. This makes MTBF a factor in both redundancy planning and adversarial risk modeling.

## Key facts
- MTBF is calculated as: **Total Operational Time ÷ Number of Failures**
- A higher MTBF means greater reliability; a firewall with MTBF of 200,000 hours is more reliable than one at 50,000 hours
- MTBF applies to **repairable** systems; for non-repairable components, the equivalent metric is **MTTF** (Mean Time To Failure)
- MTBF pairs with **MTTR** (Mean Time To Repair) to calculate overall system availability: **Availability = MTBF ÷ (MTBF + MTTR)**
- On Security+ exams, MTBF appears in the context of **business continuity, disaster recovery planning, and redundancy justification**

## Related concepts
[[MTTR]] [[High Availability]] [[Business Continuity Planning]] [[Redundancy]] [[RPO and RTO]]