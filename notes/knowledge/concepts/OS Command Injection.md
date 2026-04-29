# OS Command Injection

## What it is
Imagine handing a restaurant order slip to a chef, but instead of writing "steak, medium-rare," a malicious customer writes "steak, medium-rare; also unlock the back door and hand me the cash register." OS command injection works the same way — an attacker appends shell commands to unsanitized user input that gets passed to a system shell, causing the OS to execute attacker-controlled instructions with the application's privileges.

## Why it matters
In 2014, the Shellshock vulnerability allowed attackers to inject commands through environment variables processed by Bash, enabling remote code execution on millions of web servers running CGI scripts. A defender who had enforced input validation and avoided shell execution functions entirely would have been immune to the attack vector entirely.

## Key facts
- **Shell metacharacters** are the weapon: semicolons (`;`), pipes (`|`), ampersands (`&`), backticks (`` ` ``), and `$()` allow chaining or substituting commands in most Unix/Windows shells
- **Blind OS command injection** returns no output to the attacker — they infer execution via time delays (`ping -c 10 localhost`) or out-of-band DNS/HTTP callbacks
- **Mitigation priority**: avoid calling OS commands altogether; if unavoidable, use parameterized APIs (e.g., `execve()` with argument arrays) rather than shell-interpreted strings
- Runs with the **privilege level of the web server process** (often `www-data` or `SYSTEM`), making privilege escalation a likely next step
- Listed as part of **OWASP Top 10 A03:2021 (Injection)** — frequently tested on Security+ and CySA+ as a critical injection class alongside SQL injection

## Related concepts
[[SQL Injection]] [[Input Validation]] [[Privilege Escalation]] [[Remote Code Execution]] [[OWASP Top 10]]