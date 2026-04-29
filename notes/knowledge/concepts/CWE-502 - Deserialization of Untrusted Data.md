# CWE-502 - Deserialization of Untrusted Data

## What it is
Imagine receiving a sealed shipping container from an unknown sender and immediately running whatever machinery is packed inside — that's deserialization of untrusted data. It occurs when an application converts serialized byte streams back into objects without validating their integrity or origin, allowing attackers to craft malicious payloads that execute arbitrary code during the reconstruction process.

## Why it matters
The 2017 Apache Struts vulnerability (CVE-2017-5638) and the broader Java deserialization epidemic — exposed by the Apache Commons Collections gadget chain — allowed attackers to achieve Remote Code Execution (RCE) on servers simply by sending a crafted serialized Java object over HTTP. This pattern compromised systems at FedEx, Equifax, and numerous enterprise environments. Defenders now enforce allowlists of deserializable classes and use serialization filters introduced in Java 9+.

## Key facts
- **OWASP Top 10 2021 A08** specifically calls out Software and Data Integrity Failures, which includes unsafe deserialization.
- Exploitation often uses **"gadget chains"** — sequences of existing classes in the classpath that, when chained together during deserialization, produce malicious outcomes like RCE or privilege escalation.
- Affected languages include Java, Python (pickle), PHP (unserialize()), Ruby, and .NET — it is **not** Java-exclusive.
- Mitigations include: cryptographically signing serialized data, using language-agnostic formats (JSON/XML with strict schemas) instead of native serialization, and implementing class allowlisting.
- Detection strategy for CySA+: monitor for **unexpected process spawning** from application servers (e.g., java.exe spawning cmd.exe) as a behavioral indicator of deserialization exploitation.

## Related concepts
[[Remote Code Execution (RCE)]] [[Injection Attacks]] [[Object-Oriented Programming Security]] [[OWASP Top 10]] [[Supply Chain Attacks]]