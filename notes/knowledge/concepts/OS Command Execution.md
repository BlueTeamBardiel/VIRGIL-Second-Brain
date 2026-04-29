# OS command execution

## What it is
Think of it like a telephone operator who will connect any call you ask for — if an application blindly passes user input to the operating system shell, attackers can dial any number they want. OS command injection is a vulnerability where unsanitized user-supplied data is passed directly to system shell interpreters (like `/bin/sh` or `cmd.exe`), allowing attackers to execute arbitrary commands with the application's privilege level.

## Why it matters
In 2021, attackers exploited a command injection flaw in Pulse Connect Secure VPNs (CVE-2021-22893), passing malicious strings through a web interface that the underlying OS executed as root — giving full server control without credentials. Defenders must sanitize inputs and avoid shell=True constructs in code entirely; using parameterized APIs that call programs directly (no shell interpreter) eliminates the attack surface.

## Key facts
- **Metacharacters** like `;`, `|`, `&&`, `||`, `` ` ``, and `$()` are the attacker's tools — they chain or nest additional commands inside legitimate-looking input
- Successful exploitation runs commands at the **privilege level of the web server or application process**, not the attacker's own account
- **Blind command injection** returns no output to the attacker; timing attacks (e.g., `sleep 10`) or out-of-band DNS callbacks confirm execution
- Mitigation hierarchy: avoid shell calls entirely → use allowlists → escape metacharacters → run applications as least-privilege accounts
- Distinct from **SQL injection** (targets database interpreters) — OS command injection targets the system shell; both are **CWE-77/CWE-78** family issues

## Related concepts
[[SQL injection]] [[input validation]] [[least privilege]] [[code injection]] [[privilege escalation]]