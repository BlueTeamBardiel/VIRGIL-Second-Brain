# string interpolation without sanitization

## What it is
Imagine a mad-lib template where a user fills in the blank labeled "your name" with "'; DROP TABLE users;'—" and the resulting sentence is read aloud as a command rather than a story. String interpolation without sanitization is exactly that: user-supplied input is embedded directly into a string (SQL query, shell command, HTML page) that is later executed or rendered, without first stripping or escaping dangerous characters.

## Why it matters
In 2017, an Equifax breach vector involved unsanitized input being passed into an Apache Struts framework that executed arbitrary commands. When developers concatenate user input directly into SQL queries—`"SELECT * FROM users WHERE name = '" + userInput + "'"—an attacker supplying `' OR '1'='1` bypasses authentication entirely, exposing every record in the database without a single password.

## Key facts
- **SQL injection** is the canonical exploit: unsanitized interpolation lets attackers alter query logic, dump tables, or execute stored procedures.
- **Parameterized queries (prepared statements)** are the primary defense—they separate code from data so injected strings are treated as literals, never as executable syntax.
- **Cross-site scripting (XSS)** occurs when unsanitized input is interpolated into HTML/JavaScript, allowing attackers to inject `<script>` tags that steal session cookies.
- **OS command injection** happens when user input is interpolated into shell commands (e.g., Python's `os.system("ping " + userInput)`), enabling arbitrary code execution.
- OWASP consistently ranks injection flaws (including string interpolation vulnerabilities) in its **Top 10**, making this directly testable on Security+ and CySA+ exams.

## Related concepts
[[SQL Injection]] [[Cross-Site Scripting (XSS)]] [[Input Validation]] [[Command Injection]] [[Parameterized Queries]]