# Mozilla Firefox

## What it is
Like a postal worker that opens every letter, reads the contents, and decides whether to deliver it based on community-voted rules — Firefox is an open-source web browser that interprets and renders HTML, CSS, and JavaScript while applying configurable security policies. Built on the Gecko engine and maintained by the Mozilla Foundation, it emphasizes user privacy and transparency over proprietary control.

## Why it matters
Firefox's enhanced tracking protection and strict Content Security Policy (CSP) enforcement make it a relevant defensive tool — but also a target. In 2019, a zero-day vulnerability (CVE-2019-11707) in Firefox's JavaScript engine was actively exploited in the wild to deliver malware to Coinbase employees, demonstrating that even privacy-focused browsers present critical attack surfaces requiring rapid patch management.

## Key facts
- Firefox uses a **sandboxed multi-process architecture** (Fission), isolating each site in its own process to limit cross-origin memory access and contain exploits
- Supports **DNS-over-HTTPS (DoH)** natively, encrypting DNS queries to prevent ISP-level surveillance and DNS spoofing attacks
- Mozilla's **about:config** interface exposes hundreds of hardening options (e.g., disabling WebRTC to prevent IP leaks through VPNs)
- Firefox enforces **Same-Origin Policy (SOP)** and supports strict **Content Security Policy** headers, reducing XSS attack viability
- As open-source software, Firefox's codebase undergoes continuous community audit — vulnerabilities are tracked publicly via Mozilla's Bugzilla and assigned CVEs

## Related concepts
[[Content Security Policy]] [[Same-Origin Policy]] [[DNS over HTTPS]] [[Cross-Site Scripting]] [[Browser Sandboxing]]