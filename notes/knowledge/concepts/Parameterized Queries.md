# parameterized queries

## What it is
Think of it like a mad-libs form where the blanks are pre-stamped and locked — user input can only fill designated slots, never escape to become part of the sentence's grammar. Precisely: parameterized queries (also called prepared statements) separate SQL code from data by sending the query structure to the database first, then binding user-supplied values as inert parameters afterward. The database engine treats those values as pure data, never as executable instructions.

## Why it matters
In 2008, Heartland Payment Systems suffered one of the largest breaches in history — approximately 130 million card numbers stolen — through SQL injection exploiting unsanitized input concatenated directly into queries. Had parameterized queries been used, the attacker's injected SQL payload (e.g., `' OR '1'='1`) would have been treated as a literal string to search for, not as logic to execute, making the entire attack vector inert.

## Key facts
- Parameterized queries are the **primary defense** against SQL injection, which consistently appears in the OWASP Top 10.
- They work at the **driver/engine level** — the database compiles the query plan before data arrives, making late-stage injection structurally impossible.
- Distinct from **input validation or escaping**: those are secondary defenses; parameterization eliminates the attack class architecturally.
- Supported in virtually all modern languages/frameworks: `PreparedStatement` in Java, `PDO` in PHP, `psycopg2` parameterization in Python.
- **Stored procedures** can provide similar protection *only* if they internally use parameterization — a stored procedure that still concatenates strings is equally vulnerable.

## Related concepts
[[SQL injection]] [[input validation]] [[stored procedures]] [[OWASP Top 10]] [[defense in depth]]