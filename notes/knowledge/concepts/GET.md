# GET

## What it is
Like shouting your order across a restaurant so everyone can hear it, GET sends request parameters visibly in the URL string. It is an HTTP method used to retrieve data from a web server, where all parameters are appended to the URL (e.g., `?user=alice&id=42`), making them visible in browser history, server logs, and network traffic.

## Why it matters
Because GET parameters appear in URLs, sensitive data passed this way ends up in web server access logs, browser history, and HTTP Referer headers — all readable by attackers. In SQL injection attacks, threat actors manipulate GET parameters directly in the address bar (e.g., `?id=1' OR '1'='1`) to craft malicious database queries without needing any special tools, making GET endpoints a primary target for automated vulnerability scanners.

## Key facts
- GET requests should be **idempotent and read-only** — they must not modify server-side data; using GET for state changes violates RFC 7231 and enables CSRF exploits
- Parameters are embedded in the URL, meaning they are stored in **browser history, bookmarks, and server access logs** — never use GET for passwords or tokens
- GET requests can be cached by browsers and proxies, which can lead to **sensitive data exposure** through shared caches
- Maximum URL length (~2048 characters in most browsers) limits GET payloads, but attackers exploit this boundary for **buffer overflow or parsing attacks** in poorly coded apps
- Contrasted with POST: POST sends data in the **request body**, not the URL, making it less exposed in logs — though POST is *not* inherently secure without HTTPS

## Related concepts
[[HTTP Methods]] [[SQL Injection]] [[CSRF]] [[HTTPS]] [[Web Application Firewall]]