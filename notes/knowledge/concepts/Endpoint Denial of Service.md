# Endpoint Denial of Service

## What it is
Like jamming a revolving door with luggage until no one can enter the building, Endpoint DoS attacks overwhelm a specific host, service, or application until it can no longer respond to legitimate users. Unlike network-layer floods that target infrastructure broadly, these attacks are precision strikes against individual endpoints — a single web server, an authentication service, or even a workstation — exhausting CPU, memory, disk, or connection resources until availability collapses.

## Why it matters
In 2016, attackers used the Mirai botnet to launch HTTP floods against Dyn's DNS endpoints, sending crafted requests that forced DNS resolvers to perform expensive lookups repeatedly — ultimately taking down Twitter, Netflix, and Spotify. Defenders countered by implementing rate limiting and anycast routing to distribute load, illustrating how endpoint-level resource exhaustion can cascade into internet-scale outages.

## Key facts
- **OS/Application Exhaustion** targets service-specific limits (e.g., Apache's max connections), while **Resource Exhaustion** attacks fill memory or disk (e.g., log flooding) — both are classified as Endpoint DoS under MITRE ATT&CK T1499
- **Slowloris** is a classic Endpoint DoS tool that opens many partial HTTP connections, keeping them alive indefinitely without triggering volumetric flood detection
- **SYN floods** exhaust TCP connection tables on a specific host by sending connection requests without completing the handshake
- Defenses include **connection rate limiting**, **SYN cookies**, **Web Application Firewalls (WAF)**, and **resource quotas** at the OS level
- MITRE ATT&CK distinguishes Endpoint DoS (T1499) from **Network DoS (T1498)** — a distinction that appears on CySA+ scenario questions

## Related concepts
[[Denial of Service]] [[Network Denial of Service]] [[Application Layer Attack]] [[SYN Flood]] [[Botnet]]