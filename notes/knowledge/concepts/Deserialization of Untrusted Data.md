# Deserialization of Untrusted Data

## What it is
Imagine receiving a flat-packed IKEA box and trusting that every piece inside is exactly what the label says — then discovering someone swapped the wooden dowels for razor blades. Deserialization is the process of reconstructing a stored or transmitted data object (like JSON, XML, or binary) back into a live program object. When an application deserializes data from an untrusted source without validation, an attacker can craft malicious payloads that execute arbitrary code during the reconstruction process.

## Why it matters
In 2017, Apache Struts suffered a critical deserialization vulnerability (CVE-2017-5638) that enabled the Equifax breach — exposing 147 million people's personal data. The attacker sent a crafted Content-Type HTTP header that triggered unsafe deserialization, achieving remote code execution without authentication. This single flaw demonstrates how deserialization sits at the application layer but can cascade into full infrastructure compromise.

## Key facts
- Listed as **OWASP Top 10 A08:2021** — a persistent, high-severity vulnerability class
- Attacks can result in **Remote Code Execution (RCE)**, privilege escalation, DoS, or authentication bypass
- Languages commonly affected: **Java** (most notorious), Python (pickle), PHP, Ruby, .NET
- Java's `ObjectInputStream` and PHP's `unserialize()` are classic dangerous deserialization entry points
- Defense layers include: input validation, using safe data formats (JSON over native binary), integrity checks (digital signatures/HMACs on serialized data), and running deserializers in sandboxed environments

## Related concepts
[[Remote Code Execution]] [[Input Validation]] [[OWASP Top 10]] [[Supply Chain Attacks]] [[XML External Entity Injection]]