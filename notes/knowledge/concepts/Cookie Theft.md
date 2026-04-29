# Cookie Theft

## What it is
Imagine someone photocopying your hotel key card while you sleep — they don't need your password, just the card itself. Cookie theft (also called session hijacking) occurs when an attacker steals a browser's session cookie to impersonate an authenticated user, bypassing login credentials entirely.

## Why it matters
In 2022, attackers used cookie theft malware (cookie stealers like Raccoon and Redline) to hijack YouTube creator accounts — even those protected by MFA — because a valid session cookie proves identity *after* authentication has already occurred. This is why Google later introduced device-bound session credentials: a stolen cookie is useless without the original hardware.

## Key facts
- **XSS is the primary delivery vector**: injecting malicious JavaScript via Cross-Site Scripting extracts `document.cookie` and sends it to an attacker-controlled server
- **The `HttpOnly` flag** prevents JavaScript from reading cookies, directly blocking XSS-based theft — this is the single most important mitigation
- **The `Secure` flag** ensures cookies are only transmitted over HTTPS, preventing interception via man-in-the-middle on unencrypted connections
- **Session fixation** is a related attack where the attacker *sets* your session ID before login rather than stealing it afterward — different mechanism, same goal
- **Defense in depth** includes short session timeouts, IP/user-agent binding, and re-authentication for sensitive actions — no single control is sufficient since stolen cookies arrive looking like legitimate traffic

## Related concepts
[[Cross-Site Scripting (XSS)]] [[Session Hijacking]] [[Man-in-the-Middle Attack]] [[HTTP Security Headers]]