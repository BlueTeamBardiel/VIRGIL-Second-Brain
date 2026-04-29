# session hijack

## What it is
Imagine someone steals your wristband at a festival after you've already passed the ID check — now they can access all the VIP areas without ever proving who they are. Session hijacking is exactly that: an attacker steals or forges a valid session token to impersonate an authenticated user, bypassing the login process entirely.

## Why it matters
In 2010, the Firesheep tool demonstrated mass session hijacking on open Wi-Fi networks by sniffing unencrypted HTTP cookies from sites like Facebook and Twitter. Anyone on the same network could click a name in Firesheep's sidebar and instantly log in as that user — no password required. This incident directly accelerated the industry-wide shift to HTTPS everywhere.

## Key facts
- **Session tokens** are the target — attackers steal them via packet sniffing, XSS, man-in-the-middle attacks, or by finding them exposed in URLs
- **Predictable session IDs** make brute-forcing feasible; secure implementations use cryptographically random tokens of sufficient length (≥128 bits)
- **HttpOnly** and **Secure** cookie flags are primary defenses: HttpOnly blocks JavaScript access (thwarting XSS theft), Secure forces HTTPS-only transmission
- **Session fixation** is a variant where the attacker *plants* a known session ID before authentication, rather than stealing one after
- Regenerating the session ID upon privilege escalation (especially after login) is a critical countermeasure mandated by OWASP

## Related concepts
[[Cross-Site Scripting (XSS)]] [[Man-in-the-Middle Attack]] [[Cookie Security]] [[Session Fixation]] [[Transport Layer Security (TLS)]]