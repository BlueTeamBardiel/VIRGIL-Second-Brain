# WAF

## What it is
Think of a WAF like a bouncer at a club who reads every sentence you say before letting you in — if you mutter "DROP TABLE users" or "<script>alert(1)</script>", you're not getting through the door. A Web Application Firewall (WAF) is a security control that inspects HTTP/HTTPS traffic at Layer 7, filtering requests to and responses from web applications based on a defined ruleset. Unlike network firewalls that block by IP or port, a WAF understands the *content* of web traffic.

## Why it matters
In 2017, Equifax's breach exposed 147 million records partly because their Apache Struts application was vulnerable to CVE-2017-5638 — a WAF with proper rules detecting malicious Content-Type headers could have blocked the initial exploitation before the patch was applied. WAFs serve as a critical compensating control during the window between vulnerability disclosure and patch deployment.

## Key facts
- WAFs operate in three modes: **blocklist** (deny known-bad patterns), **allowlist** (permit only known-good), or **hybrid** — allowlist is more secure but harder to maintain
- Can be deployed as **inline (transparent bridge)**, **reverse proxy** (most common), or **out-of-band** (monitor only, no blocking)
- WAF bypass techniques include encoding payloads (URL encoding, Unicode), HTTP parameter pollution, and case variation — no WAF is bypass-proof
- **OWASP ModSecurity Core Rule Set (CRS)** is the industry-standard open-source ruleset used to configure WAFs against the OWASP Top 10
- WAFs are NOT a substitute for secure coding — they are a defense-in-depth layer, not a root-cause fix; CySA+ expects you to know their limitations

## Related concepts
[[SQL Injection]] [[Cross-Site Scripting (XSS)]] [[Defense in Depth]] [[Reverse Proxy]] [[OWASP Top 10]]