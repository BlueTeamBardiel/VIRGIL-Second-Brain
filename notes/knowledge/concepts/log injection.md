# log injection

## What it is
Imagine a security guard who records everything visitors say verbatim — if a visitor says "John left. [NEW ENTRY] Admin badge used at vault," the fake entry ends up in the official logbook. Log injection is exactly that: an attacker inserts newline characters (`\n`, `\r\n`) or formatted strings into user-controlled input that gets written to log files, creating fraudulent log entries or overwriting legitimate ones.

## Why it matters
During a breach investigation at a financial firm, attackers who had exploited a login form injected newline sequences into the username field, planting fake "successful authentication" entries attributed to a legitimate administrator. When forensic analysts reviewed the logs, the fabricated entries obscured the attacker's actual access pattern, delaying detection by weeks and potentially invalidating the logs as legal evidence.

## Key facts
- **Root cause**: Applications log unsanitized user input directly, allowing control characters like `%0A` (URL-encoded newline) to split or forge log entries
- **OWASP categorization**: Falls under *A03:2021 – Injection*; log injection is a precursor to or component of **log forging** attacks
- **Impact triad**: Attackers can *hide malicious activity*, *frame innocent users*, or *crash log parsers* that can't handle malformed entries
- **Detection**: SIEM tools should flag log entries containing raw newline characters or entries where timestamp sequences are non-monotonic
- **Mitigation**: Encode or strip `CR/LF` characters from all user-supplied input before logging; use structured logging formats (JSON, CEF) that don't interpret newlines as record delimiters

## Related concepts
[[input validation]] [[SIEM]] [[log tampering]] [[CRLF injection]] [[forensic integrity]]