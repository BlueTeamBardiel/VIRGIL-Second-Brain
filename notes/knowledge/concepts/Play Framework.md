# Play Framework

## What it is
Like a traffic controller that handles thousands of cars simultaneously without stopping to wait for slow vehicles to clear the intersection, Play is a non-blocking, asynchronous web application framework. Built on Akka and running on the JVM, it supports both Java and Scala and follows a reactive, stateless architecture where requests are handled without blocking threads.

## Why it matters
In 2017, a critical path traversal vulnerability (CVE-2017-1000028) in Play Framework allowed attackers to read arbitrary files from the server by manipulating URL-encoded path sequences like `%2F..%2F`. An attacker targeting a Play-based API could traverse outside the web root and exfiltrate sensitive configuration files containing database credentials or API keys — a critical threat to any organization running unpatched Play versions in production.

## Key facts
- Play uses a **stateless, share-nothing architecture** — sessions are stored client-side in signed cookies, not server memory, making session fixation attacks harder but cookie tampering a concern if secrets are weak
- **Path traversal** and **template injection** have historically been the most critical vulnerability classes found in Play deployments
- Play's **Twirl templating engine** auto-escapes HTML by default, reducing reflected XSS risk, but developers using `Html()` raw interpolation bypass this protection entirely
- Built-in **CSRF protection** is opt-in via filters; misconfiguration or disabling `CSRFFilter` leaves state-changing endpoints exposed
- Play applications are commonly deployed behind **reverse proxies** (Nginx, Apache); improper `X-Forwarded-For` header trust can allow IP spoofing for access control bypass

## Related concepts
[[Path Traversal]] [[Cross-Site Request Forgery]] [[Template Injection]]