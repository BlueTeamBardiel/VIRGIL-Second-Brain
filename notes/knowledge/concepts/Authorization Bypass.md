# authorization bypass

## What it is
Imagine a nightclub where the bouncer checks your ID at the front door, but the back door leads straight to the VIP section with no check at all — that's authorization bypass. It's a vulnerability where an attacker accesses resources or performs actions they are not permitted to, by circumventing the enforcement of access control policies rather than defeating authentication. The system knows *who* you are, but fails to properly enforce *what* you're allowed to do.

## Why it matters
In 2019, attackers exploited a Fortigate SSL VPN authorization bypass (CVE-2018-13379) to read sensitive session files — including plaintext credentials — without ever logging in, simply by crafting a malicious URL path traversal request. This demonstrates that even authenticated systems can hemorrhage data when authorization checks are applied inconsistently across endpoints. Defenders counter this by enforcing authorization at the server side on every request, never trusting client-supplied role or privilege data.

## Key facts
- **IDOR (Insecure Direct Object Reference)** is the most common form: changing a URL parameter from `user_id=42` to `user_id=43` to access another user's data
- Authorization bypass is distinct from authentication bypass — auth*entication* is proving identity; auth*orization* is enforcing what that identity can do
- OWASP categorizes this under **A01:2021 – Broken Access Control**, the #1 web application risk
- **Privilege escalation** (horizontal and vertical) is a direct consequence: horizontal means accessing peers' data; vertical means gaining higher-privilege actions
- Mitigation requires **deny-by-default** access control, enforced server-side, with every request validated against the user's actual permission set — not a role embedded in a cookie or JWT claim without server-side verification

## Related concepts
[[access control]] [[IDOR]] [[privilege escalation]] [[broken access control]] [[authentication bypass]]