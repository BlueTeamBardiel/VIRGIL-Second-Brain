# auth bypass

## What it is
Like slipping through a back door of a theater while the bouncer watches the front entrance, auth bypass tricks a system into granting access without ever actually verifying credentials. It is a vulnerability where an attacker circumvents authentication mechanisms entirely — not by cracking a password, but by exploiting flawed logic, misconfigured controls, or implementation errors that let the system *skip* the verification step altogether.

## Why it matters
In 2021, attackers exploited an auth bypass in Fortinet's SSL VPN (CVE-2018-13379 combined with related flaws) to access enterprise networks without valid credentials, compromising thousands of organizations including government targets. Defenders must audit every code path that leads to protected resources — even "unreachable" endpoints — because developers often leave alternative routes that bypass the main login flow.

## Key facts
- **Common techniques**: SQL injection in login forms (`' OR '1'='1`), JWT `alg:none` manipulation, forced browsing to authenticated pages directly, and parameter tampering (changing `role=user` to `role=admin`)
- **JWT alg:none attack**: If a server accepts tokens with the algorithm set to "none," an attacker can forge a valid-looking token with no signature
- **IDOR vs auth bypass**: IDOR assumes you're authenticated but accesses unauthorized *objects*; auth bypass skips authentication entirely — both are broken access control variants
- **Testing approach**: Tools like Burp Suite's Auth Analyzer extension and manual forced-browsing using sitemaps/robots.txt help discover unprotected endpoints
- **OWASP Top 10 mapping**: Auth bypass falls under A07:2021 (Identification and Authentication Failures) and A01:2021 (Broken Access Control) depending on the specific mechanism exploited

## Related concepts
[[broken access control]] [[SQL injection]] [[JWT attacks]] [[session hijacking]] [[IDOR]]