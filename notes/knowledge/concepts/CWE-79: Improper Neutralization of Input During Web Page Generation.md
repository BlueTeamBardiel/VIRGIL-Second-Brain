# CWE-79: Improper Neutralization of Input During Web Page Generation

## What it is
Imagine a restaurant that prints your name on a birthday cake exactly as written on the order form — if you write "Happy Birthday <script>steal()</script>", the kitchen pipes it straight onto the frosting and the oven "executes" it. CWE-79, commonly called Cross-Site Scripting (XSS), occurs when a web application accepts user-supplied input and renders it in a browser without properly encoding or sanitizing it, allowing injected scripts to execute in victims' browsers. The attacker's code runs with the trust level of the legitimate site.

## Why it matters
In 2018, British Airways suffered a Magecart attack where attackers injected malicious JavaScript into the booking page, silently harvesting payment card data from ~500,000 customers in real time. The injected script persisted because the application reflected form field content back to the page without output encoding — a textbook Stored XSS scenario.

## Key facts
- **Three variants**: Reflected (Type 1 — non-persistent, payload in URL), Stored (Type 2 — persistent, payload saved in database), and DOM-based (Type 0 — manipulation occurs entirely client-side without server involvement)
- **Primary defense**: Output encoding tied to context — HTML encoding for HTML body, JavaScript encoding for script contexts, URL encoding for URLs; one method does not cover all contexts
- **Content Security Policy (CSP)** acts as a second-layer defense by whitelisting approved script sources, significantly limiting XSS impact even when injection occurs
- **Session hijacking** via `document.cookie` theft is the classic XSS payload; modern browsers' `HttpOnly` flag blocks this specific vector
- XSS consistently ranks in the **OWASP Top 10** (A03:2021 Injection category) and is frequently tested on Security+/CySA+ as a web application threat

## Related concepts
[[Cross-Site Request Forgery]] [[Content Security Policy]] [[Input Validation]] [[HTTP-Only Cookies]] [[OWASP Top 10]]