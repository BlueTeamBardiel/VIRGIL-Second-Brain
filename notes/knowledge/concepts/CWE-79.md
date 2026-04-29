# CWE-79

## What it is
Imagine a bulletin board where anyone can pin a note, but the librarian reads every note aloud to visitors — including one that says "ignore everything and steal everyone's wallets." Cross-Site Scripting (XSS) works exactly like that: an attacker injects malicious scripts into a trusted web page, which then execute in the victim's browser as if they were legitimate site code. CWE-79 specifically covers improper neutralization of input during web page generation.

## Why it matters
In 2005, the Samy worm exploited a stored XSS vulnerability in MySpace, self-propagating to over one million profiles in under 24 hours by injecting JavaScript that automatically added Samy as a friend and replicated itself. A proper output encoding defense — escaping `<`, `>`, `"`, and `&` before rendering user content — would have stopped it entirely.

## Key facts
- **Three types**: Stored (persistent, server saves payload), Reflected (payload in URL/request, immediately returned), and DOM-based (manipulation happens entirely client-side in JavaScript)
- **Primary defense**: Context-aware output encoding — HTML encode for HTML context, JavaScript encode for JS context, URL encode for URL context
- **Content Security Policy (CSP)** is a secondary defense that restricts which scripts the browser will execute, limiting XSS blast radius
- **Impact**: Session hijacking via cookie theft, credential harvesting, keylogging, and drive-by malware delivery — all executing under the victim's trusted session
- CWE-79 consistently ranks in the **OWASP Top 10** (under Injection/A03) and is among the top three most dangerous web weaknesses by CVE volume

## Related concepts
[[SQL Injection]] [[Content Security Policy]] [[Session Hijacking]] [[Input Validation]] [[OWASP Top 10]]