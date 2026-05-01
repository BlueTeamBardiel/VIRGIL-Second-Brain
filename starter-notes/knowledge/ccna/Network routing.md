# Network routing

## What it is
Like a postal sorting facility that reads zip codes and decides which truck carries each letter toward its destination, routing is the process of forwarding packets across networks by examining destination IP addresses and consulting decision tables. Routers use routing tables and protocols (like OSPF, BGP, or RIP) to determine the best path for each packet through a network of interconnected nodes.

## Why it matters
BGP hijacking is a devastating real-world attack where a malicious or misconfigured autonomous system (AS) advertises false routes, convincing other routers to send traffic through attacker-controlled infrastructure. In 2018, attackers rerouted Amazon Route 53 DNS traffic through Russian infrastructure to steal cryptocurrency — all by injecting fraudulent BGP announcements that legitimate routers trusted without verification.

## Key facts
- **BGP (Border Gateway Protocol)** is the routing protocol of the internet and operates on TCP port 179; it uses an honor system with no built-in authentication by default
- **RPKI (Resource Public Key Infrastructure)** is the defense mechanism that cryptographically validates BGP route announcements, mitigating hijacking attacks
- **Static routes** are manually configured and don't adapt to topology changes; **dynamic routes** use protocols like OSPF (link-state) or RIP (distance-vector) to update automatically
- **Routing table poisoning** attacks target dynamic routing protocols by injecting false route information, redirecting or black-holing traffic
- **TTL (Time to Live)** in IP packets decrements at each hop, preventing routing loops from circulating packets indefinitely — when TTL hits zero, the packet is dropped and an ICMP "Time Exceeded" message returns to the sender

## Related concepts
[[BGP hijacking]] [[ICMP]] [[Network address translation]] [[Autonomous Systems]] [[Firewall rules]]
