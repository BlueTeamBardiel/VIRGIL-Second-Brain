# penetration testing

## What it is
Like hiring a locksmith to break into your own house before a burglar does — penetration testing is an authorized, simulated cyberattack against a system to find exploitable vulnerabilities before real adversaries do. A skilled tester methodically attempts to breach defenses using the same tools and techniques as malicious actors, then documents exactly how they succeeded.

## Why it matters
In 2020, a financial firm hired pen testers who successfully bypassed multi-factor authentication using an adversary-in-the-middle phishing proxy (Evilginx2), captured live session tokens, and accessed customer account data — all without triggering a single SIEM alert. The test revealed that their detection rules were tuned only for credential stuffing, leaving token hijacking completely invisible.

## Key facts
- **Rules of Engagement (ROE)** must be established in writing before testing begins — defining scope, allowed techniques, and emergency contacts; testing without authorization is a federal crime under the CFAA
- **Five phases**: Reconnaissance → Scanning/Enumeration → Exploitation → Post-Exploitation/Pivoting → Reporting
- **Black box** = no prior knowledge; **White box** = full access/source code; **Gray box** = partial knowledge (most common in real engagements)
- A **penetration test differs from a vulnerability scan** — scanners identify potential weaknesses; pen testers actively exploit them to confirm impact and chain vulnerabilities together
- The final **report must include an executive summary** (business risk language) AND technical findings with a CVSS score, evidence, and specific remediation steps

## Related concepts
[[vulnerability scanning]] [[red team vs blue team]] [[rules of engagement]] [[CVSS scoring]] [[social engineering]]