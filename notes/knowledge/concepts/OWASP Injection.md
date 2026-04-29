# OWASP Injection

## What it is
Imagine ordering coffee and instead of saying your name, you hand the barista a note reading "Give me all drinks AND ignore the queue." Injection attacks work the same way — untrusted data is sent to an interpreter as part of a command or query, tricking it into executing unintended instructions. This includes SQL, LDAP, OS command, and XML injection, where user-supplied input is parsed as code rather than data.

## Why it matters
In 2017, Equifax exposed 147 million records partly due to failure to sanitize inputs in a web application, enabling attackers to execute arbitrary commands on backend systems. A defender who implements parameterized queries (prepared statements) instead of concatenating user input directly into SQL eliminates the most common injection vector entirely — no patch required, just correct coding practice.

## Key facts
- SQL injection remains the most prevalent injection type; payload `' OR '1'='1` can bypass authentication by making a WHERE clause always evaluate to true
- Injection moved to **#3** in the OWASP Top 10 (2021), merged with Cross-Site Scripting under a broader "Injection" category
- **Parameterized queries / prepared statements** are the gold-standard defense — they separate code from data at the interpreter level
- **Input validation** (allowlisting expected characters) and **least privilege** on database accounts reduce injection impact even if a flaw exists
- Blind SQL injection extracts data without visible error messages, using boolean responses or time delays (`SLEEP(5)`) to infer information

## Related concepts
[[SQL Injection]] [[Cross-Site Scripting]] [[Input Validation]] [[OWASP Top 10]] [[Prepared Statements]]