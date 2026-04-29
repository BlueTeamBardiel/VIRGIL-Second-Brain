# authentication bypass

## What it is
Imagine a bouncer who checks IDs at the front door, but the kitchen entrance is unlocked and unguarded — an attacker just walks around. Authentication bypass is precisely that: an attacker gains access to a system or resource without supplying valid credentials by exploiting flaws in how authentication logic is implemented or enforced.

## Why it matters
In 2020, attackers exploited a Cisco ASA VPN authentication bypass (CVE-2020-3580) by sending a specially crafted URL that skipped credential validation entirely, granting unauthenticated access to internal networks. This class of vulnerability is why security teams must verify that every protected endpoint enforces authentication independently — not just at the front door.

## Key facts
- **SQL injection as bypass**: A classic technique uses `' OR '1'='1` in a login form to manipulate the SQL query so it returns true without a real password match.
- **JWT "none" algorithm attack**: Attackers modify a JSON Web Token's header to specify `"alg": "none"`, tricking servers that don't validate signatures into accepting a forged token.
- **Forced browsing**: Directly navigating to a privileged URL (e.g., `/admin/dashboard`) can bypass authentication if server-side access controls are absent and only the UI hides the link.
- **Parameter tampering**: Modifying hidden form fields or URL parameters (e.g., `?admin=true`) can escalate privilege if the server trusts client-supplied values.
- **Defense — defense-in-depth**: Mitigations include server-side session validation on every request, parameterized queries, strong token signature verification, and automated DAST scanning for unprotected endpoints.

## Related concepts
[[SQL injection]] [[broken access control]] [[session hijacking]] [[JWT vulnerabilities]] [[insecure direct object reference]]