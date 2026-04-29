# Encoding

## What it is
Think of encoding like Morse code — it's a universally agreed-upon system for translating information into a different format so two parties can communicate, with no secrecy intended. Precisely: encoding is the process of converting data from one representation to another using a publicly known scheme (Base64, URL encoding, Unicode) for compatibility or transmission purposes. It is **not** encryption — there is no key, and anyone who knows the scheme can reverse it instantly.

## Why it matters
Attackers abuse encoding constantly to bypass input validation and WAF rules. A classic example: injecting `<script>` as `%3Cscript%3E` (URL encoding) or `PHNjcmlwdD4=` (Base64) to sneak past filters that block the literal string, then relying on the browser or server to decode it before execution. Defenders must ensure their security controls decode input **before** inspecting it, not after.

## Key facts
- **Base64** encodes binary data into ASCII text using 64 printable characters; output always ends with `=` or `==` padding — a red flag in logs worth investigating
- **URL encoding** replaces unsafe characters with `%HH` hex values (e.g., space = `%20`); double-encoding (`%2520` for `%`) is a common WAF evasion trick
- Encoding ≠ Encryption ≠ Hashing — encoding is fully reversible without a key, which makes it **zero confidentiality**
- **Obfuscation via encoding** appears in malware payloads, phishing URLs, and XSS attacks — recognizing Base64 blobs in network traffic is a core analyst skill
- Security+ and CySA+ expect you to distinguish encoding from encryption; a Base64-encoded password in source code is a critical vulnerability, not a security control

## Related concepts
[[Encryption]] [[Cross-Site Scripting (XSS)]] [[Input Validation]] [[Obfuscation]] [[URL Manipulation]]