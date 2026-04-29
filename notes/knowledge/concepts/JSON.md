# JSON

## What it is
Think of JSON like a universal packing list that any shipping company can read — clear labels, nested boxes, no proprietary format required. JSON (JavaScript Object Notation) is a lightweight, human-readable data interchange format that uses key-value pairs and arrays to structure data, making it language-agnostic and universally parseable.

## Why it matters
APIs that accept JSON input without proper validation are prime targets for **injection and deserialization attacks**. An attacker can craft a malicious JSON payload — for example, smuggling a `__proto__` key to poison an object's prototype in Node.js — gaining remote code execution on the server. Defenders must implement strict schema validation and reject unexpected keys before parsing.

## Key facts
- JSON supports six data types: strings, numbers, booleans, null, arrays, and objects — no functions or comments allowed natively.
- **JSON injection** occurs when untrusted data is embedded into a JSON structure without sanitization, potentially altering logic (e.g., inserting `"admin": true` into a user object).
- **Insecure deserialization** (OWASP Top 10) frequently targets JSON parsers — malformed or weaponized JSON can trigger unexpected behavior in the application layer.
- JWT (JSON Web Tokens) use JSON as their payload format; a classic attack exploits parsers accepting `"alg": "none"` to bypass signature verification entirely.
- JSON does not natively support comments, which prevents certain comment-based injection vectors but also means configuration files using JSON are less human-annotatable.

## Related concepts
[[API Security]] [[Insecure Deserialization]] [[JWT (JSON Web Token)]] [[Input Validation]] [[Injection Attacks]]