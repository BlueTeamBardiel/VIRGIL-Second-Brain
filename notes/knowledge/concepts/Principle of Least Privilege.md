# principle of least privilege

## What it is
Like a hotel housekeeper who gets a master key only for their assigned floor during their shift — not every room, not the penthouse, not forever — least privilege means every user, process, or system gets only the minimum access rights needed to perform its specific function, and nothing more. Access is scoped by role, time, and necessity, not convenience.

## Why it matters
In the 2020 SolarWinds supply chain attack, the malicious Orion software update ran with broad administrative privileges across customer networks, allowing it to move laterally and exfiltrate data for months undetected. Had the Orion service account been constrained to only the network monitoring functions it actually needed, the blast radius of the compromise would have been dramatically smaller — attackers would have hit a wall at nearly every lateral movement attempt.

## Key facts
- Least privilege is a **foundational access control principle** and appears directly in frameworks like NIST SP 800-53 (AC-6) and CIS Controls
- **Privilege creep** — the gradual accumulation of excess access over time — is the most common violation; mitigated by periodic access reviews and re-certification
- Applies to **humans, service accounts, applications, and processes** equally; misconfigured service accounts are a top attack vector
- **Just-in-time (JIT) access** is the temporal enforcement of least privilege — granting elevated rights only for the duration of a specific task, then revoking them automatically
- Works in tandem with **separation of duties**: one limits *how much* access, the other limits *who can combine* sensitive functions

## Related concepts
[[separation of duties]] [[role-based access control]] [[privilege escalation]] [[zero trust architecture]] [[need to know]]