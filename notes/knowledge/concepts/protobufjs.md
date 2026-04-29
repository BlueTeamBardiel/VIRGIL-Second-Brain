# protobufjs

## What it is
Think of it like a hyper-efficient postal system that compresses letters into binary shorthand instead of plain English — the receiving post office reassembles them perfectly. protobufjs is a JavaScript/Node.js library that serializes and deserializes data using Google's Protocol Buffers (protobuf) binary format, enabling compact, fast structured data exchange between services.

## Why it matters
In 2022, protobufjs suffered **CVE-2022-25878** and **CVE-2022-1365** — prototype pollution vulnerabilities where a maliciously crafted protobuf message could inject properties into JavaScript's base `Object.prototype`. An attacker sending a specially formed message to a Node.js backend could corrupt application logic, bypass authorization checks, or achieve remote code execution — all through what looked like routine API traffic, making it invisible to signature-based detection.

## Key facts
- **Prototype pollution** is the primary attack class: malicious keys like `__proto__` or `constructor` in deserialized messages can corrupt shared JavaScript objects globally
- Affects **server-side Node.js applications** that deserialize untrusted protobuf input — common in microservices and gRPC-based APIs
- Protobuf messages are **binary, not human-readable**, meaning WAF/IDS rules built for JSON/XML injection often miss these attacks entirely
- Fix requires updating to **protobufjs ≥ 6.11.3 / 7.x** and sanitizing field names during deserialization
- Prototype pollution via deserialization is categorized under **CWE-1321** (Improperly Controlled Modification of Object Prototype Attributes)

## Related concepts
[[Prototype Pollution]] [[Deserialization Vulnerabilities]] [[Supply Chain Security]] [[gRPC Security]] [[CVE Management]]