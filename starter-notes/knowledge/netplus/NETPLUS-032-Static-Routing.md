---
tags: [knowledge, netplus, network-plus]
created: 2026-05-01
cert: CompTIA Network+
exam: N10-009
chapter: 032
source: rewritten
---

# Static Routing
**A manually configured method where administrators explicitly define the path packets take across networks.**

---

## Overview
Static routing is the foundational mechanism that allows [[routers]] to intelligently move data between different [[IP subnets]]. Understanding how routers make forwarding decisions—examining destination addresses and consulting routing tables—is critical for the Network+ exam because it underpins how modern networks actually communicate. While dynamic routing protocols automate this process, static routing reveals the core logic that every router uses.

---

## Key Concepts

### Packet Forwarding Process
**Analogy**: Imagine a postal worker examining an envelope's address, consulting a delivery map, and deciding which truck to put it on—each truck driver repeats the process until the letter reaches its destination.

**Definition**: The sequential steps a [[router]] performs when deciding where to send incoming traffic: examining the destination [[IP address]], consulting the [[routing table]], and selecting the appropriate outbound [[interface]].

| Step | Action | Example |
|------|--------|---------|
| 1 | Read destination IP from packet header | 192.168.2.50 |
| 2 | Consult routing table | Find matching entry |
| 3 | Determine next hop or direct delivery | Send to 10.0.0.1 or local subnet |
| 4 | Forward out appropriate interface | Ethernet 0/1 |

---

### Destination IP Address Examination
**Analogy**: A mailroom clerk reads the ZIP code before deciding which regional distribution center to route the package toward.

**Definition**: The router extracts and analyzes the destination [[IP address]] from every incoming packet header to determine the packet's ultimate target [[network]].

---

### Local vs. Remote Subnets
**Analogy**: If the destination address is in your own neighborhood, you deliver it directly; if it's across town, you send it to the regional hub.

**Definition**: A router checks whether the destination subnet is directly connected ([[directly connected network]]) or requires forwarding through other routers ([[remote network]]).

| Scenario | Router Behavior | Next Step |
|----------|-----------------|-----------|
| Destination on locally connected subnet | Direct delivery | Send directly to destination host |
| Destination on remote subnet | Consult routing table | Forward to next hop router |
| No matching route found | Drop packet | Generate ICMP Destination Unreachable |

---

### Routing Table
**Analogy**: Think of it as a postal delivery guide listing every possible destination and which truck route delivers packages there most efficiently.

**Definition**: A stored database on the [[router]] that maps destination networks (or hosts) to their corresponding [[next hop]] addresses and outbound [[interfaces]].

```
Destination Network    Next Hop        Interface
10.0.0.0/24           Direct          Eth0/0
192.168.0.0/24        10.1.1.1        Eth0/1
172.16.0.0/16         10.1.1.2        Eth0/1
0.0.0.0/0             10.1.1.1        Eth0/1 (default route)
```

---

### Next Hop
**Analogy**: The address of the next relay station that will move your package one step closer to its destination.

**Definition**: The [[IP address]] of the immediately adjacent [[router]] interface where packets are forwarded when the destination subnet is not directly connected.

---

### Static Routing Configuration
**Analogy**: You personally decide every delivery route and write it down in a book that never changes unless you manually update it.

**Definition**: Administrators manually enter routes into the routing table via command-line interface (CLI) or network management software; routes remain fixed until manually modified.

```
[Router CLI Example]
router(config)# ip route 192.168.2.0 255.255.255.0 10.0.0.1
router(config)# ip route 172.16.0.0 255.255.0.0 10.0.0.2
router(config)# ip route 0.0.0.0 0.0.0.0 10.0.0.1
```

**Components**:
- **Destination Network**: Target [[subnet]] (e.g., 192.168.2.0)
- **Subnet Mask**: Range of IPs within that destination (e.g., 255.255.255.0)
- **Next Hop IP**: Where to forward packets (e.g., 10.0.0.1)

---

### Default Route
**Analogy**: The "catch-all" mailbox for packages going to addresses not listed in your specific delivery guide.

**Definition**: A static route with the destination 0.0.0.0/0 that matches any traffic without a more specific route; packets destined for unknown networks use this fallback path.

```
ip route 0.0.0.0 0.0.0.0 10.0.0.1
```

---

