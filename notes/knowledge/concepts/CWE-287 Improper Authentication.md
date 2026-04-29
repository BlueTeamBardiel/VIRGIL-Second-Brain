# CWE-287 Improper Authentication

## What it is
Imagine a nightclub bouncer who waves people through without checking IDs because they *look* old enough — that's improper authentication. It occurs when a system fails to adequately verify that a claimed identity is actually who they say they are, allowing attackers to bypass authentication controls entirely or through flimsy verification. This weakness is distinct from broken password logic — it covers *any* failure to properly prove identity before granting access.

## Why it matters
In 2012, Dropbox suffered a breach where an employee's stolen password — used without MFA — granted attackers access to a file containing millions of user email addresses, leading to spam campaigns and credential stuffing attacks years later. Had Dropbox enforced proper multi-factor authentication on privileged accounts, the authentication bypass would have been blocked even with valid credentials in hand.

## Key facts
- CWE-287 is a **parent weakness** encompassing more specific failures like CWE-306 (Missing Authentication), CWE-290 (Spoofing-based bypass), and CWE-294 (Capture-Replay attacks)
- Common manifestations include: trusting client-supplied identity values, skipping authentication on "internal" API endpoints, and accepting expired or forged tokens
- Authentication failures consistently appear in **OWASP Top 10** (A07:2021 — Identification and Authentication Failures)
- Attackers exploit this via **forced browsing** — directly navigating to authenticated URLs without going through the login flow
- Mitigations include: enforcing server-side session validation, implementing MFA, using tested authentication libraries rather than homegrown solutions, and setting secure session timeouts

## Related concepts
[[Multi-Factor Authentication]] [[Session Management]] [[CWE-306 Missing Authentication for Critical Function]] [[Broken Access Control]] [[Credential Stuffing]]