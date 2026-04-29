# Failback

## What it is
Like a sports team's star player returning from injury to reclaim their starting position, failback is the process of returning operations to the original primary system after it has been restored following a failure. Specifically, it is the planned cutover from a secondary/failover system back to the restored primary system after the root cause of the outage has been resolved.

## Why it matters
After a ransomware attack forces a hospital to failover to its backup systems, the IT team must carefully plan failback to the primary infrastructure once it's been rebuilt and hardened. A rushed, unplanned failback risks reintroducing vulnerabilities — or even re-infecting the primary system — if proper verification steps are skipped before restoring production traffic.

## Key facts
- Failback is distinct from **failover**: failover moves to the backup; failback returns to the primary
- Failback must include **data synchronization** — changes made on the secondary system during the outage must be replicated back to the primary before cutover
- A **failback test** should be part of any Business Continuity Plan (BCP) and Disaster Recovery Plan (DRP); testing failover without testing failback leaves a critical gap
- Failback can be **automatic or manual**; manual failback is preferred in security-sensitive environments because it allows human verification of primary system integrity
- Improper failback is a common cause of **secondary outages** — it can disrupt active user sessions, corrupt data, or reintroduce patched-over misconfigurations

## Related concepts
[[Failover]] [[Business Continuity Planning]] [[Disaster Recovery]] [[High Availability]] [[Recovery Time Objective]]