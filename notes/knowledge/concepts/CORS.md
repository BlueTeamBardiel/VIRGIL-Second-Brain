# CORS

## What it is
Think of CORS like a nightclub bouncer checking a guest list: your browser asks the server "is this website allowed to talk to you?" and the server either stamps your hand or turns you away. Cross-Origin Resource Sharing (CORS) is an HTTP header-based mechanism that allows or restricts web applications running at one origin (domain/protocol/port) to make requests to a different origin, relaxing the browser's default Same-Origin Policy.

## Why it matters
A misconfigured CORS policy — such as a server responding with `Access-Control-Allow-Origin: *` on an authenticated API endpoint — allows an attacker's malicious website to silently make credentialed requests to that API on behalf of a logged-in victim. This effectively turns CORS misconfiguration into a pathway for data exfiltration attacks, where the attacker's page harvests sensitive API responses the victim's browser retrieves automatically.

## Key facts
- The `Access-Control-Allow-Origin` response header is the core CORS control; a wildcard (`*`) value prohibits credentialed requests by design, but many servers incorrectly echo back the requesting origin instead
- **Preflight requests** are browser-sent HTTP `OPTIONS` requests that check server permissions before sending complex cross-origin requests (non-GET/POST or custom headers)
- CORS is enforced by the **browser**, not the server — server-side tools and curl bypass it entirely, making it a client-side protection mechanism
- Allowing `Access-Control-Allow-Credentials: true` alongside a dynamically reflected origin is the most dangerous CORS misconfiguration, enabling session-riding attacks
- CORS does not replace authentication — it only controls which origins browsers permit to read responses

## Related concepts
[[Same-Origin Policy]] [[Cross-Site Request Forgery]] [[Content Security Policy]]