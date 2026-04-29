# HttpOnly Attribute

## What it is
Think of it like a read-only safety deposit box that only the bank's internal pneumatic tube system can access — no customer can reach in directly. HttpOnly is a cookie attribute that instructs the browser to block JavaScript from accessing the cookie via `document.cookie`, while still allowing it to be transmitted automatically with HTTP requests.

## Why it matters
In a Cross-Site Scripting (XSS) attack, an adversary injects malicious JavaScript into a trusted page hoping to steal session cookies and hijack authenticated sessions. If the session cookie carries the HttpOnly flag, `document.cookie` returns nothing useful — the attacker's script cannot exfiltrate the token even though the XSS injection succeeded, effectively breaking the most common XSS-to-account-takeover kill chain.

## Key facts
- HttpOnly is set server-side in the `Set-Cookie` header: `Set-Cookie: sessionid=abc123; HttpOnly`
- It does **not** encrypt the cookie — it only restricts JavaScript access; the cookie is still visible in browser developer tools under the Application tab
- HttpOnly prevents theft via `document.cookie` but does **not** stop CSRF attacks, since browsers still auto-send HttpOnly cookies with cross-origin requests
- It works alongside the `Secure` attribute (HTTPS-only transmission) and `SameSite` attribute (CSRF mitigation) — all three together form the defensive cookie triad
- Supported by all modern browsers; absence of HttpOnly on session cookies is flagged as a finding in web application penetration tests and OWASP Top 10 assessments

## Related concepts
[[Cross-Site Scripting (XSS)]] [[Secure Cookie Attribute]] [[Session Hijacking]] [[SameSite Attribute]] [[Cross-Site Request Forgery (CSRF)]]