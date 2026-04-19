# Routing Fundamentals
**Why it matters**: Routing is the foundational process that allows packets to traverse multiple networks. Understanding how routers build and use routing tables, and how to configure them manually, is essential for any network professional and critical for CCNA.

## 9.1 How End Hosts Send Packets

### Simple Explanation: The Mailbox Analogy
Think of routing like sending mail. If your neighbor lives on the same street (same network), you deliver it directly. If they live in another city (different network), you put it in your mailbox (default gateway) and the postal service (router) handles delivery.

### Local Network Communication
When a host sends a packet to another host in the **same network**:
- The source host performs a **subnet calculation** using [[Subnet Mask]] to determine if destination is local
- Encapsulates the packet in a [[Frame]] with the **destination host's MAC address**
- **No router involvement needed** — the packet goes directly to the destination

**Example (Figure 9.1)**:
- PC1 (192.168.1.11) → PC2 (192.168.1.12)
- Both in 192.168.1.0/24 network
- Frame destination MAC = PC2's MAC address
- Router R1 is not consulted

### Remote Network Communication
When a host sends a packet to a host in a **different network**:
- Host determines via [[Subnet Mask|subnet calculation]] that destination is remote
- Host **must know its [[Default Gateway]]** (typically first usable IP in network, e.g., 192.168.1.1)
- Encapsulates packet in frame addressed to **default gateway's MAC address**
- Router receives frame, de-encapsulates, and forwards toward destination

**Example (Figure 9.2)**:
- PC1 (192.168.1.11) → PC3 (192.168.2.11)
- PC1 and PC3 in separate networks (192.168.1.0/24 vs 192.168.2.0/24)
- PC1 sends frame to R1's G0/0 MAC address (default gateway)
- R1 forwards out G0/1 in new frame to PC3's MAC address
- **Packet's IP addresses never change** — only MAC addresses change at each hop

### Learning the Default Gateway

| Method | Details | Common Use |
|--------|---------|------------|
| **Manual Configuration** | Admin manually enters gateway IP on device | Servers, network devices |
| **[[DHCP]]** | Device automatically learns gateway, IP, DNS, etc. | PCs, laptops, smartphones |

**Windows Example**:
```
C:\Users\jmcdo> ipconfig
IPv4 Address. . . . . . . . . . . : 192.168.1.11
Subnet Mask . . . . . . . . . . . : 255.255.255.0
Default Gateway . . . . . . . . . : 192.168.1.1
```

### Critical Layer 2/Layer 3 Interaction
- **Packets are NEVER sent "naked" over the cable** — they must be encapsulated in frames
- Host uses [[ARP]] to learn the default gateway's **MAC address** from its **IP address**
- Default gateway is configured as an **IP address**, not a MAC address

---

## 9.2 The Basics of Routing

### Simple Explanation: The Post Office Sorting Process
A router's routing table is like a post office's sorting system. When mail arrives, staff look up the destination ZIP code and check a table to see which outgoing truck that mail goes on.

### The Routing Process (3 Steps)

**1. Frame Reception**
- Router receives frame on an interface
- Checks if destination MAC = router's own MAC
- If not, **discards frame** (not meant for this router)
- If yes, de-encapsulates to examine [[IP]] packet

**2. Routing Table Lookup**
- If packet's destination IP = router's own IP address → **process locally** (e.g., SSH session)
- If packet's destination IP ≠ router's own IP → **must forward it**
- Router performs **longest prefix match** (most specific route) lookup in [[Routing Table]]
- If route found → forward packet out specified interface
- If no route found → **discard packet** (packet reaches a dead end)

**3. Frame Re-encapsulation and Forwarding**
- Router de-encapsulates packet from incoming frame
- Encapsulates packet in **new frame** with:
  - **New source MAC** = outgoing interface's MAC address
  - **New destination MAC** = next-hop device's MAC address
- Forwards frame out the outgoing interface specified in routing table
- **Original packet's IP addresses never change** across hops

### Understanding the Routing Table

A routing table is a database of known networks and how to reach them. Each entry contains:
- **Destination Network** — the network being routed to (e.g., 192.168.2.0/24)
- **Next Hop (Gateway)** — the IP address of the neighbor router to forward packets to
- **Outgoing Interface** — which interface the packet should be sent out on
- **Metric** — cost of the route (used to choose between multiple routes to same destination)

**Typical Routing Table Entry**:
```
Destination: 192.168.2.0/24
Next Hop: 192.168.2.1
Interface: G0/1
Metric: 0
```

### Routes Can Be Learned Three Ways

| Method | How Learned | Who Maintains | Common Use |
|--------|------------|---------------|-----------|
| **Connected** | Automatically (interface is on that network) | Router (automatic) | Direct subnets on router interfaces |
| **Static** | Administrator manually enters route | Administrator | Small networks, specific paths, default routes |
| **Dynamic** | Learned via [[Routing Protocol|routing protocols]] ([[RIP]], [[OSPF]], [[EIGRP]], [[BGP]]) | Routing protocol daemon | Large networks, redundancy, automation |

