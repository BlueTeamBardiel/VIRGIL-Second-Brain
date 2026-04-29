# Header Injection and Stripping

## What it is
Like a mail clerk who stamps "INTERNAL USE ONLY" on every package but lets attackers sneak their own forged stamps onto incoming mail — header injection occurs when untrusted input is embedded into HTTP headers without sanitization, allowing attackers to insert malicious headers or split responses. Header stripping is the defensive countermeasure where proxies or WAFs remove dangerous or unauthorized headers before forwarding requests or responses.

## Why it matters
In HTTP Response Splitting attacks, an attacker injects CRLF characters (`\r\n`) into a redirect parameter, effectively crafting a second forged HTTP response that poisons a shared cache. This can serve malicious content to thousands of users from a trusted domain — a cache poisoning attack that starts with a single injected header field.

## Key facts
- **CRLF injection** (`\r\n`) is the core technique enabling HTTP Response Splitting; any user-controlled data written into response headers without stripping carriage returns is vulnerable
- **Email header injection** targets mail functions (e.g., PHP's `mail()`) — injecting `\r\nBcc: victim@target.com` turns a contact form into a spam relay
- **Security headers that should be stripped inbound** include `X-Forwarded-For` spoofing — if an application trusts this header for access control, an attacker simply forges it
- **Hop-by-hop headers** (e.g., `Connection`, `Transfer-Encoding`) must be stripped by proxies per RFC 7230; failure to do so enables **HTTP Request Smuggling**
- Defenses include input validation rejecting CRLF sequences, using frameworks that encode headers automatically, and configuring reverse proxies to strip attacker-controlled headers before they reach backend applications

## Related concepts
[[HTTP Request Smuggling]] [[Cache Poisoning]] [[Input Validation]] [[CRLF Injection]] [[Proxy Security]]