# Layer 7

## What it is
Like a customs officer who reads your passport, checks your visa, and understands *why* you're traveling — not just that a person arrived — Layer 7 (the Application Layer) is the top of the OSI model where network communication becomes meaningful to end-user software. It handles protocols that carry actual content: HTTP, DNS, SMTP, FTP, and others that applications use to exchange structured data.

## Why it matters
Layer 7 is the primary battlefield for modern web attacks. A **Layer 7 DDoS** (HTTP flood) is devastatingly effective because each request looks *legitimate* at lower layers — packets are well-formed, TCP handshakes complete — but thousands of bots hammering `/search?q=complex_query` can exhaust a web server's CPU without ever triggering a volumetric alert. Web Application Firewalls (WAFs) exist specifically to inspect and filter at this layer, blocking SQLi and XSS payloads that only become visible when you read the actual request content.

## Key facts
- Layer 7 is the **Application Layer** — the 7th and topmost layer of the OSI model; it does *not* refer to the application itself, but the protocols it uses
- Common Layer 7 protocols: **HTTP/HTTPS (port 80/443), DNS (port 53), SMTP (port 25), FTP (port 21), LDAP (port 389)**
- Layer 7 DDoS attacks are harder to detect than volumetric (Layer 3/4) attacks because traffic appears legitimate to stateful firewalls
- **WAFs** and **Next-Generation Firewalls (NGFWs)** perform deep packet inspection at Layer 7 — traditional firewalls cannot
- SSL/TLS termination must occur before Layer 7 inspection is possible, which is why encrypted traffic is a blind spot for passive inspection tools

## Related concepts
[[OSI Model]] [[Web Application Firewall]] [[DDoS Attack]] [[Deep Packet Inspection]] [[HTTP Protocol]]