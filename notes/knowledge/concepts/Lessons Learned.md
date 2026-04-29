# Lessons Learned

## What it is
Like a flight crew debriefing after a near-miss to prevent the next crash, a Lessons Learned session is the structured post-incident review where security teams systematically examine what happened, what worked, and what failed. It is a formal component of the incident response lifecycle — specifically the final phase — producing documented findings that improve future detection, response, and prevention.

## Why it matters
After the 2013 Target breach, forensic analysis revealed that FireEye alerts *had fired* but were ignored due to alert fatigue and unclear escalation paths. A rigorous Lessons Learned process would have identified this gap — that having detection tools is worthless without defined human response procedures — and produced actionable policy changes before attackers returned.

## Key facts
- Lessons Learned is the **final phase of the NIST SP 800-61 incident response lifecycle**, occurring after containment, eradication, and recovery are complete
- The session should be held **within two weeks** of incident closure while details remain fresh; delayed reviews produce weaker findings
- Outputs typically include an **After-Action Report (AAR)** documenting timeline, root cause, impact, and specific corrective actions with owners and deadlines
- Common findings drive updates to **runbooks, detection rules, access controls, and training programs** — not just vague "improve communication" platitudes
- Lessons Learned sessions must be **blameless in culture** but accountable in action; finger-pointing kills honest disclosure and degrades future sessions

## Related concepts
[[Incident Response Lifecycle]] [[After-Action Report]] [[Root Cause Analysis]] [[Post-Mortem Analysis]] [[Continuous Improvement]]