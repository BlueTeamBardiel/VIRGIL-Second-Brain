# CSRF nonce

## What it is
Like a secret handshake that changes every time you meet — a CSRF nonce (also called an anti-CSRF token) is a unique, unpredictable value embedded in a web form that the server generates per-session or per-request and validates on submission. If the submitted token doesn't match what the server issued, the request is rejected as forged. The word "nonce" literally means "number used once."

## Why it matters
In 2008, a CSRF vulnerability in a major banking application allowed attackers to craft a malicious webpage that silently submitted a funds-transfer form when a logged-in victim visited it — the browser automatically sent session cookies, and the server had no way to distinguish the legitimate user's intent from the forged request. A properly implemented CSRF nonce would have blocked this because the attacker's page cannot read the hidden token value due to the Same-Origin Policy, making the forged submission fail server-side validation.

## Key facts
- The token must be **cryptographically random** (at minimum 128 bits of entropy); sequential or predictable tokens are trivially bypassed
- Tokens should be **tied to the user's session**, not shared globally across users or requests
- **Double-submit cookie** is an alternative pattern: the same random value is placed in both a cookie and a form field, and the server checks that they match
- The **SameSite cookie attribute** (`Strict` or `Lax`) is a modern defense that complements but does not fully replace CSRF tokens
- CSRF attacks exploit **trust the server has in the browser**, while XSS exploits trust the browser has in the server — they are mirror threats

## Related concepts
[[Cross-Site Request Forgery]] [[SameSite Cookie Attribute]] [[Same-Origin Policy]] [[Session Tokens]] [[Cross-Site Scripting]]