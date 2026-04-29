# XSS command-and-control

## What it is
Think of it like a puppet master who slips a radio receiver into someone's pocket — the victim walks around normally, but the attacker can issue commands anytime they visit a compromised page. XSS C2 (also called a "browser botnet") uses persistent or reflected cross-site scripting to inject JavaScript into a victim's browser, turning it into an agent that polls an attacker-controlled server for commands and exfiltrates results — all without installing any malware on disk.

## Why it matters
The BeEF (Browser Exploitation Framework) tool demonstrates this precisely: once a single XSS hook loads in a victim's browser, the attacker gains a real-time dashboard to capture keystrokes, steal cookies, pivot to the internal network via the browser's trusted position, and launch further attacks — all over standard HTTP/HTTPS, which most firewalls allow outbound without inspection. A single unpatched stored XSS in a corporate intranet portal can silently compromise every employee who views it.

## Key facts
- BeEF is the canonical XSS C2 framework; it communicates via a polling JavaScript "hook" (`hook.js`) loaded into the victim's browser session
- Unlike traditional botnets, XSS C2 is **fileless** and **session-scoped** — the agent disappears when the browser tab closes, making forensic detection harder
- Commands are typically delivered over **HTTP long-polling or WebSockets** on port 80/443, blending into normal traffic
- Attackers can use XSS C2 to perform **same-origin attacks**: stealing session tokens, making authenticated requests, and bypassing CSRF protections
- Mitigations include **Content Security Policy (CSP)**, output encoding, HTTPOnly cookie flags, and subresource integrity (SRI) checks

## Related concepts
[[Cross-Site Scripting (XSS)]] [[BeEF Framework]] [[Content Security Policy]] [[Browser Exploitation]] [[Session Hijacking]]