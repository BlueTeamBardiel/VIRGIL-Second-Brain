# Apache Log4net

## What it is
Think of it as a flight recorder for .NET applications — instead of capturing cockpit data, it captures application events, errors, and debug messages to files, databases, or remote servers. Log4net is a port of the Java-based Log4j logging framework adapted for Microsoft's .NET ecosystem, allowing developers to instrument their applications with configurable, hierarchical logging.

## Why it matters
During log4shell (CVE-2021-44228) incident response in 2021, security teams scrambling to patch Log4j vulnerabilities frequently needed to distinguish between the Java Log4j library and Log4net — organizations that confused the two either over-patched or missed actual exposure. Log4net itself does **not** perform JNDI lookups, meaning it was **not** vulnerable to log4shell, but security teams still needed to inventory all logging libraries across hybrid Java/.NET environments to confirm their attack surface accurately.

## Key facts
- Log4net is a .NET library (C#), **not** a Java library — it is a sibling of Log4j, not the same codebase
- It was **not affected** by CVE-2021-44228 (Log4Shell) because it does not implement JNDI message lookup functionality
- Configuration is typically stored in XML files (`log4net.config`), which if misconfigured can log sensitive data like credentials or PII — a common compliance/SIEM hygiene finding
- Logs can be sent to multiple "appenders" simultaneously: files, databases, Windows Event Log, SMTP, and remote syslog — widening or narrowing your detection surface
- Improperly protected log files can become a goldmine for attackers performing **log scraping** during lateral movement to harvest tokens or credentials embedded in debug output

## Related concepts
[[Log4j]] [[SIEM Log Management]] [[Sensitive Data Exposure]] [[Attack Surface Management]]