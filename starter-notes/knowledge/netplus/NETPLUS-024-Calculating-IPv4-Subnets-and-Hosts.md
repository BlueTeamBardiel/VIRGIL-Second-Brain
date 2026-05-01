---
tags: [knowledge, netplus, network-plus]
created: 2026-05-01
cert: CompTIA Network+
exam: N10-009
chapter: 024
source: rewritten
---

# Calculating IPv4 Subnets and Hosts
**Mastering the math behind dividing networks into perfectly-sized chunks for efficient routing and device placement.**

---

## Overview
Subnet calculation is the foundational skill that lets you take a large IP address block and intelligently carve it into smaller, manageable networks. Without this ability, networks would collapse under their own weight—you couldn't realistically route traffic to billions of devices without first organizing them into logical subdivisions. This is one of the most heavily tested topics on the Network+ exam because it directly impacts real-world network design and troubleshooting.

---

## Key Concepts

### Variable Length Subnet Masking (VLSM)
**Analogy**: Think of VLSM like dividing a large plot of land into different-sized neighborhoods. One area might need 50 houses, another might need 200—you divide the land differently each time rather than forcing every neighborhood into the same rigid size.

**Definition**: [[VLSM]] is the ability to create [[subnet masks]] of varying lengths across different subnets within the same network space. Unlike [[Classful Subnetting|classful networks]], which lock you into fixed bit positions, VLSM lets you customize exactly how many bits represent the network portion and how many represent hosts on a per-subnet basis.

This flexibility means you, as the [[Network Administrator]], achieve two critical goals: eliminating wasted IP addresses and creating exactly the right number of subnets and [[Hosts|hosts]] for your infrastructure.

---

### The Subnet Mask and Network Division
**Analogy**: A [[subnet mask]] works like a filter or sieve—it tells devices which part of an IP address is the "neighborhood" and which part is the "house number" on that block.

**Definition**: The [[subnet mask]] determines the boundary between the [[Network Address|network portion]] and the [[Host Address|host portion]] of an [[IPv4 Address]]. By borrowing bits from the host section and designating them as network bits, you reduce the number of available hosts per subnet but multiply the total number of possible subnets.

| Concept | Purpose | Behavior |
|---------|---------|----------|
| **Network Bits** | Identify the subnet | Fixed for all devices in that subnet |
| **Host Bits** | Identify individual devices | Can vary within a single subnet |
| **Borrowed Bits** | Create additional subnets | Taken from the original host space |

---

### Why Subnetting Matters for Routing
**Analogy**: Imagine a postal service without ZIP codes—delivery trucks would have to know the location of every single address. Subnetting is like ZIP codes for IP networks: [[Routers]] only need to know which "zone" a destination belongs to, not every individual device.

**Definition**: By segmenting networks, [[Routers|routers]] can make forwarding decisions based on [[Network Address|network addresses]] rather than memorizing paths to billions of individual hosts. This scalability is why the entire internet functions—each router only maintains routes to other networks, not to every device.

---

### The Relationship Between Subnets and Hosts
**Analogy**: Every time you add a wall to subdivide a building, you create more rooms but each room gets smaller. Subnetting works identically—more subnets means fewer hosts per subnet.

**Definition**: The total number of bits in an [[IPv4 Address]] is fixed at 32. As you increase the [[subnet mask]] length (more network bits), you decrease the number of bits available for [[Hosts|hosts]]. This inverse relationship is mathematically expressed as:

```
Total Subnets Created = 2^(borrowed bits)
Hosts per Subnet = 2^(remaining host bits) - 2
```

The "minus 2" accounts for the [[Network Address|network address]] (all host bits = 0) and [[Broadcast Address|broadcast address]] (all host bits = 1), which cannot be assigned to devices.

| Subnet Mask | Bits Borrowed | Subnets Created | Hosts per Subnet |
|-------------|---------------|-----------------|------------------|
| /24 | 0 | 1 | 254 |
| /25 | 1 | 2 | 126 |
| /26 | 2 | 4 | 62 |
| /27 | 3 | 8 | 30 |
| /28 | 4 | 16 | 14 |
| /29 | 5 | 32 | 6 |
| /30 | 6 | 64 | 2 |

---

