# Markdown

## What it is
Think of Markdown like a Post-it note shorthand — instead of using a full word processor's toolbar, you write `**bold**` and the renderer dresses it up for you. Precisely, Markdown is a lightweight plaintext markup language that converts human-readable syntax into formatted HTML, used widely in documentation, wikis, README files, and web content platforms.

## Why it matters
Markdown parsers that render content into HTML introduce a critical attack surface: if user-supplied Markdown is not properly sanitized before rendering, attackers can inject raw HTML or JavaScript, leading to **Stored XSS (Cross-Site Scripting)** attacks. For example, many early GitHub Issues and forum platforms allowed `[click me](javascript:alert(1))` as a valid Markdown link, executing arbitrary scripts in victims' browsers. Defenders must ensure Markdown renderers strip or escape dangerous HTML tags and URI schemes before output.

## Key facts
- Markdown itself is **not inherently secure or insecure** — risk lives entirely in the renderer's sanitization logic
- The `javascript:` URI scheme inside Markdown hyperlinks is a classic XSS vector: `[text](javascript:malicious())`
- Raw HTML passthrough is allowed by the original Markdown spec, meaning `<script>` tags embedded in `.md` files can execute if rendered without sanitization
- **CommonMark** is the standardized Markdown specification; different parsers (GitHub Flavored Markdown, Showdown, Marked.js) have historically had differing sanitization behaviors, creating inconsistent attack surfaces
- Markdown injection in **CI/CD pipeline READMEs and wiki pages** can be used for **phishing and credential harvesting** by disguising malicious links as legitimate documentation

## Related concepts
[[Cross-Site Scripting (XSS)]] [[Input Validation]] [[Content Security Policy (CSP)]]