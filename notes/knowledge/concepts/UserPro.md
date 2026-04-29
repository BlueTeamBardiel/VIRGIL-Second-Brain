# UserPro

## What it is
Like a master key ring handed to a new tenant before the locks have been changed, UserPro is a WordPress plugin that manages user registration, profiles, and authentication — but ships with a history of severe access control vulnerabilities. Precisely, it is a premium WordPress membership plugin that handles front-end login, custom user profiles, and role management, making it a high-value target due to its privileged access to user data and authentication flows.

## Why it matters
In 2023, researchers discovered a critical authentication bypass vulnerability (CVE-2023-2986) in UserPro versions prior to 5.1.1, allowing unauthenticated attackers to log in as any user — including administrators — by exploiting weak token validation in the password reset flow. An attacker could enumerate user emails, trigger a reset, intercept or guess the predictable token, and achieve full site takeover without knowing any credentials. This exemplifies how plugins extending WordPress's authentication surface dramatically expand the attack footprint.

## Key facts
- CVE-2023-2986 is an **authentication bypass** (CVSS 9.8 Critical) affecting UserPro < 5.1.1, caused by insufficient token verification during account confirmation.
- The vulnerability class is **Insecure Direct Object Reference (IDOR)** combined with **broken authentication**, both mapped to OWASP Top 10 A07 (Identification and Authentication Failures).
- UserPro also carried **privilege escalation** vulnerabilities allowing subscriber-level users to change their own role to administrator via parameter tampering.
- WordPress plugins represent over **90% of WordPress vulnerabilities** — third-party code extending core is consistently the weakest link.
- Remediation requires **input validation**, **cryptographically secure token generation** (e.g., `wp_generate_password(20, false)`), and **rate limiting** on reset endpoints.

## Related concepts
[[Authentication Bypass]] [[Insecure Direct Object Reference]] [[Privilege Escalation]] [[Broken Access Control]] [[WordPress Security]]