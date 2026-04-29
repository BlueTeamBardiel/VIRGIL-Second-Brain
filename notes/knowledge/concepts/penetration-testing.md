# penetration-testing

## What it is
Like hiring a professional locksmith to break into your own house before a burglar does — penetration testing is a structured, authorized attempt to exploit vulnerabilities in a system before real attackers can. It simulates adversarial techniques against defined targets to measure actual exploitability, not just theoretical risk.

## Why it matters
In 2020, a penetration test against a U.S. financial firm revealed that testers could pivot from a phishing email to domain administrator access in under four hours — a path the organization's vulnerability scanner had never flagged. This directly drove a network segmentation overhaul that would have been deprioritized without the concrete proof of exploitability.

## Key facts
- **Rules of Engagement (ROE)** define scope, permitted techniques, timeline, and emergency contacts — operating outside them is illegal regardless of employer authorization
- Pen testing phases follow a standard lifecycle: **Reconnaissance → Scanning → Exploitation → Post-Exploitation → Reporting**
- **White-box** testing gives full system knowledge; **black-box** simulates an external attacker; **gray-box** provides partial information (most common in real engagements)
- A **penetration test differs from a vulnerability assessment**: pen testing actively exploits weaknesses to confirm impact; vulnerability assessments only identify and rank them
- Findings are classified by **CVSS scores** and must be documented with evidence (screenshots, logs) to produce an actionable remediation report

## Related concepts
[[vulnerability-scanning]] [[red-team-vs-blue-team]] [[rules-of-engagement]] [[exploit-frameworks]] [[post-exploitation]]