# HTML

## What it is
HTML is like the skeleton of a house — it defines the structure and layout, but on its own has no paint, wiring, or furniture. Precisely, HyperText Markup Language is the standard markup language browsers use to render web page structure through a system of nested tags and attributes. It is interpreted client-side, meaning the browser executes whatever HTML it receives.

## Why it matters
Attackers exploit HTML's client-side execution model through Cross-Site Scripting (XSS), injecting malicious `<script>` tags into input fields that aren't properly sanitized. For example, a comment field that stores and reflects user input verbatim can deliver attacker-controlled JavaScript to every visitor who loads that page, stealing session cookies or redirecting users to phishing sites.

## Key facts
- HTML `<form>` tags with `action` attributes can silently submit data to attacker-controlled servers — the basis of **Cross-Site Request Forgery (CSRF)**
- The `<iframe>` tag can embed malicious external content inside a trusted page, enabling **clickjacking** attacks
- HTML5 introduced APIs (geolocation, local storage, WebSockets) that dramatically expanded the browser attack surface
- **Content Security Policy (CSP)** is a defensive HTTP header that restricts which HTML sources and scripts a browser will execute, directly mitigating XSS
- Unvalidated HTML input is OWASP Top 10 category **A03:2021 – Injection**; output encoding (e.g., converting `<` to `&lt;`) is the primary mitigation

## Related concepts
[[Cross-Site Scripting (XSS)]] [[Cross-Site Request Forgery (CSRF)]] [[Content Security Policy]] [[Clickjacking]] [[Input Validation]]