# Markdown escaping

## What it is
Like putting a "do not interpret" sticker on a piece of text, Markdown escaping uses a backslash (`\`) or backtick enclosure to tell a parser to treat special characters as literal text rather than formatting instructions. Precisely, it is the technique of neutralizing characters (like `*`, `#`, `_`, `` ` ``, `[`, `]`) that a Markdown renderer would otherwise process as structural syntax.

## Why it matters
In security documentation platforms (like GitHub wikis, Confluence, or Jira), an attacker who controls user-supplied Markdown input could inject malicious links using `[click here](javascript:alert(1))` syntax if the renderer supports raw HTML or dangerous URI schemes. Proper escaping or a strict allowlist of Markdown elements prevents this link injection from becoming a stored XSS vector. Security advisories written in Markdown that fail to escape CVE-related code snippets can also accidentally render as broken formatting, obscuring critical details.

## Key facts
- The backslash (`\`) is the primary escape character in standard Markdown; placing it before a special character renders that character literally (e.g., `\*` outputs `*`).
- Backtick fencing (`` `code` `` or ` ```blocks``` `) suppresses nearly all Markdown interpretation inside, making it the safest way to display untrusted text snippets.
- Markdown itself has **no standardized security model** — safety depends entirely on the renderer; CommonMark, GitHub Flavored Markdown (GFM), and others differ in what HTML they permit.
- Many Markdown renderers sanitize `<script>` tags but still allow `javascript:` URIs inside link syntax, making link injection a persistent risk even with partial sanitization.
- Output encoding for Markdown-generated HTML must still follow HTML escaping rules downstream — Markdown escaping and HTML escaping are **separate, layered defenses**.

## Related concepts
[[Cross-Site Scripting (XSS)]] [[Input Validation]] [[Content Security Policy]]