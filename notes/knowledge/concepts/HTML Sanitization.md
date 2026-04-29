# HTML sanitization

## What it is
Think of HTML sanitization like a TSA checkpoint for user input — it lets harmless text through but strips out anything that could be weaponized, like `<script>` tags or `onerror` event handlers. Precisely, it is the process of parsing and cleaning untrusted HTML input to remove or neutralize dangerous elements and attributes before rendering it in a browser. Unlike escaping (which encodes everything), sanitization allows *some* HTML through while surgically removing the dangerous parts.

## Why it matters
In 2018, a stored XSS vulnerability in British Airways' booking platform allowed attackers to inject malicious scripts that harvested 500,000 customers' payment card details — a breach partly rooted in insufficient input sanitization on server-rendered HTML. Proper sanitization with an allowlist-based library (e.g., DOMPurify) would have stripped the injected payload before it ever reached the DOM.

## Key facts
- **Allowlist > Blocklist**: Sanitizers should permit only known-safe tags (e.g., `<b>`, `<p>`, `<a>`) rather than trying to block known-bad ones — attackers constantly find new bypass vectors like `<svg onload=...>`.
- **Context matters**: Sanitization logic differs between HTML body, attribute values, JavaScript contexts, and CSS — a sanitizer safe for one context may be bypassed in another.
- **DOMPurify** is the de facto standard JavaScript sanitization library; it is actively maintained and allowlist-based.
- **Sanitization ≠ Validation**: Validation rejects bad input entirely; sanitization cleans it and lets modified content through — both are needed in layered defense.
- **Browser-native `setHTML()`** (Sanitizer API) is an emerging W3C standard bringing built-in sanitization to browsers, reducing reliance on third-party libraries.

## Related concepts
[[Cross-Site Scripting (XSS)]] [[Input Validation]] [[Content Security Policy]] [[Output Encoding]]