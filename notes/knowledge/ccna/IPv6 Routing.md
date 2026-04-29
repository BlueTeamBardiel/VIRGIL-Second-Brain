# IPv6 Routing
**Tagline:** Master IPv6 packet forwarding and static route configuration—the foundation for dynamic routing protocols you'll encounter in advanced studies.

---

## Overview

IPv6 routing operates on the same fundamental principles as [[IPv4 Routing]], but with critical differences in how devices discover neighbors and resolve Layer 3 addresses to Layer 2 MAC addresses. This chapter covers three core concepts:

1. **[[Neighbor Discovery Protocol]]** (NDP) — IPv6's replacement for [[ARP]]
2. **IPv6 routing table interpretation** — how routers make forwarding decisions
3. **Static IPv6 route configuration** — manual route entry for IPv6 networks

**Important context:** The CCNA exam covers IPv6 static routing only. Dynamic routing protocols like [[OSPFv3]] are outside exam scope (OSPFv2 supports IPv4 only).

---

## 21.1 Neighbor Discovery Protocol (NDP)

### Core Concept (Simple First)

Think of NDP like a postal worker (your router) trying to deliver a package. The worker has a street address (IPv6 address) but needs to know which house number (MAC address) corresponds to that street. In IPv4, they'd use ARP—a broadcast "hey, who lives at this address?" In IPv6, they're smarter: they call out to a specific group chat (multicast) of devices at that address instead of yelling to the whole neighborhood (broadcast). That's NDP.

### Why IPv6 Doesn't Use ARP

- IPv4 uses **broadcast** to reach all hosts on a segment
- IPv6 has **no broadcast mechanism** (by design)
- IPv6 uses **multicast** instead—specifically [[solicited-node multicast addresses]]
- Result: More efficient, no broadcast storms, reduced traffic on local links

---

### 21.1.1 Solicited-Node Multicast Addresses

A **solicited-node multicast address** is a special link-local multicast address derived from a unicast address. It allows NDP to target a specific host without broadcasting.

#### Formula for Generating Solicited-Node Multicast Address

```
Solicited-node multicast address = ff02::1:ff + [last 6 hex digits of unicast address]
```

| Unicast Address | Last 6 Hex Digits | Solicited-Node Multicast |
|---|---|---|
| `2001:db8:123::1` | `00:00:01` | `ff02::1:ff00:1` |
| `fd12:3456:78:1df:ac80:0:3ab:fff1` | `3a:b:ff:f1` | `ff02::1:ffab:fff1` |
| `fe80::99ff:fe12:1234` | `12:12:34` | `ff02::1:ff12:1234` |
| `2001:db8:1:1::1` | `00:00:01` | `ff02::1:ff00:1` |

#### Example: Breaking Down a Real Address

```
Unicast: 2001:DB8:1:1::1
         └─────────────┬─────────────┘  ├─ Last 6 hex digits: 00 00 1
                                        
Solicited-node: ff02::1:ff + 00:01 = ff02::1:ff00:1
```

**Key detail:** The scope is always **link-local** (indicated by `ff02`). This means the multicast traffic never leaves the local network segment.

#### Automatic Group Memberships

When a router enables IPv6 on an interface, it automatically joins three multicast groups:
- `ff02::1` — All IPv6 nodes (link-local scope)
- `ff02::2` — All IPv6 routers (link-local scope)
- `ff02::1:ff[last 6 hex]` — Solicited-node multicast for each unicast address

**Lab observation:**
```
R1# show ipv6 interface g0/0
IPv6 is enabled, link-local address is FE80::2D0:97FF:FE92:B401
Global unicast address(es):
2001:DB8:1:1::1, subnet is 2001:DB8:1:1::/64
Joined group address(es):
FF02::1              ← All nodes
FF02::2              ← All routers
FF02::1:FF00:1       ← Solicited-node for global unicast 2001:DB8:1:1::1
FF02::1:FF92:B401    ← Solicited-node for link-local FE80::2D0:97FF:FE92:B401
```

---

### 21.1.2 Address Resolution with NDP

#### The NDP Process

NDP uses two [[ICMPv6]] message types for address resolution:

| Message Type | ICMPv6 Type | Function | Equivalent |
|---|---|---|---|
| **Neighbor Solicitation (NS)** | 135 | Request: "What's your MAC?" | ARP Request |
| **Neighbor Advertisement (NA)** | 136 | Reply: "My MAC is..." | ARP Reply |

#### Step-by-Step NDP Exchange

```
R1 (needs R2's MAC address)
  │
  ├─→ Sends Neighbor Solicitation (NS)
      Source IP: 2001:db8::1 (R1's global unicast)
      Destination IP: ff02::1:ff00:2 (R2's solicited-node multicast)
      Target Address field: 2001:db8::2 (R2's unicast address)
      Payload: "Who has 2001:db8::2?"
  │
R2 (receives NS, recognizes its own address in Target field)
  │
  └←─ Sends Neighbor Advertisement (NA) — UNICAST (not multicast)
      Source IP: 2001:db8::2 (R2's global unicast)
      Destination IP: 2001:db8::1 (R1's unicast — direct reply)
      Payload: "I have 2001:db8::2, my MAC is 5254.000a.fc35"
```

