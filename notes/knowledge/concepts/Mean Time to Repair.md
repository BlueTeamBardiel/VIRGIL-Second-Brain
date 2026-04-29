# Mean Time to Repair

## What it is
Like a pit crew's average tire-change time tells you how fast a racing team recovers from a blowout, Mean Time to Repair (MTTR) measures how long it takes an organization to restore a system or service after a failure or incident. Precisely, MTTR is the average elapsed time from when a failure is detected to when full functionality is restored. It captures recovery speed, not failure frequency.

## Why it matters
During a ransomware attack that encrypts a hospital's patient management system, MTTR becomes a life-or-death operational metric — administrators need to know realistically how long it takes to restore from clean backups before deciding whether to pay the ransom. A high MTTR (say, 72 hours) may indicate weak backup procedures, insufficient IR staffing, or poor runbook documentation, all of which attackers exploit when timing extortion pressure. Organizations that regularly measure and drill MTTR can negotiate from a position of strength.

## Key facts
- MTTR is calculated as: **Total Repair Time ÷ Number of Incidents** over a given period
- MTTR specifically measures **repair and restoration time**, not detection time — detection lag is captured by Mean Time to Detect (MTTD)
- Lower MTTR directly improves **Recovery Time Objective (RTO)** compliance; if MTTR consistently exceeds RTO, the BCP/DRP is failing
- On Security+/CySA+ exams, MTTR is grouped with **MTTF** (Mean Time to Failure) and **MTBF** (Mean Time Between Failures) as core availability metrics
- MTTR can be reduced through automation (e.g., SOAR playbooks), pre-staged spare hardware, and regularly tested **runbooks**

## Related concepts
[[Mean Time Between Failures]] [[Recovery Time Objective]] [[Business Continuity Planning]] [[Incident Response]] [[SOAR]]