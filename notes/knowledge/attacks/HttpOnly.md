# HttpOnly

## What it is
Think of it like a safe-deposit box where the bank teller can send and receive it, but you — the customer standing at the counter — can never personally open or handle it. HttpOnly is a flag you set on an HTTP cookie that instructs the browser to block JavaScript from accessing that cookie via `document.cookie`, while still allowing it to be transmitted automatically with HTTP requests.

## Why it matters
In a Cross-Site Scripting (XSS) attack, an attacker injects malicious JavaScript into a page hoping to steal a victim's session cookie and hijack their account. If the session cookie carries the HttpOnly flag, that injected script hits a wall — `document.cookie` returns nothing for that cookie, and the attacker cannot exfiltrate it even with full script execution. This single flag neutralizes the most common XSS payoff without patching the underlying XSS vulnerability.

## Key facts
- HttpOnly is set server-side in the `Set-Cookie` response header: `Set-Cookie: sessionid=abc123; HttpOnly`
- It does **not** encrypt the cookie — it only restricts JavaScript access; the cookie is still sent in plaintext over HTTP unless `Secure` flag is also set
- HttpOnly mitigates cookie theft via XSS but does **not** prevent CSRF attacks, because the cookie is still automatically sent with cross-origin requests
- Most modern browsers (Chrome, Firefox, Edge, Safari) honor HttpOnly; it's supported universally for practical purposes
- HttpOnly is frequently paired with the `Secure` flag (HTTPS-only transmission) and `SameSite` attribute for defense-in-depth cookie hardening

## Related concepts
[[Cross-Site Scripting (XSS)]] [[Session Hijacking]] [[Secure Cookie Flag]] [[SameSite Cookie Attribute]] [[Cross-Site Request Forgery (CSRF)]]