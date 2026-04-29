# HTTP Cookies

## What it is
Think of an HTTP cookie like a coat-check ticket at a restaurant — the server hands you a numbered stub so it can recognize you next time without making you re-introduce yourself from scratch. Precisely, a cookie is a small piece of data sent by a web server via the `Set-Cookie` response header and stored by the browser, which then automatically includes it in subsequent requests to that domain. This mechanism gives stateful memory to an otherwise stateless HTTP protocol.

## Why it matters
Session hijacking attacks exploit cookies directly: if an attacker intercepts a session cookie over an unencrypted connection (e.g., on public Wi-Fi), they can replay that cookie and impersonate the victim without ever knowing their password. This is why the `Secure` flag exists — it prevents the browser from transmitting the cookie over plain HTTP, blocking this class of attack entirely.

## Key facts
- **HttpOnly flag**: Prevents JavaScript from accessing the cookie via `document.cookie`, directly mitigating XSS-based cookie theft.
- **Secure flag**: Ensures the cookie is only sent over HTTPS connections.
- **SameSite attribute**: Controls cross-origin cookie sending; set to `Strict` or `Lax` to defend against Cross-Site Request Forgery (CSRF) attacks.
- **Scope**: Cookies are scoped by `Domain` and `Path` attributes — a cookie set for `bank.com` won't be sent to `evil.com`.
- **Session vs. Persistent cookies**: Session cookies expire when the browser closes; persistent cookies have an explicit `Expires` or `Max-Age` value and survive restarts, making them a higher-value target if stolen.

## Related concepts
[[Session Hijacking]] [[Cross-Site Scripting (XSS)]] [[Cross-Site Request Forgery (CSRF)]] [[Man-in-the-Middle Attack]]