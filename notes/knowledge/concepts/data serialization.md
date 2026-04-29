# data serialization

## What it is
Like flattening a 3D sculpture into a blueprint so you can mail it and rebuild it elsewhere — data serialization converts complex in-memory objects (with methods, references, and state) into a flat byte stream or string format for storage or transmission. The reverse process, deserialization, reconstructs the original object from that stream. Common formats include JSON, XML, YAML, and language-specific formats like Java's native serialization or Python's pickle.

## Why it matters
In 2017, the Apache Struts vulnerability (CVE-2017-5638) and widespread Java deserialization flaws let attackers send a crafted serialized payload to a server; when the application blindly deserialized the data, it instantiated attacker-controlled objects and executed arbitrary OS commands. This pattern — **insecure deserialization** — is so dangerous it earned a spot in the OWASP Top 10. Defenders mitigate it by validating serialized data with integrity checks (HMAC signatures), avoiding native deserialization of untrusted input, and using safe formats like JSON with strict schema validation instead of binary object serialization.

## Key facts
- **Insecure deserialization** is an OWASP Top 10 category; it enables Remote Code Execution (RCE), privilege escalation, and replay attacks
- Java's `ObjectInputStream`, Python's `pickle`, and PHP's `unserialize()` are notorious high-risk deserialization entry points
- Attackers exploit **gadget chains** — sequences of legitimate classes already on the classpath that, when chained during deserialization, produce malicious behavior
- A defense strategy is **serialization filters** (introduced in Java 9+) that whitelist acceptable classes before deserialization completes
- Tampered serialized tokens (e.g., a Base64-encoded cookie) can escalate privileges if the application trusts the data without cryptographic verification

## Related concepts
[[insecure deserialization]] [[remote code execution]] [[input validation]] [[OWASP Top 10]] [[XML external entity injection]]