---
tags: [knowledge, netplus, network-plus]
created: 2026-05-01
cert: CompTIA Network+
exam: N10-009
chapter: 020
source: rewritten
---

# Binary Math
**Master the conversion between decimal and binary to unlock IP subnetting mastery.**

---

## Overview
Binary math forms the foundation for understanding [[IP Subnetting]] and network addressing on the Network+ exam. You'll encounter conversion problems repeatedly throughout the certification, making this one of the most practical skills you'll develop. Without solid binary fundamentals, subnet mask calculations and IP address breakdowns become guesswork rather than logic.

---

## Key Concepts

### Binary Number System
**Analogy**: Think of binary like light switches—each switch is either ON (1) or OFF (0). You can't have it halfway on. A network uses millions of these switches to represent data.

**Definition**: A base-2 numbering system using only two digits: 0 and 1. Each position represents a power of 2, unlike our everyday decimal system which uses base-10.

[[Binary]] | [[Base-2]] | [[Bit]] | [[Byte]]

---

### Bits and Bytes
**Analogy**: A bit is a single Lego brick (one unit). A byte is exactly 8 of those bricks snapped together—always 8, never more or less.

**Definition**: A [[Bit]] is one binary digit (0 or 1). A [[Byte]] (also called an [[Octet]]) is exactly 8 bits grouped together. This standardization ensures everyone uses the same measurement when discussing data.

| Term | Size | Use Case |
|------|------|----------|
| Bit | 1 binary digit | Smallest unit of data |
| Byte/Octet | 8 bits | One IP address octet |
| Nibble | 4 bits | Half a byte (less common) |

---

### Binary-to-Decimal Conversion Chart
**Analogy**: Imagine a row of boxes, each labeled with a multiplication value. As you move left, each box's value doubles. It's like a seating chart where each seat to the left is worth twice as much money.

**Definition**: A positional value chart where each column represents a power of 2. The rightmost position is 2⁰ (1), and each leftward position doubles the previous value.

| Position | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0 |
|----------|---|---|---|---|---|---|---|---|
| Power of 2 | 2⁷ | 2⁶ | 2⁵ | 2⁴ | 2³ | 2² | 2¹ | 2⁰ |
| Decimal Value | 128 | 64 | 32 | 16 | 8 | 4 | 2 | 1 |

This chart is your foundation for almost every binary conversion in Network+. You can extend it infinitely: 256, 512, 1024, 2048, etc.

**Example Conversion**:
```
Binary: 11010110
Chart:  128 64 32 16 8 4 2 1
Bits:    1  1  0  1  0 1 1 0

Calculation: 128 + 64 + 16 + 4 + 2 = 214 (decimal)
```

---

### Decimal-to-Binary Conversion
**Analogy**: You're breaking down a pile of coins. If you have 214, you ask: "Do I have enough for a 128-value coin?" Yes, so mark 1. Then with 86 left, "Do I have 64?" Yes, mark 1. Keep subtracting until nothing remains.

**Definition**: The reverse process of identifying which power-of-2 positions are "turned on" (set to 1) to reach your target decimal number.

**Example Conversion**:
```
Decimal: 214

214 ÷ 128 = Yes (1), remainder 86
86 ÷ 64 = Yes (1), remainder 22
22 ÷ 32 = No (0)
22 ÷ 16 = Yes (1), remainder 6
6 ÷ 8 = No (0)
6 ÷ 4 = Yes (1), remainder 2
2 ÷ 2 = Yes (1), remainder 0
0 ÷ 1 = No (0)

Result: 11010110
```

---

## Exam Tips

### Question Type 1: Direct Binary-to-Decimal Conversion
- *"Convert the binary number 10101010 to decimal."* → 128 + 32 + 8 + 2 = **170**
- **Trick**: Students often forget to add all the "1" positions. Use the chart systematically left-to-right to avoid skipping values.

### Question Type 2: Decimal-to-Binary Conversion
- *"What is the binary equivalent of 172?"* → **10101100** (128 + 32 + 8 + 4)
- **Trick**: Exam questions often use numbers like 172, 192, 224 that appear in [[Subnet Masks]]. Memorizing the top 10 subnet mask conversions saves time.

### Question Type 3: Application to Subnetting
- *"How many usable hosts in a /25 network?"* → Requires understanding that /25 = 25 ones in the mask, leaving 7 bits for hosts = 2⁷ - 2 = **126 hosts**
- **Trick**: You MUST know binary to answer subnet questions correctly. This isn't separate from subnetting—it's the foundation.

---

## Common Mistakes

### Mistake 1: Forgetting the Chart Structure
**Wrong**: "128, 64, 32, 16, 8, 4, 2, 1... wait, what comes next? Is it 0.5?"

**Right**: Each position left is exactly 2× the previous. The rightmost is always 1. Extend left infinitely: 1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024...

**Impact on Exam**: You'll waste precious minutes trying to reconstruct the chart during the test. Memorize the 8-bit version completely.

### Mistake 2: Misunderstanding "Bit" vs. "Byte"
**Wrong**: Using the terms interchangeably—"a kilobit byte" or confusing data rates measured in bits with storage measured in bytes.

**Right**: [[Bit]] is singular unit (0 or 1). [[Byte]] is exactly 8 bits. Network speeds (megabits per second) use bits. File sizes use bytes.

**Impact on Exam**: Questions about [[Bandwidth]] vs. storage require knowing this distinction. You might calculate the wrong number of addresses or conversion values.

### Mistake 3: Stopping at 255
**Wrong**: Believing the conversion chart ends at 128-64-32-16-8-4-2-1 because that's "one byte."

**Right**: IP addresses are often discussed at larger scales. A /8 network requires understanding 256 and beyond. The chart extends indefinitely.

**Impact on Exam**: Larger subnetting questions require converting numbers like 256, 512, or 1024. Without extending the chart, you'll miss advanced subnetting problems.

### Mistake 4: Not Practicing Order of Operations
**Wrong**: Randomly selecting which "1" bits to add without a systematic left-to-right or right-to-left process.

**Right**: Always work through the chart in the same direction (typically left-to-right for clarity) to ensure you evaluate every position.

**Impact on Exam**: Rushed conversions lead to arithmetic errors. A systematic approach catches mistakes before submitting your answer.

---

## Related Topics
- [[IP Subnetting]]
- [[Subnet Masks]]
- [[CIDR Notation]]
- [[Classful Addressing]]
- [[IP Address Classes]]
- [[Network Address Calculation]]
- [[Hexadecimal]] (bonus: some advanced topics use hex alongside binary)

---

*Source: Professor Messer CompTIA Network+ N10-009 | [[Network+]] | [[CompTIA Certifications]]*