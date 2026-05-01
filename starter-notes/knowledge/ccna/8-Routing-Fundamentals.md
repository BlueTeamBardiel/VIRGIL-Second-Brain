---  
tags: [knowledge, ccna, chapter-8]  
created: 2026-04-30  
cert: CCNA  
chapter: 8  
source: rewritten  
---  

# 8. Routing Fundamentals  
**[Routing is the science of learning where packets should go and then sending them accordingly, like a GPS for data.]**

---

## Routing Overview

### Defining Routing  

**Analogy**: Imagine a delivery truck driver who first checks a map to know where each package belongs, then follows that map to drop each package at the correct address.  

**Routing**: The process by which a device builds a [[routing table]] (the map) and then forwards packets based on that table.  

---

## Host Packet Transmission

### Same Subnet Delivery  

**Analogy**: Two friends in the same apartment building just hand a letter directly to each other without involving the building's mailroom.  

**Same Network (No Router Needed)**:  
- Packet destination IP = destination host IP.  
- Frame destination MAC = destination host MAC.  
- No router is part of the path.  
- If the MAC isn’t known, the host uses [[ARP]] to learn it.

---

### Different Subnet Delivery  

**Analogy**: Sending a letter to a friend in another city requires passing it through the city’s postal hub (default gateway).  

**Different Network (Router Required)**:  
- Packet destination IP = final destination IP.  
- Frame destination MAC = default gateway’s MAC.  
- The host forwards the packet to its default gateway, which then handles the next hop.  
- **Key rule**: Hosts never send frames directly to remote hosts; they always go to their default gateway.

---

### Default Gateway Basics  

**Analogy**: Think of the default gateway as a local post office address that all outgoing mail must carry.  

**Default Gateway**:  
- Configured as an IP address (not a MAC).  
- Obtained via manual setup or most commonly via [[DHCP]].  
- Its MAC address is discovered with [[ARP]].  

**Windows check**:  
```bash
ipconfig
```

---

## Router Forwarding Process

### What a Router Does When It Receives a Frame  

**Analogy**: A mail sorting facility receives a letter, reads the envelope to see the destination, and then chooses the right outgoing truck based on the sorting map.  

**Steps**:  
1. Frame arrives addressed to the router’s MAC.  
2. Router removes the Ethernet header (de-encapsulates).  
3. Examines the destination IP.  
4. Looks up that IP in its [[routing table]].  
5. Takes one of three actions:  
   - **Forward** to the next hop.  
   - **Receive** the packet for itself (if it belongs to the router).  
   - **Drop** the packet if no route matches.  
**Routers never flood packets** across interfaces.  

---

## Routing Table Essentials

### What the Routing Table Is  

**Analogy**: The routing table is like a city’s traffic control system, telling drivers which street to take to reach their destination.  

**Routing Table**: A set of instructions that directs packet forwarding.  
Command to view:  
```bash
show ip route
```

---

### Automatic Route Types  

| Route Type | Symbol | Description | Example |
|------------|--------|-------------|---------|
| Connected Route | C | The router knows a network directly through an up interface | `C 192.168.1.0/24` via G0/0 |
| Local Route | L | The router has an IP address on an interface (host route) | `L 192.168.1.1/32` via G0/0 |

**Network Route vs Host Route**  
- **Network route**: prefix < /32 (covers many IPs).  
- **Host route**: prefix = /32 (single IP).  

---

### Route Selection Logic  

**Analogy**: When several routes are available, the driver chooses the one that gets them closest to the destination with the least detours.  

**Rule**: The router picks the **longest prefix match** (most specific).  
- /32 > /24 > /16 > /0 (default).  

---

### Router Decision Outcomes  

| Destination | Action | Reason |
|-------------|--------|--------|
| Matches non‑local route | Forward | Packet goes to next hop |
| Matches local route | Receive | Packet is for the router |
| No match | Drop | No path known |

---

### Layer 3 vs Layer 2  

| Layer | Matching Basis | Example |
|-------|----------------|---------|
| L3 (Router) | Longest‑prefix IP match | /24, /16 |
| L2 (Switch) | Exact MAC address match | 00:1A:2B:3C:4D:5E |

