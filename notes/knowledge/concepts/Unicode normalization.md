# Unicode normalization

## What it is
Like two different spellings of the same name ("Jon" vs "John") that refer to the same person, Unicode can represent identical-looking characters through multiple distinct byte sequences. Normalization is the process of converting these equivalent representations into a single canonical form — for example, collapsing the composed form "é" (one code point) and the decomposed form "e" + combining accent (two code points) into one standard representation.

## Why it matters
In 2000, a critical IIS 5.0 vulnerability (CVE-2000-0884) allowed attackers to bypass access controls by encoding path traversal sequences like `../` using Unicode representations such as `%c0%af` — the server validated the encoded form but then normalized it before passing it to the filesystem, executing the traversal. This "double decode" or normalization bypass pattern recurs in modern web application firewalls and input validation logic where security checks run *before* normalization.

## Key facts
- **Unicode has four normalization forms**: NFC, NFD, NFKC, NFKD — the "K" forms apply compatibility decomposition, which can collapse visually distinct characters (like "ﬁ" ligature → "fi")
- **Security checks must run AFTER normalization**, never before — validating a raw string then normalizing it creates a TOCTOU-style logic flaw
- **Homograph attacks** exploit normalization failures: Cyrillic "а" (U+0430) looks identical to Latin "a" (U+0061) but is a different code point — used in IDN domain spoofing
- **NFKC normalization** can silently change meaning: fullwidth characters (ｅｘａｍｐｌｅ) normalize to standard ASCII equivalents, potentially bypassing blocklists
- **Python's `unicodedata.normalize()`** and Java's `Normalizer.normalize()` are the standard library tools — knowing they exist is testable

## Related concepts
[[Path Traversal]] [[Input Validation]] [[IDN Homograph Attack]]