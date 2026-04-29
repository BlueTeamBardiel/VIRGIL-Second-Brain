# Session ID

## What it is
Like a coat-check ticket at a restaurant — the server doesn't memorize your face, they just match your ticket number to your coat. A Session ID is a temporary, unique token issued by a web server after authentication, allowing it to recognize a returning user across stateless HTTP requests without re-sending credentials every time. It typically lives in a cookie, URL parameter, or hidden form field.

## Why it matters
In a session hijacking attack, an attacker who intercepts or steals a valid Session ID can impersonate the victim entirely — no password needed. This is exactly what Firesheep (2010) demonstrated on open Wi-Fi networks, capturing unencrypted session cookies from Facebook and Twitter users and replaying them to gain full account access. The defense is enforcing HTTPS everywhere and setting the `Secure` and `HttpOnly` cookie flags to prevent interception and JavaScript theft.

## Key facts
- **Session fixation** is an attack where the attacker *sets* the victim's Session ID before login, then waits for the victim to authenticate — making the pre-known ID valid
- A secure Session ID should be **at least 128 bits of entropy**, cryptographically random, and never predictable or sequential
- The **`HttpOnly` flag** prevents JavaScript from reading the cookie, blocking most XSS-based session theft
- Sessions should **expire after inactivity** (e.g., 15–30 minutes) and be **invalidated server-side on logout** — deleting the cookie client-side alone is insufficient
- OWASP lists **Broken Authentication** (which includes weak session management) as a critical Top 10 web vulnerability category

## Related concepts
[[Cross-Site Scripting (XSS)]] [[Cookie Security Flags]] [[Session Hijacking]] [[Authentication Tokens]] [[OWASP Top 10]]