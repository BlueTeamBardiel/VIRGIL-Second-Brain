# HSTS

## What it is
Like a bouncer with a permanent list who turns you away at the door if you try to enter without a suit — no exceptions, no negotiating at the entrance — HSTS (HTTP Strict Transport Security) is a web security header that instructs browsers to *only* communicate with a server over HTTPS, refusing plain HTTP connections entirely. Once a browser receives the header, it enforces HTTPS automatically for all future visits without even attempting an HTTP request.

## Why it matters
Without HSTS, an attacker performing a SSL stripping attack (like sslstrip) can intercept a user typing `example.com`, downgrade the connection from HTTPS to HTTP, and silently proxy the traffic — stealing credentials without the victim noticing the missing padlock. HSTS defeats this because the browser never sends the initial HTTP request that the attacker needs to intercept; it upgrades internally before any packet leaves the machine.

## Key facts
- Delivered via the response header: `Strict-Transport-Security: max-age=31536000; includeSubDomains; preload`
- `max-age` defines how long (in seconds) the browser caches and enforces the policy — 31,536,000 = one year
- `includeSubDomains` extends enforcement to all subdomains; omitting it leaves subdomains as an attack surface
- **HSTS Preload** embeds domains into browser source code (via hstspreload.org), protecting first-time visitors before they ever receive the header
- HSTS does **not** protect against invalid certificates — it only enforces the use of TLS, not validates it

## Related concepts
[[SSL Stripping]] [[TLS]] [[Certificate Pinning]] [[Content Security Policy]] [[HTTPS]]