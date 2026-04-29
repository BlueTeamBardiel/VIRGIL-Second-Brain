# HTTP header injection

## What it is
Imagine slipping a forged sticky note into a diplomat's official correspondence — it looks like it belongs, but it carries your own instructions. HTTP header injection occurs when an attacker inserts malicious data containing CRLF characters (`\r\n`) into an HTTP response, allowing them to craft arbitrary headers or even inject an entirely separate HTTP response body.

## Why it matters
A classic attack scenario is **response splitting**: an attacker manipulates a vulnerable redirect parameter (e.g., `Location: /page\r\nSet-Cookie: session=attacker`) to poison a shared cache, delivering malicious content to every user who receives that cached response. This was exploited in early 2000s web caching proxies and remains a vector in modern APIs that echo user input into response headers without sanitization.

## Key facts
- The root cause is failure to strip or encode **CR (`\r`, 0x0D) and LF (`\n`, 0x0A)** characters before including user input in HTTP headers.
- **HTTP Response Splitting** is the most dangerous variant — attackers inject a full second HTTP response to hijack caches or deliver XSS payloads.
- Common injection points include `Location`, `Set-Cookie`, and custom headers that reflect user-supplied values.
- Mitigation requires **input validation** (reject CRLF in header values) and using frameworks that automatically encode header output.
- Modern HTTP/2 implementations are less vulnerable because they use binary framing rather than plaintext CRLF-delimited headers, but HTTP/1.1 endpoints remain at risk.

## Related concepts
[[Cross-Site Scripting (XSS)]] [[Cache Poisoning]] [[Input Validation]] [[CRLF Injection]] [[HTTP Response Splitting]]