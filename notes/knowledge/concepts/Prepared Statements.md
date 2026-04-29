# prepared statements

## What it is
Like ordering at a restaurant by filling out a printed form (where the structure is fixed and you just write in your choices), a prepared statement separates SQL code structure from user-supplied data before sending it to the database. The query template is compiled first; user input is then passed as parameters that the database engine treats as pure data — never as executable code.

## Why it matters
In 2008, Heartland Payment Systems was breached via SQL injection, exposing 130 million credit card numbers — one of the largest breaches in history. Had their application used prepared statements, the attacker's injected SQL payload (`' OR 1=1 --`) would have been treated as a literal string to search for, not as logic to execute, and the breach would have been stopped at the query layer.

## Key facts
- Prepared statements are the **primary defense** against SQL injection (CWE-89), listed as OWASP's #1 web application risk
- They work by **parameterizing inputs**: the database precompiles the query skeleton, so injected syntax cannot alter the query's structure
- Available in virtually all modern languages/frameworks: `PDO` in PHP, `PreparedStatement` in Java, `parameterized queries` in Python's `sqlite3`
- **Stored procedures** can offer similar protection but only when implemented without dynamic SQL string concatenation internally
- Prepared statements do **not** protect against all injection types — they don't defend against second-order SQL injection if stored data is later reused unsafely, or against NoSQL/LDAP/OS command injection in non-SQL contexts

## Related concepts
[[SQL injection]] [[input validation]] [[parameterized queries]] [[stored procedures]] [[OWASP Top 10]]