# Session Riding

## What it is
Imagine someone slips a forged check into your stack of signed blank checks — the bank sees your real signature and honors it. Session riding (Cross-Site Request Forgery, CSRF) works the same way: an attacker tricks your already-authenticated browser into sending a forged HTTP request to a site where you're logged in, using your real session cookie without your knowledge.

## Why it matters
A classic attack embeds a hidden `<img>` tag pointing to `https://bank.com/transfer?amount=5000&to=attacker` in a malicious email. When the victim opens the email while logged into their bank, the browser dutifully fires the GET request with the valid session cookie attached — and the transfer executes. The bank's server sees a legitimate authenticated request and complies.

## Key facts
- CSRF exploits the browser's automatic inclusion of cookies with every matching-domain request — the attacker never needs to *steal* the token, just *ride* it
- Primary defense is the **synchronizer token pattern**: a secret, per-session random token embedded in forms that the server validates before processing state-changing requests
- The `SameSite` cookie attribute (`Strict` or `Lax`) is a modern, browser-enforced defense that blocks cross-origin requests from including the cookie
- CSRF primarily threatens **state-changing requests** (POST, PUT, DELETE); GET requests should never trigger side effects (per REST principles), though GET-based CSRF is possible if developers violate this
- Double-submit cookie pattern and custom request headers (e.g., `X-Requested-With`) are additional mitigations used when synchronizer tokens are impractical

## Related concepts
[[Cross-Site Scripting (XSS)]] [[Session Hijacking]] [[Same-Origin Policy]] [[Cookie Security Flags]]