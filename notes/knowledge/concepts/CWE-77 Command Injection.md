# CWE-77 Command Injection

## What it is
Imagine handing a note to a bank teller that says "deposit $100 — also, open the vault and give me everything inside." Command Injection works the same way: an attacker embeds shell commands inside input that an application passes to a system interpreter, and the interpreter obediently executes both the intended operation *and* the attacker's payload. Specifically, CWE-77 occurs when user-supplied data is incorporated into a command string without proper neutralization, allowing arbitrary command execution in the application's privilege context.

## Why it matters
In 2021, attackers exploited a command injection vulnerability in Pulse Connect Secure VPN appliances (CVE-2021-22893), passing malicious input through a web interface to execute arbitrary commands as root — compromising defense contractors and government agencies. A single unsanitized field became a complete system takeover, demonstrating why this class ranks consistently in OWASP Top 10 injection attacks.

## Key facts
- **CWE-77 is the parent** of CWE-78 (OS Command Injection); CWE-77 covers any command interpreter (SQL, LDAP, shell), while CWE-78 is shell-specific.
- **Dangerous functions to flag in code review:** `system()`, `exec()`, `popen()`, `subprocess.call(shell=True)`, and `Runtime.exec()`.
- **Primary defense is allowlist input validation** combined with parameterized APIs — never rely solely on blocklists or escaping.
- **Privilege escalation multiplier:** if the vulnerable process runs as root or SYSTEM, one injection = full host compromise.
- **Detection signature:** look for shell metacharacters in inputs: `;`, `|`, `&&`, `` ` ``, `$()`, `>`, `<`.

## Related concepts
[[CWE-78 OS Command Injection]] [[Input Validation]] [[Principle of Least Privilege]] [[OWASP Injection]] [[Code Review]]