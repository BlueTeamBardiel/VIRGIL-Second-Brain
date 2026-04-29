# Axios

## What it is
Like a postal courier that handles all the messy paperwork of sending and receiving letters so you don't have to, Axios is a promise-based HTTP client library for JavaScript (Node.js and browsers) that simplifies making HTTP requests. It wraps the native `fetch` and `XMLHttpRequest` APIs, automatically serializing JSON and handling request/response interception.

## Why it matters
Attackers targeting web applications frequently exploit misconfigured Axios instances to perform Server-Side Request Forgery (SSRF). If a Node.js backend uses Axios to fetch a user-supplied URL without validation, an attacker can manipulate the request to target internal cloud metadata endpoints (e.g., `http://169.254.169.254/latest/meta-data/`) and exfiltrate IAM credentials — a technique used in the 2019 Capital One breach.

## Key facts
- Axios **interceptors** allow developers to globally modify requests or responses — a double-edged sword that can be abused if malicious code is injected into the interceptor chain via supply chain attacks.
- Axios does **not sanitize URLs by default**, making applications vulnerable to SSRF if user-controlled input is passed directly to `axios.get()`.
- Unlike native `fetch`, Axios **automatically throws errors for HTTP 4xx/5xx responses**, which can leak internal error details if not properly caught and sanitized before returning to the client.
- Axios supports **cross-site request forgery (CSRF) protection** via the `xsrfCookieName` and `xsrfHeaderName` config options — but developers must explicitly enable and configure these.
- As an **npm package**, Axios is a common target for dependency confusion and typosquatting attacks (e.g., fake packages named `axois` or `axios-http`).

## Related concepts
[[Server-Side Request Forgery (SSRF)]] [[Cross-Site Request Forgery (CSRF)]] [[Supply Chain Attack]] [[Dependency Confusion]] [[XML HTTP Request (XHR)]]