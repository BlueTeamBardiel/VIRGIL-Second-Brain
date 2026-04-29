# servlet filter

## What it is
Like a bouncer at a club who checks IDs, searches bags, and stamps hands *before* anyone reaches the dance floor — a servlet filter intercepts HTTP requests and responses in a Java web application before they reach the target servlet or after the servlet responds. It is a reusable Java EE/Jakarta EE component that can inspect, modify, log, or block traffic in a web application's request-processing pipeline.

## Why it matters
Servlet filters are a primary defense layer for input validation and authentication enforcement in Java applications. A misconfigured or bypassed filter — for example, exploiting URL encoding tricks like `/admin;jsessionid=x` or path traversal in older Spring Security versions (CVE-2022-22965, Spring4Shell) — can allow attackers to reach protected endpoints entirely unchecked, bypassing authentication and authorization controls that the filter was supposed to enforce.

## Key facts
- Filters are configured in `web.xml` or via `@WebFilter` annotation and execute in a defined **filter chain** — order matters for security
- Common security uses: authentication checks, XSS/SQLi input sanitization, CSRF token validation, rate limiting, and audit logging
- Filters operate on **URL patterns**, meaning a poorly defined pattern like `/api/*` can miss `/API/` or encoded variants, enabling filter bypass
- The `doFilter()` method must explicitly call `chain.doFilter()` to pass the request forward — failing to do so silently blocks the request (useful for blocking, dangerous if miscoded)
- WAF bypass techniques often target filter chain weaknesses; penetration testers specifically fuzz URL encoding and HTTP method variations to find gaps

## Related concepts
[[input validation]] [[authentication bypass]] [[web application firewall]] [[cross-site scripting]] [[path traversal]]