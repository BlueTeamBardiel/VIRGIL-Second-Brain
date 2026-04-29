# router

## What it is
Like a postal sorting facility that reads destination addresses on packages and decides which truck to load them onto, a router is a Layer 3 network device that forwards IP packets between different networks by examining destination IP addresses and consulting a routing table to determine the best path. Unlike switches (which operate within a network), routers define the boundaries *between* networks.

## Why it matters
In 2023, Cisco disclosed critical vulnerabilities in IOS XE software that allowed unauthenticated attackers to gain root-level control of routers via a malicious HTTP request — compromising entire network segments instantly. Hardening routers (disabling unused services like HTTP management, Telnet, and CDP) is a frontline defense because a compromised router lets an attacker intercept, reroute, or drop all traffic passing through it.

## Key facts
- Routers operate at **OSI Layer 3 (Network layer)** and make forwarding decisions based on IP addresses, not MAC addresses
- Default gateway: the router IP address configured on hosts to reach external networks — a common target for **ARP poisoning attacks** that redirect traffic to an attacker's machine
- **Administrative interfaces** (SSH, HTTPS management consoles) exposed to the internet are a top attack surface; Security+ emphasizes disabling Telnet in favor of SSH
- Router **ACLs (Access Control Lists)** function as basic stateless firewalls, filtering traffic based on IP/port rules at the perimeter
- **BGP (Border Gateway Protocol)** is used between routers on the internet; BGP hijacking can redirect global traffic to malicious autonomous systems

## Related concepts
[[default gateway]] [[BGP hijacking]] [[ACL]] [[ARP poisoning]] [[network segmentation]]