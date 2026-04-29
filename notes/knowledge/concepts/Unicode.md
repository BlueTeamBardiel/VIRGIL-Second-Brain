# Unicode

## What it is
Think of Unicode as the United Nations translation bureau for computers — every character in every human language gets a unique diplomatic passport number (called a code point), so they can travel safely between systems. Precisely, Unicode is a universal character encoding standard that assigns a unique numeric value to over 140,000 characters across 150+ scripts, with UTF-8 being its most common encoding implementation on the web.

## Why it matters
Attackers exploit Unicode normalization to bypass input validation in a technique called **Unicode smuggling** or **homograph attacks** — for example, registering `xn--pple-43d.com` (which renders as `аpple.com` using a Cyrillic "а") to phish victims who visually can't distinguish it from Apple's real domain. Web application firewalls blocking the word "script" can be bypassed by submitting a lookalike Unicode character that normalizes to the same string after server-side processing, executing XSS payloads that sailed past defenses.

## Key facts
- **UTF-8** encodes code points using 1–4 bytes; ASCII characters (U+0000–U+007F) use only 1 byte, making UTF-8 backward compatible with ASCII
- **Overlong encoding** attacks exploit legacy decoders that accept non-canonical multi-byte representations of ASCII characters (e.g., encoding `/` as `0xC0 0xAF`) to bypass path traversal filters
- **Normalization forms** (NFC, NFD, NFKC, NFKD) can transform characters *after* validation — security logic must validate *after* normalization, not before
- **Bidirectional (BiDi) control characters** (like U+202E) can visually reverse text direction, used in **Trojan Source** attacks to hide malicious code in source files that looks benign to reviewers
- IDN homograph attacks are mitigated by browsers flagging mixed-script domains and registrars restricting lookalike TLD registrations

## Related concepts
[[Input Validation]] [[Cross-Site Scripting (XSS)]] [[IDN Homograph Attack]] [[Path Traversal]] [[Encoding and Obfuscation]]