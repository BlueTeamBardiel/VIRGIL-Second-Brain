# Client-Side XSS

## What it is
Imagine a bulletin board where anyone can pin a note, but the janitor reads every note aloud to every visitor who walks in — including notes that say "call this phone number and hand over your wallet." Client-Side XSS (Cross-Site Scripting) occurs when an attacker injects malicious JavaScript into a web application that executes inside the victim's browser, not on the server, because the application reflects or stores unsanitized user input back into the DOM.

## Why it matters
In 2014, eBay suffered a stored XSS vulnerability where attackers embedded malicious scripts in product listings; when buyers viewed the listing, the script redirected them to phishing pages harvesting credentials. Proper output encoding and Content Security Policy (CSP) headers would have blocked script execution entirely, making this a preventable architectural failure.

## Key facts
- **Two primary types**: Reflected XSS (payload in the HTTP request/response, non-persistent) and Stored XSS (payload saved in the database, persistent and higher impact)
- **DOM-based XSS** is a third subtype where the vulnerability lives entirely in client-side JavaScript — the server never sees the malicious payload
- Successful XSS enables session hijacking (stealing cookies), credential harvesting, keylogging, and browser-based malware delivery
- The primary defenses are **input validation**, **output encoding** (HTML-encoding `<`, `>`, `"`, `'`, `&`), and deploying a strict **Content Security Policy**
- XSS consistently appears in the OWASP Top 10 under *Injection* and is tested via payloads like `<script>alert(1)</script>` or event handlers like `<img src=x onerror=alert(1)>`

## Related concepts
[[Cross-Site Request Forgery (CSRF)]] [[Content Security Policy (CSP)]] [[Session Hijacking]] [[Input Validation]] [[DOM-Based Vulnerabilities]]