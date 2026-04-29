# Squid Proxy

## What it is
Like a librarian who fetches books on your behalf so the author never knows who actually requested them — Squid is an open-source caching proxy server that sits between clients and the internet, forwarding requests and caching responses. It operates primarily on port 3128 and supports HTTP, HTTPS, and FTP traffic.

## Why it matters
Attackers who compromise an internal Squid instance can pivot it into a **C2 relay** — malware beacons out to the proxy, which forwards traffic to an external server, effectively laundering malicious connections through a trusted internal IP. Defenders use Squid with SSL bump (HTTPS inspection) to decrypt, inspect, and log outbound traffic, catching data exfiltration attempts that would otherwise hide inside TLS tunnels.

## Key facts
- **Default port: 3128** (also commonly 8080); a Squid service exposed to the internet without authentication is a critical misconfiguration
- **SSL Bump** allows Squid to perform a MITM on HTTPS traffic for inspection — requires deploying a custom CA cert to clients
- Squid supports **ACLs (Access Control Lists)** to whitelist/blacklist domains, IPs, and URL patterns — primary mechanism for egress filtering
- **Forward proxy vs. Reverse proxy**: Squid is typically deployed as a forward proxy (client-side); misconfigured as an open proxy, it can be abused for anonymous browsing or amplification attacks
- Logs are stored in `/var/log/squid/access.log` — a goldmine for forensic analysis of web activity and potential insider threats

## Related concepts
[[Forward Proxy]] [[SSL Inspection]] [[Egress Filtering]] [[C2 Infrastructure]] [[Web Application Firewall]]