# Burp Suite

## What it is
Think of it as a toll booth you install between your browser and a web server — every request and response must pass through you, and you can inspect, modify, or replay any of it at will. Burp Suite is an integrated web application security testing platform that acts as an intercepting proxy, allowing testers to analyze and manipulate HTTP/HTTPS traffic in real time. Developed by PortSwigger, it is the industry-standard toolkit for manual and automated web vulnerability assessment.

## Why it matters
During a penetration test against a banking application, a tester uses Burp Suite's Intruder module to fuzz a login form's hidden `accountID` parameter — cycling through sequential integers reveals that the application returns other users' account data with no authorization check, confirming an IDOR (Insecure Direct Object Reference) vulnerability. Without an intercepting proxy, this parameter would never be visible in a normal browser interaction. This class of vulnerability is responsible for countless real-world data breaches.

## Key facts
- **Proxy module** intercepts and modifies HTTP/HTTPS requests between browser and server; requires installing Burp's CA certificate to inspect TLS traffic.
- **Scanner** (Pro edition) automatically crawls and audits for OWASP Top 10 vulnerabilities including SQLi, XSS, and SSRF.
- **Intruder** performs automated customized attacks — fuzzing, brute-forcing, and payload injection — against specific request parameters.
- **Repeater** allows manual resending and modification of individual requests, essential for manually confirming and exploiting vulnerabilities.
- **Community edition is free**; Professional edition (~$449/year) unlocks the automated scanner — a common exam distractor about its capabilities.

## Related concepts
[[Intercepting Proxy]] [[OWASP Top 10]] [[SQL Injection]] [[Cross-Site Scripting (XSS)]] [[Penetration Testing]]