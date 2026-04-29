# HTTP Basic Authentication

## What it is
Think of it like a nightclub bouncer who asks for your name and password, then you shout both out loud in a crowded street — anyone nearby can hear. HTTP Basic Authentication transmits credentials (username:password) encoded in Base64 within the HTTP `Authorization` header. It is a standardized scheme (RFC 7617) that provides *no encryption* — Base64 is encoding, not encryption, and is trivially reversible.

## Why it matters
In a 2022-style credential-harvesting attack, an attacker performing a man-in-the-middle intercept on plain HTTP traffic can capture the `Authorization: Basic dXNlcjpwYXNz` header and decode it instantly with any Base64 tool, revealing `user:pass` in seconds. This is why security standards require Basic Auth to be used **only over HTTPS (TLS)** — the TLS layer provides the encryption that Basic Auth itself lacks. Organizations still running internal tools over HTTP with Basic Auth are one Wireshark capture away from credential exposure.

## Key facts
- Credentials are transmitted as `Base64(username:password)` — not hashed, not encrypted; decode is one command: `echo dXNlcjpwYXNz | base64 -d`
- The header format is: `Authorization: Basic <encoded-credentials>` sent with **every request**
- No session management — credentials must be re-sent on each HTTP request, increasing the attack surface
- Browsers cache Basic Auth credentials for the session, and there is **no native logout mechanism** — closing the browser is the only standard logout
- Per NIST SP 800-63B and PCI-DSS, Basic Auth over unencrypted HTTP is considered non-compliant for handling sensitive data
- Vulnerable to credential replay attacks if intercepted, since credentials are static per session

## Related concepts
[[Base64 Encoding]] [[Man-in-the-Middle Attack]] [[TLS/SSL]] [[Digest Authentication]] [[Session Hijacking]]