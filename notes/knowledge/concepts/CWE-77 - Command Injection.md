# CWE-77 - Command Injection

## What it is
Imagine handing a restaurant order slip to a chef, but instead of writing "steak, medium rare," a customer writes "steak, medium rare; then unlock the back door." The chef follows all instructions blindly. Command injection works the same way: an attacker embeds OS-level commands into user-supplied input that an application passes to a system shell, causing the host to execute unintended commands with the application's privilege level.

## Why it matters
In 2021, attackers exploited command injection in Pulse Connect Secure VPN appliances (CVE-2021-22893) to execute arbitrary commands remotely without authentication, compromising government and defense networks. Had input been sanitized before being passed to shell functions, the attack surface would not have existed — defenders patching this relied entirely on vendor updates rather than compensating controls.

## Key facts
- **CWE-77 is the parent class**; CWE-78 (OS Command Injection) is the more specific child where input reaches an OS shell directly via functions like `system()`, `exec()`, or `popen()`
- Injection characters to know: semicolons (`;`), pipes (`|`), ampersands (`&`), backticks (`` ` ``), and `$()` are common shell metacharacters used to chain commands
- Severity is typically **Critical (CVSS 9.0+)** because successful exploitation often yields remote code execution (RCE)
- **Parameterized APIs and allowlisting** are the preferred mitigations — avoid constructing shell commands from user input entirely; if unavoidable, use allowlists, not denylists
- Distinct from **SQL injection**: command injection targets the OS shell layer, not a database query interpreter

## Related concepts
[[CWE-78 OS Command Injection]] [[Input Validation]] [[Remote Code Execution]] [[Principle of Least Privilege]]