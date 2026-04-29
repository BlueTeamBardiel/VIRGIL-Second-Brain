# WebSocket Security

## What it is
Think of a regular HTTP request like a postcard — you send one, get one back, done. WebSockets are more like a dedicated phone call: once connected, both sides can talk freely without hanging up and redialing. Technically, WebSockets are a full-duplex, persistent communication protocol (RFC 6455) that upgrades from HTTP via a handshake, enabling real-time bidirectional data exchange between client and server.

## Why it matters
In 2019, researchers demonstrated Cross-Site WebSocket Hijacking (CSWSH) against chat and trading platforms where servers failed to validate the `Origin` header during the handshake. An attacker could embed a malicious page that silently opens an authenticated WebSocket to the victim's bank app — because WebSockets don't enforce Same-Origin Policy by default — and read or inject real-time financial data mid-stream.

## Key facts
- WebSocket connections begin with an HTTP `Upgrade` request; if the server doesn't validate the `Origin` header, any cross-origin site can initiate a connection using the victim's cookies
- Unlike REST APIs, WebSockets bypass traditional WAF rules and CSRF protections because they are stateful and persist beyond the initial request
- Use `wss://` (WebSocket Secure) over TLS, not unencrypted `ws://` — equivalent to HTTPS vs HTTP; plaintext `ws://` enables eavesdropping and man-in-the-middle injection
- Authentication must be handled explicitly (e.g., token in the initial handshake or first message) — cookies authenticate the *upgrade* request but not individual frames
- Input validation applies to every message frame, not just the initial connection; unsanitized frames can deliver stored XSS or injection payloads post-handshake

## Related concepts
[[Cross-Site Request Forgery]] [[Same-Origin Policy]] [[Transport Layer Security]] [[Cross-Site Scripting]]