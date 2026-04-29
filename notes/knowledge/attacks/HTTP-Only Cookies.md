# HTTP-Only Cookies

## What it is
Think of an HTTP-Only cookie like a sealed evidence bag — a police officer can carry it and hand it to the court, but nobody is allowed to open it and read the contents directly. Precisely: the `HttpOnly` flag is a cookie attribute that instructs the browser to block any client-side JavaScript from accessing the cookie value via `document.cookie`. The server sets it, the browser enforces it, and scripts never see it.

## Why it matters
Cross-Site Scripting (XSS) attacks frequently target session cookies — an attacker injects malicious JavaScript that calls `document.cookie` and ships the victim's session token to an attacker-controlled server. If the session cookie has the `HttpOnly` flag set, that JavaScript call returns nothing, neutralizing the most common XSS session-hijacking payload even when the XSS vulnerability itself remains unpatched.

## Key facts
- Set by the server in the `Set-Cookie` response header: `Set-Cookie: sessionid=abc123; HttpOnly; Secure`
- `HttpOnly` does **not** prevent the cookie from being sent over the network — it only blocks JavaScript DOM access
- Should be combined with the `Secure` flag to ensure the cookie is only transmitted over HTTPS
- Does **not** protect against Cross-Site Request Forgery (CSRF) — the browser still automatically attaches the cookie to cross-origin requests
- Supported by all modern browsers; absence of this flag is flagged by tools like OWASP ZAP and Burp Suite as a medium-severity misconfiguration

## Related concepts
[[Cross-Site Scripting (XSS)]] [[Session Hijacking]] [[Secure Cookie Flag]] [[Same-Site Cookie Attribute]] [[Cross-Site Request Forgery (CSRF)]]