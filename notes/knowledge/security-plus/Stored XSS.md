# stored XSS

## What it is
Imagine a graffiti artist who sneaks into a library and writes malicious instructions inside a popular book — every reader who opens it gets infected, not just one. Stored XSS (also called persistent XSS) works the same way: an attacker injects malicious script into a web application's database, and that script executes in every victim's browser whenever they load the infected page. Unlike reflected XSS, no crafted link is required — the payload lives in the server itself.

## Why it matters
In 2018, attackers exploited stored XSS in British Airways' booking platform to inject a card-skimming script that silently harvested payment details from ~500,000 customers. Every user who visited the legitimate checkout page had their credentials and card data exfiltrated to an attacker-controlled domain — no phishing link, no user error beyond visiting the real website.

## Key facts
- Stored XSS payloads persist in back-end storage (databases, log files, comment fields) and execute on page load for every user, making them higher-impact than reflected XSS
- Common injection points include comment sections, user profile fields, forum posts, and anywhere user-supplied data is rendered back as HTML
- The attack breaks the browser's Same-Origin Policy by running in the trusted context of the victim site
- Mitigation requires **output encoding** (convert `<` to `&lt;`) at render time AND **input validation** at write time — one alone is insufficient
- Content Security Policy (CSP) headers reduce damage by restricting which scripts the browser will execute, even if injection succeeds

## Related concepts
[[reflected XSS]] [[DOM-based XSS]] [[Content Security Policy]] [[input validation]] [[SQL injection]]