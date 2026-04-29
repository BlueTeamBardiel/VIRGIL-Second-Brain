# DOM Injection

## What it is
Imagine a library where patrons can slip their own handwritten pages directly into books already on the shelf — bypassing the librarian entirely. DOM Injection is exactly that: an attacker inserts malicious content directly into a web page's Document Object Model (DOM) at runtime, through client-side JavaScript, without the payload ever touching the server. Unlike traditional XSS, the browser itself is the vulnerable party, parsing and executing attacker-controlled data entirely on the client side.

## Why it matters
In 2021, researchers found DOM Injection vulnerabilities in several popular WordPress plugins where `innerHTML` assignments rendered unsanitized URL fragment data (`location.hash`) as executable HTML. An attacker could craft a malicious link that, when clicked by a victim, silently hijacked their authenticated session or dropped a credential harvester — all without triggering server-side WAF inspection because the malicious payload never transited the server.

## Key facts
- DOM Injection is the root mechanism behind **DOM-based XSS (CWE-79)**, which OWASP classifies as distinct from Reflected and Stored XSS because the vulnerability lives in client-side code, not server responses.
- Dangerous JavaScript **sinks** — functions that render raw HTML — include `innerHTML`, `document.write()`, `eval()`, and `outerHTML`; these are the targets auditors scrutinize.
- Attacker-controlled **sources** include `location.hash`, `location.search`, `document.referrer`, and `postMessage` data — inputs that never pass through HTTP responses.
- Mitigation centers on using **safe DOM APIs** like `textContent` or `createElement()` instead of innerHTML, combined with a strict **Content Security Policy (CSP)**.
- DOM Injection is particularly dangerous because traditional **server-side input validation and WAFs cannot inspect or block it** — defense must occur in client-side code.

## Related concepts
[[Cross-Site Scripting (XSS)]] [[Content Security Policy (CSP)]] [[Client-Side Validation]] [[Injection Attacks]] [[JavaScript Security]]