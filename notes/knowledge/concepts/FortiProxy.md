# FortiProxy

## What it is
Think of it as a customs checkpoint at an airport — every packet of web traffic must pass through, show its contents, and get cleared before entering or leaving. FortiProxy is Fortinet's dedicated secure web gateway (SWG) appliance that inspects, filters, and controls HTTP/HTTPS traffic between users and the internet, enforcing policy through SSL inspection, URL filtering, and application control.

## Why it matters
In 2022, a critical authentication bypass vulnerability (CVE-2022-40684) was actively exploited in FortiProxy (and FortiOS/FortiGate), allowing unauthenticated attackers to perform administrative actions via specially crafted HTTP requests — effectively walking past the customs checkpoint in a disguise. Organizations that hadn't patched saw threat actors drop configuration backdoors within hours of public disclosure, demonstrating how a gateway meant to protect traffic can itself become the attack surface.

## Key facts
- FortiProxy operates as a **forward proxy**, meaning it sits between internal users and external internet resources, not between external users and internal servers (that's a reverse proxy)
- Performs **SSL/TLS deep packet inspection** — it terminates the encrypted session, inspects the plaintext, then re-encrypts, which requires deploying a trusted CA certificate to endpoints
- Supports **explicit and transparent proxy modes** — explicit requires client-side configuration; transparent intercepts traffic without client awareness
- CVE-2022-40684 (CVSS 9.8) exploited the **management interface** via HTTP/HTTPS, not the proxy function itself — a reminder that management planes need separate access controls
- Integrates with **FortiGuard threat intelligence** for real-time URL categorization, malware detection, and DNS filtering

## Related concepts
[[Secure Web Gateway]] [[SSL Inspection]] [[Forward Proxy]] [[CVE Exploitation]] [[Defense in Depth]]