# secondary payload

## What it is
Like a Russian nesting doll where the outer shell just exists to open and reveal what's really inside, a secondary payload is the *actual* malicious code delivered after an initial dropper or loader has established a foothold. The first-stage malware's only job is survival and delivery; the secondary payload — a RAT, ransomware, or credential stealer — is the true objective.

## Why it matters
In the 2020 SolarWinds supply chain attack, the initial SUNBURST backdoor acted as a first-stage implant that profiled victim environments before selectively delivering TEARDROP, a secondary payload that loaded Cobalt Strike beacons on high-value targets. Defenders who only detected and removed SUNBURST without hunting for subsequent payloads left active Cobalt Strike sessions running undetected.

## Key facts
- Secondary payloads are commonly delivered via **staged malware architectures** — the stager is small and stealthy; the real payload downloads only if the environment passes anti-analysis checks (no sandbox, correct victim profile)
- Common delivery mechanisms include **process injection**, living-off-the-land binaries (LOLBins), and encrypted C2 channels to evade signature detection
- Ransomware groups routinely use secondary payloads — Emotet delivers TrickBot, which then delivers Ryuk/Conti — forming a **malware-as-a-service chain**
- Defenders should treat any identified dropper as a **presumed compromise indicator**, not a contained incident — assume a secondary payload was already deployed
- On Security+/CySA+ exams, secondary payloads relate to **multi-stage attack frameworks** and the importance of full incident scope analysis rather than treating first-stage detection as remediation complete

## Related concepts
[[dropper]] [[command and control (C2)]] [[staged payload]] [[malware persistence]] [[lateral movement]]