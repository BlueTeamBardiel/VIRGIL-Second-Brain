# CIDR

## What it is
Think of CIDR like a pizza cutter — instead of slicing a network into rigid, pre-sized pieces (Class A/B/C), it lets you cut exactly how much IP space you need. Classless Inter-Domain Routing (CIDR) is a method for allocating IP addresses and routing that replaces the old class-based system, using a suffix notation (e.g., `192.168.1.0/24`) to indicate how many bits define the network portion of an address.

## Why it matters
Firewall rules and ACLs rely entirely on CIDR notation to define which traffic is permitted or denied — a misconfigured `/16` rule instead of `/24` could accidentally allow 65,534 hosts instead of 254 into a sensitive network segment. Attackers performing reconnaissance use CIDR blocks to scope their scans (e.g., `nmap 10.0.0.0/8`) and identify the full attack surface of an organization. CIDR also appears in BGP route hijacking attacks, where adversaries advertise more specific (smaller) CIDR blocks to intercept traffic.

## Key facts
- `/24` = 256 addresses (254 usable), `/16` = 65,536 addresses, `/32` = single host
- The CIDR suffix represents the number of **network bits** in the subnet mask (e.g., `/24` = `255.255.255.0`)
- CIDR replaced classful routing in 1993, dramatically slowing IPv4 exhaustion through efficient allocation
- Security tools like Shodan, nmap, and Nessus accept CIDR notation directly for scoping scans
- RFC 1918 private address spaces (`10.0.0.0/8`, `172.16.0.0/12`, `192.168.0.0/16`) are defined using CIDR notation — critical for firewall rule writing on Security+ exams

## Related concepts
[[Subnetting]] [[Firewall ACLs]] [[BGP Hijacking]] [[Network Reconnaissance]] [[IPv4 Addressing]]
