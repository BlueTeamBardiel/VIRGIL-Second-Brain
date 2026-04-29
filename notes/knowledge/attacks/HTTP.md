# HTTP

## What it is
Think of HTTP like a waiter at a restaurant: your browser shouts an order (GET /index.html), and the server shouts back a response (200 OK, here's your food) — but neither remembers the other between visits. HTTP (HyperText Transfer Protocol) is a stateless, application-layer protocol operating over TCP port 80 that governs how clients request and servers deliver web resources.

## Why it matters
Because HTTP transmits data in plaintext, an attacker performing a man-in-the-middle attack on an unsecured Wi-Fi network can use a tool like Wireshark to capture login credentials submitted via an HTTP form — credentials that would be invisible if the site used HTTPS instead. This is why forcing HTTPS redirects and implementing HSTS headers are critical hardening steps for any web application.

## Key facts
- HTTP operates on **TCP port 80**; HTTPS operates on **TCP port 443**
- HTTP is **stateless** — cookies and session tokens were invented specifically to work around this limitation
- Common HTTP methods: **GET** (retrieve), **POST** (submit data), **PUT** (update), **DELETE** (remove), **HEAD** (headers only)
- HTTP response codes matter for security: **401** (Unauthorized), **403** (Forbidden), **500** (Internal Server Error — can reveal server info)
- **HTTP request smuggling** is an attack that exploits discrepancies between how front-end proxies and back-end servers parse HTTP requests, enabling request hijacking

## Related concepts
[[HTTPS]] [[TLS]] [[Man-in-the-Middle Attack]] [[HSTS]] [[Session Hijacking]]