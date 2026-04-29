# traceroute

## What it is
Like dropping breadcrumbs along a hiking trail to map every waypoint between trailhead and summit, traceroute sends packets with incrementally increasing TTL values to force each router along a path to reveal itself. It is a network diagnostic tool that maps the hop-by-hop route packets take from a source to a destination, recording the IP address and round-trip latency of each intermediate node. On Windows the command is `tracert`; on Linux/macOS it is `traceroute`.

## Why it matters
Attackers use traceroute during the **reconnaissance phase** to map network topology — identifying firewall boundaries, load balancers, and internal routing infrastructure before launching targeted attacks. Defenders use the same output to detect asymmetric routing, identify choke points, and confirm that traffic is actually traversing expected security controls like a DMZ or IDS appliance.

## Key facts
- Uses **ICMP Time Exceeded** messages (Linux default uses UDP probes; Windows uses ICMP Echo); each hop is revealed when a router decrements TTL to zero and returns the error
- A **`* * *`** response means a router is blocking ICMP, not necessarily that the hop doesn't exist — a common firewall behavior that can obscure network maps
- Traceroute is classified as an **active reconnaissance** technique because it generates real traffic that can appear in logs and trigger IDS alerts
- TTL field in IPv4 (and **Hop Limit** in IPv6) is the mechanism exploited — each router decrements it by one before forwarding
- Tools like **Nmap** (`--traceroute` flag) and **tcptraceroute** bypass ICMP-blocking firewalls by using TCP SYN packets on port 80/443 instead

## Related concepts
[[ICMP]] [[TTL (Time to Live)]] [[network reconnaissance]] [[ping]] [[Nmap]]