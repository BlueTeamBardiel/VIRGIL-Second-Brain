---
tags: [knowledge, ccna, chapter-0]
created: 2026-04-30
cert: CCNA
chapter: 0
source: rewritten
---

# IPv4 Addressing Quiz
**Master the art of dissecting IP addresses to unlock network boundaries, usable hosts, and critical addresses.**

---

## Network Address Calculations

### Finding the Network Address, Broadcast Address, and Usable Host Range

**Analogy**: Think of an [[IPv4 Address]] with its [[Subnet Mask]] like a street address with a zip code. The zip code (subnet mask) tells you which part is the "neighborhood" (network), and everything else identifies individual houses (hosts). The first house address is always the network itself, the last is always the town bulletin board (broadcast), and everything in between are actual homes you can live in.

**Network Identification Process**: To discover your network foundation, you perform a bitwise AND operation between the [[IPv4 Address]] and its [[Subnet Mask]]. This reveals the starting point of your addressable space.

**Broadcast Address Calculation**: The broadcast address emerges when you flip all host bits to 1. This is the "send-to-everyone" address within that network.

**Usable Host Range**: Subtract 2 from your total host count (one for network, one for broadcast). The first usable address is network + 1, and the last usable is broadcast - 1.

| Parameter | /8 Network | /16 Network | /24 Network |
|-----------|-----------|-----------|-----------|
| Total Hosts | 16,777,216 | 65,536 | 256 |
| Usable Hosts | 16,777,214 | 65,534 | 254 |
| Network Bits | 8 | 16 | 24 |
| Host Bits | 24 | 16 | 8 |

---

## Example Problems with Solutions

### Example 1: /16 Network Calculation
**Given**: PC1 IP: 129.221.23.13/16

| Element | Value |
|---------|-------|
| **Network Address** | 129.221.0.0 |
| **Broadcast Address** | 129.221.255.255 |
| **First Usable Host** | 129.221.0.1 |
| **Last Usable Host** | 129.221.255.254 |
| **Maximum Usable Hosts** | 65,534 |

### Example 2: /8 Network Calculation
**Given**: PC1 IP: 43.109.23.12/8

| Element | Value |
|---------|-------|
| **Network Address** | 43.0.0.0 |
| **Broadcast Address** | 43.255.255.255 |
| **First Usable Host** | 43.0.0.1 |
| **Last Usable Host** | 43.255.255.254 |
| **Maximum Usable Hosts** | 16,777,214 |

### Example 3: /24 Network Calculation
**Given**: PC1 IP: 209.211.3.22/24

| Element | Value |
|---------|-------|
| **Network Address** | 209.211.3.0 |
| **Broadcast Address** | 209.211.3.255 |
| **First Usable Host** | 209.211.3.1 |
| **Last Usable Host** | 209.211.3.254 |
| **Maximum Usable Hosts** | 254 |

### Example 4: /8 Network (Class A)
**Given**: PC1 IP: 2.71.209.233/8

| Element | Value |
|---------|-------|
| **Network Address** | 2.0.0.0 |
| **Broadcast Address** | 2.255.255.255 |
| **First Usable Host** | 2.0.0.1 |
| **Last Usable Host** | 2.255.255.254 |
| **Maximum Usable Hosts** | 16,777,214 |

### Example 5: /16 Network Calculation
**Given**: PC1 IP: 155.200.201.141/16

| Element | Value |
|---------|-------|
| **Network Address** | 155.200.0.0 |
| **Broadcast Address** | 155.200.255.255 |
| **First Usable Host** | 155.200.0.1 |
| **Last Usable Host** | 155.200.255.254 |
| **Maximum Usable Hosts** | 65,534 |

---

## Exam Tips

### Question Type 1: Network Address Identification
- *"What is the network address for 192.168.45.67/22?"* → Convert CIDR to binary, AND with mask, convert back to decimal
- **Trick**: Students often forget that you CANNOT use the network address itself as a usable host address—always subtract 2 from total hosts!

### Question Type 2: Broadcast Address Recognition
- *"What is the broadcast address for 10.50.100.200/16?"* → Set ALL host bits to 1; for /16, that's 10.50.255.255
- **Trick**: The broadcast address varies with subnet mask—don't memorize; calculate every time!

### Question Type 3: Usable Host Range Determination
- *"How many usable hosts exist in 172.16.0.0/20?"* → 2^(32-20) - 2 = 4,094 usable hosts
- **Trick**: Remember the minus 2! One host address is reserved for the network, one for broadcast.

---

## Common Mistakes

### Mistake 1: Forgetting the "Minus 2" Rule
**Wrong**: A /24 network has 256 usable hosts
**Right**: A /24 network has 254 usable hosts (256 total - 2 reserved)
**Impact on Exam**: This is worth multiple points on the CCNA—you'll be asked to calculate usable hosts in various scenarios. Missing this costs you full-point answers.

### Mistake 2: Confusing Network Address with First Usable Address
**Wrong**: The network address (129.221.0.0) can be assigned to a device
**Right**: The network address is reserved; only 129.221.0.1 and beyond are usable
**Impact on Exam**: Design questions will trip you up if you assign the network address to a real device. This violates [[IPv4]] protocol standards.

### Mistake 3: Misunderstanding Broadcast Address Usage
**Wrong**: Broadcasting to 129.221.255.255 reaches only that specific subnet
**Right**: Broadcasting to 129.221.255.255 reaches ALL devices in that /16 network
**Impact on Exam**: Subnet design and [[VLAN]] isolation questions hinge on understanding broadcast domain limitations.

### Mistake 4: Incorrectly Converting CIDR to Subnet Mask
**Wrong**: /16 equals 255.255.255.0
**Right**: /16 equals 255.255.0.0 (16 ones in binary = 255.255.0.0)
**Impact on Exam**: You'll miscalculate every subsequent network boundary—this cascades into wrong answers.

### Mistake 5: Applying Wrong Subnet Mask to Host Bits
**Wrong**: For 209.211.3.22/24, calculating the last usable as 209.211.3.224
**Right**: For 209.211.3.24, the last usable is 209.211.3.254 (all host bits = 1, minus 1 for broadcast)
**Impact on Exam**: Subnet boundary questions will fail if you don't properly identify which octets are network vs. host.

---

## Related Topics
- [[IPv4 Address]]
- [[Subnet Mask]]
- [[CIDR Notation]]
- [[Subnetting]]
- [[Network Address]]
- [[Broadcast Address]]
- [[Binary Math for Networking]]
- [[Class A B C D E Networks]]
- [[CCNA]]

---

*Source: CCNA 200-301 Study Notes | [[CCNA]]*