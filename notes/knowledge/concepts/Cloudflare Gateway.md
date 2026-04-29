# Cloudflare Gateway

## What it is
Think of it as a TSA checkpoint at the edge of the internet — every DNS query and HTTP request your users make passes through it before reaching its destination, where it gets inspected, filtered, or blocked. Cloudflare Gateway is a cloud-native Secure Web Gateway (SWG) that enforces DNS filtering, HTTP inspection, and network firewall policies for users regardless of where they're working. It's a core component of Cloudflare's Zero Trust platform, sitting between users and the internet to control and log outbound traffic.

## Why it matters
During a phishing campaign, an attacker registers a lookalike domain and tricks employees into clicking a malicious link. Cloudflare Gateway's DNS filtering can block resolution of that domain entirely — before any TCP connection is ever made — because the domain matches threat intelligence feeds flagging it as newly registered and suspicious. This stops malware delivery and C2 callback traffic at the DNS layer, the cheapest possible point of interception.

## Key facts
- Operates at **three inspection layers**: DNS (blocks malicious domains), HTTP/S (inspects content and enforces URL filtering), and network (layer 3/4 firewall rules)
- Uses **DoH (DNS-over-HTTPS)** or a WARP client to route user traffic through Cloudflare's network, enabling inspection even on remote devices
- Supports **identity-aware policies** — rules can be tied to specific users or groups via SSO integration (Okta, Azure AD), not just IP addresses
- Logs all DNS queries and HTTP requests to a **SIEM-ready audit trail**, supporting CySA+ incident investigation workflows
- Part of Cloudflare's **SASE (Secure Access Service Edge)** architecture alongside Cloudflare Access (Zero Trust Network Access)

## Related concepts
[[Secure Web Gateway]] [[DNS Filtering]] [[Zero Trust Architecture]] [[SASE]] [[DNS-over-HTTPS]]