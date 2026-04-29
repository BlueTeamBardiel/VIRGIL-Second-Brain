# CSRF

## What it is
Imagine a forged letter using your official letterhead, sent by someone else — the bank acts on it because it looks like it came from you. Cross-Site Request Forgery (CSRF) tricks an authenticated user's browser into unknowingly submitting a malicious request to a trusted site, exploiting the fact that the browser automatically includes session cookies with every request. The attack abuses *trust the server has in the user's browser*, not trust the user has in a site.

## Why it matters
In 2008, a CSRF vulnerability in a major router's admin panel allowed attackers to change DNS settings simply by getting users to visit a malicious page — the browser silently sent authenticated requests to `192.168.1.1` on their behalf. The victim never typed a thing, yet their traffic was redirected to attacker-controlled servers. This illustrates why CSRF is dangerous even without stealing credentials.

## Key facts
- CSRF exploits the browser's automatic cookie-sending behavior — not an XSS or injection flaw
- The primary defense is the **anti-CSRF token** (synchronizer token pattern): a unique, unpredictable value embedded in forms that the server validates
- **SameSite cookie attribute** (`Strict` or `Lax`) is a modern, highly effective CSRF mitigation baked into browsers
- CSRF attacks only inherit the victim's *existing permissions* — they cannot read responses (unlike XSS), making them blind attacks
- HTTP methods matter: GET requests should never trigger state changes; POST/PUT/DELETE are the typical CSRF targets
- Checking the `Origin` or `Referer` header is a secondary defense but can be spoofed or stripped in some environments

## Related concepts
[[Cross-Site Scripting (XSS)]] [[Session Hijacking]] [[Same-Origin Policy]] [[Cookie Security Flags]] [[Clickjacking]]