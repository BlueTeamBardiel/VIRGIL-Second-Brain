---
tags: [knowledge, netplus, network-plus]
created: 2026-05-01
cert: CompTIA Network+
exam: N10-009
chapter: 023
source: rewritten
---

# IPv4 Subnet Masks
**Modern networks use flexible subnet masks rather than rigid address classes to divide IP networks.**

---

## Overview

The shift away from [[Class-Based Addressing]] in 1993 transformed how we organize [[IP Address]] spaces. Today, [[Classless Inter-Domain Routing]] (CIDR) allows network administrators to assign [[Subnet Masks]] of any size, giving us granular control over network division. Understanding subnet mask notation—both traditional decimal and modern CIDR formats—is essential for the Network+ exam, as you'll encounter both formats in real-world configurations.

---

## Key Concepts

### Classless Inter-Domain Routing (CIDR)
**Analogy**: If [[Class-Based Addressing]] was like standardized t-shirt sizes (S, M, L), CIDR is like custom tailoring—you get exactly the fit you need instead of one-size-fits-most categories.

**Definition**: [[CIDR]] is a method of allocating [[IP Addresses]] and routing that ignores traditional [[Address Classes]] (A, B, C), instead allowing any number of bits to define the network portion of an address.

---

### Subnet Mask Notation: Decimal vs. CIDR
**Analogy**: Think of two ways to describe the same measurement—inches versus centimeters. They're identical values expressed in different languages.

**Definition**: A [[Subnet Mask]] can be expressed as a dotted-decimal number (e.g., 255.255.255.0) OR as a [[CIDR Notation|slash notation]] (e.g., /24), where the number represents how many bits belong to the network portion.

| Decimal Notation | CIDR Notation | Interpretation |
|---|---|---|
| 255.0.0.0 | /8 | 8 network bits (Class A) |
| 255.255.0.0 | /16 | 16 network bits (Class B) |
| 255.255.255.0 | /24 | 24 network bits (Class C) |
| 255.255.255.128 | /25 | 25 network bits (custom) |
| 255.255.255.192 | /26 | 26 network bits (custom) |

**Key Relationship**: Each octet equals 8 bits. A /24 mask = 24 bits total = 3 complete octets of 255s.

---

### Address and Mask Configuration
**Analogy**: When mailing a package, you need the recipient's address AND the delivery zone code—each serves a different purpose.

**Definition**: Device configuration typically requires four essential network parameters: [[IP Address]], [[Subnet Mask]], [[Default Gateway]], and [[DNS Server]] entries.

**Operating System vs. Network Device Expectations**:

- **Hosts (Windows, Linux, macOS)**: Expect [[Subnet Mask]] in decimal format (255.255.255.0)
- **Network Devices (Routers, Switches, Firewalls)**: Often expect [[CIDR Notation]] (/24)

```
# Host configuration (Windows)
IP Address:    192.168.1.44
Subnet Mask:   255.255.255.0
Default GW:    192.168.1.1
DNS Server:    8.8.8.8

# Router configuration (Cisco-style)
192.168.1.44/24
or
ip address 192.168.1.44 255.255.255.0
```

**Best Practice**: Always verify the device documentation to determine which notation format it requires.

---

## Exam Tips

### Question Type 1: Notation Conversion
- *"A subnet mask of 255.255.0.0 is equivalent to which CIDR notation?"* → **/16** (16 bits of 255s)
- *"Convert /28 to decimal notation."* → **255.255.255.240** (28 bits set, 4 bits for hosts)
- **Trick**: Candidates often forget that CIDR counts from the LEFT side of the address. /24 means the first 24 bits are network, NOT the last 24.

### Question Type 2: Configuration Scenarios
- *"A technician configures a router with a /25 subnet mask but enters 255.255.255.50. What will happen?"* → **Incorrect routing; network won't function properly**
- **Trick**: The exam may describe a scenario where the wrong notation format causes a device to reject the configuration. Know which devices expect which format.

### Question Type 3: Network Division
- *"How many usable host addresses exist on a /26 network?"* → **62 hosts** (64 total addresses - network and broadcast)
- **Trick**: CIDR notation alone doesn't tell you hosts; you must calculate the remaining bits (32 - 26 = 6 bits = 2^6 = 64 addresses, minus 2).

---

## Common Mistakes

### Mistake 1: Confusing CIDR Notation with Host Bits
**Wrong**: Thinking /24 means "24 host bits available"
**Right**: /24 means "24 network bits defined"; remaining 8 bits (32-24) are for hosts
**Impact on Exam**: You'll miscalculate usable addresses and fail subnet sizing questions.

### Mistake 2: Assuming All Devices Use Same Notation
**Wrong**: Entering /24 into a Windows PC configuration dialog expecting it to work
**Right**: Windows wants 255.255.255.0; routers may accept either format depending on OS
**Impact on Exam**: Scenario-based questions test whether you know device-specific expectations. Answering "the technician should enter /24" when Windows demands decimal format is wrong.

### Mistake 3: Forgetting the Legacy Class System Still Appears
**Wrong**: Assuming every /16 network is called a "Class B"
**Right**: /16 networks *behave like* old Class B networks, but CIDR is classless—you can subnet a /16 further (e.g., /25)
**Impact on Exam**: Questions may reference "what was traditionally Class B" to test whether you understand the transition from class-based to classless addressing.

### Mistake 4: Mixing Up Notation in Written Answers
**Wrong**: Writing "192.168.1.0/255.255.255.0" (mixing formats)
**Right**: Either "192.168.1.0/24" OR "192.168.1.0 with mask 255.255.255.0"
**Impact on Exam**: Lab simulations and fill-in-the-blank questions require precise notation. Hybrid formats may be marked incorrect.

---

## Related Topics
- [[Class-Based Addressing]]
- [[CIDR Notation]]
- [[Subnet Calculation]]
- [[Default Gateway]]
- [[Network Address]]
- [[Broadcast Address]]
- [[IPv4 Address Structure]]
- [[Routing]]

---

*Source: Professor Messer CompTIA Network+ N10-009 | [[Network+]]*