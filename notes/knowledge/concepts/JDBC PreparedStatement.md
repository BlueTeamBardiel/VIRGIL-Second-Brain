# JDBC PreparedStatement

## What it is
Think of it like a cookie cutter: the shape (SQL template) is fixed before you pour in the dough (user input), so the dough can never reshape the cutter. A `PreparedStatement` is a precompiled SQL template in Java where parameters are bound separately using placeholders (`?`), preventing user-supplied input from ever being interpreted as SQL syntax.

## Why it matters
In 2008, Heartland Payment Systems suffered one of the largest data breaches in history — attackers used SQL injection to compromise over 130 million card numbers. Had the application used `PreparedStatement` instead of concatenating raw input into SQL strings, the injected `' OR 1=1 --` payloads would have been treated as literal string data, not executable SQL, making the attack vector impossible.

## Key facts
- **Parameterized queries are the #1 defense** against SQL injection (OWASP Top 10 A03:2021); `PreparedStatement` is Java's primary implementation mechanism.
- A vulnerable pattern: `"SELECT * FROM users WHERE name = '" + userInput + "'"` — this concatenation allows injection. The safe form uses `"SELECT * FROM users WHERE name = ?"` with `stmt.setString(1, userInput)`.
- The driver sends the query template and parameters **as separate protocol messages**, so the database engine parses structure before seeing any user data.
- `PreparedStatement` also provides a **performance benefit** — the query is compiled once and can be reused with different parameters, reducing parse overhead.
- For CySA+/Security+: parameterized queries are classified as **input validation/sanitization controls** and are an example of **secure coding practices** under defensive programming.

## Related concepts
[[SQL Injection]] [[Input Validation]] [[OWASP Top 10]] [[Database Security]] [[Secure Coding Practices]]