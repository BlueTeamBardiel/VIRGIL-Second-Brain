# reflected XSS

## What it is
Like a mirror that throws sunlight into someone's eyes — you craft a malicious payload, bounce it off a trusted server, and the server reflects it straight back into the victim's browser. Reflected XSS (Cross-Site Scripting) occurs when user-supplied input is immediately echoed back in an HTTP response without sanitization, causing the victim's browser to execute attacker-injected JavaScript in the context of the trusted site. Unlike stored XSS, the payload is never persisted — it lives only in the crafted URL or request.

## Why it matters
In 2011, attackers exploited a reflected XSS vulnerability in a major banking portal by embedding a malicious script in a password-reset link sent via phishing email. When victims clicked the link, the bank's own server reflected the script, which harvested session cookies and transmitted them to an attacker-controlled server — bypassing the bank's same-origin policy entirely because the script appeared to originate from the bank's domain.

## Key facts
- Reflected XSS is classified as **non-persistent** — the payload must be delivered to the victim each time, typically via a crafted URL in a phishing message
- It is listed in the **OWASP Top 10** under Injection (A03:2021)
- The attack executes in the **victim's browser**, inheriting that site's session cookies, local storage, and DOM permissions
- Primary defenses include **input validation, output encoding** (especially HTML entity encoding), and **Content Security Policy (CSP)** headers
- On Security+ exams, reflected XSS is commonly contrasted with **stored XSS** (persistent, server-side) and **DOM-based XSS** (client-side, never hits the server)

## Related concepts
[[stored XSS]] [[DOM-based XSS]] [[Content Security Policy]] [[input validation]] [[session hijacking]]