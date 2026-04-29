# Same-Origin Policy

## What it is
Think of it like apartment mailboxes: your key only opens your own box, never your neighbor's — even if you're standing in the same lobby. The Same-Origin Policy (SOP) is a browser security mechanism that prevents scripts loaded from one origin (scheme + hostname + port) from reading data returned by a different origin. Two URLs share an origin only when all three components match exactly.

## Why it matters
Without SOP, a malicious script on `evil.com` could silently make an authenticated request to `bank.com` and read your account balance directly from the response — a classic data-theft scenario. SOP blocks the *read*, which is why Cross-Site Request Forgery (CSRF) still works (the browser *sends* the request with cookies) but the attacker can't harvest the response content. This distinction is the heart of why CSRF tokens and SOP are complementary, not redundant.

## Key facts
- **Origin = scheme + host + port**: `http://example.com:80` and `https://example.com:443` are *different* origins despite sharing a domain.
- SOP restricts **reading** cross-origin responses; it does **not** block cross-origin *writes* (form submissions, redirects) — which is why CSRF exists.
- `CORS` (Cross-Origin Resource Sharing) is the official mechanism to *relax* SOP using `Access-Control-Allow-Origin` response headers, with the server's explicit consent.
- SOP applies to `XMLHttpRequest` and `fetch()` calls, but **not** to `<script>`, `<img>`, or `<link>` tags — those load cross-origin resources freely, which JSONP historically exploited.
- `document.domain` manipulation and `postMessage()` are legacy/modern techniques respectively for controlled cross-origin communication within trusted contexts.

## Related concepts
[[Cross-Origin Resource Sharing (CORS)]] [[Cross-Site Request Forgery (CSRF)]] [[Cross-Site Scripting (XSS)]] [[JSONP]] [[Content Security Policy (CSP)]]