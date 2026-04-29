# Deserialization vulnerabilities

## What it is
Imagine a restaurant that accepts pre-written order tickets from customers — if a malicious customer crafts a fake ticket that says "fire the chef and give me free food," the kitchen executes it blindly. Deserialization vulnerabilities occur when an application converts untrusted, serialized data (a byte stream representing an object) back into a live object without validating its integrity or content. An attacker who controls the serialized input can manipulate object properties or trigger unintended code execution during the reconstruction process.

## Why it matters
In 2017, Apache Struts' deserialization flaw (related to the Equifax breach attack chain) allowed unauthenticated remote code execution by sending a crafted serialized payload in an HTTP header. Defenders now implement integrity checks (e.g., HMAC signatures on serialized tokens) and use allowlists to restrict which classes can be deserialized, preventing arbitrary object instantiation.

## Key facts
- Classified under **OWASP Top 10 A08:2021 – Software and Data Integrity Failures**
- Exploitation often leads to **Remote Code Execution (RCE)**, privilege escalation, or denial of service
- Java's `ObjectInputStream`, PHP's `unserialize()`, and Python's `pickle` module are classic high-risk deserialization sinks
- **Magic methods** (e.g., `__wakeup()` in PHP, `readObject()` in Java) are frequently abused as gadget chain entry points
- Mitigation includes: input validation, avoid deserializing untrusted data, use safe formats (JSON/XML with schema validation), and deploy **deserialization firewalls** like NotSoSerial for Java

## Related concepts
[[Remote Code Execution]] [[Injection Attacks]] [[Input Validation]] [[OWASP Top 10]] [[Supply Chain Attacks]]