# OWASP Juice Shop

## What it is
Think of it as a stunt driver's training track — deliberately built with every dangerous curve and guardrail removed so you can practice crashing safely. OWASP Juice Shop is an intentionally vulnerable web application written in Node.js that simulates a real e-commerce store riddled with over 100 documented security flaws. It serves as a legal, self-contained target for practicing offensive and defensive web security techniques.

## Why it matters
During a penetration test engagement, a junior tester might use Juice Shop to rehearse exploiting a SQL injection flaw in a login form before touching a client's actual system — the skills transfer directly. Defenders use it to understand exactly what a reflected XSS payload looks like in server logs, sharpening their ability to write SIEM detection rules for real environments.

## Key facts
- Covers all **OWASP Top 10** vulnerability categories, including Injection, Broken Access Control, and Security Misconfiguration — making it directly relevant to Security+/CySA+ exam scenarios
- Built with a **CTF-style challenge board** that tracks solved vulnerabilities with score flags, providing structured progression from one-star (trivial) to six-star (expert) difficulty
- Runs locally via **Docker, Node.js, or Heroku** — no network exposure required, making it safe for isolated lab environments
- Includes **broken authentication** exercises such as bypassing login with default credentials (`admin@juice-sh.op` / `admin123`) — a direct analog to real credential-stuffing attacks
- Supported officially by **OWASP** and used in security awareness training, university curricula, and professional certification prep worldwide

## Related concepts
[[OWASP Top 10]] [[SQL Injection]] [[Cross-Site Scripting (XSS)]] [[Penetration Testing]] [[Broken Access Control]]