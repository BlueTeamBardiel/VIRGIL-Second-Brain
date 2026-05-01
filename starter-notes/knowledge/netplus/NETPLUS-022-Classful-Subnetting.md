---
tags: [knowledge, netplus, network-plus]
created: 2026-05-01
cert: CompTIA Network+
exam: N10-009
chapter: 022
source: rewritten
---

# Classful Subnetting
**The foundational IP address classification system that predetermined network and host boundaries before modern subnetting methods emerged.**

---

## Overview
Classful subnetting is a legacy organizational framework that categorized [[IPv4]] addresses into predetermined groups—Classes A, B, and C—each with a fixed boundary between the [[network portion]] and [[host portion]]. While this approach has been obsolete since 1993 (replaced by [[CIDR]]), understanding it remains essential for the Network+ exam because it forms the conceptual baseline for all modern subnetting calculations. You'll encounter classful thinking in exam questions and must recognize how addresses naturally segment into these historical categories.

---

## Key Concepts

### Class A Addresses
**Analogy**: Think of Class A like a massive warehouse where one supervisor (the first 8 bits) oversees millions of workers (the remaining 24 bits). That supervisor's identity never changes—it's always the first floor.

**Definition**: [[Class A]] addresses dedicate the first 8 bits to the [[network address]] and reserve 24 bits for [[host addresses]]. The default [[subnet mask]] is **255.0.0.0** (written as /8 in [[CIDR]] notation).

| Aspect | Value |
|--------|-------|
| First Octet Range | 1–126 |
| Network Bits | 8 |
| Host Bits | 24 |
| Default Subnet Mask | 255.0.0.0 |
| Hosts Per Network | 16,777,214 |

---

### Class B Addresses
**Analogy**: Picture Class B as a mid-sized company where two directors (the first 16 bits) each manage multiple departments (the remaining 16 bits). The boundary is in the middle—left side is administration, right side is operations.

**Definition**: [[Class B]] addresses split the address space evenly—the first 16 bits identify the [[network]] and the second 16 bits represent [[host]] addresses. The default [[subnet mask]] is **255.255.0.0** (/16 in [[CIDR]]).

| Aspect | Value |
|--------|--------|
| First Octet Range | 128–191 |
| Network Bits | 16 |
| Host Bits | 16 |
| Default Subnet Mask | 255.255.0.0 |
| Hosts Per Network | 65,534 |

---

### Class C Addresses
**Analogy**: Imagine Class C as a small neighborhood where the street address (first 24 bits) identifies the block, and individual house numbers (the last 8 bits) identify each residence. The neighborhood boundary is almost at the end.

**Definition**: [[Class C]] addresses use the first 24 bits for the [[network address]] and only the final 8 bits for [[host addresses]]. The default [[subnet mask]] is **255.255.255.0** (/24 in [[CIDR]]).

| Aspect | Value |
|--------|--------|
| First Octet Range | 192–223 |
| Network Bits | 24 |
| Host Bits | 8 |
| Default Subnet Mask | 255.255.255.0 |
| Hosts Per Network | 254 |

---

### Network vs. Host Boundary
**Analogy**: The network-to-host boundary is like a fence on a property—everything on one side belongs to the city (network), and everything on the other side belongs to the homeowner (hosts). The fence position is fixed in classful systems.

**Definition**: In classful addressing, the [[network-host boundary]] is predetermined and non-negotiable. Class A draws it after 8 bits, Class B after 16 bits, and Class C after 24 bits. This inflexibility is precisely why [[CIDR]] was invented.

---

## Exam Tips

### Question Type 1: Identifying Address Classes
- *"What class is the address 172.16.5.9?"* → **Class B** (first octet 172 falls in 128–191 range)
- *"Which subnet mask belongs to a Class C default?"* → **255.255.255.0**
- **Trick**: Don't overthink it—just check the first octet against the ranges. Memorize: A (1–126), B (128–191), C (192–223)

### Question Type 2: Host Capacity
- *"How many usable hosts exist in a Class B network with the default mask?"* → **65,534** (2^16 − 2, subtracting network and broadcast addresses)
- **Trick**: Remember to always subtract 2 (network address and broadcast address) from the 2^(host bits) formula.

### Question Type 3: Historical Context
- *"When was classful subnetting replaced?"* → **1993** (with the introduction of [[CIDR]])
- **Trick**: The exam may ask why we still study it—the answer is always "because it forms the foundation for understanding modern subnetting."

---

## Common Mistakes

### Mistake 1: Confusing Classful with Modern Subnetting
**Wrong**: "I'll use Class B rules to subnet a 172.16.0.0/22 network" (treating the /22 as if it must respect Class B boundaries)
**Right**: Modern subnetting using [[CIDR]] ignores class boundaries entirely. A /22 is valid regardless of whether it "fits" a class definition.
**Impact on Exam**: Questions asking about [[VLSM]] or [[CIDR]] require you to abandon classful thinking entirely. Confusing the two will tank subnet calculations.

### Mistake 2: Forgetting the Reserved Ranges
**Wrong**: Assuming address 127.0.0.1 is a Class A network address
**Right**: The range 127.x.x.x is the [[loopback]] address range—it's reserved and not usable for real networks. Class A actually ranges from 1–126.
**Impact on Exam**: A tricky question might include 127.x.x.x as a decoy. Always remember the gaps and reserved zones.

### Mistake 3: Miscalculating Host Count
**Wrong**: "A Class C has 256 hosts" (using 2^8 without subtracting 2)
**Right**: A Class C has **254 usable hosts** (2^8 − 2 = 256 − 2). The first address is the network address, the last is the broadcast address.
**Impact on Exam**: Network+ always tests the difference between total addresses and usable hosts. This error propagates through subnetting scenarios.

### Mistake 4: Assuming Default Masks Are Always Used
**Wrong**: "A Class B address always has subnet mask 255.255.0.0"
**Right**: A Class B address has a *default* mask of 255.255.0.0, but it can be [[subnetting|subnetted]] into smaller networks with masks like 255.255.255.0 or 255.255.255.192.
**Impact on Exam**: Questions about [[subnetting]] require you to separate the concept of "default class mask" from "actual deployed mask." These are not interchangeable.

---

## Related Topics
- [[IPv4]]
- [[CIDR]] (the modern replacement)
- [[Subnet Mask]]
- [[Network Address]]
- [[Host Address]]
- [[Subnetting]]
- [[VLSM]] (Variable Length Subnet Masking)
- [[Loopback Address]]
- [[Network Fundamentals]]

---

*Source: Professor Messer CompTIA Network+ N10-009 | [[Network+]]*