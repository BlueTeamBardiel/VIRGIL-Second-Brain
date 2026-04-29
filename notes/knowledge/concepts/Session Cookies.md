# session cookies

## What it is
Think of a session cookie like a coat-check ticket — the server keeps your coat (your logged-in state), and the cookie is just the numbered stub that proves you're the rightful owner. Precisely, a session cookie is a small piece of data stored in a browser that holds a session ID, allowing a web server to recognize and maintain a user's authenticated state across multiple HTTP requests. Unlike persistent cookies, session cookies exist only in memory and expire when the browser closes.

## Why it matters
If an attacker on the same network intercepts an unencrypted HTTP session cookie via a tool like Wireshark, they can paste that session ID into their own browser and immediately gain access to the victim's account — a classic **session hijacking** attack. This is exactly what the Firesheep Firefox extension demonstrated in 2010 on open Wi-Fi networks, forcing widespread adoption of HTTPS. Defending against this means setting the `Secure` and `HttpOnly` flags on session cookies so they can't be transmitted over plain HTTP or stolen via JavaScript.

## Key facts
- **HttpOnly flag** prevents JavaScript from reading the cookie, mitigating XSS-based session theft
- **Secure flag** ensures the cookie is only transmitted over HTTPS, preventing interception over plaintext connections
- **SameSite attribute** (Strict/Lax/None) controls cross-site request behavior, directly mitigating CSRF attacks
- Session cookies that never expire or rotate after login enable **session fixation** attacks, where an attacker pre-sets a known session ID before the victim authenticates
- OWASP lists broken session management under its Top 10; proper session IDs should be at least 128 bits of entropy and invalidated server-side on logout

## Related concepts
[[session hijacking]] [[cross-site scripting (XSS)]] [[cross-site request forgery (CSRF)]] [[HTTP vs HTTPS]] [[authentication tokens]]