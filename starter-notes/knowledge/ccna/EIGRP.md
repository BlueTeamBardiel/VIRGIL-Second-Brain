# EIGRP

## What it is
Imagine a GPS app that doesn't just use distance to pick a route, but also factors in road speed, lane count, and reliability — then shares updates instantly only when something changes. That's EIGRP: Enhanced Interior Gateway Routing Protocol is a Cisco-proprietary hybrid routing protocol that combines distance-vector efficiency with link-state awareness, using a Diffusing Update Algorithm (DUAL) to calculate loop-free paths based on composite metrics (bandwidth, delay, reliability, load).

## Why it matters
An attacker with access to an internal network segment can inject fraudulent EIGRP route advertisements — a technique called **route poisoning or EIGRP route injection** — to redirect traffic through a malicious hop, enabling man-in-the-middle interception of sensitive data. This is particularly dangerous in enterprise environments where EIGRP runs without MD5 or SHA authentication configured, which is still common in legacy Cisco deployments. Defenders should enforce EIGRP neighbor authentication and monitor for unexpected changes in routing tables using network detection tools.

## Key facts
- EIGRP uses **Hello packets** to discover and maintain neighbor relationships; default Hello interval is 5 seconds on LAN links
- Supports **MD5 and SHA-256 authentication** for neighbor verification — absence of this is a common misconfiguration finding
- Unlike OSPF, EIGRP is **classless and supports VLSM/CIDR**, making it flexible for modern subnetting schemes
- Uses **multicast address 224.0.0.10** for routing updates, which can be monitored for anomalous EIGRP traffic on unexpected segments
- EIGRP route injection attacks exploit the lack of authentication to manipulate the **DUAL algorithm's feasible successor** selection, redirecting traffic silently

## Related concepts
[[Routing Protocol Security]] [[Man-in-the-Middle Attack]] [[Network Authentication]] [[OSPF]] [[Defense in Depth]]
