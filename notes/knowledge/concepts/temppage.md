# temppage

## What it is
Like a chef's scratch paper used mid-recipe that gets left on the counter for anyone to read, a temp page (temporary page) is a short-lived web page or buffer space created dynamically during a session or process — often intended to be transient but inadvertently left accessible. In web applications, temp pages may store intermediate data, partial form submissions, or session-specific content at predictable or discoverable URLs.

## Why it matters
Attackers performing forced browsing or directory enumeration routinely probe for temporary pages left exposed on web servers (e.g., `/tmp/report_1234.html` or `/temppage.php`). In one classic scenario, a vulnerable e-commerce site generated temporary order confirmation pages with sequential IDs, allowing an attacker to iterate through IDs and harvest other customers' order details, names, and addresses — a textbook Insecure Direct Object Reference (IDOR) vulnerability.

## Key facts
- Temp pages are a common artifact of poor session hygiene; they may persist beyond their intended lifespan due to misconfigured cleanup routines
- Predictable naming conventions (sequential numbers, timestamps) make temp pages trivially guessable via automated fuzzing tools like Gobuster or Burp Suite Intruder
- Sensitive data cached in temp pages violates the principle of data minimization and may breach GDPR/HIPAA if PII is exposed
- Web application firewalls (WAFs) and proper access controls (authentication checks before serving temp content) are the primary defenses
- OWASP Top 10 maps this risk under **A01: Broken Access Control** and **A03: Injection** (if temp pages are dynamically generated from user input)

## Related concepts
[[Insecure Direct Object Reference (IDOR)]] [[Forced Browsing]] [[Session Management]] [[Directory Enumeration]] [[Broken Access Control]]