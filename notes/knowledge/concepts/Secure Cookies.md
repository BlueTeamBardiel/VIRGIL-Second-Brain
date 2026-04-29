# Secure cookies

## What it is
Think of a cookie like a wristband at a concert — the `Secure` flag is the rule that says "this wristband can only be shown indoors, never outside." Technically, the `Secure` attribute on an HTTP cookie instructs the browser to transmit that cookie *only* over HTTPS connections, never over plaintext HTTP. This prevents the cookie's value from being exposed in transit on unencrypted channels.

## Why it matters
In a coffee shop attack, an adversary runs a passive Wi-Fi sniffer and waits for a victim to visit `http://example.com` — even as a redirect to HTTPS. Without the `Secure` flag, the browser may send the session cookie on that initial HTTP request, and the attacker captures it in plaintext, enabling full session hijacking. Setting `Secure` closes this specific interception window entirely.

## Key facts
- The `Secure` flag does **not** encrypt the cookie's contents — it only restricts the transport channel to HTTPS.
- Combine `Secure` with `HttpOnly` (blocks JavaScript access) and `SameSite=Strict/Lax` (blocks cross-site sending) for full defense-in-depth on cookies.
- A cookie without `Secure` can be intercepted via a **SSL stripping attack** (e.g., using `sslstrip`), where HTTPS is downgraded to HTTP mid-connection.
- The `Secure` flag is set server-side in the `Set-Cookie` response header: `Set-Cookie: sessionid=abc123; Secure; HttpOnly`.
- HSTS (HTTP Strict Transport Security) complements `Secure` cookies by preventing the browser from making HTTP requests in the first place, closing the initial redirect gap.

## Related concepts
[[Session Hijacking]] [[HttpOnly Flag]] [[HTTP Strict Transport Security (HSTS)]] [[SSL Stripping]] [[Cross-Site Scripting (XSS)]]