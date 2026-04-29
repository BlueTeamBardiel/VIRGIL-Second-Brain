# session token

## What it is
Think of a session token like a wristband at a concert — once the bouncer checks your ID at the door, you get a wristband so you don't have to show ID again for every beer. A session token is a temporary, unique identifier issued by a server after successful authentication, allowing a user to make subsequent requests without re-submitting credentials. It lives in a cookie, URL parameter, or HTTP header and expires after a set period of inactivity or logout.

## Why it matters
In 2022, attackers targeting Okta stole session tokens from a support engineer's machine, allowing them to impersonate authenticated customers without ever needing their passwords — a classic **session hijacking** attack. This illustrates the core danger: a valid token *is* the user from the server's perspective, making token theft equivalent to credential theft.

## Key facts
- Session tokens should be generated using a **cryptographically secure random number generator** (CSPRNG) — predictable tokens enable session prediction attacks
- **HttpOnly** flag prevents JavaScript from reading cookies, mitigating XSS-based token theft; **Secure** flag ensures cookies only transmit over HTTPS
- **Session fixation** attacks trick a victim into using an attacker-controlled token *before* login; the fix is to regenerate the token immediately after authentication
- Tokens should be **invalidated server-side** on logout — simply deleting a client-side cookie is insufficient, as the server still recognizes the token
- OWASP categorizes broken session management under **A07:2021 – Identification and Authentication Failures**

## Related concepts
[[session hijacking]] [[cross-site scripting (XSS)]] [[cookie security flags]] [[session fixation]] [[authentication]]