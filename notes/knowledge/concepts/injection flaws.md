# injection flaws

## What it is
Imagine handing a chef a recipe card, but you've smuggled extra instructions onto the back — "and also give me everything in the kitchen." Injection flaws occur when an attacker supplies untrusted input that an interpreter executes as commands rather than treating as data, allowing the attacker to alter the logic of a query, command, or script. The classic form is SQL injection, but the family includes OS command injection, LDAP injection, and XML/XPath injection.

## Why it matters
In 2019, attackers exploited SQL injection against a major healthcare provider, extracting millions of patient records by appending `' OR '1'='1` conditions to login queries — bypassing authentication entirely without knowing a single valid password. Parameterized queries (prepared statements) directly neutralize this attack class by ensuring user input is never interpreted as executable code, which is why input validation and query parameterization are considered foundational secure-coding practices.

## Key facts
- **SQL injection** remains the most prevalent injection type; OWASP historically ranked injection as the #1 web application risk (now #3 in OWASP Top 10 2021, under "Injection").
- **Blind SQL injection** extracts data without visible error messages by asking true/false questions through response behavior differences (time delays or content changes).
- **Mitigation**: Parameterized queries / prepared statements are the gold-standard defense; stored procedures help only if they don't internally construct dynamic SQL.
- **OS command injection** occurs when applications pass unsanitized input to system shell functions (e.g., `exec()`, `system()`), allowing arbitrary command execution.
- **Defense-in-depth layers**: input validation (allowlist > denylist), least-privilege database accounts, and WAFs are layered controls — none alone is sufficient.

## Related concepts
[[SQL injection]] [[input validation]] [[cross-site scripting]] [[OWASP Top 10]] [[parameterized queries]]