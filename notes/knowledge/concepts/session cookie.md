# session cookie

## What it is
Think of a session cookie like a coat-check ticket at a restaurant — the server keeps your coat (your authenticated session data), and you just carry the stub so staff can retrieve it each time you need something. Precisely, a session cookie is a small piece of data stored in the browser that contains a session ID, allowing a web server to associate subsequent HTTP requests with an already-authenticated user without requiring re-login. Unlike persistent cookies, session cookies exist only in memory and are deleted when the browser closes.

## Why it matters
In a session hijacking attack, an adversary intercepts or steals a valid session cookie — often via a man-in-the-middle attack on unencrypted HTTP traffic or through cross-site scripting (XSS) — and replays it to impersonate the legitimate user without ever needing their password. This is exactly why HTTPS and the `Secure` cookie flag are non-negotiable: without them, a coffee-shop attacker running Wireshark can grab your banking session in seconds.

## Key facts
- Session cookies should have the `HttpOnly` flag set, preventing JavaScript from reading them and blocking most XSS-based theft
- The `Secure` flag ensures the cookie is only transmitted over HTTPS connections
- The `SameSite` attribute (`Strict` or `Lax`) mitigates Cross-Site Request Forgery (CSRF) by restricting cross-origin cookie sending
- Session IDs must be cryptographically random and sufficiently long (128+ bits) to resist brute-force prediction
- After authentication, servers should issue a **new** session ID (session fixation defense) to prevent pre-authentication token reuse

## Related concepts
[[session hijacking]] [[cross-site scripting (XSS)]] [[cross-site request forgery (CSRF)]] [[HTTP cookies]] [[man-in-the-middle attack]]