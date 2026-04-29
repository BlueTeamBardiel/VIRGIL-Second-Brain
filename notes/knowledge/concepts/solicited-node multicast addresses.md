# solicited-node multicast addresses

## What it is
Like a postal system where instead of broadcasting "Does anyone know John Smith?" to the entire city, you only shout it down the one specific street where John Smiths tend to live — solicited-node multicast addresses let IPv6 nodes efficiently resolve MAC addresses without flooding the whole network. Every IPv6 device automatically joins a multicast group derived from the last 24 bits of its own IPv6 address, formatted as `FF02::1:FF00:0/104`. This replaces ARP's noisy broadcast mechanism with targeted multicast Neighbor Discovery Protocol (NDP) queries.

## Why it matters
Attackers who compromise a network segment can still perform IPv6 Neighbor Cache Poisoning by responding to NDP Neighbor Solicitation messages — the solicited-node multicast equivalent of ARP spoofing. A rogue device can intercept traffic by falsely claiming ownership of an IPv6 address before the legitimate host responds, enabling man-in-the-middle attacks even in "broadcast-free" IPv6 environments. Defenders use tools like NDPMon or RA Guard to detect anomalous NDP responses targeting these multicast groups.

## Key facts
- Solicited-node multicast address format: `FF02::1:FF` + last 24 bits of the target IPv6 address
- Defined in **RFC 4291**; used by NDP (RFC 4861) to replace IPv4 ARP
- Every IPv6 interface *automatically* joins its corresponding solicited-node multicast group upon address assignment
- Because multiple hosts can share the same last 24 bits, one multicast group may serve multiple nodes — reducing but not eliminating collision probability
- NDP poisoning attacks exploiting these addresses are not blocked by traditional ARP inspection tools; **IPv6-aware security controls are required**

## Related concepts
[[Neighbor Discovery Protocol]] [[IPv6 address types]] [[ARP spoofing]] [[Router Advertisement attacks]] [[man-in-the-middle attacks]]