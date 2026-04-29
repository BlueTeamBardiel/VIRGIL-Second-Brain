# UTF-8

## What it is
Like a universal power adapter that can handle any plug in the world using variable-length encoding, UTF-8 is a character encoding scheme that represents every Unicode character using 1 to 4 bytes, while remaining backward-compatible with ASCII for the first 128 characters. It is the dominant encoding standard on the web, allowing a single document to contain English, Arabic, Chinese, and emoji simultaneously.

## Why it matters
Attackers exploit UTF-8's multi-byte flexibility through **overlong encoding attacks** — representing a simple character like `/` using a longer-than-necessary byte sequence (e.g., `%c0%af`) that some parsers normalize *after* security checks pass. This technique famously bypassed path traversal protections in early IIS and Apache servers, allowing directory traversal attacks where `../` was encoded to slip through input validation filters that only checked standard ASCII representations.

## Key facts
- UTF-8 uses 1 byte for U+0000–U+007F (standard ASCII), 2 bytes for U+0080–U+07FF, 3 bytes for U+0800–U+FFFF, and 4 bytes for higher code points
- **Overlong encoding** (encoding a character in more bytes than required) is explicitly invalid per RFC 3629 but was exploited before parsers enforced this — CVE-2000-0884 (IIS Unicode traversal) is the canonical example
- Input validation must occur *after* canonical decoding — validating raw bytes before normalization is a common WAF bypass technique
- **Null byte injection** (`%00` or `\u0000`) in UTF-8 strings can truncate filenames in C-based systems while passing higher-level string checks
- BOM (Byte Order Mark, `0xEF 0xBB 0xBF`) prepended to UTF-8 files can confuse parsers and has been used to bypass script filters

## Related concepts
[[Input Validation]] [[Path Traversal]] [[Encoding and Decoding Attacks]] [[Canonicalization]]