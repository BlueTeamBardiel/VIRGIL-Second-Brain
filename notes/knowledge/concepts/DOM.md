# DOM

## What it is
Think of the DOM like a live blueprint of a house — contractors (scripts) can walk in at any time and move walls, add rooms, or knock things down, all while people are living in it. The Document Object Model (DOM) is a programming interface that represents an HTML or XML document as a structured tree of objects, allowing scripts to dynamically read and manipulate page content, structure, and styling in real time.

## Why it matters
DOM-based XSS attacks occur when attacker-controlled data flows directly into a dangerous sink — like `document.write()` or `innerHTML` — without touching the server at all. For example, a malicious link might contain a payload in the URL fragment (`#<script>...</script>`) that a vulnerable script reads via `location.hash` and injects directly into the page, bypassing server-side input filtering entirely. Defenders must sanitize data at the client-side source, not just the server boundary.

## Key facts
- DOM-based XSS is client-side only — the malicious payload never appears in the server's HTTP response, making server-side WAFs largely blind to it
- **Sources** (where attacker data enters): `location.href`, `document.referrer`, `location.hash`, URL parameters
- **Sinks** (where execution happens): `innerHTML`, `eval()`, `document.write()`, `setTimeout()` with string arguments
- `innerHTML` is the most commonly exploited sink in real-world DOM XSS vulnerabilities
- Mitigation: use `textContent` instead of `innerHTML`, apply Content Security Policy (CSP), and use trusted sanitization libraries like DOMPurify

## Related concepts
[[Cross-Site Scripting (XSS)]] [[Content Security Policy]] [[Same-Origin Policy]] [[JavaScript Injection]]