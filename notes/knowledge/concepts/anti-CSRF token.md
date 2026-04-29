# anti-CSRF token

## What it is
Think of it like a secret handshake that only your browser tab and the server share — a forged request from a malicious site can't reproduce it because it never had the handshake. Precisely: an anti-CSRF token is a unique, unpredictable, session-tied value embedded in HTML forms or request headers that the server validates before processing any state-changing request. If the submitted token doesn't match the server's expected value, the request is rejected as potentially forged.

## Why it matters
In 2008, a CSRF vulnerability in a major bank's transfer form allowed attackers to embed a hidden `<img>` tag on a malicious site — when a logged-in victim visited the page, their browser silently sent an authenticated GET request transferring funds. An anti-CSRF token would have blocked this: the attacker's page has no way to read or replicate the secret token from the victim's legitimate session due to the browser's same-origin policy.

## Key facts
- Tokens must be **cryptographically random** (≥128 bits of entropy) and unique per session or per request to prevent guessing attacks
- The **Synchronizer Token Pattern** stores the token server-side and compares it against the submitted value; the **Double Submit Cookie** pattern compares a cookie value against a request parameter without server-side storage
- Anti-CSRF tokens are **ineffective if XSS exists** — script injection lets attackers read the token from the DOM directly
- The `SameSite` cookie attribute (`Strict` or `Lax`) is a modern complement that reduces CSRF risk by restricting cross-origin cookie transmission
- CSRF tokens should be placed in **request bodies or custom headers**, never in URLs, to prevent leakage via Referer headers or server logs

## Related concepts
[[Cross-Site Request Forgery (CSRF)]] [[SameSite Cookie Attribute]] [[Cross-Site Scripting (XSS)]] [[Same-Origin Policy]]