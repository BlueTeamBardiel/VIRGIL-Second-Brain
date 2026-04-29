# Routing

## What it is
Like a postal sorting facility that reads zip codes and decides which truck carries each package to its destination, routing is the process by which network devices (routers) examine IP destination addresses and forward packets along the best path toward their target. Routers maintain routing tables — databases of known networks and the next-hop addresses used to reach them — updated via protocols like OSPF, BGP, or RIP.

## Why it matters
BGP (Border Gateway Protocol) hijacking is a real and recurring attack where a malicious or misconfigured autonomous system advertises falsely shortened routes, causing internet traffic to detour through attacker-controlled infrastructure. In 2018, traffic from major cloud providers was briefly redirected through Russia via a BGP route leak, exposing unencrypted data to interception. Defenders counter this with RPKI (Resource Public Key Infrastructure), which cryptographically validates that BGP route announcements are authorized.

## Key facts
- **Routing tables** are populated via static routes (manually configured) or dynamic routing protocols (OSPF, BGP, RIP, EIGRP)
- **BGP** is the protocol that glues the internet together — it routes between autonomous systems (AS) and is notoriously trust-based, making it vulnerable to hijacking
- **Route poisoning** is a defense against routing loops: a failed route is advertised with an infinite metric to quickly propagate the failure across the network
- **Default gateway** is the router a host sends packets to when no specific route matches the destination — compromising it enables a man-in-the-middle position
- **ICMP Redirect attacks** trick a host into changing its default route to an attacker-controlled router, enabling traffic interception without touching the actual network infrastructure

## Related concepts
[[BGP Hijacking]] [[Man-in-the-Middle Attack]] [[Network Protocols]] [[Autonomous Systems]] [[ICMP]]