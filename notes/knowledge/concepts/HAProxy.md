# HAProxy

## What it is
Think of HAProxy as a traffic cop standing at a busy intersection, deciding which lane each car should take before it ever reaches its destination. Technically, it is a high-performance, open-source TCP/HTTP load balancer and proxy server that distributes incoming network traffic across multiple backend servers. It operates at both Layer 4 (transport) and Layer 7 (application) of the OSI model.

## Why it matters
HAProxy sits at the network perimeter as a first line of defense, making it both a target and a shield. In a real attack scenario, a threat actor exploiting CVE-2021-40346 (an integer overflow vulnerability in HAProxy) could perform HTTP request smuggling — injecting malicious requests that backend servers process as legitimate, bypassing access controls entirely. Defensively, HAProxy's ACL rules can block malicious IPs, rate-limit connections, and terminate SSL/TLS before traffic hits internal servers.

## Key facts
- Operates at **Layer 4 and Layer 7**, enabling both TCP passthrough and full HTTP inspection/manipulation
- Supports **SSL/TLS termination**, offloading cryptographic processing from backend servers and centralizing certificate management
- **HTTP request smuggling** vulnerabilities (like CVE-2021-40346) can occur when HAProxy and backend servers interpret HTTP headers (e.g., `Content-Length` vs `Transfer-Encoding`) differently
- HAProxy **ACLs (Access Control Lists)** allow granular traffic filtering based on IP, URL, headers, or request rate — functioning as a lightweight WAF layer
- Commonly deployed in front of web application firewalls or as part of a **DMZ architecture**, making it a high-value target for initial access

## Related concepts
[[Load Balancing]] [[Reverse Proxy]] [[HTTP Request Smuggling]] [[SSL/TLS Termination]] [[Web Application Firewall]]