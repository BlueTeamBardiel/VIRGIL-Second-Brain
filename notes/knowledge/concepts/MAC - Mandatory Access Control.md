# MAC - Mandatory Access Control

## What it is
Like a military base where your rank badge *physically won't open* certain doors regardless of who vouches for you — the building itself enforces the rule, not the guard. Mandatory Access Control is a policy model where the **operating system or kernel** enforces access decisions based on security labels (classifications), completely bypassing user or owner discretion. Neither the data owner nor the user can override these rules — only the system administrator or security policy can.

## Why it matters
In the 2010 Bradley Manning leak, the core failure was that a user with a *network-level* clearance could access and exfiltrate data far beyond operational need. A properly implemented MAC system (like SELinux with strict type enforcement) would have confined Manning's processes to only the specific data types his role's label explicitly permitted — bulk cross-category reads would have been denied at the kernel level before any data left the system.

## Key facts
- MAC uses **security labels** (e.g., Top Secret, Secret, Unclassified) assigned to both subjects (users/processes) and objects (files, ports) — access requires a label match or dominance
- The **Bell-LaPadula model** underpins MAC: "no read up, no write down" to prevent data leaking to lower classifications
- SELinux and AppArmor are real-world MAC implementations; SELinux ships enabled by default in RHEL/CentOS
- Unlike DAC, the **data owner cannot grant permissions** — control is centralized in the security policy
- MAC is mandatory for systems seeking **DoD/government certifications** (Common Criteria EAL4+ and above)

## Related concepts
[[DAC - Discretionary Access Control]] [[Bell-LaPadula Model]] [[SELinux]] [[Role-Based Access Control]] [[Security Labels and Classifications]]