### Default Gateway and Network Boundaries
**Analogy**: The [[Default Gateway]] is like the neighborhood entrance—it's the exit point that leads outside your local network to the rest of the internet.

**Definition**: The [[Default Gateway]] is typically the [[Network Address|network address]] plus one (the first usable host address in a subnet). When a device needs to communicate outside its subnet, it sends the packet to this gateway address. Understanding network boundaries—where your [[Subnet|subnet]] begins and ends—is essential for calculating whether two hosts can communicate directly or must go through a router.

---

## Exam Tips

### Question Type 1: Identify Subnet Count from a Given Network Block
- *"Your company is assigned 192.168.0.0/22. You need to create 8 subnets of equal size. What subnet mask should you use?"*
  - **Answer**: /25 (borrowing 3 additional bits: 2^3 = 8 subnets)
- **Trick**: Candidates often confuse the number of bits to borrow with the final mask length. Remember: you're borrowing FROM the existing host bits, not starting from zero.

### Question Type 2: Calculate Usable Hosts in a Subnet
- *"A subnet uses the mask 255.255.255.240 (/28). How many usable host addresses are available?"*
  - **Answer**: 14 (2^4 - 2, since 4 host bits remain)
- **Trick**: Never forget to subtract 2 for the network and broadcast addresses—this is a guaranteed trick answer on the exam.

### Question Type 3: Determine if Addresses are in the Same Subnet
- *"Are 10.0.4.50 and 10.0.5.100 in the same subnet if the mask is /23?"*
  - **Answer**: Yes. A /23 mask means the first 23 bits must match. Both addresses share the same first 23 bits in binary, so they're on the same subnet.
- **Trick**: You must convert to binary to verify this accurately—decimal comparison often leads students astray.

### Question Type 4: Find the Broadcast Address
- *"Given 172.16.50.0/25, what is the broadcast address?"*
  - **Answer**: 172.16.50.127 (all host bits set to 1)
- **Trick**: The broadcast address is the LAST address in the subnet range, not the last usable host address.

---

## Common Mistakes

### Mistake 1: Forgetting the -2 for Network and Broadcast Addresses
**Wrong**: "A /28 subnet has 2^4 = 16 usable hosts"
**Right**: "A /28 subnet has 2^4 - 2 = 14 usable hosts"
**Impact on Exam**: This error cascades through every question involving host counts. You'll calculate the theoretical maximum but miss the practical reality that two addresses are always reserved. Expect to lose points on any scenario-based question if you make this mistake.

---

### Mistake 2: Confusing Subnet Mask Length with Bits Borrowed
**Wrong**: "To create 4 subnets, I need a /4 mask"
**Right**: "To create 4 subnets, I borrow 2 bits (2^2 = 4), so if starting from /24, the new mask is /26"
**Impact on Exam**: This fundamental confusion will cause you to suggest completely invalid subnet masks that don't exist in the context of your original network allocation. You'll fail scenario questions outright.

---

### Mistake 3: Not Converting to Binary When Comparing Addresses
**Wrong**: Comparing two addresses in decimal to determine if they're in the same subnet
**Right**: Converting both addresses to binary and comparing against the [[subnet mask|subnet mask]] bit boundary
**Impact on Exam**: Decimal comparison is unreliable, especially with "tricky" addresses that are numerically close but on different subnets. This is a high-risk error for hands-on scenario questions.

---

### Mistake 4: Ignoring the Role of VLSM in Real-World Networks
**Wrong**: Assuming all subnets must be the same size across an organization
**Right**: Understanding that [[VLSM]] allows different subnets to have different sizes based on actual need
**Impact on Exam**: Network+ emphasizes practical, efficient network design. Questions often present scenarios where a one-size-fits-all approach is wasteful. If you can't recognize when [[VLSM]] is the superior choice, you'll miss questions about real-world optimization.

---

## Related Topics
- [[Binary Math for Networking]]
- [[Classful Subnetting]]
- [[IPv4 Address Structure]]
- [[Subnet Masks]]
- [[Routers and Routing]]
- [[Network Address Translation (NAT)]]
- [[CIDR Notation]]
- [[Supernetting]]

---

*Source: Professor Messer CompTIA Network+ N10-009 | [[Network+]]*