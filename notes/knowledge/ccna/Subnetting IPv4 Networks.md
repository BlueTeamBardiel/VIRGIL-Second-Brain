# Subnetting IPv4 Networks
**Tagline:** Master subnet calculation—the foundation for all network design, IP planning, and CCNA troubleshooting.

---

## What is Subnetting?

### The Simple Explanation
Imagine a postal system where every address must specify not just a house, but also which neighborhood it belongs to. [[IPv4]] addressing works the same way: subnetting divides one large network into smaller, logical groups. Instead of treating 192.168.1.0 as one giant network, you can split it into separate subnets for different departments, buildings, or functions. Each subnet is its own isolated broadcast domain.

### Why It Matters
Without subnetting, every device on a network receives every broadcast frame—wasting bandwidth and creating security problems. Subnetting allows you to:
- **Contain broadcasts** to smaller groups (reducing traffic)
- **Improve security** by isolating traffic between departments
- **Maximize address utilization** so you don't waste IP space
- **Enable hierarchical network design** that scales from small offices to global enterprises

### The Core Mechanic
Subnetting works by "borrowing" host bits from the [[IPv4 address space]] and converting them into network bits. A device's [[subnet mask]] tells it which bits represent the network and which represent individual hosts.

| Concept | Function |
|---------|----------|
| Network address | The first usable IP in a subnet (host bits = 0) |
| Subnet mask | Binary pattern that separates network from host portions |
| Broadcast address | The last IP in a subnet (host bits = all 1s) |
| Usable host addresses | Everything between network and broadcast address |
| Prefix length (/notation) | Shorthand for how many network bits exist |

---

## FLSM (Fixed-Length Subnet Mask) Subnetting

### Core Concept
[[FLSM]] creates subnets of equal size. All subnets use the same subnet mask. This is simpler than [[VLSM]] but wastes address space when networks have widely different sizes.

### Subnetting /24 Address Blocks

The most common scenario in enterprise networks. A /24 network (Class C range) has 8 host bits available for subnetting.

**Formula:** 2^(borrowed bits) = number of subnets

If you borrow 2 bits from host space:
- Original: 192.168.1.0/24
- New subnets: 192.168.1.0/26, 192.168.1.64/26, 192.168.1.128/26, 192.168.1.192/26
- Hosts per subnet: 2^(8-2) = 2^6 = 64 addresses (62 usable after removing network and broadcast)

**Subnet Mask Conversion:**
- /26 = 11111111.11111111.11111111.11000000 = 255.255.255.192

**Working Example:**
```
Network: 192.168.1.0/24
Borrow 2 bits → /26

Subnet 1: 192.168.1.0/26
  Network: 192.168.1.0
  Broadcast: 192.168.1.63
  Usable: 192.168.1.1 - 192.168.1.62

Subnet 2: 192.168.1.64/26
  Network: 192.168.1.64
  Broadcast: 192.168.1.127
  Usable: 192.168.1.65 - 192.168.1.126

Subnet 3: 192.168.1.128/26
Subnet 4: 192.168.1.192/26
```

### Subnetting /16 Address Blocks

Larger scope (Class B networks) with 16 host bits available.

**Common scenario:** Borrowing 3 bits for 8 subnets
- Original: 172.16.0.0/16
- New prefix: /19 (16 + 3 = 19)
- Hosts per subnet: 2^(16-3) = 2^13 = 8,192 addresses

**Subnet List:**
```
172.16.0.0/19     (172.16.0.0 - 172.16.31.255)
172.16.32.0/19    (172.16.32.0 - 172.16.63.255)
172.16.64.0/19    (172.16.64.0 - 172.16.95.255)
172.16.96.0/19    (172.16.96.0 - 172.16.127.255)
[...]
```

The key: track the block size. Each octet doubles when you borrow from it:
- Borrow 1 bit: block size 128
- Borrow 2 bits: block size 64
- Borrow 3 bits: block size 32
- Borrow 4 bits: block size 16

### Subnetting /8 Address Blocks

Enterprise-scale networks (Class A) with 24 host bits.

**Example:** Borrowing 5 bits creates 32 subnets of /13 each
- Original: 10.0.0.0/8
- New prefix: /13
- Hosts per subnet: 2^(24-5) = 2^19 = 524,288 addresses

Block size in second octet: 2^(8-5) = 2^3 = 32
```
10.0.0.0/13      (10.0.0.0 - 10.31.255.255)
10.32.0.0/13     (10.32.0.0 - 10.63.255.255)
10.64.0.0/13     (10.64.0.0 - 10.95.255.255)
[...]
```

### FLSM Scenarios

**When to use FLSM:**
- All departments need similar numbers of hosts
- Simple, predictable network design
- No complex growth requirements
- Every subnet has the same requirements

**Real-world example:**
- 8 branch offices, each needs ~250 hosts
- Use a /22 (4 subnets per site) carved from a /16
- Wastes some addresses but ensures consistency

---

## VLSM (Variable-Length Subnet Mask) Subnetting

