# PortSwigger

## What it is
Think of it as a flight simulator for hackers — a company and platform that lets security professionals practice real attacks in a safe, controlled environment before ever touching a live system. PortSwigger is a UK-based cybersecurity company best known for creating Burp Suite (the industry-standard web application security testing tool) and maintaining the Web Security Academy, a free training platform covering web vulnerabilities.

## Why it matters
When a penetration tester needs to assess whether a banking application is vulnerable to SQL injection or broken access control, they use Burp Suite's proxy to intercept HTTP requests, modify parameters on the fly, and replay crafted payloads — all without writing custom tooling from scratch. The Web Security Academy's hands-on labs mirror real CVEs, meaning analysts can practice exploiting and remediating the exact vulnerability classes appearing in enterprise breach reports.

## Key facts
- **Burp Suite** operates as an intercepting proxy, sitting between a browser and target server to capture, inspect, and manipulate HTTP/HTTPS traffic in real time
- The **Web Security Academy** is free and covers all OWASP Top 10 categories through interactive labs tied to real vulnerability research
- PortSwigger researchers coined and formalized the **HTTP Request Smuggling** attack technique, which manipulates ambiguous Content-Length vs. Transfer-Encoding headers to desynchronize front-end/back-end server parsing
- Burp Suite Professional includes an **active scanner** that automates detection of SQLi, XSS, XXE, and SSRF — relevant to CySA+ tool knowledge objectives
- PortSwigger maintains a **research blog** that regularly discloses novel web attack techniques before they become widespread, functioning as an early-warning resource for defenders

## Related concepts
[[Burp Suite]] [[OWASP Top 10]] [[HTTP Request Smuggling]] [[Web Application Penetration Testing]] [[Intercepting Proxy]]