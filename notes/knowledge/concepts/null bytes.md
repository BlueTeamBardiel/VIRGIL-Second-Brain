# null bytes

## What it is
Think of a null byte like a period that also erases everything after it — in C-based systems, the character `\x00` (ASCII 0) signals "string ends here," so anything after it becomes invisible to the parser. Precisely: a null byte is a zero-value byte used as a string terminator in C and C-style languages, which can be exploited when one system sees the null as an endpoint while another ignores it entirely.

## Why it matters
A classic null byte injection attack targets file upload validators: an attacker submits a filename like `shell.php%00.jpg`, where `%00` is a URL-encoded null byte. The validator sees a `.jpg` extension and approves it; the underlying C-based file system truncates at the null and saves `shell.php` — a fully executable web shell. This was a widespread vulnerability in older PHP versions (pre-5.3.4) and still appears in poorly configured systems.

## Key facts
- `\x00` is byte value zero — distinct from the character "0" (which is `\x30`)
- Null byte injection exploits **context switching**: different layers interpret the same string differently (validator vs. filesystem vs. interpreter)
- PHP fixed null byte handling in file functions in **version 5.3.4** (CVE-2006-7243)
- Null bytes can bypass **intrusion detection signatures** if the IDS normalizes strings differently than the target application
- In SQL contexts, null bytes can sometimes terminate queries or bypass WAF pattern matching that doesn't strip them
- Defense: **input validation with allowlists**, explicit null byte stripping, and using language-native file handling that doesn't expose raw C string behavior

## Related concepts
[[input validation]] [[file upload vulnerabilities]] [[injection attacks]]