# Lenovo Service Bridge

## What it is
Think of it like a key hidden under the doormat for a repair technician — convenient, but anyone who knows where to look can use it. Lenovo Service Bridge is a pre-installed software application on Lenovo consumer devices designed to allow the Lenovo support website to automatically detect hardware details, run diagnostics, and facilitate warranty service — all through browser-to-application communication via a local web server.

## Why it matters
In 2015–2016, security researchers discovered that Lenovo Service Bridge ran an HTTP server on localhost and accepted commands without adequate origin validation, making it vulnerable to cross-site request forgery (CSRF) and remote code execution. An attacker could craft a malicious webpage that silently communicated with the local service bridge, potentially exfiltrating system information or executing arbitrary commands — turning a "helpful" support tool into an attack surface simply by visiting a webpage.

## Key facts
- Lenovo Service Bridge listens on a **local HTTP port** (e.g., 55555), creating a localhost attack surface reachable via browser-based requests
- The vulnerability class is **cross-origin localhost bypass** — browsers typically block cross-origin requests, but localhost loopback servers have historically been exploitable via DNS rebinding or lax CORS policies
- Classified under **CWE-346 (Origin Validation Error)** and related to **CVE-2016-5249**, which allowed remote information disclosure
- This is an example of **bloatware/crapware risk** — pre-installed OEM software expanding attack surface without user consent
- Remediation involves **uninstalling the application or applying vendor patches**; defenders should audit pre-installed OEM software on managed endpoints during hardening

## Related concepts
[[Bloatware and OEM Attack Surface]] [[Cross-Site Request Forgery (CSRF)]] [[DNS Rebinding]] [[Localhost Service Exploitation]] [[Supply Chain Security]]