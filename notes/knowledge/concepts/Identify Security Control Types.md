# Identify Security Control Types

## What it is
Think of security controls like layers of a medieval castle: the moat (preventive), the guards watching towers (detective), and the backup supply routes if the castle falls (corrective). Precisely, security control types are classified by **when** and **how** they act — Preventive, Detective, Corrective, Deterrent, Compensating, and Directive — and by **implementation category**: Technical, Managerial, Operational, or Physical.

## Why it matters
During a ransomware incident, an organization discovers it had antivirus (preventive/technical) and audit logs (detective/technical) but no tested backups. The absence of a corrective control turned a containable incident into a $2M recovery. Mapping controls to types exposes exactly these gaps before attackers do.

## Key facts
- **Control Types (function-based):** Preventive stops attacks before they happen; Detective identifies them during or after; Corrective restores systems post-incident; Deterrent discourages attackers (e.g., warning banners); Compensating substitutes for a primary control that can't be implemented; Directive mandates behavior through policy.
- **Control Categories (implementation-based):** Technical (firewalls, encryption), Managerial (risk assessments, policies), Operational (security awareness training, background checks), Physical (fences, badge readers).
- A single control can belong to **multiple types**: a security camera is both Detective *and* Deterrent; an IPS is both Preventive *and* Detective.
- **Compensating controls** are critical on Security+/CySA+ — they must provide equivalent protection when the primary control is infeasible (e.g., network segmentation when a legacy system can't be patched).
- Directive controls are the most commonly overlooked category — they include **policies, procedures, and regulations** that mandate security behavior rather than enforce it technically.

## Related concepts
[[Defense in Depth]] [[Risk Management Framework]] [[Compensating Controls]] [[Security Policies]] [[Vulnerability Management]]