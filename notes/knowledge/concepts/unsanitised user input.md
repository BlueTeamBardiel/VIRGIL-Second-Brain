# unsanitised user input

## What it is
Imagine a postal sorting facility that forwards every package without checking contents — bombs, biohazards, and all. Unsanitised user input is data accepted from a user and passed directly into a system process (database query, shell command, HTML renderer) without validation, encoding, or filtering. The application blindly trusts the user, treating their data as instructions rather than just data.

## Why it matters
In 2017, the Equifax breach exposed 147 million records partly because a web application passed unsanitised input into a backend query, enabling attackers to exploit Apache Struts. Proper input validation — rejecting unexpected characters, enforcing length limits, and using parameterised queries — would have broken the attack chain before data was ever reached.

## Key facts
- **Root cause of multiple vuln classes:** SQL injection, XSS, command injection, path traversal, and LDAP injection all fundamentally rely on unsanitised input reaching an interpreter.
- **Allowlist > Denylist:** Allowlisting (defining what IS acceptable) is more secure than denylisting (blocking known bad strings), because attackers can craft novel bypass strings for denylists.
- **Context determines encoding:** The same input needs different sanitisation depending on destination — HTML encoding for web output, parameterised queries for SQL, shell escaping for OS commands.
- **Client-side validation is not security:** JavaScript input validation is trivially bypassed with Burp Suite or `curl`; server-side validation is the only enforceable control.
- **CWE-20 (Improper Input Validation)** consistently appears in OWASP Top 10 and MITRE's top 25 most dangerous software weaknesses — examiners love citing it.

## Related concepts
[[SQL injection]] [[cross-site scripting (XSS)]] [[command injection]] [[parameterised queries]] [[input validation]]