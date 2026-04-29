# Session management

## What it is
Like a coat check at a restaurant — when you hand over your coat, you get a numbered ticket that proves ownership for the evening without carrying the coat everywhere. Session management is the server-side mechanism that issues, tracks, and invalidates temporary session tokens so authenticated users can make multiple requests without re-entering credentials on every page load.

## Why it matters
In 2011, Firesheep — a Firefox plugin — let anyone on an open Wi-Fi network sniff unencrypted session cookies and hijack Facebook, Twitter, and Dropbox accounts instantly. The attacker never needed a password; stealing the session token was enough because the server couldn't distinguish the legitimate owner from the thief. This forced major platforms to enforce HTTPS sitewide, protecting session tokens in transit.

## Key facts
- **Session fixation** attacks force a victim to use an attacker-controlled session ID; defense requires regenerating the session token *after* successful login
- **Session tokens must be random and long** — OWASP recommends at least 128 bits of entropy to prevent brute-force guessing
- **Idle and absolute timeouts** are separate controls: idle timeout resets on activity; absolute timeout expires the session regardless of activity (critical for high-privilege apps)
- **Secure and HttpOnly cookie flags** are essential — `Secure` prevents transmission over HTTP; `HttpOnly` blocks JavaScript access, mitigating XSS-based cookie theft
- OWASP lists broken session management as a component of **A07:2021 – Identification and Authentication Failures** in the Top 10

## Related concepts
[[Cross-Site Scripting (XSS)]] [[Cookie Security]] [[Authentication]] [[OWASP Top 10]] [[Cross-Site Request Forgery (CSRF)]]