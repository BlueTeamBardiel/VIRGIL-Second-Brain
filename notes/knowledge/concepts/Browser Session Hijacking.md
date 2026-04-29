# Browser Session Hijacking

## What it is
Imagine a thief doesn't steal your house key — they wait until you've already unlocked the door, then slip in behind you using the same open door. Browser session hijacking works identically: an attacker steals your active session token (the "you're already logged in" cookie) and uses it to impersonate you on a web application without ever needing your password.

## Why it matters
In 2010, the Firesheep Firefox extension automated session hijacking over open Wi-Fi by sniffing unencrypted HTTP cookies from sites like Facebook and Twitter — anyone on the same network could click a button and log in as another user. This attack directly accelerated the industry-wide adoption of HTTPS everywhere, since TLS encryption makes cookie sniffing impractical.

## Key facts
- Session tokens transmitted over HTTP (not HTTPS) can be intercepted via packet sniffing on shared networks — this is why the `Secure` cookie flag exists
- The `HttpOnly` cookie flag prevents JavaScript from reading session cookies, blocking XSS-based token theft
- Cross-Site Scripting (XSS) is one of the most common delivery mechanisms for session hijacking — malicious scripts exfiltrate document.cookie to an attacker's server
- Session fixation is a variant where the attacker *sets* the victim's session ID before login, rather than stealing it after
- Mitigations include short session timeouts, IP/user-agent binding, token rotation on privilege escalation, and the `SameSite=Strict` cookie attribute to block CSRF-assisted hijacking

## Related concepts
[[Cross-Site Scripting (XSS)]] [[Cross-Site Request Forgery (CSRF)]] [[Session Fixation]] [[Cookie Security Attributes]] [[Man-in-the-Middle Attack]]