### Route Lookup and Longest Prefix Match
**Analogy**: When checking your delivery map, you use the most detailed (longest) address match available before falling back to broader categories.

**Definition**: When multiple routes could match a destination, the [[router]] selects the route with the longest (most specific) [[subnet mask]] before using less specific or default routes.

| Destination | Route 1 | Route 2 | Route 3 | Selected |
|-------------|---------|---------|---------|----------|
| 192.168.2.50 | 192.168.2.0/24 | 192.168.0.0/16 | 0.0.0.0/0 | /24 (most specific) |

---

## Exam Tips

### Question Type 1: Route Selection and Next Hop Determination
- *"A router receives a packet destined for 172.16.5.100. Its routing table contains 172.16.5.0/24 via 10.1.1.1 and 172.16.0.0/16 via 10.1.1.2. Which next hop will be used?"* → 10.1.1.1 (longest prefix match: /24 is more specific than /16)
- **Trick**: Candidates often choose the first matching route instead of the longest (most specific) matching route.

### Question Type 2: Directly Connected vs. Static Routes
- *"A router has Ethernet 0/0 configured with 192.168.1.0/24. Does the router need a static route for 192.168.1.50?"* → No; it's a directly connected network and the router automatically knows how to reach it.
- **Trick**: Test-takers forget that directly connected subnets don't require manual route entries.

### Question Type 3: Default Route Behavior
- *"If no route matches a destination IP, what does the router do?"* → Either forwards to the default route (if configured) or drops the packet and sends an ICMP Destination Unreachable message.
- **Trick**: Confusing what happens when a route exists but is down (uses alternate path) versus no route existing at all (uses default or drops).

### Question Type 4: Static vs. Dynamic Routing Context
- *"Which routing method requires manual configuration and does NOT automatically adapt to network changes?"* → Static routing.
- **Trick**: Understanding when static routing is preferred (small networks, high control, lower overhead) versus when [[dynamic routing protocols]] are necessary.

---

## Common Mistakes

### Mistake 1: Assuming All Routes Are Configured Automatically
**Wrong**: "The router will figure out where to send packets without any route entries."
**Right**: Static routes must be manually entered; the router only knows about directly connected subnets and explicitly configured routes.
**Impact on Exam**: Questions about why a router cannot reach a destination often hinge on missing or incorrect static route entries. Missing a single route entry in a multi-network topology will cause connectivity failure.

---

### Mistake 2: Forgetting That Directly Connected Networks Require No Static Routes
**Wrong**: "I need to create a static route for every subnet the router has an interface on."
**Right**: [[Directly connected networks]] are automatically in the routing table; only remote subnets require static route entries.
**Impact on Exam**: Candidates waste time configuring unnecessary routes or misdiagnose connectivity issues by not recognizing that direct connections are inherent.

---

### Mistake 3: Misunderstanding Longest Prefix Match
**Wrong**: "The router uses the first matching route it finds in the table."
**Right**: The router selects the route with the longest (most specific) [[subnet mask]], regardless of its position in the table.
**Impact on Exam**: Route selection questions often include overlapping destinations to test whether you understand that /25 is more specific than /24, and will be selected even if /24 is listed first.

---

### Mistake 4: Confusing Next Hop with Destination
**Wrong**: "The next hop IP is the final destination of the packet."
**Right**: The next hop is the IP address of the next router's interface; the destination remains unchanged across hops.
**Impact on Exam**: Tracing packet flow across multiple routers requires understanding that each hop moves the packet closer but doesn't change the original destination address.

---

### Mistake 5: Not Recognizing When a Default Route Is Essential
**Wrong**: "Static routing requires listing every possible destination network."
**Right**: A default route (0.0.0.0/0) handles all unspecified destinations, reducing configuration burden.
**Impact on Exam**: Scenarios with stub networks (networks that only connect to one upstream router) almost always require a default route for traffic exiting the network.

---

## Related Topics
- [[Dynamic Routing Protocols]]
- [[Routing Table]]
- [[Next Hop]]
- [[Directly Connected Networks]]
- [[IP Subnets]]
- [[Router]]
- [[ICMP Destination Unreachable]]
- [[Longest Prefix Match]]
- [[Subnet Mask]]
- [[Default Route]]
- [[Network Interface Card (NIC)]]

---

*Source: Professor Messer CompTIA Network+ N10-009 | [[Network+]]*