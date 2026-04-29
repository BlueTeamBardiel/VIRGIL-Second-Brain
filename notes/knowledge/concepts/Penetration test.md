# penetration test

## What it is
Like hiring a professional lockpicker to try every door and window before you open your hotel to guests — a penetration test is an authorized, simulated cyberattack conducted by security professionals to identify exploitable vulnerabilities in a system before real attackers do. Unlike a vulnerability scan that merely lists weaknesses, a pentest actively exploits them to measure real-world impact.

## Why it matters
In 2020, a financial firm hired red teamers who successfully chained together an unpatched VPN appliance, weak internal credentials, and misconfigured Active Directory to achieve domain admin access — none of which their vulnerability scanner flagged as critical individually. The pentest revealed that the combination of low-severity findings created a catastrophic attack path, prompting a complete remediation overhaul before a real breach occurred.

## Key facts
- **Rules of Engagement (ROE)** must be documented before testing begins — defining scope, allowed techniques, and emergency stop conditions
- The five phases are: **Reconnaissance → Scanning → Exploitation → Post-exploitation → Reporting**
- **White-box** testing gives full system knowledge; **black-box** simulates an outside attacker; **gray-box** is a hybrid — all three appear on Security+ exams
- Pentests require explicit **written authorization**; testing without it is illegal under the CFAA regardless of intent
- A pentest produces a formal report with **findings, risk ratings (CVSS scores), and remediation recommendations** — the deliverable is actionable intelligence, not just a list of holes

## Related concepts
[[vulnerability scan]] [[red team]] [[rules of engagement]] [[CVSSv3]] [[privilege escalation]]