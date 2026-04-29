# Post-Incident Activity

## What it is
Like a flight crew debriefing after an emergency landing — reviewing every decision, every alarm, every action taken — post-incident activity is the structured phase where an organization analyzes a security incident *after* containment to extract lessons and harden defenses. It encompasses the lessons-learned meeting, evidence retention, documentation finalization, and control improvements that follow the incident response lifecycle's resolution phase.

## Why it matters
After the 2013 Target breach, investigators found that alerts from FireEye's malware detection tool had triggered *before* card data was exfiltrated — but no one acted on them. A rigorous post-incident review would have surfaced this gap in the alert-response workflow, potentially preventing 40 million stolen card numbers from becoming a headline. Post-incident activity turns expensive failures into institutional knowledge.

## Key facts
- The **lessons-learned meeting** should occur within **two weeks** of incident resolution while details remain fresh — NIST SP 800-61r2 explicitly recommends this timeframe.
- Evidence must be retained according to organizational policy and legal requirements; chain of custody documentation created during the incident must be preserved intact.
- Outputs include an **incident report**, updated playbooks/runbooks, and recommended control changes — all feeding back into the Preparation phase of the IR lifecycle.
- Metrics collected include **Mean Time to Detect (MTTD)** and **Mean Time to Respond (MTTR)**, used to benchmark future incident handling effectiveness.
- Recurrence prevention measures — patching exploited vulnerabilities, revoking compromised credentials, updating detection signatures — are formally tracked and assigned ownership during this phase.

## Related concepts
[[Incident Response Lifecycle]] [[Lessons Learned]] [[Chain of Custody]] [[Mean Time to Respond]] [[NIST SP 800-61]]