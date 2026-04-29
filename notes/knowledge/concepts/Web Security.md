# Web Security

## What it is
Like a bank vault with a glass door — your application might look secure, but if the inputs aren't validated and outputs aren't encoded, anyone walking by can reach through and grab the cash. Web security is the discipline of protecting web applications, APIs, and browsers from exploitation by controlling how data flows between clients, servers, and third parties.

## Why it matters
In 2017, the Equifax breach exposed 147 million records because attackers exploited an unpatched Apache Struts vulnerability (CVE-2017-5638) — a publicly known flaw with a patch already available. Proper patch management and input validation would have closed the window entirely. This single gap in web security hygiene cost the company over $700 million in settlements.

## Key facts
- **OWASP Top 10** is the canonical reference for web application risk; Security+/CySA+ expect familiarity with categories like Injection, Broken Access Control, and Security Misconfiguration
- **SQL Injection** occurs when user-supplied input is interpreted as SQL commands; parameterized queries (prepared statements) are the primary defense
- **Cross-Site Scripting (XSS)** injects malicious scripts into pages viewed by other users; output encoding is the mitigation
- **Cross-Site Request Forgery (CSRF)** tricks authenticated users into submitting unwanted requests; anti-CSRF tokens and SameSite cookie attributes are defenses
- **HTTP Security Headers** (e.g., `Content-Security-Policy`, `X-Frame-Options`, `Strict-Transport-Security`) provide browser-enforced protection layers without changing application logic

## Related concepts
[[SQL Injection]] [[Cross-Site Scripting]] [[OWASP Top 10]] [[Content Security Policy]] [[Input Validation]]