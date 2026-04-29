# SSL stripping

## What it is
Imagine a bilingual translator who secretly downgrades every conversation from encrypted walkie-talkie to open megaphone — that's SSL stripping. It's a man-in-the-middle attack where the attacker intercepts an HTTPS request and serves the victim an unencrypted HTTP connection, while maintaining the HTTPS session with the legitimate server themselves. The victim's browser shows HTTP, the server believes it's talking securely, and the attacker reads everything in plaintext.

## Why it matters
In 2010, security researcher Moxie Marlinspike demonstrated SSL stripping at Black Hat using a tool called *sslstrip*, capturing login credentials from coffee shop Wi-Fi users who typed URLs without explicitly writing `https://`. The defense that emerged — HTTP Strict Transport Security (HSTS) — forces browsers to always use HTTPS for known domains, making this attack significantly harder against sites that preload HSTS headers.

## Key facts
- SSL stripping was first publicly demonstrated by Moxie Marlinspike in 2009 using the tool **sslstrip**
- The attack works because most users type `example.com`, not `https://example.com` — the first request goes out as HTTP and can be intercepted
- **HSTS (HTTP Strict Transport Security)** is the primary defense; the `Strict-Transport-Security` response header instructs browsers to reject HTTP connections
- **HSTS Preloading** goes further by hardcoding major domains into browser source code, eliminating even the first-visit vulnerability
- SSL stripping is classified as a **downgrade attack** — it reduces security protocol strength rather than directly breaking encryption
- Requires the attacker to be positioned on the network path (e.g., rogue Wi-Fi access point or ARP poisoning)

## Related concepts
[[Man-in-the-Middle Attack]] [[HTTP Strict Transport Security]] [[Downgrade Attack]] [[ARP Poisoning]] [[Certificate Pinning]]