# CWE-79 Cross-Site Scripting

## What it is
Imagine slipping a forged note into a teacher's grade book — when the teacher reads it aloud, your words come out of their trusted mouth. XSS works the same way: an attacker injects malicious scripts into a trusted web application, and the victim's browser executes that code as if it came from the legitimate site. It exploits the browser's trust in the origin, not a flaw in the browser itself.

## Why it matters
The 2005 Samy worm exploited a stored XSS vulnerability in MySpace, self-propagating to over one million profiles in under 20 hours — the fastest-spreading worm at the time. Attackers used it to steal session cookies, hijack accounts, and deface profiles. This incident cemented XSS as a critical web threat rather than a minor nuisance.

## Key facts
- **Three types**: Stored (persisted in database), Reflected (in URL/request), and DOM-based (client-side script manipulation) — all three appear on Security+ objectives
- **Primary weapon**: Session cookie theft via `document.cookie`, enabling session hijacking without knowing the user's password
- **Root cause**: Insufficient output encoding — failing to escape characters like `<`, `>`, `"`, and `'` before rendering user-supplied data as HTML
- **Primary defense**: Context-aware output encoding (HTML, JavaScript, CSS, URL contexts differ) plus Content Security Policy (CSP) headers to block inline script execution
- **OWASP ranking**: Consistently in the OWASP Top 10; classified under "Injection" in the 2021 edition (A03)

## Related concepts
[[Content Security Policy]] [[Session Hijacking]] [[SQL Injection]] [[Input Validation]] [[OWASP Top 10]]