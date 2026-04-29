# Root Cause Analysis

## What it is
Like a doctor who doesn't just treat a fever but orders blood work to find the underlying infection, Root Cause Analysis (RCA) is the structured process of tracing an incident back to its fundamental origin rather than just fixing the visible symptom. It identifies *why* a failure occurred so the same failure cannot repeat, distinguishing between immediate causes (the door was unlocked) and root causes (the key management policy was never enforced).

## Why it matters
After the 2013 Target breach, investigators didn't stop at "attackers installed malware on POS systems." RCA traced the intrusion back to compromised credentials from a third-party HVAC vendor with excessive network access — the true root cause. Without that finding, Target could have patched the malware and remained vulnerable to the exact same attack vector through any other vendor.

## Key facts
- RCA is a core component of the **post-incident activity phase** in the NIST SP 800-61 incident response lifecycle
- Common RCA frameworks include **5 Whys** (iteratively asking "why" until the base cause emerges) and **Fishbone/Ishikawa diagrams** (categorizing contributing causes)
- RCA output should directly inform **corrective controls** — technical, administrative, or physical — to prevent recurrence
- RCA distinguishes between three cause types: **direct cause** (the action), **contributing cause** (conditions that enabled it), and **root cause** (the systemic failure)
- On CySA+ exams, RCA is closely tied to **lessons learned reports** and the concept of **continuous improvement** within security operations

## Related concepts
[[Incident Response Lifecycle]] [[Lessons Learned]] [[Post-Incident Analysis]] [[Five Whys]] [[NIST SP 800-61]]