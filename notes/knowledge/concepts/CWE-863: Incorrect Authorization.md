# CWE-863: Incorrect Authorization

## What it is
Imagine a concert venue where the bouncer checks that you *have* a wristband, but never checks if your cheap general-admission band actually grants access to the VIP lounge — you just walk in. Incorrect Authorization means the system *does* perform an authorization check, but the logic is flawed, checking the wrong attribute, role, or condition. Unlike missing authorization (CWE-862), the gate exists — it just has the wrong lock.

## Why it matters
In 2019, a Shopify bug allowed any authenticated merchant to access other merchants' order data by manipulating resource IDs in API requests. The system confirmed the user was logged in and had *some* merchant role, but never verified ownership of the specific resource being requested — a textbook authorization logic flaw. An attacker could enumerate IDs and exfiltrate thousands of customer records.

## Key facts
- **Distinct from authentication failures**: The user's identity is confirmed; the error is in what that identity *permits* — critical distinction for CySA+ exam scenarios
- **IDOR is a common child vulnerability**: Insecure Direct Object Reference (CWE-639) is a specific instance where object ownership isn't validated
- **Horizontal vs. vertical privilege escalation**: Incorrect authorization enables both — horizontal (User A accessing User B's data) and vertical (regular user accessing admin functions)
- **OWASP Top 10 mapping**: Falls under A01:2021 — Broken Access Control, the #1 web application risk category
- **Common in role-based systems**: Errors often occur when developers check *role existence* rather than *role-to-resource* mapping (e.g., "is admin?" instead of "is admin of *this* tenant?")

## Related concepts
[[Broken Access Control]] [[CWE-862 Missing Authorization]] [[Insecure Direct Object Reference]] [[Privilege Escalation]] [[Role-Based Access Control]]