### Core Concept
[[VLSM]] allows different subnet masks within the same network. You allocate exactly the IP space each segment needs—no wasted addresses. This is the standard for modern networks but requires careful planning.

**Key principle:** Subnet the subnets. Start large, then subdivide where needed.

### Design Methodology

**Step 1:** List all required networks sorted by host count (largest first)
**Step 2:** Assign /prefix values based on host requirements
**Step 3:** Assign actual subnet addresses avoiding overlaps
**Step 4:** Document the allocation clearly

### Toronto/Tokyo Multi-Site Example

**Requirements:**
- Toronto LAN A: 60 hosts
- Toronto LAN B: 30 hosts
- Tokyo LAN A: 20 hosts
- Tokyo LAN B: 10 hosts
- WAN link: 2 hosts

**Available space:** 192.168.1.0/24 (256 total addresses)

**Sorted by size:**
1. Toronto LAN A: 60 hosts → need /26 (64 addresses)
2. Toronto LAN B: 30 hosts → need /27 (32 addresses)
3. Tokyo LAN A: 20 hosts → need /27 (32 addresses)
4. Tokyo LAN B: 10 hosts → need /28 (16 addresses)
5. WAN link: 2 hosts → need /30 (4 addresses)

**Assignments:**

| Network | CIDR | Network Address | Broadcast | Usable Range | Host Count |
|---------|------|-----------------|-----------|--------------|-----------|
| Toronto LAN A | /26 | 192.168.1.0 | 192.168.1.63 | .1 - .62 | 62 |
| Toronto LAN B | /27 | 192.168.1.64 | 192.168.1.95 | .65 - .94 | 30 |
| Tokyo LAN A | /27 | 192.168.1.96 | 192.168.1.127 | .97 - .126 | 30 |
| Tokyo LAN B | /28 | 192.168.1.128 | 192.168.1.143 | .129 - .142 | 14 |
| WAN Link | /30 | 192.168.1.144 | 192.168.1.147 | .145 - .146 | 2 |

**Critical calculation check:** 64 + 32 + 32 + 16 + 4 = 148 addresses used from 256 available. Valid.

### Why VLSM Matters for Real Networks

Enterprise networks never have identical requirements. A server LAN might need 500 addresses while a guest WiFi only needs 50. [[VLSM]] lets you right-size each segment, maximizing efficiency and reducing administrative overhead.

---

## Lab Relevance

### Essential IOS Commands for Subnetting Validation

```bash
# Display interface IP configuration (verify subnet mask)
Router# show ip interface brief
Router# show ip interface <interface-name>

# Display routing table with prefix lengths
Router# show ip route
Router# show ip route connected

# Configure an IP address on an interface
Router(config-if)# ip address <ip-address> <subnet-mask>

# Example: assigning an IP with VLSM
Router(config-if)# ip address 192.168.1.1 255.255.255.192

# Verify connectivity between subnets
Router# ping <destination-ip>
Router# traceroute <destination-ip>

# Display VLAN IP assignments (Layer 3 segments)
Switch(config)# interface vlan <vlan-id>
Switch(config-if)# ip address <ip-address> <subnet-mask>

# Verify routing between subnets
Router# show ip route <destination-ip>

# Create a static route (requires understanding of subnets)
Router(config)# ip route <network-address> <subnet-mask> <next-hop>
```

**Lab scenario:** Given 10.0.0.0/8, create VLSM subnets for 5 sites with varying host counts, then configure [[Cisco IOS]] interfaces with correct IP/mask combinations.

---

## Exam Tips

### What the CCNA Exam Specifically Tests

**Subnetting is ~15-20% of CCNA exam content.** Expect:

#### Question Type 1: Subnet Calculation Under Pressure
"Given 172.16.0.0/16 and the requirement for 50 subnets with at least 500 hosts each, which prefix length works?"
- **Trap:** Confusing how many bits to borrow
- **Strategy:** Always calculate 2^bits for both subnets AND hosts per subnet

#### Question Type 2: Identify Network Address
"What is the network address of 192.168.45.230/27?"
- **Trap:** Students round wrong or use incorrect block size
- **Math:** /27 = borrow 3 bits from 8 available in last octet = block size 32
- 230 ÷ 32 = 7 remainder 6, so 7 × 32 = 224
- **Answer:** 192.168.45.224/27

#### Question Type 3: Broadcast Address Identification
"What is the broadcast address for 10.50.60.0/22?"
- **Trick:** Requires knowing block size across octets
- /22 = 256 - 4 = .252 in third octet, but affects second octet too
- **Block size calculation:** 2^(22-16) = 2^6 = 64 in third octet

#### Question Type 4: Valid Host Ranges
"Which of these IPs is valid on subnet 192.168.10.64/27?"
- A) 192.168.10.64  
- B) 192.168.10.96  
- C) 192.168.10.65

---
*Source: Acing the CCNA Exam, Volume 1, Chapter 11 | [[CCNA]]*