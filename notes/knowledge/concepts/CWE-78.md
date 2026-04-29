# CWE-78

## What it is
Like a chef who shouts your dinner order verbatim to the kitchen — if you say "soup AND give everyone food poisoning," the kitchen just does it. OS Command Injection occurs when untrusted user input is passed directly to a system shell (e.g., `exec()`, `system()`) without proper sanitization, allowing attackers to append or substitute their own operating system commands.

## Why it matters
In 2021, attackers exploited a command injection flaw in Pulse Connect Secure VPN appliances (CVE-2021-22893) to execute arbitrary commands as root, compromising government and defense networks worldwide. Had the application used parameterized inputs or avoided shell invocation entirely, the attack surface wouldn't have existed.

## Key facts
- **Metacharacters are the weapon**: Characters like `;`, `|`, `&&`, `` ` ``, `$()`, and `\n` allow attackers to chain or substitute commands in shell contexts
- **Blind vs. verbose**: Blind command injection returns no output — attackers infer success via timing delays (`sleep 10`) or out-of-band DNS callbacks
- **Root cause**: Developers use shell functions for convenience (e.g., calling `ping` or `nslookup` via system calls) instead of native library equivalents
- **CVSS scores trend severe**: OS command injection bugs frequently score 9.0+ because they typically yield full system compromise
- **Prevention hierarchy**: (1) Avoid shell calls entirely; (2) Use allowlists for inputs; (3) Apply `escapeshellarg()`/`escapeshellcmd()` as last resort — never rely on blacklists alone
- **CWE-78 vs. CWE-77**: CWE-77 is the parent ("Command Injection" generically); CWE-78 specifically involves OS-level shell interpreters

## Related concepts
[[CWE-77 Command Injection]] [[Input Validation]] [[Principle of Least Privilege]] [[SQL Injection]] [[Server-Side Template Injection]]