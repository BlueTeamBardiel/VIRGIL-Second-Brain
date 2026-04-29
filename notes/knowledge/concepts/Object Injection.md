# Object Injection

## What it is
Imagine a shipping label that tells the warehouse robot *what to do* when a package arrives — not just what's inside. Object Injection works the same way: an attacker smuggles executable instructions inside what looks like harmless data. Precisely, it occurs when user-supplied input is deserialized by an application without validation, allowing attackers to instantiate arbitrary objects and trigger unintended code execution.

## Why it matters
In 2017, the Apache Struts vulnerability (CVE-2017-5638) demonstrated how malicious serialized objects could achieve remote code execution — ultimately enabling the Equifax breach that exposed 147 million records. Defenders counter this by implementing allowlists of permitted classes during deserialization and avoiding native serialization of untrusted data entirely.

## Key facts
- **Root cause**: Insecure deserialization — OWASP Top 10 category A08:2021 — where applications reconstruct objects from attacker-controlled byte streams
- **Languages at risk**: Java (`.ser` files), PHP (`unserialize()`), Python (`pickle`), and Ruby all have well-documented exploitation paths
- **Magic methods**: Exploits typically abuse language-specific lifecycle hooks like PHP's `__wakeup()` or Java's `readObject()` that fire automatically on deserialization
- **Impact chain**: Successful exploitation can lead to RCE, privilege escalation, authentication bypass, or denial of service — making it critical severity
- **Detection signal**: Look for base64-encoded blobs, `rO0AB` (Java serialization magic bytes), or `O:` prefixes (PHP objects) in HTTP parameters, cookies, or API payloads

## Related concepts
[[Insecure Deserialization]] [[Remote Code Execution]] [[Input Validation]] [[OWASP Top 10]] [[SQL Injection]]