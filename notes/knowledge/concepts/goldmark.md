# goldmark

## What it is
Like a Markdown-to-HTML translator that could accidentally smuggle contraband through customs if not configured carefully, Goldmark is a Go-based Markdown parser that converts Markdown text into HTML — and its default configuration historically allowed raw HTML passthrough, meaning attacker-controlled input could survive into rendered output unchanged.

## Why it matters
In static site generators and documentation platforms built on Go (such as Hugo), Goldmark processes user-supplied or third-party Markdown content. If an attacker contributes a malicious Markdown file containing raw `<script>` tags or JavaScript event handlers, and the application renders that output without sanitization, a stored XSS attack can execute in victims' browsers — compromising session tokens, credentials, or performing actions on behalf of authenticated users.

## Key facts
- Goldmark's default mode prior to version hardening allowed **unsafe HTML** rendering; mitigation requires explicitly enabling the `WithUnsafe(false)` option or using the `html.WithXHTMLSelf()` renderer with sanitization.
- It is the default Markdown renderer for **Hugo** (static site generator), making it relevant to a wide attack surface in developer-facing tooling.
- XSS via Markdown parsers is a **CWE-79** (Improper Neutralization of Input During Web Page Generation) instance — a common exam target for CySA+.
- Defense requires **output encoding** and **Content Security Policy (CSP)** headers in addition to parser-level hardening, since defense-in-depth is necessary.
- Goldmark supports **CommonMark** specification compliance, meaning attackers can use standard, spec-compliant syntax to inject payloads rather than relying on parser bugs.

## Related concepts
[[Cross-Site Scripting (XSS)]] [[Input Validation]] [[Content Security Policy]] [[Static Site Generators]] [[CWE-79]]