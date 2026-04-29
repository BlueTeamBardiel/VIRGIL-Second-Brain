# Burp Suite Community Edition

## What it is
Think of it as a glass-walled postal sorting facility for web traffic — every HTTP/HTTPS message passing between your browser and a web server gets intercepted, examined, and can be tampered with before delivery. Burp Suite Community Edition is a free web application security testing platform developed by PortSwigger that operates as an intercepting proxy, sitting between a tester's browser and the target application to capture and manipulate web requests in real time.

## Why it matters
During a web application penetration test, a tester suspects a login form is vulnerable to SQL injection. Using Burp's Proxy Intercept, they capture the POST request containing username and password fields, forward it to the Repeater tool, and manually inject payloads like `' OR 1=1--` to confirm the vulnerability before reporting it — without writing a single line of code.

## Key facts
- **Proxy module** listens on localhost:8080 by default, requiring the browser to route traffic through it; certificates must be installed to intercept HTTPS traffic
- **Repeater** allows manual modification and re-sending of individual HTTP requests, making it essential for manual payload testing
- **Intruder** (rate-limited in Community Edition) automates request fuzzing across defined payload positions — useful for brute-force and parameter tampering scenarios
- **Decoder** converts data between Base64, URL encoding, HTML entities, and hex — critical for analyzing obfuscated parameters
- Community Edition lacks the automated **Scanner** module, which is restricted to the paid Professional Edition; manual testing workflow compensates for this gap

## Related concepts
[[Intercepting Proxy]] [[HTTP Request Smuggling]] [[OWASP Top 10]] [[SQL Injection]] [[Web Application Penetration Testing]]