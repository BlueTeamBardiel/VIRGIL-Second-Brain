# Dynamic Routing with EIGRP

## What it is
Like a delivery driver who constantly texts other drivers about traffic jams and recalculates the fastest route in real time, EIGRP (Enhanced Interior Gateway Routing Protocol) is a Cisco-proprietary hybrid routing protocol that shares topology updates only when changes occur, using the DUAL algorithm to calculate loop-free paths and maintain backup routes instantly.

## Why it matters
An attacker with access to a network segment can inject fraudulent EIGRP Hello packets or route advertisements — a technique called **route injection** — to redirect traffic through a malicious router, enabling man-in-the-middle interception of sensitive data. Configuring EIGRP MD5 or SHA-256 neighbor authentication prevents unauthorized routers from participating in route advertisements and stops this attack cold.

## Key facts
- EIGRP uses **DUAL (Diffusing Update Algorithm)** to guarantee loop-free paths and provide instant failover using a pre-calculated Feasible Successor route
- Unlike OSPF, EIGRP is **classless and Cisco-proprietary** (though an open standard RFC 7868 exists), making it common in enterprise Cisco environments
- EIGRP neighbor authentication uses **MD5 or SHA-256** key chains — absence of authentication is a critical misconfiguration and exam red flag
- EIGRP sends **partial, bounded updates** only when topology changes occur, reducing bandwidth overhead compared to distance-vector protocols that send full routing tables periodically
- Default **administrative distance for EIGRP is 90** (internal) and 170 (external), lower than OSPF (110), meaning EIGRP routes are preferred when both protocols exist

## Related concepts
[[OSPF Security]] [[Route Injection Attacks]] [[Network Authentication Protocols]]