# Networking: Cookies

## What it is
Like a coat-check ticket stapled to your wrist — the server hands you a small token so it can recognize you next time without asking who you are all over again. Precisely, a cookie is a small piece of data (key-value pair) that a web server sends to a client's browser, which stores it and automatically includes it in subsequent HTTP requests to that same domain.

## Why it matters
Session hijacking attacks (like those executed with tools such as Firesheep on unencrypted Wi-Fi) steal a victim's session cookie from HTTP traffic, allowing the attacker to impersonate them to the server without ever knowing their password. This is why the **Secure** flag exists — it forces cookies to transmit only over HTTPS, making passive sniffing useless against them.

## Key facts
- **Secure flag**: Cookie only sent over HTTPS connections — critical defense against network interception
- **HttpOnly flag**: Blocks JavaScript from reading the cookie, directly mitigating XSS-based cookie theft
- **SameSite attribute** (Strict/Lax/None): Controls whether cookies are sent on cross-site requests, the primary defense against Cross-Site Request Forgery (CSRF)
- **Scope**: Cookies are bounded by domain and path; the `Domain` attribute can extend sharing to subdomains, which can be a misconfiguration risk
- **Expiration**: Session cookies disappear when the browser closes; persistent cookies survive until an explicit expiry date — longer-lived cookies represent a larger attack window

## Related concepts
[[Session Hijacking]] [[Cross-Site Scripting (XSS)]] [[Cross-Site Request Forgery (CSRF)]]