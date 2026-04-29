# Java RMI

## What it is
Imagine you could press a button on your TV remote and it actually ran code inside your neighbor's DVD player — that's Java RMI. Remote Method Invocation (RMI) is a Java API that allows an object running in one JVM to invoke methods on an object running in a different JVM, typically across a network, using serialized Java objects as the transport payload.

## Why it matters
Java RMI became a critical attack vector because it deserializes untrusted data by default — attackers can send a crafted serialized payload to an exposed RMI registry (default port **1099**) that executes arbitrary code upon deserialization. The 2015–2017 wave of Apache Commons Collections exploits lit up enterprise systems globally because countless RMI endpoints blindly deserialized attacker-controlled objects, enabling unauthenticated Remote Code Execution.

## Key facts
- RMI registry listens on **TCP port 1099** by default — a red flag during port scanning and enumeration
- The core vulnerability is **insecure deserialization** (OWASP Top 10 A08:2021): attackers craft malicious serialized Java objects using tools like **ysoserial**
- Java serialized streams are identifiable by the magic bytes **`AC ED 00 05`** (hex) — useful for packet analysis or IDS signatures
- RMI can be exploited for **JNDI injection** attacks, which is exactly the mechanism that made **Log4Shell (CVE-2021-44228)** devastating
- Mitigations include: disabling RMI if unused, implementing **deserialization filters** (JEP 290), and blocking outbound JNDI/RMI calls at the firewall

## Related concepts
[[Insecure Deserialization]] [[JNDI Injection]] [[Log4Shell]] [[Java Serialization]] [[Remote Code Execution]]