**Critical difference from ARP:**
- NS goes to **solicited-node multicast** (not broadcast)
- NA is **unicast** (not broadcast like ARP reply)
- Result: Only the target router responds; others ignore the message

#### Neighbor Table Storage

IPv6 devices store L3-to-L2 mappings in the **IPv6 neighbor table** (not ARP table). View it with:

```
show ipv6 neighbors
```

**Example output after pinging:**
```
R1# ping 2001:db8::2
!!!!!
Success rate is 100 percent (5/5)

R1# show ipv6 neighbors
IPv6 Address         Age  Link-layer Addr  State Interface
2001:DB8::2          0    5254.000a.fc35   REACH Gi0/0
FE80::1              0    5254.000a.fc35   REACH Gi0/0
```

Note: R1 automatically learned FE80::1 (R2's link-local address) through NDP even though we only pinged the global unicast address.

#### Handling Overlapping Solicited-Node Addresses

**Problem scenario:**
```
Host A: 2001:db8:1:1::1100:1234/64
Host B: 2001:db8:1:1::2200:1234/64

Both generate the same solicited-node address: ff02::1:ff00:1234
```

**Solution:** The NS message includes a **Target Address field** in its payload containing the specific unicast address being requested. Hosts examine this field and only respond if the Target Address matches their own address.

---

## 21.1.3 Router Discovery

### How Hosts Learn Default Gateways

IPv6 hosts can dynamically discover routers on their link without manual configuration. This is **Router Discovery**, another NDP function.

#### Two New ICMPv6 Message Types

| Message | Type | Direction | Purpose |
|---|---|---|---|
| **Router Solicitation (RS)** | 133 | Host → Routers | "Is anyone out there?" |
| **Router Advertisement (RA)** | 134 | Router → Hosts | "I'm here, here's my info" |

#### Router Advertisement (RA) Process

1. **Hosts send RS** (Router Solicitation):
   - Destination: `ff02::2` (all routers multicast)
   - Asks: "Any routers on this link?"

2. **Routers send RA** (Router Advertisement):
   - Destination: `ff02::1` (all nodes multicast)
   - Sent periodically even without RS (default: every 200 seconds)
   - Contains:
     - Router's link-local address (source of RA)
     - Prefix information (network addresses available)
     - Hop limit, MTU, and other configuration flags

3. **Hosts process RA**:
   - Learn the router's link-local address as default gateway
   - Learn available prefixes for address autoconfiguration

**Key advantage:** IPv6 hosts can configure themselves without DHCP for address assignment.

---

### 21.1.4 Duplicate Address Detection (DAD)

### Purpose

Before using an IPv6 address, a host must verify that no other device on the link uses the same address. This is **Duplicate Address Detection (DAD)**.

#### DAD Process

1. **Host generates an address** (link-local or through SLAAC)
2. **Host sends NS** to the address's solicited-node multicast:
   - Source IP: `::` (unspecified address — "I don't have an address yet")
   - Target Address: The address being tested
3. **Listen for NA responses:**
   - If NA received: Address is in use, host must use different address
   - If timeout with no NA: Address is unique, safe to use

**Lab observation:**
```
R1# conf t
R1(config)# ipv6 address 2001:db8:1:1::1/64
R1(config-if)# end
R1# show ipv6 interface g0/0
IPv6 is enabled, link-local address is FE80::...
Global unicast address(es):
2001:DB8:1:1::1, subnet is 2001:DB8:1:1::/64 (tentative)
```

Notice `(tentative)` — the address is undergoing DAD. After the DAD waiting period (~1 second), it becomes `(valid)`.

---

## 21.2 IPv6 Routing Table

### Structure and Components

The IPv6 routing table is conceptually identical to the IPv4 routing table. Routers use it to make forwarding decisions.

#### Display the IPv6 Routing Table

```
show ipv6 route
```

**Example output:**
```
R1# show ipv6 route
IPv6 Routing Table - default - 3 entries
Codes: C - Connected, L - Local, S - Static, R - RIPng, B - BGP
       IA - ISIS Interarea, IS - ISIS, EX - EIGRP External, O - OSPF Intra
       OI - OSPF Inter, OE - OSPF External, ON1 - OSPF NSSA External Type 1
       ON2 - OSPF NSSA External Type 2
C   2001:DB8:1:1::/64 [0/0]
     via FE80::1, GigabitEthernet0/0
L   2001:DB8:1:1::1/128 [0/0]
     via ::, GigabitEthernet0/0
S   2001:DB8:2:2::/64 [1/0]
     via FE80::1, GigabitEthernet0/0
```

### Entry Components

| Component | Example | Meaning |
|---|---|---|
| **Route source code** | `C`, `L`, `S` | Connected, Local, Static |
| **Destination prefix** | `2001:DB8:1:1::/64` | Network address and prefix length |
| **Administrative

---
*Source: Acing the CCNA Exam, Volume 1, Chapter 21 | [[CCNA]]*