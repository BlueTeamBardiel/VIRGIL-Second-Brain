# mitmproxy

## What it is
Think of it as a glass pipe for HTTP/HTTPS traffic — instead of an opaque tube where data flows invisibly, every packet is visible, interceptable, and modifiable before it reaches its destination. mitmproxy is an open-source, interactive command-line tool that acts as a Man-in-the-Middle proxy, allowing security professionals to intercept, inspect, modify, and replay HTTP and HTTPS network traffic in real time.

## Why it matters
During a penetration test against a mobile banking application, a tester configures mitmproxy as the device's proxy gateway and installs its CA certificate on the phone — instantly decrypting TLS traffic that reveals API endpoints sending unencrypted session tokens in headers. This same technique is used offensively by attackers who trick users into trusting rogue certificates on compromised networks to steal credentials and session data.

## Key facts
- mitmproxy operates in three interfaces: `mitmproxy` (interactive TUI), `mitmdump` (command-line/scripted), and `mitmweb` (browser-based GUI)
- It performs SSL/TLS interception by dynamically generating forged certificates signed by its own CA — the target device must trust this CA for HTTPS decryption to succeed
- Supports Python scripting via addon hooks, allowing automated modification of requests/responses (e.g., stripping HSTS headers or injecting payloads)
- Certificate pinning defeats mitmproxy — apps that pin their expected certificate will reject mitmproxy's forged cert and refuse to connect
- Primarily a **white-box testing and research tool**; using it on networks without authorization violates the CFAA and equivalent laws globally

## Related concepts
[[Man-in-the-Middle Attack]] [[SSL TLS Inspection]] [[Certificate Pinning]] [[Burp Suite]] [[HTTP Proxy]]