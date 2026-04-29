# URL normalization

## What it is
Like a GPS that converts "turn left at the old bakery" and "head west on Elm St" into the same set of coordinates — URL normalization is the process of converting equivalent URL representations into a single canonical form. Browsers, servers, and security tools translate percent-encoding, case differences, extra slashes, and dot-segments so that `http://example.com/%2e%2e/admin` and `http://example.com/../admin` resolve identically.

## Why it matters
Inconsistent normalization between a security layer and a backend server is the engine behind path traversal and WAF bypass attacks. An attacker submits `/%2e%2e/%2e%2e/etc/passwd` — the WAF sees encoded dots and allows it, while the origin server decodes and normalizes the path, serving a sensitive file. This double-decode discrepancy was central to vulnerabilities in IIS 4.0/5.0 (CVE-2000-0884) and modern reverse proxy misconfigurations.

## Key facts
- **Percent-encoding normalization**: `%41` decodes to `A`; security tools must decode *before* pattern matching, or attackers bypass filters with encoded characters
- **Double encoding**: `%252F` decodes first to `%2F`, then to `/` — a common WAF evasion technique exploiting single-pass decoders
- **Path segment normalization**: `/a/b/../c` normalizes to `/a/c`; failure to normalize before access-control checks enables directory traversal
- **Case normalization**: Scheme and host are case-insensitive (`HTTP://EXAMPLE.COM` = `http://example.com`), but paths may be case-sensitive depending on the OS — Windows vs. Linux behavior creates security mismatches
- **Unicode normalization**: Characters like `٪` (Arabic percent sign) or fullwidth characters can bypass naive string matching if not normalized to ASCII equivalents first

## Related concepts
[[Path Traversal]] [[WAF Bypass]] [[Percent Encoding]] [[Directory Traversal]] [[Input Validation]]