# IPv4 Routing

## What it is
Like a postal sorting facility that reads only the ZIP code on an envelope — not the letter inside — to decide which truck carries it next, IPv4 routing is the process of forwarding packets hop-by-hop across networks based solely on the destination IP address in each packet's header. Routers consult their routing tables to select the best next-hop path, decrementing the TTL field at each hop until the packet reaches its destination or expires.

## Why it matters
Attackers exploit routing to perform **IP spoofing** — forging the source IP address in packet headers to impersonate trusted hosts or obscure their origin. In a Smurf attack, an attacker sends ICMP echo requests to a broadcast address with a spoofed source IP (the victim's), causing hundreds of devices to flood the victim with replies — an amplification DDoS rooted entirely in how routers blindly forward packets without verifying source addresses.

## Key facts
- IPv4 addresses are 32-bit, expressed in four octets (e.g., 192.168.1.1); routing decisions use the **network portion** determined by the subnet mask
- The **TTL (Time to Live)** field prevents infinite loops — routers decrement it by 1 each hop; when it hits 0, the packet is dropped and an ICMP "Time Exceeded" message is sent back
- **Longest prefix match** wins: a route to 10.0.0.0/24 beats 10.0.0.0/8 for a packet destined to 10.0.0.5
- **Default routes** (0.0.0.0/0) act as a catch-all; traffic with no specific match is forwarded there — often toward the internet gateway
- Route poisoning and **BGP hijacking** can manipulate routing tables to redirect traffic through attacker-controlled infrastructure (e.g., the 2010 China Telecom incident)

## Related concepts
[[IP Spoofing]] [[Subnetting and CIDR]] [[BGP Hijacking]]
