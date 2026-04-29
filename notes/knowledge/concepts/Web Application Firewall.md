# web application firewall

## What it is
Think of it as a bouncer at a club who doesn't just check IDs — they read every sentence you say and throw you out if you mention anything suspicious. A Web Application Firewall (WAF) is a security control that sits between clients and a web application, inspecting HTTP/HTTPS traffic at Layer 7 and filtering requests based on predefined rules to block attacks like SQL injection, XSS, and directory traversal.

## Why it matters
In 2017, Equifax was breached partly because a known Apache Struts vulnerability was exploited through crafted HTTP requests — a properly tuned WAF with up-to-date signatures could have blocked the malicious payload before it ever reached the vulnerable application. WAFs are often the last line of defense when underlying application code cannot be immediately patched, buying organizations critical time.

## Key facts
- WAFs operate at **OSI Layer 7** (Application layer), distinguishing them from traditional firewalls that filter at Layers 3–4
- Three deployment modes: **inline (blocking)**, **out-of-band (monitoring only)**, and **reverse proxy** — the reverse proxy model is most common in cloud deployments
- WAFs use two detection models: **positive security model** (allowlist — only permit known-good traffic) and **negative security model** (denylist — block known-bad signatures); most production WAFs combine both
- **OWASP ModSecurity Core Rule Set (CRS)** is the industry-standard open-source ruleset used to configure WAFs against the OWASP Top 10 threats
- WAFs are **not a substitute for secure coding** — they can be bypassed via encoding tricks, HTTP parameter pollution, or fragmentation attacks if rules aren't maintained

## Related concepts
[[SQL injection]] [[cross-site scripting]] [[OWASP Top 10]] [[reverse proxy]] [[intrusion prevention system]]