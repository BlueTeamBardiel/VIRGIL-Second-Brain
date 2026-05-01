---
tags: [knowledge, netplus, network-plus]
created: 2026-05-01
cert: CompTIA Network+
exam: N10-009
chapter: 035
source: rewritten
---

# Network Address Translation
**A mechanism that translates private IP addresses into public ones, solving IPv4 address exhaustion by allowing billions of devices to share limited public address space.**

---

## Overview
The Internet hosts tens of billions of connected devices—a number that grows daily. However, [[IPv4]] was designed with only approximately 4.3 billion possible addresses, and we've already distributed every single one. To enable this impossible scenario (more devices than addresses), networks rely on [[Network Address Translation (NAT)]] to convert internal private addresses into publicly routable ones on demand. Understanding NAT is critical for the Net+ exam because it underpins how modern home networks, corporate intranets, and cloud infrastructures function.

---

## Key Concepts

### Private IP Addresses
**Analogy**: Think of private IP addresses like apartment building numbers inside a gated community—they identify devices within that space perfectly, but delivery services won't find them from the outside world.

**Definition**: [[Private IP addresses]] are non-routable address blocks reserved for internal use only. Defined by [[RFC 1918]], these ranges never appear on the public [[Internet]] and allow organizations to build networks without coordination with [[IANA]].

**RFC 1918 Private Address Ranges**:

| Range | CIDR | Class | Use Case |
|-------|------|-------|----------|
| 10.0.0.0 – 10.255.255.255 | 10.0.0.0/8 | Class A | Large enterprises, data centers |
| 172.16.0.0 – 172.31.255.255 | 172.16.0.0/12 | Class B | Mid-size organizations, AWS default VPC |
| 192.168.0.0 – 192.168.255.255 | 192.168.0.0/16 | Class C | Home networks, small offices |

---

### Public IP Addresses
**Analogy**: Public IP addresses are like your street address and zip code—universally recognized and routable everywhere on the Internet.

**Definition**: [[Public IP addresses]] are globally unique, [[IANA]]-allocated addresses that are routable across the entire [[Internet]]. Every device communicating outside its private network needs one to send and receive traffic.

---

### Network Address Translation (NAT)
**Analogy**: NAT is like a receptionist at a large office building. Visitors send messages to the reception desk (public IP), the receptionist swaps out the return address with their own office number and forwards it to the correct department (private IP), then collects the responses and sends them back with the reception desk address to the outside caller.

**Definition**: [[NAT]] is a networking technique that rewrites the source and/or destination IP addresses in packet headers as traffic passes through a router or firewall. This allows multiple devices with private addresses to share a single public address or address pool.

**How NAT Works**:
1. Device on private network (10.1.1.5) sends packet destined for Internet
2. Packet reaches [[NAT router/firewall]]
3. Router translates source address from 10.1.1.5 → 203.0.113.4 (public IP)
4. Packet traverses Internet with public source address
5. Response returns to 203.0.113.4
6. Router translates destination back to 10.1.1.5
7. Internal device receives response

---

### Stateful NAT / NAT Translation Table
**Analogy**: The router keeps a diary recording every conversation—which internal employee made which external call—so it knows where to send incoming responses.

**Definition**: [[Stateful NAT]] maintains a dynamic [[translation table]] (connection tracking table) that maps internal private addresses and ports to external public addresses and ports. This allows the router to "remember" which internal device initiated each connection.

**Translation Table Example**:

```
Internal Address : Port  →  External Address : Port
10.1.1.5 : 54321         →  203.0.113.4 : 5001
10.1.1.7 : 54322         →  203.0.113.4 : 5002
10.1.1.9 : 54323         →  203.0.113.4 : 5003
```

---

### NAT Type: Static NAT
**Analogy**: Like assigning a permanent mailbox to one tenant in a building—8B always maps to 8B.

**Definition**: [[Static NAT]] creates a permanent one-to-one mapping between a private IP address and a public IP address. Every time that internal device communicates, it always uses the same public address.

**Use Cases**:
- Web servers that need consistent public addresses
- Mail servers
- VPN gateways
- Any service requiring a predictable external address

---

### NAT Type: Dynamic NAT
**Analogy**: Like a shared mailbox system where any letter from the office gets the next available outgoing address.

**Definition**: [[Dynamic NAT]] assigns public addresses from a pool on a temporary basis. When an internal device initiates a connection, it's assigned an available public address from the pool; when the connection closes, that public address returns to the pool for reuse.

**Key Characteristic**: No incoming connections can be initiated—only outbound traffic can be translated.

---

### NAT Type: Port Address Translation (PAT) / Overloading
**Analogy**: Multiple people in an office sharing a single mailbox, but each person has a unique mail slot (port) inside that box.

**Definition**: [[Port Address Translation (PAT)]], also called [[NAT overloading]], allows many internal devices to share a single public IP address by multiplexing them across different source ports. This is the most common NAT implementation in home and small-business networks.

**How PAT Differs from Dynamic NAT**:

| Aspect | Dynamic NAT | PAT (Overloading) |
|--------|-------------|-------------------|
| Public IPs needed | One per internal device | One for entire network |
| Distinguishes devices by | IP address | IP address + port |
| Scaling | Limited by public IP pool | Theoretically 65,535 connections per IP |
| Home router usage | Rare | Universal |

