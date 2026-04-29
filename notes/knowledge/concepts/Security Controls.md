# Security Controls

## What it is
Like a medieval castle's layered defenses — moat, drawbridge, guards, and vault — security controls are the deliberate mechanisms layered to protect assets. Precisely defined, security controls are safeguards or countermeasures implemented to avoid, detect, counteract, or minimize security risks to assets. They are categorized by *type* (what they do) and *category* (how they're implemented).

## Why it matters
In the 2013 Target breach, attackers gained network access via a third-party HVAC vendor. Proper **network segmentation** (a technical, preventive control) would have isolated point-of-sale systems from vendor-accessible networks — stopping lateral movement before 40 million credit cards were exfiltrated. The breach exposed that missing a single control layer can collapse an entire defense posture.

## Key facts
- **Control Types** by function: *Preventive* (block attacks), *Detective* (identify incidents), *Corrective* (remediate damage), *Deterrent* (discourage attackers), *Compensating* (alternative when primary control isn't feasible), *Directive* (establish policy behavior)
- **Control Categories** by implementation: *Technical* (firewalls, encryption), *Administrative/Managerial* (policies, training), *Physical* (locks, cameras)
- **Compensating controls** are critical for legacy systems — e.g., placing an unpatched machine behind a firewall when patching is impossible
- **Defense in Depth** is the strategy of stacking multiple control types so no single failure is catastrophic
- On Security+ exams, "deterrent" and "preventive" are frequently confused — deterrents *discourage* (warning banners), preventive controls *block* (access control lists)

## Related concepts
[[Defense in Depth]] [[Risk Management]] [[Access Control]] [[Network Segmentation]] [[Compensating Controls]]