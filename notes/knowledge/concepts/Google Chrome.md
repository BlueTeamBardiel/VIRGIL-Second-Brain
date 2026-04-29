# Google Chrome

## What it is
Think of Chrome like a sophisticated embassy building — it hosts foreign code (websites) in isolated rooms (sandboxed processes) while managing passports (cookies), communications (HTTPS), and security clearances (permissions). Precisely, Google Chrome is a Chromium-based web browser that uses a multi-process architecture to isolate web content, featuring built-in security mechanisms including sandboxing, Safe Browsing, and automatic updates to mitigate client-side threats.

## Why it matters
In 2021, attackers exploited CVE-2021-21166, a zero-day use-after-free vulnerability in Chrome's audio component, allowing remote code execution simply by luring a victim to a malicious webpage — no additional user interaction required. This demonstrates why browser patch management is a critical control; organizations running outdated Chrome versions expose endpoints to drive-by download attacks that can bypass perimeter defenses entirely.

## Key facts
- Chrome uses **Site Isolation** (post-Spectre), placing each website in its own renderer process to prevent cross-site data leakage via speculative execution attacks
- **Safe Browsing API** checks URLs against Google's blocklist of known malicious sites, providing real-time phishing and malware protection
- Chrome stores saved passwords, cookies, and browsing history in **SQLite databases** locally — a prime forensic artifact and credential-theft target (see malware like Redline Stealer)
- **V8 JavaScript engine** vulnerabilities are among the most exploited browser attack surfaces; type confusion bugs frequently lead to sandbox escapes
- Chrome's **Certificate Transparency (CT)** requirement forces all publicly trusted TLS certificates to be logged, enabling detection of misissued certificates

## Related concepts
[[Browser Sandbox]] [[Drive-By Download]] [[Cross-Site Scripting (XSS)]] [[Certificate Transparency]] [[Use-After-Free Vulnerability]]