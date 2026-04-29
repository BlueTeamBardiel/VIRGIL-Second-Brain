# HTML-encode

## What it is
Think of HTML-encoding like putting a wild animal in a display case — the dangerous creature (malicious code) is still visible, but it can't bite anyone. Precisely: HTML-encoding converts special characters like `<`, `>`, `&`, and `"` into their safe HTML entity equivalents (`&lt;`, `&gt;`, `&amp;`, `&quot;`) so browsers render them as literal text rather than executable markup.

## Why it matters
Without HTML-encoding, an attacker can inject `<script>alert('XSS')</script>` into a comment field, and any visitor's browser will execute that JavaScript — a classic Reflected or Stored XSS attack. Properly HTML-encoding all user-supplied output before rendering it in a page is one of the primary defenses against Cross-Site Scripting, and its absence is consistently listed in the OWASP Top 10 under injection vulnerabilities.

## Key facts
- HTML-encoding is an **output encoding** control — it must be applied at the point of rendering, not just at input validation
- The five critical characters to encode: `<` → `&lt;`, `>` → `&gt;`, `&` → `&amp;`, `"` → `&quot;`, `'` → `&#x27;`
- **Context matters**: HTML-encoding is insufficient inside JavaScript blocks or CSS attributes — those contexts require JavaScript-encoding or CSS-encoding respectively
- Encoding ≠ stripping — the original data is preserved and displayed safely, unlike sanitization which removes characters
- Failure to HTML-encode is categorized under **CWE-79** (Improper Neutralization of Input During Web Page Generation) in the Common Weakness Enumeration

## Related concepts
[[Cross-Site Scripting (XSS)]] [[Input Validation]] [[Output Encoding]] [[Content Security Policy]] [[OWASP Top 10]]