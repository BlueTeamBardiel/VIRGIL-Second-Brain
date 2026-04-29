# Insecure Deserialization

## What it is
Imagine a restaurant receiving a sealed meal kit with assembly instructions — if the kitchen trusts those instructions blindly without checking whether they've been tampered with, a malicious actor could swap "add salt" for "burn the building down." Insecure deserialization occurs when an application converts untrusted serialized data (bytes → objects) without validating its integrity or content, allowing attackers to manipulate object state, inject code, or escalate privileges.

## Why it matters
In 2017, the Apache Struts vulnerability (CVE-2017-9805) exploited insecure XML deserialization to achieve Remote Code Execution — the exact vector used in the Equifax breach exposing 147 million records. Attackers crafted a malicious serialized payload in an HTTP request that the server blindly deserialized and executed with application-level privileges.

## Key facts
- Ranked **OWASP Top 10 A08:2021** (previously A8:2017), reflecting consistent real-world exploitation frequency
- Attack impact ranges from **denial of service → privilege escalation → RCE**, depending on available classes in the application's classpath
- **Magic bytes** identify serialized formats: Java serialized objects begin with `AC ED 00 05` (hex); useful for detection in traffic analysis
- Defense requires **integrity checks** (HMAC signing serialized data), **allowlist-based deserialization**, and avoiding native serialization for untrusted data entirely
- Languages commonly affected: **Java, PHP, Python (pickle), Ruby** — each has documented gadget chain libraries (e.g., `ysoserial` for Java)

## Related concepts
[[Remote Code Execution]] [[Input Validation]] [[OWASP Top 10]] [[Object Injection]] [[Supply Chain Attacks]]