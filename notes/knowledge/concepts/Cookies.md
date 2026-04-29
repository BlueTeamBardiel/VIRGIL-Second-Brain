# Cookies

## What it is
Like a coat-check ticket at a restaurant — you hand the server your jacket, they give you a numbered stub so they can find you again later without memorizing your face. A cookie is a small piece of data that a web server sends to a browser, which stores it and returns it with every subsequent request to maintain stateful information (like session identity) over the inherently stateless HTTP protocol.

## Why it matters
In a session hijacking attack, an adversary intercepts or steals a victim's session cookie — perhaps via an XSS payload or sniffing unencrypted HTTP traffic — and replays it to impersonate the authenticated user without ever knowing their password. This is why banks enforce the `Secure` and `HttpOnly` flags: `Secure` prevents transmission over plain HTTP, while `HttpOnly` blocks JavaScript from reading the cookie, neutering most XSS-based theft attempts.

## Key facts
- **HttpOnly flag**: Prevents JavaScript access to the cookie, mitigating XSS-based cookie theft
- **Secure flag**: Ensures the cookie is only transmitted over HTTPS connections
- **SameSite attribute**: Controls cross-site cookie sending; `SameSite=Strict` blocks cookies on cross-origin requests, directly defending against CSRF attacks
- **Session vs. Persistent cookies**: Session cookies expire when the browser closes; persistent cookies have an explicit `Expires` or `Max-Age` value and survive restarts
- **Cookie scope**: Defined by `Domain` and `Path` attributes — a cookie set for `.example.com` is shared across all subdomains, which can expand attack surface

## Related concepts
[[Session Hijacking]] [[Cross-Site Scripting (XSS)]] [[Cross-Site Request Forgery (CSRF)]] [[HTTP Security Headers]]