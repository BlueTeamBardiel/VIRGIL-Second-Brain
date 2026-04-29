# CWE-77

## What it is
Like slipping a forged work order into a maintenance crew's clipboard — they execute whatever's written without questioning its origin. CWE-77 (Improper Neutralization of Special Elements used in a Command, aka Command Injection) occurs when an application passes user-supplied data to a system shell or interpreter without properly sanitizing metacharacters that alter command structure. Unlike OS Command Injection (CWE-78), CWE-77 is broader — it covers any command language, not just OS shells.

## Why it matters
In 2021, attackers exploited command injection in Pulse Connect Secure VPN appliances (CVE-2021-22893), executing arbitrary commands on the host by injecting shell metacharacters into a parameter that was passed to a backend function. A single unvalidated field bypassed authentication entirely and gave attackers persistent access to corporate networks — illustrating why input reaching any interpreter must be treated as hostile.

## Key facts
- CWE-77 is the **parent** of CWE-78 (OS Command Injection) and CWE-89 (SQL Injection) — it abstracts injection across *any* command language
- Attack payload typically uses metacharacters like `;`, `&&`, `||`, `|`, `` ` ``, `$()` to chain or substitute commands
- Mitigation priority: **avoid shell invocation entirely**; use parameterized APIs or library functions that don't invoke a shell interpreter
- Input allowlisting (permitting only known-good characters) is preferred over denylisting metacharacters — attackers routinely find encoding bypasses
- CVSS scores for command injection vulnerabilities frequently reach **9.0+** due to direct code execution potential with the application's privilege level

## Related concepts
[[CWE-78 OS Command Injection]] [[CWE-89 SQL Injection]] [[Input Validation]] [[Principle of Least Privilege]] [[Defense in Depth]]