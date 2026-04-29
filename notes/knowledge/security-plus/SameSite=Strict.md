# SameSite=Strict

## What it is
Like a bouncer who only lets in guests who were *already inside the building* — if you arrive from anywhere external, you're turned away at the door. `SameSite=Strict` is a cookie attribute that instructs the browser to **never** send the cookie along with requests originating from a different site, including navigation links clicked in emails, third-party pages, or any cross-site context whatsoever.

## Why it matters
CSRF (Cross-Site Request Forgery) attacks rely on a victim's authenticated cookie being silently attached to a forged request triggered from an attacker's site. With `SameSite=Strict` on the session cookie, when a victim clicks a malicious link on `evil.com` that targets `bank.com`, the browser withholds the session cookie entirely — the forged request arrives unauthenticated and fails, neutralizing the attack without any token-based CSRF countermeasure.

## Key facts
- `SameSite=Strict` is the most restrictive of three values: **Strict**, **Lax**, and **None**
- The cookie is sent **only** when the request origin matches the cookie's domain exactly — even a top-level navigation from an external link suppresses it
- `SameSite=Lax` (the browser default since ~2020) allows the cookie on top-level GET navigations; `Strict` does not
- A practical trade-off: `Strict` can break legitimate UX flows — e.g., clicking a shared link to a banking dashboard logs you in without session context, forcing re-authentication
- `SameSite=None` requires the `Secure` flag and is used for intentional cross-site cookie sharing (e.g., embedded widgets, OAuth flows)

## Related concepts
[[Cross-Site Request Forgery (CSRF)]] [[Cookie Security Attributes]] [[SameSite=Lax]] [[Secure Flag]] [[Same-Origin Policy]]