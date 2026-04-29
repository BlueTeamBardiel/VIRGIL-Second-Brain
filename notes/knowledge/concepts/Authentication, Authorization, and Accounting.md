# Authentication, Authorization, and Accounting

## What it is
Think of a hotel: the front desk confirms *who you are* (authentication), your keycard only opens *your room* (authorization), and the hotel logs every door entry with a timestamp (accounting). Together, AAA is the three-part framework that controls and audits access to systems and resources — confirming identity, enforcing permissions, and maintaining a trail of activity.

## Why it matters
In 2016, attackers breached a U.S. utility's control network partly because shared credentials bypassed meaningful authentication, and no accounting logs existed to detect lateral movement. A properly implemented AAA architecture — such as RADIUS or TACACS+ — would have enforced individual authentication, limited each user's network segment access, and generated audit logs that could trigger anomaly alerts before critical systems were reached.

## Key facts
- **Authentication factors**: Something you know (password), something you have (token), something you are (biometrics) — MFA combines two or more
- **RADIUS** combines authentication and authorization in one response; **TACACS+** separates all three AAA functions, making it preferred for device administration
- **Accounting** produces non-repudiation evidence — logs that legally and forensically bind actions to identities
- Authorization models include **DAC** (owner-controlled), **MAC** (label-based), **RBAC** (role-based), and **ABAC** (attribute-based) — each enforcing permissions differently
- **OAuth 2.0** handles *authorization* only; it delegates access without sharing credentials, which is why it's used for "Sign in with Google" flows — not true authentication without OpenID Connect layered on top

## Related concepts
[[Multi-Factor Authentication]] [[RADIUS and TACACS+]] [[Access Control Models]] [[Identity and Access Management]] [[Non-Repudiation]]