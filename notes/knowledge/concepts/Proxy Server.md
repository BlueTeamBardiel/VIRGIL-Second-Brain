# Proxy Server

## What it is
Like a personal assistant who picks up your mail, reads the address, and forwards it — so the sender never learns your home address — a proxy server acts as an intermediary between a client and a destination server. It receives requests on the client's behalf, forwards them, and returns the responses, masking the client's true IP address in the process.

## Why it matters
Attackers frequently chain together multiple proxy servers (called *proxy chaining*) to obscure the origin of their intrusion attempts, making forensic attribution extremely difficult. Defenders use forward proxies to inspect and filter outbound web traffic, blocking connections to known malicious domains before malware can phone home to a C2 server.

## Key facts
- **Forward proxy**: sits between internal clients and the internet; controls and logs outbound traffic (used for content filtering and anonymity).
- **Reverse proxy**: sits in front of web servers, protecting them from direct exposure; commonly used for load balancing and WAF functionality.
- **Transparent proxy**: intercepts traffic without client configuration — users may not know it exists; common in enterprise and ISP environments.
- **SOCKS5 proxy**: operates at Layer 5, handles any traffic type (not just HTTP), and supports authentication — frequently abused by threat actors for anonymized tunneling.
- Proxies break direct client-to-server connections, which can defeat geolocation-based IP blocking but do **not** provide encryption by themselves — that requires TLS or a VPN layer.

## Related concepts
[[VPN]] [[Network Address Translation]] [[Web Application Firewall]] [[Tor Network]] [[Command and Control]]