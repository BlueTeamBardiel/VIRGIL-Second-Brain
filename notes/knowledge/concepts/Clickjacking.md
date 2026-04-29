# Clickjacking

## What it is
Imagine a magician placing a sheet of invisible glass over a "Press Here to Win a Prize" button — when you press it, you're actually hitting the hidden button *behind* it. Clickjacking (UI Redress Attack) works the same way: an attacker overlays a transparent or opaque iframe containing a legitimate site over a decoy page, tricking users into clicking interface elements they never intended to interact with. The victim believes they're clicking one thing; they're actually clicking something else entirely.

## Why it matters
In 2009, a Twitter worm exploited clickjacking to silently retweet a message from any user who visited a malicious page — no credentials stolen, no malware installed, just a hidden "Retweet" button under a visible decoy. This demonstrated that clickjacking can weaponize authenticated sessions at scale, turning legitimate user actions into attacker-controlled operations without ever breaking encryption or bypassing authentication.

## Key facts
- **Primary defense is `X-Frame-Options`** — setting it to `DENY` or `SAMEORIGIN` prevents a page from being loaded inside an iframe by unauthorized origins
- **Modern replacement is `Content-Security-Policy: frame-ancestors`** — more flexible and the preferred method per current OWASP guidance
- Clickjacking exploits **trust between a browser and an authenticated session**, not a vulnerability in the server's logic
- **Frame-busting JavaScript** (e.g., `if (top !== self) top.location = self.location`) was the legacy defense but is bypassable via iframe sandbox attributes
- Clickjacking is classified as a **client-side attack** and appears in the **OWASP Top 10** historically under "Security Misconfiguration" and related UI categories

## Related concepts
[[Cross-Site Request Forgery (CSRF)]] [[Content Security Policy (CSP)]] [[Same-Origin Policy]] [[Iframe Sandboxing]]