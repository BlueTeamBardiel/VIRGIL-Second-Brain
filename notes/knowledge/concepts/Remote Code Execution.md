# remote code execution

## What it is
Imagine slipping a forged work order into a factory's inbox — the machines execute the instructions without ever questioning who wrote them. Remote Code Execution (RCE) is a class of vulnerability that allows an attacker to run arbitrary commands or code on a target system from a different machine, without physical access or prior authentication.

## Why it matters
In 2021, the Log4Shell vulnerability (CVE-2021-44228) in the Apache Log4j library enabled unauthenticated RCE by embedding a malicious JNDI lookup string in a log message — attackers could compromise hundreds of millions of internet-facing systems simply by triggering a log entry. Defenders responded by emergency-patching Log4j and implementing WAF rules to block `${jndi:` patterns in inbound traffic.

## Key facts
- RCE is typically the *end goal* of an exploit chain — it often follows initial vulnerabilities like buffer overflows, deserialization flaws, or injection attacks
- CVSS scores for RCE vulnerabilities frequently reach 9.0–10.0 (Critical) due to the combination of high impact across confidentiality, integrity, and availability
- Common root causes include unsafe deserialization, OS command injection, memory corruption bugs, and server-side template injection (SSTI)
- Mitigations include input validation, sandboxing/containerization, least-privilege execution, address space layout randomization (ASLR), and Data Execution Prevention (DEP)
- RCE can be **authenticated** (requires valid credentials first) or **unauthenticated** (no credentials needed) — unauthenticated RCE is considered the most severe category

## Related concepts
[[buffer overflow]] [[injection attacks]] [[deserialization vulnerabilities]] [[privilege escalation]] [[CVE scoring]]