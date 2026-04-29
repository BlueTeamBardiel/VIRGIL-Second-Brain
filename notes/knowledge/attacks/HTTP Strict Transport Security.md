# HTTP Strict Transport Security

## What it is
Like a bouncer who turns away anyone not wearing a wristband — no exceptions, no "just this once" — HSTS is a web security policy that forces browsers to connect only via HTTPS, rejecting plain HTTP entirely. It's an HTTP response header (`Strict-Transport-Security`) that instructs browsers to automatically upgrade all future requests to HTTPS for a specified duration, even if the user types `http://` manually.

## Why it matters
Without HSTS, an attacker on a coffee shop network can intercept a user's initial HTTP request before it gets redirected to HTTPS — a classic SSL stripping attack using tools like `sslstrip`. The attacker silently downgrades the connection to plaintext, sitting invisibly in the middle. HSTS defeats this by making the browser refuse to send that first unencrypted request at all, removing the window of opportunity entirely.

## Key facts
- The header syntax is: `Strict-Transport-Security: max-age=31536000; includeSubDomains; preload` — `max-age` is in seconds (31536000 = 1 year)
- `includeSubDomains` extends the policy to all subdomains; omitting it leaves them vulnerable to stripping attacks
- **HSTS Preload** embeds domains directly into browser source code (Chrome, Firefox, etc.) — eliminating the vulnerable first visit entirely; opt-in via hstspreload.org
- HSTS is **TOFU** (Trust On First Use) — the first visit must succeed over HTTPS to set the header; that initial connection remains a risk
- Removing a site from HSTS preload takes months to propagate — it's a near-irreversible commitment

## Related concepts
[[SSL Stripping]] [[TLS]] [[Certificate Pinning]] [[Man-in-the-Middle Attack]]