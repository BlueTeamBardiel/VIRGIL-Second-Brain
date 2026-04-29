# Secure Cookie

## What it is
Think of a Secure Cookie like a note that can only be passed through a locked pneumatic tube — it simply won't travel through the open hallway. The `Secure` flag is an attribute added to HTTP cookies that instructs the browser to transmit the cookie **only over HTTPS connections**, never over unencrypted HTTP.

## Why it matters
Without the `Secure` flag, an attacker performing a man-in-the-middle attack on an HTTP connection — even briefly, such as during an HTTP redirect before HTTPS kicks in — can intercept a session cookie and hijack the authenticated session entirely. This is how **SSL stripping attacks** exploit cookies: they downgrade the connection to HTTP and silently harvest cookies that lack this flag.

## Key facts
- The `Secure` flag does **not** encrypt the cookie's content — it only restricts the transport channel to HTTPS.
- Should be combined with the `HttpOnly` flag (prevents JavaScript access) and `SameSite` attribute (prevents CSRF) for a complete defense posture.
- Set in the `Set-Cookie` HTTP response header: `Set-Cookie: sessionid=abc123; Secure; HttpOnly; SameSite=Strict`
- Even with `Secure` set, cookies remain visible to the server and in browser storage — they are not confidential at rest.
- PCI-DSS and OWASP explicitly require the `Secure` flag on any cookie carrying authentication or session data.

## Related concepts
[[HttpOnly Cookie]] [[SameSite Cookie]] [[SSL Stripping]] [[Session Hijacking]] [[HTTPS]]