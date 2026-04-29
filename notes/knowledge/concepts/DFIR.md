# DFIR

## What it is
Like a trauma surgeon who must simultaneously stabilize a dying patient *and* preserve evidence for a malpractice investigation, DFIR practitioners must contain active damage while keeping the forensic chain of custody intact. Digital Forensics and Incident Response is the combined discipline of investigating how a breach occurred (forensics) and actively stopping ongoing harm (incident response). These two functions are deliberately paired because response decisions made in panic routinely destroy the evidence needed to understand the attack.

## Why it matters
During the 2020 SolarWinds supply chain attack, responders had to simultaneously evict threat actors from thousands of networks *and* preserve artifacts — memory dumps, event logs, prefetch files — that revealed how SUNBURST malware achieved persistence via trojanized DLL updates. Teams that reimaged compromised hosts too quickly lost critical forensic evidence needed to determine the full blast radius, delaying attribution by months.

## Key facts
- The **IR lifecycle** (NIST SP 800-61) has four phases: Preparation → Detection & Analysis → Containment/Eradication/Recovery → Post-Incident Activity
- **Order of volatility** governs forensic collection: CPU registers and RAM are captured before disk, which is captured before logs — because faster-changing data disappears first
- **Chain of custody** documentation must be maintained throughout; without it, evidence is inadmissible and findings are challengeable
- A **write blocker** is mandatory during forensic disk imaging to prevent accidental modification of evidence
- Mean Time to Detect (MTTD) and Mean Time to Respond (MTTR) are the primary KPIs measuring IR program effectiveness; industry average MTTD in 2023 was ~204 days

## Related concepts
[[Incident Response]] [[Digital Forensics]] [[Chain of Custody]] [[SIEM]] [[Memory Forensics]]