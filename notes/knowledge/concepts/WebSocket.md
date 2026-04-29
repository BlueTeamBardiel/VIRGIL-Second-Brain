# WebSocket

## What it is
Think of HTTP as a walkie-talkie where you press a button, speak, and wait for a reply — WebSocket is a telephone call where both sides can talk simultaneously without hanging up. WebSocket is a full-duplex communication protocol that upgrades an HTTP connection into a persistent, bidirectional channel between client and server. Unlike HTTP's request-response cycle, the connection stays open indefinitely, allowing real-time data flow in both directions.

## Why it matters
WebSocket connections bypass many traditional web application firewall rules designed for HTTP traffic, making them a blind spot for defenders. An attacker who finds an XSS vulnerability can hijack an open WebSocket connection and silently relay sensitive real-time data — like chat messages or financial tickers — to an external server without triggering standard HTTP monitoring alerts. Security teams must explicitly configure WAFs and proxies to inspect WebSocket frame payloads, not just the initial HTTP upgrade handshake.

## Key facts
- WebSocket connections begin with an HTTP/HTTPS **upgrade handshake** (the `Upgrade: websocket` header), then switch protocols — the initial request is still subject to CORS and cookie policies
- Uses **ws://** (port 80) or **wss://** (port 443, TLS-encrypted); always prefer wss:// to prevent eavesdropping
- Lacks built-in CSRF protection after handshake — servers must validate the `Origin` header and use token-based authentication per message
- WebSocket messages are framed, not HTTP — **IDS/IPS tools that only parse HTTP will miss malicious payloads** sent over an established WebSocket tunnel
- Common attack: **Cross-Site WebSocket Hijacking (CSWSH)** — analogous to CSRF, tricks a victim's browser into opening a WebSocket using their authenticated session

## Related concepts
[[Cross-Site Request Forgery]] [[Cross-Site Scripting]] [[Transport Layer Security]] [[Web Application Firewall]] [[HTTP Headers]]