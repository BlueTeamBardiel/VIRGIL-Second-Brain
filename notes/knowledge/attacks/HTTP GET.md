# HTTP GET

## What it is
Like shouting a question across a library — everyone nearby can hear exactly what you asked. HTTP GET is a request method that retrieves data from a web server by embedding all parameters directly in the URL, making the request visible in browser history, server logs, and network captures.

## Why it matters
Attackers exploit GET parameters to perform SQL injection, cross-site scripting (XSS), and directory traversal — because the payload travels in the URL itself (`?id=1' OR '1'='1`), it's trivially easy to craft and share malicious links. Defenders monitor web server logs specifically for suspicious GET parameters, making GET-based attacks both easy to launch and easy to detect and audit.

## Key facts
- GET requests are **idempotent** — they should only retrieve data, never modify server state (though poorly designed apps violate this)
- All parameters are **visible in the URL**, browser history, Referer headers, and server access logs — never use GET for passwords or sensitive data
- GET requests can be **bookmarked and cached**, which is exploitable: a malicious link is a complete, weaponized GET request
- Maximum URL length is browser/server-dependent (~2,048 chars in older IIS), limiting GET payload size compared to POST
- OWASP Top 10 vulnerabilities including **A03 Injection** and **A07 Identification and Authentication Failures** frequently manifest through unsanitized GET parameters

## Related concepts
[[HTTP POST]] [[SQL Injection]] [[Cross-Site Scripting (XSS)]] [[OWASP Top 10]] [[HTTP Request Methods]]