# Routing Protocol

## What it is
Like postal workers negotiating the fastest route for a letter between cities, routing protocols are the automated conversations routers have to build and share maps of the network. Precisely, they are standardized algorithms and message formats that allow routers to dynamically discover network paths, exchange topology information, and determine optimal packet-forwarding paths. Common examples include OSPF, BGP, RIP, and EIGRP.

## Why it matters
In 2008, a Pakistani ISP misconfigured BGP routes and accidentally advertised that it owned YouTube's IP prefixes — hijacking YouTube's global traffic for nearly 20 minutes. This BGP hijacking attack illustrates how routing protocols, especially BGP, operate largely on trust, making them a critical attack surface for traffic interception, redirection, and denial of service at internet scale.

## Key facts
- **BGP (Border Gateway Protocol)** is the internet's inter-domain routing protocol and is highly vulnerable to prefix hijacking because it historically had no built-in authentication; **RPKI** (Resource Public Key Infrastructure) is the modern defense.
- **RIP (Routing Information Protocol)** uses hop count as its metric and is vulnerable to route poisoning attacks where an attacker injects false routing updates.
- **OSPF** uses cryptographic MD5 or SHA authentication to validate routing updates — configuring this is a key hardening step.
- Routing protocol attacks can cause **traffic black-holing** (packets dropped), **traffic sniffing** (redirected through attacker), or **network partitioning**.
- For Security+: understand the difference between **interior gateway protocols** (OSPF, EIGRP — within one organization) and **exterior gateway protocols** (BGP — between autonomous systems on the internet).

## Related concepts
[[BGP Hijacking]] [[Network Hardening]] [[Man-in-the-Middle Attack]] [[Autonomous System]] [[RPKI]]