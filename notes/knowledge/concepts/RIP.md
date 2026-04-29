# RIP

## What it is
Like postal workers shouting routes to each other across a hallway — whoever shouts loudest or most recently wins, no credentials required — RIP (Routing Information Protocol) is a distance-vector routing protocol where routers broadcast their routing tables to neighbors every 30 seconds, selecting paths based purely on hop count (max 15 hops).

## Why it matters
Because RIP has no authentication by default, an attacker on the same network segment can inject fraudulent route advertisements — a technique called **RIP route injection** — redirecting traffic through an attacker-controlled router to perform man-in-the-middle attacks. In a penetration test against a legacy enterprise network, tools like Scapy or Quagga can forge RIP v1 broadcasts to poison routing tables and intercept sensitive traffic silently.

## Key facts
- **RIPv1** sends broadcasts with zero authentication; **RIPv2** supports MD5 authentication and uses multicast (224.0.0.9) instead of broadcast
- Maximum hop count of **15** — a route with 16 hops is considered unreachable, limiting RIP to small networks
- **Split horizon** and **poison reverse** are loop-prevention mechanisms built into RIP to prevent routing loops
- RIP is vulnerable to **route injection/poisoning attacks** due to its trust-all-neighbors model, especially v1
- Largely replaced by OSPF and EIGRP in modern networks, but still appears in legacy environments and on embedded devices (routers, IoT gateways)

## Related concepts
[[OSPF]] [[BGP Hijacking]] [[Man-in-the-Middle Attack]] [[Route Poisoning]] [[Network Protocols]]