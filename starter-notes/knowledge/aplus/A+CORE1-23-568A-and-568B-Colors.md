---
tags: [knowledge, aplus, core-1-(220-1201)]
created: 2026-04-30
cert: CompTIA A+
chapter: 23
source: rewritten
---

# 568A and 568B Colors
**International cabling standards that dictate how network technicians arrange colored wires inside Ethernet connectors for consistent, reliable installations worldwide.**

---

## Overview

Imagine you're moving to a new house and need to plug in appliances — if electrical outlets were different in every room, chaos would ensue. The [[568A]] and [[568B]] color standards work the same way for networking: they ensure that no matter which building or continent you walk into, the wires inside an [[RJ45 connector]] follow the same predictable color sequence. The [[TIA/EIA 568 standard]] (managed internationally by [[ISO/IEC 11801]]) defines these two competing specifications, and understanding which one your organization uses is critical for the A+ exam and real-world troubleshooting.

---

## Key Concepts

### TIA/EIA 568 Standard

**Analogy**: Think of it as the "rulebook" for building with LEGO — everyone uses the same instruction manual so their creations fit together properly.

**Definition**: The [[Telecommunications Industry Association (TIA)]] established this formal cabling standard that specifies how [[twisted pair cables]] must be arranged, installed, and terminated in commercial buildings across North America and beyond.

---

### 568A Color Sequence

**Analogy**: Like memorizing the order of colors in a rainbow (ROYGBIV), you need to lock the 568A sequence into memory — it's always the same, just like nature's color order never changes.

**Definition**: [[568A]] defines this specific wire color order from pin 1 to pin 8 in an [[RJ45 connector]]:

| Pin | Color |
|-----|-------|
| 1 | White/Green |
| 2 | Green |
| 3 | White/Orange |
| 4 | Blue |
| 5 | White/Blue |
| 6 | Orange |
| 7 | White/Brown |
| 8 | Brown |

---

### 568B Color Sequence

**Analogy**: Imagine a secondary instruction manual for the same LEGO set — it produces identical results but rearranges some pieces in a different order.

**Definition**: [[568B]] is the alternate [[wire arrangement]] standard, which shifts the orange and green color pairs. Here's the sequence:

| Pin | Color |
|-----|-------|
| 1 | White/Orange |
| 2 | Orange |
| 3 | White/Green |
| 4 | Blue |
| 5 | White/Blue |
| 6 | Green |
| 7 | White/Brown |
| 8 | Brown |

**Key Difference**: Notice that 568B swaps positions 2-3 and 6-7 compared to 568A — orange moves to the front, green moves to the back.

---

### RJ45 Connector

**Analogy**: Like a serial number printed on a product, the [[RJ45 connector]] is the standardized plug that ensures your cable will physically fit into any network port worldwide.

**Definition**: The [[RJ45]] (Registered Jack 45) is the 8-pin modular connector used on both ends of [[Ethernet cables]] and compatible with [[Cat5e]], [[Cat6]], and [[Cat6a]] cabling infrastructure.

---

### Why Two Standards Exist

**Analogy**: Like having both Celsius and Fahrenheit for temperature — both work perfectly fine, but picking one and sticking with it prevents confusion.

**Definition**: Although both 568A and 568B achieve identical [[data transmission]] speeds and performance, organizations must choose one standard for their entire installation to maintain consistency during [[installation]] and [[troubleshooting]].

---

### The 568B Dominance in North America

**Analogy**: It's like how most of the world drives on the right side of the road, but the UK drives on the left — 568B won the popularity contest in the US, even though 568A works just as well.

**Definition**: In the United States and most commercial environments, [[568B]] has become the de facto standard. Organizations rarely switch standards mid-installation; once they select 568B (or 568A), every single cable in their infrastructure follows that pattern.

---

## Exam Tips

### Question Type 1: Wire Color Identification
- *"When terminating a cable using the 568B standard, which color wire should be placed in pin 1?"* → White/Orange
- **Trick**: The exam may show you a picture of an 568A cable and ask you to identify what's "wrong" about it when 568B is required. They're testing whether you know both sequences, not just one.

### Question Type 2: Standard Selection
- *"A company has installed their entire network using 568A. A new technician arrives and wants to use 568B for a new patch cable. What should happen?"* → The new cable should also use 568A to maintain consistency.
- **Trick**: The exam wants to test whether you understand **organizational standards compliance**, not technical superiority (both standards are equally valid).

### Question Type 3: Troubleshooting Scenario
- *"You find a cable that doesn't follow the standard color sequence. What is the first step?"* → Verify which standard your organization uses, then check if the cable matches it.
- **Trick**: Don't assume a "mixed" or "wrong" cable is defective — always confirm against your documented standard first.

---

## Common Mistakes

### Mistake 1: Memorizing Only One Standard
**Wrong**: "I only need to know 568B because it's more common."
**Right**: You must know both 568A and 568B sequences — the exam will test your ability to identify either one and explain the differences.
**Impact on Exam**: You could fail questions asking "which standard uses White/Green in position 1?" if you only memorized 568B.

---

### Mistake 2: Thinking the Standards Affect Speed
**Wrong**: "568B is faster than 568A because it's more widely used."
**Right**: Both standards transmit data at identical speeds. The standard choice is purely about organizational consistency, not performance.
**Impact on Exam**: The exam may include a distractor answer claiming one standard is "faster" — knowing this is false prevents you from selecting it.

---

### Mistake 3: Confusing Pin Order
**Wrong**: Thinking pins are numbered from right to left instead of left to right when looking at the connector.
**Right**: When holding an [[RJ45 connector]] with the clip facing away from you, pins are numbered 1–8 from LEFT to RIGHT.
**Impact on Exam**: A diagram question could trick you if you don't have the correct pin orientation in your mind. Always mentally align: left side = pins 1-4, right side = pins 5-8.

---

### Mistake 4: Assuming Mixed Cables Are Always Bad
**Wrong**: "Any cable that doesn't follow 568A or 568B is broken."
**Right**: A cable using 568A on one end and 568B on the other end is called a **[[crossover cable]]**, which serves a specific (though legacy) purpose. Straight-through cables match on both ends.
**Impact on Exam**: You may encounter a question about crossover cables — knowing they intentionally mix standards prevents misdiagnosis.

---

## Related Topics
- [[RJ45 Connector]]
- [[Ethernet Cables]]
- [[Cat5e vs Cat6 vs Cat6a]]
- [[Crossover Cables]]
- [[TIA/EIA Standards]]
- [[Network Troubleshooting]]
- [[Cable Termination]]
- [[Physical Layer Cabling]]

---

*Source: Professor Messer CompTIA A+ Core 1 (220-1201) | [[A+]] | [[Network Infrastructure]]*