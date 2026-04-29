# IPv4 address space

## What it is
Think of IPv4 addresses like a city's street address system — except the entire city only has about 4.3 billion possible addresses, and they've all been claimed. Precisely, IPv4 uses 32-bit binary numbers written in dotted-decimal notation (e.g., 192.168.1.1), divided into network and host portions by a subnet mask. The total addressable space spans 0.0.0.0 to 255.255.255.255, yielding exactly 2³² (4,294,967,296) unique addresses.

## Why it matters
IPv4 exhaustion drove widespread NAT adoption, which obscures internal network topology — a fact attackers exploit and defenders rely on differently. During a penetration test, discovering that 10.0.0.0/8 is in use immediately tells you the organization's internal range is RFC 1918 private space, meaning those addresses are unreachable from the internet directly. Misconfigured NAT or firewall rules that accidentally expose RFC 1918 addresses to public routing create phantom routes attackers can sometimes leverage in BGP hijacking scenarios.

## Key facts
- **Three private ranges (RFC 1918):** 10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16 — these are non-routable on the public internet
- **Special ranges to know:** 127.0.0.0/8 (loopback), 169.254.0.0/16 (APIPA/link-local), 0.0.0.0/8 (unspecified), 255.255.255.255 (broadcast)
- **IANA exhausted** its last IPv4 blocks in February 2011; regional registries (RIRs) followed shortly after
- **CIDR notation** (e.g., /24) replaced classful addressing (Class A/B/C) to slow exhaustion through efficient subnetting
- **Classful legacy:** Class A = /8, Class B = /16, Class C = /24 — still tested on Security+ despite being deprecated operationally

## Related concepts
[[Subnetting]] [[NAT (Network Address Translation)]] [[IPv6 address space]] [[CIDR notation]] [[BGP hijacking]]