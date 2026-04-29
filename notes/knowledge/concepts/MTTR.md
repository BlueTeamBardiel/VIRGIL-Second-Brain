# MTTR

## What it is
Like timing how long it takes a pit crew to fix a blown tire and get the car back on track, MTTR measures your team's repair speed after something breaks. Mean Time to Repair (or Recover) is the average elapsed time between when an incident is detected and when systems are fully restored to normal operation.

## Why it matters
During the 2017 NotPetya attack, organizations with practiced incident response playbooks restored operations in days; those without clear runbooks took weeks — some permanently lost data. A low MTTR meant the difference between a painful incident and an existential business event. Security teams track MTTR specifically to identify bottlenecks in their detection-to-recovery pipeline.

## Key facts
- **Formula:** MTTR = Total downtime across all incidents ÷ Number of incidents (measured in hours or minutes)
- MTTR is a **reactive** metric — it measures response *after* failure, distinguishing it from MTTF (Mean Time to Failure), which is predictive
- CySA+ specifically pairs MTTR with **MTTD (Mean Time to Detect)** — a low MTTD with high MTTR indicates detection is fine but remediation is broken
- Organizations targeting SOC efficiency use MTTR benchmarks: industry average for breach containment is ~24 days (IBM Cost of a Data Breach Report); best-in-class teams aim for hours
- Reducing MTTR relies on **automation** (SOAR playbooks), clear escalation paths, and pre-authorized remediation actions — not just faster humans

## Related concepts
[[MTTD]] [[MTTF]] [[Incident Response]] [[SOAR]] [[Business Continuity Planning]]