# deserialization

## What it is
Like unpacking a shipped IKEA box and trusting that every part inside is exactly what the label says — deserialization is the process of reconstructing a data object from a stored or transmitted byte stream without questioning its contents. Precisely: serialization converts an object into a portable format (JSON, XML, binary); deserialization reconstructs it back into a live object. The danger is that malicious actors can tamper with the byte stream *before* it's unpacked, injecting unexpected instructions the application then executes.

## Why it matters
In 2017, Apache Struts (the framework behind Equifax's web portal) suffered a critical deserialization vulnerability that allowed attackers to send a crafted HTTP header containing a serialized object — when the server deserialized it, arbitrary OS commands executed with application-level privileges, exposing 147 million records. Defenders must treat any deserialized input as untrusted and validate object types before reconstruction.

## Key facts
- Insecure deserialization is listed in the **OWASP Top 10** (A08:2021) and frequently appears in remote code execution (RCE) exploit chains
- Attack payloads are often delivered in **cookies, API parameters, or HTTP headers** — anywhere the app accepts serialized data from clients
- Common vulnerable languages/frameworks: **Java (Apache Commons Collections), PHP, Python (pickle), .NET**
- Mitigations include: **integrity checks (HMAC signing)** on serialized data, allowlisting acceptable object types, and running deserializers in sandboxed environments
- The `java.io.ObjectInputStream` class is a classic attack surface — any class implementing `readObject()` can be a gadget in an exploit chain

## Related concepts
[[remote code execution]] [[input validation]] [[object injection]]