---

## 9.3 Configuring Static Routes

### Simple Explanation: The Hand-Drawn Map
Static routing is like giving someone a hand-drawn map to a specific destination. You tell them exactly which way to go. It doesn't adapt if roads change — someone must redraw the map.

### Static Route Basics
- **Manually configured by administrator** using Cisco IOS commands
- Does **not adapt** if network changes (unlike dynamic routing protocols)
- Useful for:
  - Small networks with few routes
  - Specific routing policy requirements
  - Backup routes
  - **Default routes** (route of last resort)
- Requires **manual update** if network topology changes

### Default Routes

A **default route** is a static route that matches all destinations. It's a route of last resort — used when no more specific route is found.

**Default route characteristics**:
- Destination: **0.0.0.0/0** (matches any IP address)
- Used when no other route matches a packet's destination
- Commonly used to point toward the **internet**
- Typically has the **lowest priority** (highest metric)

**Example**: A small branch office with one internet connection uses a default route to send all unknown traffic toward the main office or ISP.

### Static Route Configuration

**IPv4 Static Route Syntax**:
```
ip route <destination-network> <netmask> {<next-hop-ip> | <exit-interface>} [metric]
```

**Parameters**:
- `<destination-network>` — Network to route to (e.g., 192.168.2.0)
- `<netmask>` — Subnet mask in dotted decimal (e.g., 255.255.255.0)
- `<next-hop-ip>` — IP address of neighbor router interface
- `<exit-interface>` — Local interface to send packet out
- `[metric]` — Administrative distance (optional, default varies)

**Common Static Route Examples**:

**Example 1: Route to remote network via next-hop IP**
```
R1(config)# ip route 192.168.2.0 255.255.255.0 192.168.1.2
```
- Packets destined for 192.168.2.0/24 are sent to router at 192.168.1.2

**Example 2: Default route via next-hop IP**
```
R1(config)# ip route 0.0.0.0 0.0.0.0 10.0.0.1
```
- All packets not matching specific routes are sent to 10.0.0.1 (typically ISP gateway)

**Example 3: Route via exit interface** (useful for point-to-point links)
```
R1(config)# ip route 192.168.3.0 255.255.255.0 G0/1
```
- Packets destined for 192.168.3.0/24 are sent out interface G0/1

**Example 4: Default route via exit interface**
```
R1(config)# ip route 0.0.0.0 0.0.0.0 S0/0
```
- All unknown packets are sent out serial interface S0/0

### IPv6 Static Routes

**IPv6 Static Route Syntax**:
```
ipv6 route <destination-network/prefix-length> {<next-hop-ipv6> | <exit-interface>} [metric]
```

**IPv6 Static Route Examples**:

```
R1(config)# ipv6 route 2001:db8:2::/64 2001:db8:1::2
```
- Route IPv6 packets destined for 2001:db8:2::/64 to 2001:db8:1::2

```
R1(config)# ipv6 route ::/0 2001:db8::1
```
- IPv6 default route (matches any IPv6 address) to 2001:db8::1

### Verifying Static Routes

**View routing table**:
```
R1# show ip route
```

**Output interpretation**:
- `S` = Static route (manually configured)
- `C` = Connected route (directly connected network)
- `O` = OSPF learned route
- Numbers in brackets = [Administrative Distance / Metric]

**Example output**:
```
S   192.168.2.0/24 [1/0] via 192.168.1.2
C   192.168.1.0/24 is directly connected, GigabitEthernet0/0
S*  0.0.0.0/0 [1/0] via 10.0.0.1
```

**View specific route details**:
```
R1# show ip route 192.168.2.0
```

**Verify route is being used**:
```
R1# ping 192.168.2.11
R1# traceroute 192.168.2.11
```

---

## 9.4 Longest Prefix Match

### Simple Explanation: Most Specific Route Wins
If your router has routes for 192.168.0.0/16 AND 192.168.2.0/24, and a packet arrives for 192.168.2.11, the router chooses the more specific /24 route. Longer prefix = more specific = more precise routing.

### How Longest Prefix Match Works

When a router has **multiple routes that could match** a destination IP:
- Router chooses the route with the **longest prefix** (highest subnet mask bits)
- **Longer prefix = more specific = preferred**

**Example**:
Routing table has:
```
192.168.0.0/16 via 10.0.0.1
192.168.2.0/24 via 10.0.0.2
192.168.2.128/25 via 10.0.0.3
```

Packet destined for **192.168.2.150**:
- Matches 192.168.0.0/16? YES (192.168.x.x matches /16)
- Matches 192.168.2.0/24? YES (192.168.2.x matches /24)
- Matches 192.168.2.128/25? YES (192.168.2.128-255 matches /25)
- **Winner**: 192.168.2.128/25 (longest prefix = /25)
- Packet sent via 10.0.0.

---
*Source: Acing the CCNA Exam, Volume 1, Chapter 9 | [[CCNA]]*
