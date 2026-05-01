---
tags: [knowledge, ccna, chapter-0]
created: 2026-04-30
cert: CCNA
chapter: 0
source: rewritten
---

# Sunny Classroom Subnetting
**Master the art of dividing a single network into multiple smaller networks to efficiently allocate IP address space.**

---

## Practical Subnetting Application

### Real-World Scenario: Multi-Department Network Division

**Analogy**: Imagine you own a coffee shop and need to organize three separate departments—the management office, the employee break room with storage, and the customer seating area. You can't put everyone on the same network because they need different access levels and security zones. That's what [[Subnetting]] does: it takes one big network and partitions it into smaller, manageable chunks!

**Subnetting**: The process of dividing a larger [[IP Network]] into smaller sub-networks ([[Subnets]]) by borrowing bits from the [[Host Portion]] of an address and converting them to the [[Network Portion]]. This maximizes address efficiency and improves security through network segmentation.

### The Coffee Shop Network Challenge

Starting with: **192.168.4.0/24**

**Goal**: Create 3 separate networks (office, employee area, customer area)

---

## Determining Subnet Requirements

### Calculating Necessary Subnets

**Analogy**: Think of powers of 2 like stacking boxes. You start with 1 box (2¹), then can have 2 boxes (2²), 4 boxes (2³), 8 boxes (2⁴), and so on. We need 3 boxes, but can't split a box, so we need the next size up: 4 boxes!

**Subnet Calculation Rule**: Since we need 3 subnets and 2² = 4, we must use 4 [[Subnets]]. This means we're borrowing 2 bits from the host portion (2 bits borrowed = 2² = 4 subnets possible).

| **Subnets Needed** | **Powers of 2** | **CIDR Notation** | **Total Hosts per Subnet** | **Usable Hosts** |
|---|---|---|---|---|
| 1 | 2⁰ | /24 | 256 | 254 |
| 2 | 2¹ | /25 | 128 | 126 |
| 4 | 2² | /26 | 64 | 62 |
| 8 | 2³ | /27 | 32 | 30 |
| 16 | 2⁴ | /28 | 16 | 14 |
| 32 | 2⁵ | /29 | 8 | 6 |
| 64 | 2⁶ | /30 | 4 | 2 |
| 128 | 2⁷ | /31 | 2 | 0 |
| 256 | 2⁸ | /32 | 1 | 0 |

**Result**: Each subnet will contain 64 total addresses, with **62 usable [[Host ID]]s** (subtract the [[Network ID]] and [[Broadcast ID]]).

---

## The Four Subnets

### Subnet Distribution Table

| **Subnet Purpose** | **Network ID** | **[[Subnet Mask]]** | **First Usable [[Host ID]]** | **Last Usable [[Host ID]]** | **Usable Hosts** | **[[Broadcast ID]]** |
|---|---|---|---|---|---|---|
| Office | 192.168.4.0 | /26 (255.255.255.192) | 192.168.4.1 | 192.168.4.62 | 62 | 192.168.4.63 |
| Employee Area | 192.168.4.64 | /26 (255.255.255.192) | 192.168.4.65 | 192.168.4.126 | 62 | 192.168.4.127 |
| Customer Area | 192.168.4.128 | /26 (255.255.255.192) | 192.168.4.129 | 192.168.4.190 | 62 | 192.168.4.191 |
| Reserved | 192.168.4.192 | /26 (255.255.255.192) | 192.168.4.193 | 192.168.4.254 | 62 | 192.168.4.255 |

---

## Subnetting Logic Breakdown

### Step-by-Step Calculation Method

**Analogy**: Think of incrementing your [[Network ID]] like climbing stairs. Each stair is exactly 64 steps tall (the block size). You start at step 0, then jump 64 steps to reach the next staircase landing.

**Block Size Calculation**: Block Size = 256 ÷ number of subnets = 256 ÷ 4 = **64**