---

## Static Routing

### Why Use Static Routes  

**Analogy**: A small town’s postmaster writes explicit instructions on where each type of mail should go, ensuring predictability without relying on a dynamic system.  

**Static Routing**: Manually configured routes that are predictable, exam‑heavy, and common in labs or small networks.  

---

### Next Hop Concept  

**Analogy**: Sending a letter to a distant city by handing it to a courier who knows the next city to forward it to.  

- The router forwards to the next router’s IP (next hop).  
- The frame’s MAC is the next hop’s MAC.  
- The packet’s IP stays unchanged all the way to the destination.  
- Only routes to the source and destination networks are needed.  

---

### Static Route Types  

#### 1) Recursive Static Route (Most Common)  

**Analogy**: A mailman checks the destination address, then looks up the next courier’s address before sending the package.  

**Command**:  
```bash
ip route <network> <mask> <next-hop-ip>
```
Example:  
```bash
ip route 192.168.3.0 255.255.255.0 192.168.12.2
```
*Why recursive?* The router looks up the network and then the next‑hop IP to decide which interface to use.  

---

#### 2) Directly Connected Static Route (Avoid in Practice)  

**Analogy**: A mailman mistakenly thinks all mail for a city is in his own post office and attempts to deliver it himself.  

**Command**:  
```bash
ip route <network> <mask> <exit-interface>
```
Example:  
```bash
ip route 192.168.3.0 255.255.255.0 g0/0
```
*Problems*: Proxy ARP required, many ARP entries, fails if proxy ARP disabled. Use only for exam knowledge.  

---

#### 3) Fully Specified Static Route (Best of Both)  

**Analogy**: The mailman has a clear list: deliver to the next courier at address X via corridor Y.  

**Command**:  
```bash
ip route <network> <mask> <exit-interface> <next-hop>
```
Example:  
```bash
ip route 192.168.3.0 255.255.255.0 g0/0 192.168.12.2
```
*Benefits*: No recursion, no proxy ARP, deterministic.  

---

### Default Route  

**Analogy**: A “go anywhere” sign that says, “If you don’t know where else to send this, send it to this address.”  

**Definition**: Destination `0.0.0.0/0` matches every IP address and is used only when no more specific route exists.  

**Command**:  
```bash
ip route 0.0.0.0 0.0.0.0 <next-hop>
```
Example:  
```bash
ip route 0.0.0.0 0.0.0.0 203.0.113.2
```

---

## Exam Tips

### Question Type 1: Routing and Forwarding  
- *"Which statement best explains why a host sends a frame to its default gateway when the destination is outside its subnet?"* → **Because the host has no route to the remote network and relies on the gateway to forward it.**  
- **Trick**: Some questions include “the gateway’s IP address” as an answer; remember the frame’s destination is the gateway’s **MAC**.

### Question Type 2: Static Routing Commands  
- *"What is the correct command to create a recursive static route for network 10.0.1.0/24 via next-hop 192.168.1.2?"* → `ip route 10.0.1.0 255.255.255.0 192.168.1.2`  
- **Trick**: Don’t confuse the mask format (255.255.255.0 vs /24) or the order of parameters.

### Question Type 3: Route Selection  
- *"Which route will be chosen when both a /24 and a /16 match the destination IP?"* → The /24 route (longest prefix).  
- **Trick**: Some questions list /0; remember that /0 is the least specific and used only if no better match exists.

---

## Common Mistakes

### Mistake 1: Confusing Default Gateway IP with MAC  

**Wrong**: “I can send frames directly to any remote IP as long as I know the gateway’s IP address.”  

**Right**: Frames are addressed to the gateway’s **MAC**; the IP is used only for the packet header. The host uses ARP to resolve the gateway’s MAC.  

**Impact on Exam**: Misunderstanding this leads to incorrect answers about host forwarding behavior and ARP usage.

---

## Related Topics
- [[IP Addressing]]
- [[Subnetting]]
- [[Routing Protocols]]
- [[Switching Fundamentals]]

---
*Source: CCNA 200-301 Study Notes | [[CCNA]]*