# GET parameter

## What it is
Like writing your grocery list on the outside of an envelope instead of inside — everyone who handles it can read it. A GET parameter is a key-value pair appended to a URL after a `?` symbol (e.g., `https://shop.com/search?query=shoes&page=2`), transmitting data from client to server entirely in plaintext within the request line itself.

## Why it matters
GET parameters are the most common injection point for SQL injection and Cross-Site Scripting (XSS) attacks — an attacker modifies `?id=1` to `?id=1' OR '1'='1` directly in the browser's address bar, requiring zero special tools. They're also logged verbatim in web server access logs, proxy logs, and browser history, meaning sensitive data like session tokens passed via GET can leak through multiple unintended channels.

## Key facts
- GET parameters are visible in browser history, server logs, and HTTP `Referer` headers — never use them for passwords or session tokens
- Maximum URL length is ~2,000–8,000 characters depending on browser/server, making GET unsuitable for large data payloads
- Unlike POST parameters, GET requests can be bookmarked, cached, and replayed trivially — making CSRF attacks easier when actions rely on GET
- OWASP lists unsanitized GET parameters as a primary vector for injection attacks (A03:2021)
- GET requests are idempotent by HTTP specification — they should retrieve data only, never modify server state (a violation commonly exploited)

## Related concepts
[[SQL Injection]] [[Cross-Site Scripting (XSS)]] [[Cross-Site Request Forgery (CSRF)]] [[HTTP Methods]] [[Input Validation]]