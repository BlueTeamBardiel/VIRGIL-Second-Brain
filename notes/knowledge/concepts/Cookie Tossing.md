# Cookie Tossing

## What it is
Imagine a hotel front desk that accepts any key card labeled "Room 404" — even ones issued by a rogue staff member in the lobby. Cookie tossing is an attack where an adversary plants a forged or crafted cookie from a *parent domain* (e.g., `.example.com`) that overrides or shadows the legitimate cookie set by a subdomain (e.g., `secure.example.com`), hijacking session behavior without ever stealing the real cookie.

## Why it matters
An attacker who can execute JavaScript on any subdomain of a target domain — perhaps through a vulnerable blog at `blog.example.com` — can set a cookie scoped to `.example.com`. When the victim later visits `banking.example.com`, the browser sends the attacker's cookie *first*, potentially forcing a session fixation condition where the victim authenticates into an attacker-controlled session ID.

## Key facts
- Browsers do **not** enforce cookie integrity by origin — they will send multiple cookies matching a domain/path, and servers typically use the **first match**, making shadowing possible.
- Cookie tossing is closely related to **session fixation**: the attacker pre-sets a known session token, then waits for the victim to authenticate with it.
- The attack requires the ability to **set cookies on a parent or sibling domain** — typically via XSS on any subdomain.
- The `__Host-` cookie prefix **mitigates** cookie tossing by requiring the cookie to be set from the exact host with no `Domain` attribute, preventing parent-domain cookies from interfering.
- RFC 6265 acknowledges this as a known weakness — domain-scoped cookies were never designed with subdomain isolation in mind.

## Related concepts
[[Session Fixation]] [[Cross-Site Scripting (XSS)]] [[Cookie Scope and Attributes]] [[Same-Origin Policy]] [[HTTP Cookie Prefixes]]