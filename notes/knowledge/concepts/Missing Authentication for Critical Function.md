# Missing Authentication for Critical Function

## What it is
Imagine a bank vault with a combination lock on the front door — but someone left a side door wide open with no lock at all. Missing Authentication for Critical Function occurs when a system exposes high-privilege operations (password resets, admin controls, firmware updates) without requiring the caller to prove their identity first. It's classified as CWE-306 and is distinct from broken authentication — the check simply doesn't exist.

## Why it matters
In 2022, attackers exploited missing authentication in Hikvision IP cameras (CVE-2021-36260), sending a crafted HTTP request to a management endpoint that required zero credentials, achieving full remote code execution. A defender auditing the API would have caught this by mapping every sensitive endpoint and verifying each one enforced an authentication gate before processing requests.

## Key facts
- **CWE-306** is the formal identifier; it appears in the OWASP Top 10 under **A07:2021 – Identification and Authentication Failures**
- Common locations: internal microservice APIs, IoT device admin endpoints, backup/restore functions, and debug interfaces left enabled in production
- Attackers discover these endpoints via fuzzing, source code review, or Shodan scanning for exposed management ports
- Mitigation requires a **defense-in-depth** approach: API gateways enforcing authentication, network segmentation isolating admin interfaces, and threat modeling critical functions during design
- On the **Security+ exam**, this concept ties directly to improper API security and the principle of **least privilege** — unauthenticated access to critical functions violates both

## Related concepts
[[Broken Authentication]] [[Insecure Direct Object Reference]] [[Improper Authorization]] [[CWE-285]] [[API Security]]