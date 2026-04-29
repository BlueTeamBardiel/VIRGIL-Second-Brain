# Burp Suite Professional

## What it is
Think of it as a customs officer standing between your browser and a web server — intercepting every package, inspecting the contents, and letting you tamper with them before they reach their destination. Burp Suite Professional is an integrated platform for web application security testing, developed by PortSwigger, that functions as an intercepting HTTP/HTTPS proxy with a suite of active and passive scanning tools built around it.

## Why it matters
During a penetration test against an e-commerce platform, a tester uses Burp's Intruder tool to fuzz a discount code field with thousands of payloads, discovering that negative values create a negative total price — a logic flaw invisible to automated scanners. Burp's ability to manually manipulate live requests makes it the industry standard for finding business logic vulnerabilities that rule-based tools consistently miss.

## Key facts
- **Intercepting Proxy** runs on localhost (default port 8080), routing browser traffic through Burp so testers can pause, inspect, and modify requests/responses in real time
- **Scanner** performs active crawling and auditing, flagging OWASP Top 10 vulnerabilities like SQL injection, XSS, and insecure deserialization with evidence-backed reports
- **Intruder** automates customized attack payloads across parameterized positions — used for brute force, fuzzing, and enumeration attacks
- **Repeater** allows manual resending and modification of individual requests, critical for confirming and exploiting discovered vulnerabilities
- **Sequencer** analyzes the randomness/entropy of session tokens to determine whether they are predictable and vulnerable to session hijacking
- Burp Suite **Community Edition** is free but rate-limits Intruder and lacks the automated scanner; **Professional** is the paid, exam-relevant version

## Related concepts
[[Web Application Firewall]] [[OWASP Top 10]] [[SQL Injection]] [[Session Hijacking]] [[Penetration Testing Methodology]]