**Network ID Progression**:
- Subnet 1: Start at original [[Network ID]] → **192.168.4.0** (+ 0)
- Subnet 2: Add block size → **192.168.4.64** (+ 64)
- Subnet 3: Add block size again → **192.168.4.128** (+ 64)
- Subnet 4: Add block size again → **192.168.4.192** (+ 64)

### Finding Host Ranges and Broadcast IDs

**Analogy**: Each subnet is like a hotel floor. The first room number is the [[Network ID]], the last room number is the [[Broadcast ID]], and all rooms in between are guest rooms (usable [[Host ID]]s).

**For Each Subnet**:
1. **[[Network ID]]**: The starting address of the block
2. **First Usable [[Host ID]]**: [[Network ID]] + 1
3. **Last Usable [[Host ID]]**: [[Broadcast ID]] - 1 (which equals [[Network ID]] + 62)
4. **[[Broadcast ID]]**: Next [[Network ID]] - 1 (or [[Network ID]] + 63)

---

## Exam Tips

### Question Type 1: Identify Usable Host Range

- *"What is the usable [[Host ID]] range for the subnet 192.168.4.64/26?"* → **192.168.4.65 - 192.168.4.126**
- **Trick**: Don't include the [[Network ID]] (192.168.4.64) or [[Broadcast ID]] (192.168.4.127) in your range. These are reserved and cannot be assigned to devices!

### Question Type 2: Calculate Number of Subnets

- *"How many usable [[Subnets]] can you create by borrowing 2 bits?"* → **2² = 4 subnets** (but only 2 are usable if the all-zeros and all-ones rules apply—though modern practice uses all 4)
- **Trick**: The exam may ask about "usable subnets" vs. "total subnets." Modern CCNA accepts all subnets as usable.

### Question Type 3: Find the Broadcast ID

- *"What is the [[Broadcast ID]] for 192.168.4.128/26?"* → **192.168.4.191**
- **Trick**: The [[Broadcast ID]] is always the last address in the block ([[Network ID]] + block size - 1).

---

## Common Mistakes

### Mistake 1: Forgetting to Account for Network and Broadcast IDs

**Wrong**: "A /26 subnet has 64 usable hosts"
**Right**: "A /26 subnet has 64 *total* addresses, but only **62 usable hosts** (subtract the [[Network ID]] and [[Broadcast ID]])"
**Impact on Exam**: You'll calculate the wrong number of available IP addresses for device assignment and fail subnet design questions.

### Mistake 2: Incorrect Block Size Calculation

**Wrong**: "The block size for 4 subnets is 256 ÷ 2 = 128"
**Right**: "The block size for 4 subnets is 256 ÷ 4 = **64**"
**Impact on Exam**: Your entire subnet range will be wrong, causing cascading errors on multi-part subnetting questions.

### Mistake 3: Confusing Increment Values with Host Counts

**Wrong**: "Each subnet increments by 62 addresses, so Subnet 2 starts at 192.168.4.62"
**Right**: "Each subnet increments by the **block size (64)**, so Subnet 2 starts at 192.168.4.64"
**Impact on Exam**: You'll assign IPs to the wrong subnets and fail any question requiring [[Host ID]] assignment verification.

### Mistake 4: Including Network and Broadcast in Host Range

**Wrong**: "The usable [[Host ID]] range for 192.168.4.0/26 is 192.168.4.0 - 192.168.4.63"
**Right**: "The usable [[Host ID]] range for 192.168.4.0/26 is **192.168.4.1 - 192.168.4.62**"
**Impact on Exam**: Routing and addressing design questions will be marked incorrect because the [[Network ID]] and [[Broadcast ID]] cannot be assigned to devices.

---

## Related Topics
- [[Subnetting]]
- [[Network ID]]
- [[Broadcast ID]]
- [[Host ID]]
- [[Subnet Mask]]
- [[CIDR Notation]]
- [[IP Addressing]]
- [[Binary Mathematics for Networking]]
- [[IPv4 Address Classes]]
- [[Network Segmentation]]
- [[CCNA]]

---

*Source: CCNA 200-301 Study Notes | [[CCNA]] | [[Subnetting]]*