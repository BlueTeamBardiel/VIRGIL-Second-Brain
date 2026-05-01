---
tags: [knowledge, ccna, chapter-2]
created: 2026-04-30
cert: CCNA
chapter: 2
source: rewritten
---

# 2. Interfaces and Cables
**A whirlwind tour of how physical connections turn raw bits into network traffic.**

---

## Core Concepts

### Ethernet Basics
**Analogy**: Imagine Ethernet as a bustling highway where cars (data packets) zip back and forth, each following strict lane rules.  
**Ethernet**: [[Ethernet]] is a family of network protocols governed by the [[IEEE 802.3]] standard, set up in 1983 by the [[Institute of Electrical and Electronics Engineers (IEEE)]] to keep data moving reliably across devices.

---

### Copper Cable Types and Limits
**Analogy**: Copper cables are like twin‑track railroads—twisted to keep the wheels (signals) from jamming each other with interference.  
**Unshielded Twisted Pair (UTP)**: The most common copper cable, capped at **100 m** to avoid signal loss, with twists that cancel out electromagnetic interference (EMI).

| Speed | Common Name | IEEE Standard | Informal Name | Max Length |
|-------|-------------|---------------|---------------|------------|
| 10 Mbps | Ethernet | 802.3i | 10BASE‑T | 100 m |
| 100 Mbps | Fast Ethernet | 802.3u | 100BASE‑T | 100 m |
| 1 Gbps | Gigabit | 802.3ab | 1000BASE‑T | 100 m |
| 10 Gbps | 10‑Gig Ethernet | 802.3an | 10GBASE‑T | 100 m |

---

### Straight‑Through vs. Crossover
**Analogy**: Think of straight‑through as a one‑way street connecting a house to a shop, while crossover is a two‑way street that lets two shops talk directly.  
**Straight‑Through Cable**: Connects **different** device types (e.g., PC ↔ switch, router ↔ switch). Pin 1 on one end maps to pin 1 on the other—same layout on both ends. Supports full‑duplex operation.  
**Crossover Cable**: Connects **similar** devices (e.g., PC ↔ PC, switch ↔ switch). Transmit pins on one end swap with receive pins on the other.  
**Auto MDI‑X**: Modern devices auto‑detect cable type, eliminating the need for crossover cables.

```bash
# Example: Verify interface status (works on both straight‑through and crossover setups)
show interfaces status
```

---

### Pin Assignments and MDI‑X
**Analogy**: Picture each device as a dance partner, with specific legs (pins) reserved for sending (Tx) and receiving (Rx) the rhythm.  
**Pin Layouts** (2‑pair standards like 10BASE‑T/100BASE‑T):

| Device Type | Tx Pins | Rx Pins |
|-------------|---------|---------|
| Router / Firewall | 1 & 2 | 3 & 6 |
| PC | 1 & 2 | 3 & 6 |
| Switch | 3 & 6 | 1 & 2 |

---

### 4‑Pair Gigabit and 10‑Gig Ethernet
**Analogy**: Upgrade to a highway with four lanes, allowing far more cars (data) to move in both directions simultaneously.  
**1000BASE‑T**: Uses all four twisted pairs to deliver 1 Gbps over 100 m of UTP.  
**10GBASE‑T**: Leverages the same four pairs but pushes 10 Gbps, still limited to 100 m due to copper constraints.

---

### SFP Transceivers
**Analogy**: Think of an SFP as a hot‑swap plug‑and‑play adapter that lets you switch between copper and fiber without changing the whole cabling layout.  
**SFP (Small Form‑factor Pluggable)**: Hot‑swappable module that supports both fiber and copper media, making it versatile for core and distribution layers.

```bash
# Sample SFP status check
show interface GigabitEthernet0/1 transceiver
```

---

### Fiber Optic Fundamentals
**Analogy**: Fiber is like a high‑speed bullet train—light beams travel through a core, immune to electrical noise, and can cover miles without slowing down.  

| Informal Name | IEEE Standard | Speed | Cable Type | Max Length |
|---------------|---------------|-------|------------|------------|
| 1000BASE‑LX | 802.3z | 1 Gbps | Multimode or Single‑mode | 550 m / 5 km |
| 10GBASE‑SR | 802.3ae | 10 Gbps | Multimode | 400 m |
| 10GBASE‑LR | 802.3ae | 10 Gbps | Single‑mode | 10 km |
| 10GBASE‑ER | 802.3ae | 10 Gbps | Single‑mode | 30 km |

#### Multimode Fiber (MMF)
**Analogy**: MMF is a wide‑bore highway that lets light take multiple detours, good for short‑haul, cheaper LED drivers.  
- Core diameter: ~50 µm  
- Max distance: OM1/OM2 ≈ 2 km; OM3/OM4 ≈ 550 m  
- Cost: Lower (LED sources)

#### Single‑Mode Fiber (SMF)
**Analogy**: SMF is a super‑narrow expressway where light travels in a straight line, ideal for long‑haul, laser sources.  
- Core diameter: ~8–10 µm  
- Max distance: Up to 100 km (or more with high‑power lasers)  
- Cost: Higher (laser drivers)

---

## Exam Tips

### Question Type 1: Cable Selection  
- *"Which cable should you use to connect two switches 30 m apart to achieve 10 Gbps?"* → **10GBASE‑T** (or 10GBASE‑SR if fiber).  
- **Trick**: Many candidates assume any 10 Gbps cable works; remember copper 10G is capped at 100 m.

### Question Type 2: Pinouts  
- *"On a straight‑through Ethernet cable, which pin on the PC sends data to the switch’s receive pin?"* → **Pin 1 (Tx) ↔ Pin 3 (Rx)** on the switch.  
- **Trick**: Don’t confuse the switch’s Tx/​Rx pins with those of the PC; they’re swapped.

---

## Common Mistakes

### Mistake 1: Assuming All UTP Cables Are the Same  
**Wrong**: Thinking a Cat5 cable works identically to Cat5e or Cat6 for all speeds.  
**Right**: Cat5 supports up to 100 Mbps; Cat5e supports 1 Gbps; Cat6 supports 10 Gbps but may need shorter runs for full performance.  
**Impact on Exam**: Incorrect cable choice can lead to failed speed or link questions.

### Mistake 2: Ignoring MDI‑X Capability  
**Wrong**: Believing you must always use a crossover cable between two switches.  
**Right**: Modern switches support Auto MDI‑X, automatically configuring the interface for straight‑through or crossover as needed.  
**Impact on Exam**: Misinterpretation may cause you to answer “crossover cable required” incorrectly.

---

## Related Topics
- [[Ethernet]]
- [[Fiber Optics]]
- [[SFP]]
- [[MDI-X]]

---

*Source: CCNA 200-301 Study Notes | [[CCNA]]*