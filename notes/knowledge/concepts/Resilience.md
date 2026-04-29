# Resilience

## What it is
Like a suspension bridge that sways in a hurricane but stays standing — and still carries traffic — resilience is a system's ability to absorb disruption, continue operating at reduced capacity if necessary, and recover to full function. Precisely: resilience is the organizational and technical capacity to withstand adverse events (attacks, failures, disasters) while maintaining acceptable service continuity and returning to normal operations within defined recovery objectives.

## Why it matters
During the 2021 Colonial Pipeline ransomware attack, the company shut down operations not because the pipeline's industrial control systems were compromised, but because their billing systems were — a failure of resilience planning. A truly resilient architecture would have isolated the billing impact and maintained pipeline operations, preventing the fuel shortage that followed. Resilience thinking asks: *can we keep the mission alive even when part of the system fails?*

## Key facts
- **RTO (Recovery Time Objective)** defines the maximum acceptable downtime; **RPO (Recovery Point Objective)** defines the maximum acceptable data loss — both are core resilience metrics on Security+/CySA+ exams
- Resilience differs from redundancy: redundancy is a *mechanism*; resilience is the *outcome* that redundancy (among other controls) helps achieve
- The NIST Cybersecurity Framework explicitly separates **Respond** and **Recover** functions, both targeting organizational resilience
- Tabletop exercises and business continuity planning (BCP) are primary tools for *testing* resilience before a real event
- Defense-in-depth contributes to resilience by ensuring no single point of failure can cause total system compromise

## Related concepts
[[Business Continuity Planning]] [[Disaster Recovery]] [[Redundancy]] [[Defense in Depth]] [[Incident Response]]