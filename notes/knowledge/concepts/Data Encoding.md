# Data Encoding

## What it is
Like a postal service that repackages letters into standard-sized boxes so every carrier can transport them — encoding transforms data into a different format so systems can reliably transmit or store it. Unlike encryption, encoding uses no secret key and provides zero confidentiality; any decoder can reverse it. It's purely a format conversion mechanism (Base64, URL encoding, hex) designed for compatibility, not protection.

## Why it matters
Attackers routinely use Base64 and URL encoding to smuggle malicious payloads past basic signature-based IDS/IPS rules — a technique called **obfuscation**. For example, a web attacker might URL-encode `<script>alert(1)</script>` as `%3Cscript%3Ealert%281%29%3C%2Fscript%3E` to bypass a naive WAF that only scans for literal angle brackets. Defenders must ensure security tools **decode data before inspecting it**, not after.

## Key facts
- **Base64** expands data by ~33% and is identifiable by its alphanumeric characters plus `+`, `/`, and `=` padding — it is NOT encryption
- **URL encoding** (percent-encoding) converts characters to `%XX` hex format; double-encoding (`%2520` = `%20` = space) is a common WAF bypass technique
- **Hex encoding** represents each byte as two hexadecimal digits (e.g., `41` = "A"); frequently seen in shellcode delivery
- Encoding ≠ Encryption ≠ Hashing — a critical Security+ distinction; encoding is reversible without a key, hashing is one-way, encryption requires a key
- **HTML entity encoding** (`&lt;` for `<`) is used defensively as an output sanitization technique to prevent XSS attacks

## Related concepts
[[Obfuscation Techniques]] [[Cross-Site Scripting (XSS)]] [[Hashing]] [[Encryption]] [[Input Validation]]