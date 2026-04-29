# Cross-Site Request Forgery Prevention

## What it is
Like a forger who steals your letterhead and mails a check in your name, CSRF tricks your authenticated browser into sending malicious requests to a trusted site without your knowledge. Precisely, it's an attack where a malicious site causes a victim's browser to unknowingly submit authenticated requests to a target application using the victim's existing session cookies. Prevention centers on ensuring every state-changing request was intentionally initiated by the user.

## Why it matters
In 2012, attackers exploited CSRF in a major router firmware interface: a single malicious image tag on a webpage silently sent HTTP requests that changed DNS settings on thousands of home routers, redirecting users to phishing sites. The routers trusted the browser session — they had no way to distinguish a legitimate admin action from a forged one without anti-CSRF controls in place.

## Key facts
- **Synchronizer Token Pattern (CSRF tokens):** Server generates a unique, unpredictable token per session, embeds it in forms, and validates it on every POST — the most widely tested mitigation
- **SameSite cookie attribute:** Setting `SameSite=Strict` or `SameSite=Lax` prevents browsers from sending cookies on cross-origin requests, making it a modern browser-native defense
- **Double Submit Cookie:** Server sends a random value as both a cookie and a request parameter; it validates that both match, requiring the attacker to read the cookie value (blocked by same-origin policy)
- **CSRF only targets state-changing requests** (POST, PUT, DELETE) — GET requests should never modify server state by design
- **Custom request headers** (e.g., `X-Requested-With`) on AJAX calls provide implicit CSRF protection because cross-origin requests cannot set arbitrary headers without CORS preflight approval

## Related concepts
[[Session Management]] [[Same-Origin Policy]] [[Cookie Security Attributes]] [[Cross-Site Scripting (XSS)]]