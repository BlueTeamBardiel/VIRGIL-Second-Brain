---
tags: [knowledge, ccna, chapter-0]
created: 2026-04-30
cert: CCNA
chapter: 0
source: rewritten
---

# Static Routing Configuration
**Manually teaching routers exactly where to send packets when they don't know the path themselves.**

---

## Fundamentals of Manual Route Programming

### Understanding Static Routes

**Analogy**: Think of static routing like giving a taxi driver turn-by-turn directions before they leave. You're telling them exactly which streets to take to reach each destination, rather than letting them figure it out on GPS. The driver (router) must follow YOUR directions (static routes) because you've told them the only way to get there.

**Static Route**: A manually configured path that tells a router "to reach this network, send packets out this interface or to this neighbor's IP address." Unlike dynamic routing, the router doesn't learn or adapt—it just follows your instructions exactly.

**Next-Hop IP Method**: Specifying the IP address of the neighboring router's interface that will receive the packet next. The local router then automatically determines which of its own interfaces leads to that neighbor.

**Exit Interface Method**: Specifying the exact outgoing interface on YOUR router that the packet should leave through. This method is particularly efficient on point-to-point links.

---

## Configuration Workflows Across a Three-Router Network

### Router 1 Setup (Single Route Needed)

**Analogy**: Router 1 only needs ONE set of directions because it only needs to reach ONE unknown network. It's like a mailman who only delivers to one neighborhood—simple and straightforward.

From global configuration mode, enter:

```
R1(config)# ip route 192.168.3.0 255.255.255.0 192.168.12.2
```

**Destination Network**: 192.168.3.0/24 (the network R1 cannot directly reach)
**Subnet Mask**: 255.255.255.0 (defines the network size)
**Next-Hop Address**: 192.168.12.2 (R2's interface facing R1)

Verify the configuration with:
```
R1# do show ip route
```

### Router 2 Setup (Dual Routes Required)

**Analogy**: Router 2 is the traffic hub—it sits in the middle and needs directions to TWO different networks. It's like a central post office that distributes mail in multiple directions.

From global configuration mode, configure the first route using exit interface:

```
R2(config)# ip route 192.168.1.0 255.255.255.0 G0/0
```

Then configure the second route using next-hop IP:

```
R2(config)# ip route 192.168.3.0 255.255.255.0 192.168.13.3
```

**Route 1 Details**:
- Uses exit interface method (G0/0)
- Points toward R1's network directly

**Route 2 Details**:
- Uses next-hop IP method (R3's address)
- Points toward R3's network

Verify with:
```
R2# do show ip route
```

### Router 3 Setup (Single Route Needed)

**Analogy**: Like Router 1, Router 3 only needs ONE direction—back toward the R1 network that exists on the opposite side of the network topology.

From global configuration mode:

```
R3(config)# ip route 192.168.1.0 255.255.255.0 192.168.13.2
```

**Destination Network**: 192.168.1.0/24
**Next-Hop Address**: 192.168.13.2 (R2's interface facing R3)

Verify with:
```
R3# do show ip route
```

---

## End-to-End Connectivity Validation

### Testing PC1 to PC2 Communication

Open command prompt on PC1 and execute:

```
C:\> ping 192.168.3.1
```

**Expected Behavior**:
- **First ping**: May timeout (ARP resolution required)
- **Subsequent pings**: Should receive replies successfully
- **Success indicator**: Reply messages confirm packets traversed all three routers correctly

---

## Comparison: Next-Hop vs. Exit Interface Methods

| **Characteristic** | **Next-Hop IP Method** | **Exit Interface Method** |
|---|---|---|
| **What you specify** | Neighbor router's IP address | Your router's outgoing interface |
| **Router's job** | Looks up next-hop IP, determines exit interface | Uses interface directly |
| **Flexibility** | Works on multi-access networks | Best for point-to-point links |
| **Example** | `ip route 192.168.3.0 255.255.255.0 192.168.13.3` | `ip route 192.168.1.0 255.255.255.0 G0/0` |
| **Processing overhead** | Slightly higher (one extra lookup) | Minimal (direct interface) |

---

## Exam Tips

### Question Type 1: Route Configuration Syntax
- *"Which command configures a static route to 10.0.0.0/24 via next-hop 172.16.1.1?"* → `ip route 10.0.0.0 255.255.255.0 172.16.1.1`
- **Trick**: Watch out for subnet mask format—CCNA uses dotted decimal, not CIDR notation in CLI commands.

### Question Type 2: Exit Interface vs. Next-Hop
- *"When should you use exit interface method instead of next-hop IP?"* → On point-to-point links (serial, PPP) to reduce lookup overhead and avoid ARP on multi-access segments.
- **Trick**: The exam sometimes shows "exit interface method" but the interface name is wrong (like using the remote interface instead of your own).

### Question Type 3: Verification Commands
- *"You've configured three static routes. Which command verifies all routes are in the routing table?"* → `show ip route` or `do show ip route` from config mode.
- **Trick**: Confusing `show ip route` with `show running-config`—only `show ip route` displays whether routes are actually active.

---

## Common Mistakes

### Mistake 1: Using Your Own Interface as Next-Hop
**Wrong**: `ip route 192.168.3.0 255.255.255.0 192.168.12.1` (where 192.168.12.1 is YOUR router's IP)
**Right**: `ip route 192.168.3.0 255.255.255.0 192.168.12.2` (where 192.168.12.2 is the NEIGHBOR's IP)
**Impact on Exam**: You'll fail connectivity tests and exam scenarios. The router becomes confused about where to send packets. This is caught immediately on practical labs.

### Mistake 2: Mixing Methods Incorrectly
**Wrong**: `ip route 192.168.3.0 255.255.255.0 G0/0 192.168.13.3` (specifying both interface AND next-hop)
**Right**: Choose ONE method: either `G0/0` OR `192.168.13.3`, not both in the same command.
**Impact on Exam**: Syntax error—command won't execute. Cisco IOS rejects this format.

### Mistake 3: Forgetting Reverse Routes
**Wrong**: Configuring R1→R3 route but forgetting R3→R1 route
**Right**: Ensure bidirectional connectivity—R1 needs path to R3, AND R3 needs path to R1
**Impact on Exam**: One-way communication looks like success initially, but exam scenarios test return traffic. Ping succeeds, traceroute fails. Highly testable on CCNA.

### Mistake 4: Misconfiguring Subnet Masks
**Wrong**: `ip route 192.168.3.0 255.255.255.128` (wrong mask for /24 network)
**Right**: `ip route 192.168.3.0 255.255.255.0`
**Impact on Exam**: Route matches wrong traffic. Packets intended for 192.168.3.0/24 might fail or go to wrong destination.

---

## Related Topics
- [[Dynamic Routing Protocols]] (contrast with static approach)
- [[Routing Table Operation]] (how routers use routes)
- [[Next-Hop Resolution]] (ARP and interface lookup)
- [[IP Routing Fundamentals]]
- [[CCNA Routing Configuration]]
- [[Point-to-Point Links]]
- [[Multi-Access Networks]]

---

*Source: CCNA 200-301 Study Notes | [[CCNA]] | Rewritten for deep comprehension*