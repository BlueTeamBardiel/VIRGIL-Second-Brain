# Web Cache Deception

## What it is
Imagine a library where the photocopier automatically copies any document slid under its lid and leaves the copy in an open tray for anyone to grab — an attacker tricks that copier into copying your private medical records. Web cache deception exploits caching logic by crafting a URL like `/account/settings/style.css`, causing the cache to store a victim's private, authenticated page response as if it were a public static asset, making it retrievable by anyone.

## Why it matters
In 2017, researcher Omer Gil demonstrated this against PayPal: by luring an authenticated user to visit a crafted URL appended with a fake `.css` extension, he caused PayPal's CDN to cache the user's private account page, which he then retrieved unauthenticated and read the victim's full name, account balance, and partial credit card number. The fix required cache servers to explicitly distinguish dynamic, authenticated responses from genuinely static assets.

## Key facts
- **Attack vector**: Attacker appends a fake static-looking path suffix (e.g., `/profile/x.jpg`) to a dynamic, authenticated endpoint to trick cache servers into storing private content
- **Prerequisite**: The cache must be configured to store responses based on file extension or URL pattern rather than `Cache-Control` response headers
- **Distinguishing from cache poisoning**: Cache deception *extracts* private data by caching authenticated responses; cache poisoning *injects* malicious content into cached responses for other users
- **Defense**: Set explicit `Cache-Control: no-store` on all authenticated/dynamic endpoints; configure caches to respect origin server headers over URL heuristics
- **CVE relevance**: Appears in OWASP API Security Top 10 under Broken Object Level Authorization and is a recognized Server-Side Request manipulation class

## Related concepts
[[Web Cache Poisoning]] [[Session Hijacking]] [[Insecure Direct Object Reference]]