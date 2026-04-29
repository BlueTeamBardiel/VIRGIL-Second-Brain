# port 80

## What it is
Think of port 80 as the front door of a building — no key required, anyone can walk up and knock. Precisely, port 80 is the default TCP port assigned to HTTP (Hypertext Transfer Protocol), the unencrypted protocol used to transfer web pages between clients and servers. It is standardized by IANA and listens for incoming connection requests on any web server that serves plain HTTP traffic.

## Why it matters
Attackers routinely tunnel malicious traffic through port 80 because firewalls almost universally allow it outbound — it would break the internet to block it. A classic technique called **HTTP tunneling** wraps command-and-control (C2) traffic inside legitimate-looking HTTP requests, allowing malware to exfiltrate data or receive instructions while blending into normal web traffic. Defenders counter this with deep packet inspection (DPI) and proxy-based filtering to distinguish malicious payloads from genuine web requests.

## Key facts
- Port 80 uses **TCP**, not UDP; HTTP requires reliable, ordered delivery.
- Traffic on port 80 is **cleartext** — credentials, cookies, and session tokens are visible to anyone performing a packet capture (e.g., with Wireshark).
- HTTP Strict Transport Security (HSTS) forces browsers to upgrade port 80 connections to port 443 (HTTPS), mitigating downgrade attacks.
- A **HTTP to HTTPS redirect** on port 80 is best practice; leaving port 80 fully open with sensitive content is a misconfiguration flagged in vulnerability scans.
- On Security+/CySA+ exams, port 80 = HTTP; port 443 = HTTPS — knowing this pairing is non-negotiable.

## Related concepts
[[port 443]] [[HTTP]] [[packet sniffing]] [[HTTP tunneling]] [[deep packet inspection]]