# prepared statement

## What it is
Think of a prepared statement like a cookie-cutter mold: you stamp out the shape first, then fill it with whatever dough you want — the shape never changes regardless of what goes in. A prepared statement is a pre-compiled SQL template where user input is passed as parameters *after* the query structure is already fixed by the database engine. Because the structure is locked before data arrives, malicious input like `' OR 1=1 --` is treated as literal data, never as executable SQL.

## Why it matters
In the 2008 Heartland Payment Systems breach, attackers exploited SQL injection to steal 130 million credit card numbers — one of the largest breaches at the time. Had developers used prepared statements instead of concatenating user input directly into queries, the injected SQL would have been rendered inert, treating the attacker's payload as a harmless string rather than a command the database would execute.

## Key facts
- Prepared statements separate **code from data** at the database engine level, not just through string sanitization — this is a structural defense, not cosmetic filtering
- They are also called **parameterized queries**; both terms appear on Security+ and CySA+ exams
- Prepared statements defend against **first-order SQL injection** but require additional controls (e.g., stored procedures with strict permissions) to fully address second-order injection
- They are available in virtually every major language/DB combination: Java (`PreparedStatement`), Python (`cursor.execute()` with parameters), PHP (`PDO`)
- Prepared statements do **not** prevent all injection types — they do not protect against OS command injection, LDAP injection, or XPath injection, which require separate countermeasures

## Related concepts
[[SQL injection]] [[input validation]] [[parameterized query]] [[stored procedure]] [[OWASP Top 10]]