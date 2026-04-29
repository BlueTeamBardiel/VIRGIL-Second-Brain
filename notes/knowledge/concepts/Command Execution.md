# Command Execution

## What it is
Like slipping a fake order into a restaurant's kitchen ticket system — the cooks execute it without question because it looks like a real ticket. Command execution (also called Remote Code Execution or RCE when done remotely) is the ability of an attacker to run arbitrary operating system or application commands on a target system, typically by exploiting improper input validation or insecure coding practices.

## Why it matters
In 2021, the Log4Shell vulnerability (CVE-2021-44228) allowed attackers to trigger remote command execution simply by logging a crafted string — affecting millions of Java applications worldwide. Defenders responded by patching Log4j, implementing WAF rules, and auditing all internet-facing services, illustrating how a single RCE vulnerability can escalate into full system compromise within minutes.

## Key facts
- **OS Command Injection** is the most direct form: unsanitized user input is passed to system shell functions like `exec()`, `system()`, or `popen()`, allowing attackers to chain commands using metacharacters like `;`, `&&`, or `|`
- RCE is rated **Critical (CVSS 9.0–10.0)** because it typically allows full confidentiality, integrity, and availability compromise
- Common attack vectors include deserialization flaws, template injection, file upload abuse, and unpatched application frameworks
- Mitigations include **input validation/sanitization**, using parameterized APIs instead of shell calls, least-privilege execution environments, and application sandboxing
- On the **Security+ exam**, command injection appears under the "Application Attacks" domain; CySA+ emphasizes detection via anomalous process spawning (e.g., a web server spawning `cmd.exe`)

## Related concepts
[[Command Injection]] [[Remote Code Execution]] [[Privilege Escalation]] [[Input Validation]] [[Web Application Firewall]]