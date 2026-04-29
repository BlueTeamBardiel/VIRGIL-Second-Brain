# CWE-80

## What it is
Like a security guard who checks IDs at the front door but ignores packages smuggled through the back window — Basic XSS filtering catches `<script>` tags but misses encoded or context-specific variants. CWE-80 is Improper Neutralization of Script-Related HTML Tags in a Web Page (Basic XSS), where user-supplied input containing HTML script elements is reflected back into the browser without adequate sanitization, enabling client-side code execution.

## Why it matters
In 2005, the Samy worm exploited a basic XSS flaw in MySpace by injecting a `<script>` payload into profile fields — it infected over one million accounts in 20 hours, the fastest-spreading malware at that time. Defenders must implement output encoding (e.g., converting `<` to `&lt;`) at every rendering point, not just input validation, because filtering on the way *in* doesn't protect against data that was already stored or arrives through indirect channels.

## Key facts
- CWE-80 is a child of CWE-79 (XSS) — it specifically targets basic, unencoded `<script>`, `<img onerror>`, and similar HTML injection patterns
- The vulnerability lives in the **output layer**, not the input layer — encoding must happen at render time
- Reflected XSS (non-persistent) and Stored XSS (persistent) are both possible under CWE-80
- Content Security Policy (CSP) headers are a key defense-in-depth control that can block inline script execution even if injection succeeds
- CVSS scores for XSS vulnerabilities typically range 4.3–8.8 depending on context (authenticated vs. unauthenticated, stored vs. reflected)

## Related concepts
[[CWE-79 Cross-Site Scripting]] [[Output Encoding]] [[Content Security Policy]] [[DOM-Based XSS]] [[HTTP Response Splitting]]