**PAT Translation Example**:
```
Internal Device    Private Address    Port    →    Public Address    Port
Laptop             10.1.1.5          54321        203.0.113.4       5001
Phone              10.1.1.7          54322        203.0.113.4       5002
Smart TV           10.1.1.9          54323        203.0.113.4       5003
```

---

### Inbound NAT / Port Forwarding
**Analogy**: A doorman at a hotel who intercepts incoming packages for Apartment 5B and routes them to the correct internal room.

**Definition**: [[Port forwarding]] (sometimes called [[Inbound NAT]]) allows external traffic arriving on a specific public port to be translated and forwarded to an internal private address and port. This enables internal services to be accessible from the Internet.

**CLI Example** (Cisco ASA):
```
access-list INBOUND permit tcp any any eq 80
nat (inside,outside) static 203.0.113.4 10.1.1.10 netmask 255.255.255.255
```

---

## Exam Tips

### Question Type 1: Identifying Why NAT Is Needed
- *"Your organization has 500 workstations but only 50 public IP addresses allocated by your ISP. How can you enable all workstations to access the Internet?"* → **Use Port Address Translation (PAT)/NAT overloading** to multiplex all 500 devices across the 50 public addresses using different source ports.
- **Trick**: Don't confuse "needing more addresses" with "needing to enable incoming services." NAT solves both but uses different configurations (static for inbound, PAT for outbound).

### Question Type 2: Comparing NAT Types
- *"A company needs their internal web server accessible from the Internet at a fixed public address. What NAT type must they use?"* → **Static NAT**, because Dynamic NAT and PAT only support outbound-initiated connections.
- **Trick**: Dynamic NAT and PAT both translate, but only **Static NAT** creates predictable inbound accessibility.

### Question Type 3: NAT Translation Process
- *"An internal device at 10.2.2.50 sends a packet to 8.8.8.8. The firewall has public IP 198.51.100.1. What source address will the packet have when it reaches 8.8.8.8?"* → **198.51.100.1** (the firewall's public address).
- **Trick**: The internal address is completely hidden from the Internet perspective.

### Question Type 4: RFC 1918 Ranges
- *"Which of the following is a valid RFC 1918 private address range?"* → Check for **10.0.0.0/8**, **172.16.0.0/12**, or **192.168.0.0/16**. Anything outside these ranges (even 10.256.0.0 or 172.32.0.0) is invalid.
- **Trick**: Remember the "Class A (10), Class B (172.16-31), Class C (192.168)" pneumonic.

---

## Common Mistakes

### Mistake 1: Confusing NAT with Routing
**Wrong**: "NAT is just another routing protocol like [[BGP]]."
**Right**: NAT operates at [[Layer 3]] and [[Layer 4]] but is address translation, not routing. It rewrites packet headers; routers forward based on destination addresses. NAT happens *before* or *after* routing.
**Impact on Exam**: You might select "configure [[OSPF]]" when the answer is "implement static NAT"—completely wrong solution to the problem.

### Mistake 2: Thinking Dynamic NAT and PAT Are the Same
**Wrong**: "Dynamic NAT and PAT are identical—they both translate multiple internal addresses."
**Right**: Dynamic NAT uses one public IP per internal device; PAT (overloading) uses *one* public IP for *all* internal devices by using different ports. They're fundamentally different in scale and mechanism.
**Impact on Exam**: A question asking "what NAT type uses only one public address for 200 internal devices?" has answer **PAT/overloading**, not Dynamic NAT.

### Mistake 3: Assuming All NAT Types Support Inbound Traffic
**Wrong**: "We'll use Dynamic NAT, so external clients can reach our internal servers."
**Right**: Only **Static NAT** and **port forwarding** support inbound-initiated connections. Dynamic NAT and PAT only work for outbound-initiated traffic.
**Impact on Exam**: Selecting Dynamic NAT for an inbound service requirement is an automatic wrong answer.

### Mistake 4: Forgetting About Port Numbers in PAT
**Wrong**: "Two devices behind PAT can't both use port 80 because they'll collide."
**Right**: PAT translates *source* ports (which are typically ephemeral/high-numbered), not destination ports. Both devices can connect to the same external destination on port 80; PAT gives them different source ports.
**Impact on Exam**: You might overthink why PAT "works"—it works because source ports are unique and re-mappable.

### Mistake 5: Misidentifying Private Address Ranges
**Wrong**: "192.168.1.0 is private, so 192.168.1.0 is also private."
**Right**: 192.168.0.0/16 is the entire RFC 1918 Class C range; **192.168.1.0/24 is a subnet within** it. Know the boundaries: 192.168.0.0–192.168.255.255.
**Impact on Exam**: A question about "which address is NOT in the RFC 1918 range" might show 192.169.1.1—one digit off, but completely public.

---

## Related Topics
- [[IPv4]] – The protocol being extended through NAT
- [[RFC 1918]] – Standard defining private address ranges
- [[IPv6]] – The long-term solution to address exhaustion
- [[Firewall]] – Device typically implementing NAT
- [[Port Forwarding]] – Specific NAT application for inbound services
- [[Stateful Inspection]] – How NAT tracks connections
- [[DHCP]] – Often paired with NAT to assign private addresses
- [[Proxy Server]] – Alternative to