# Burp Proxy

## What it is
Think of it as a customs inspector sitting between your browser and a website — every package (HTTP/HTTPS request and response) passes through the checkpoint, where it can be read, held, or tampered with before continuing. Burp Proxy is an intercepting proxy component within PortSwigger's Burp Suite that positions itself as a man-in-the-middle between a web browser and a target web application. It captures live traffic, allowing security testers to inspect, modify, replay, or drop individual requests and responses in real time.

## Why it matters
During a web application penetration test, a tester might intercept a POST request containing a hidden form field like `role=user`, manually change it to `role=admin`, and forward it to the server — revealing a broken access control vulnerability (OWASP A01). This exact technique has exposed privilege escalation flaws in banking and healthcare applications where client-side trust assumptions were incorrectly baked into server logic.

## Key facts
- Burp Proxy listens on **127.0.0.1:8080** by default; the browser must be configured to route traffic through this address
- To intercept **HTTPS**, Burp installs a custom CA certificate into the browser's trust store, performing SSL/TLS termination on both sides
- The **HTTP history** tab logs all proxied traffic even when interception is toggled off, enabling passive reconnaissance
- Intercepted requests can be sent to other Burp tools: **Repeater** (manual replay), **Intruder** (fuzzing), and **Scanner** (automated vulnerability detection)
- Burp Proxy operates at **Layer 7** (Application Layer) of the OSI model, making it protocol-aware rather than a raw packet sniffer

## Related concepts
[[Man-in-the-Middle Attack]] [[TLS Interception]] [[Web Application Penetration Testing]] [[OWASP Top 10]] [[HTTP Request Smuggling]]