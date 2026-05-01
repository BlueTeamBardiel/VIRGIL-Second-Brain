---
tags: [knowledge, aplus, core-1-(220-1201)]
created: 2026-04-30
cert: CompTIA A+
chapter: 22
source: rewritten
---

# Network Cables
**The physical pathways that carry data everywhere on your network, from computers to servers to that wireless access point on your wall.**

---

## Overview

Network cabling is the invisible backbone that makes every device connection possible. When you plug a computer into the network or connect a wireless access point to your infrastructure, cables are doing the heavy lifting behind the scenes. For the A+ exam, understanding cable types, specifications, and proper installation is critical because poor cabling creates network failures that no amount of software fixes can solve.

---

## Key Concepts

### [[Twisted Pair Copper Cabling]]

**Analogy**: Think of twisted pair cables like a DNA helix—two strands spiraling around each other. Just as the double helix protects genetic information through its structure, the twisting pattern protects data signals from electromagnetic interference in the surrounding environment.

**Definition**: A [[network transmission medium]] consisting of four color-coded wire pairs (blue, green, orange, brown) twisted together inside a single jacket. Each pair carries balanced signals—one wire transmits the positive signal while its partner transmits the inverted (negative) signal simultaneously.

**Why the twist matters**: The constant rotation of paired wires moves them away from environmental electromagnetic noise. When the receiving device gets both signals, it can calculate the difference between them to extract the real data and reject interference.

| Cable Type | Speed | Distance | Cost | Use Case |
|-----------|-------|----------|------|----------|
| [[Cat5]] | 100 Mbps | 100m | Low | Legacy networks (outdated) |
| [[Cat5e]] | 1 Gbps | 100m | Low | Standard office networks |
| [[Cat6]] | 10 Gbps | 55m | Medium | High-speed modern networks |
| [[Cat6a]] | 10 Gbps | 100m | High | Enterprise, future-proofing |
| [[Cat7]] | 10 Gbps | 100m | High | Shielded, industrial use |

---

### [[Fiber Optic Cabling]]

**Analogy**: Imagine replacing a copper pipe that carries water with a fiber-optic cable—it's like switching from water flow to beams of light traveling through glass. The light pulses represent your data, completely immune to the electromagnetic interference that would disturb copper wires.

**Definition**: [[Transmission media]] using pulses of light traveling through ultra-thin glass or plastic strands to transmit data at extremely high speeds over long distances.

**Two varieties**:
- **[[Single-Mode Fiber (SMF)]]**: Thinner core, one light path, extreme distance (40+ km), used by ISPs
- **[[Multimode Fiber (MMF)]]**: Thicker core, multiple light paths, shorter distance (2 km), data center deployments

**Advantages**: Immune to [[EMI]] (electromagnetic interference), higher bandwidth, longer distances, secure (hard to tap)

**Disadvantages**: Expensive, fragile, requires specialized equipment to install and troubleshoot

---

### [[Cable Shielding]]

**Analogy**: Shielding is like putting a metal cage around your data signals—the cage reflects stray electromagnetic noise away from the wires inside, similar to how a metal coffee can shields radio signals.

**Definition**: A conductive layer (usually braided copper or foil) wrapped around wire pairs to block external [[electromagnetic interference]].

**Shielding types**:
- **[[UTP]]** (Unshielded Twisted Pair): No shielding, standard for offices
- **[[STP]]** (Shielded Twisted Pair): Full foil wrap, used near electrical equipment
- **[[FTP]]** (Foil Twisted Pair): Lighter shielding option

---

### [[Cable Installation and Termination]]

**Analogy**: Properly terminating a cable is like carefully threading a needle—one wrong move and the whole thing fails. The order of wire colors at the connector is as critical as the sequence of stitches.

**Definition**: The process of attaching [[RJ45]] connectors to cable ends following industry-standard color sequences to ensure proper data transmission.

**Two standard wiring sequences** (MUST memorize for exam):

```
T568A: White-Blue, Blue, White-Green, Green, White-Orange, Orange, White-Brown, Brown
T568B: White-Orange, Orange, White-Green, Green, White-Blue, Blue, White-Brown, Brown
```

**Cable types**:
- **[[Straight-through cable]]**: Both ends use SAME standard (568A on both, or 568B on both) — 99% of all network cables
- **[[Crossover cable]]**: One end 568A, other end 568B — used only for direct device-to-device connection (rarely needed in modern networks with auto-sensing)

**Installation best practices**:
- Don't bend cables tighter than 1 inch radius
- Keep [[Cat5e/Cat6]] away from power lines (minimum 3 inches)
- Don't exceed 328 feet (100 meters) per [[IEEE 802.3]]
- Test every cable after installation with a [[cable tester]]

---

## Exam Tips

### Question Type 1: Cable Type Identification
- *"A customer needs to run Ethernet across 200 feet of distance in a warehouse with heavy electrical equipment. Which cable type should you recommend?"* → [[Cat6]] or [[Cat6a]] with [[STP]] shielding to handle distance and electromagnetic noise
- **Trick**: Candidates often pick fiber optic when Cat6a works fine—fiber is expensive and adds complexity. Save fiber for ISP backbone links.

### Question Type 2: Wiring Standards
- *"You're terminating a cable in a standard office environment. What color sequence goes after white-orange?"* → Orange (T568B sequence)
- **Trick**: Test makers mix up which standard came first. T568A was older but either works—consistency is what matters. Know BOTH sequences cold.

### Question Type 3: Cable Troubleshooting
- *"A network port works intermittently and you suspect installation issues. What's the most likely cause?"* → Cable bent too sharply, run too close to power lines, or improper termination
- **Trick**: The test wants you to understand that physical layer problems cause Layer 1 failures before any software issue could occur.

---

## Common Mistakes

### Mistake 1: Confusing Cable Categories with Speed Guarantees
**Wrong**: "I bought Cat6 cable so my network will automatically run at 10 Gbps"
**Right**: Cat6 *supports* 10 Gbps, but your network speed depends on your equipment (network cards, switches), not just the cable
**Impact on Exam**: Questions test whether you understand that cable is ONE component of a complete network system

### Mistake 2: Using Crossover Cables for Standard Connections
**Wrong**: "I'll use a crossover cable to connect my computer to the switch because it sounds more technical"
**Right**: Use straight-through cables for computer-to-switch connections; crossover cables only for direct device-to-device connections
**Impact on Exam**: Modern networks auto-sense, but A+ still tests knowledge of when each cable type applies

### Mistake 3: Ignoring Shielding Requirements
**Wrong**: "Shielding doesn't matter; all cables transmit data the same way"
**Right**: In electrically noisy environments (factories, medical facilities), [[STP]] shielding prevents data corruption that [[UTP]] would suffer
**Impact on Exam**: Scenario questions test your ability to match cable type to environment

### Mistake 4: Mixing 568A and 568B Standards on Same Cable
**Wrong**: "I'll terminate one end with 568A and the other with 568B for better performance"
**Right**: Consistency on both ends is mandatory—mixed standards create a non-functional or flaky connection
**Impact on Exam**: This is a reliability/troubleshooting question designed to test practical installation knowledge

---

## Related Topics
- [[RJ45 Connectors]]
- [[Network Interface Cards (NICs)]]
- [[Switches and Network Infrastructure]]
- [[IEEE 802.3 Ethernet Standards]]
- [[Electromagnetic Interference (EMI)]]
- [[Network Topology]]
- [[Copper vs. Fiber Trade-offs]]

---

*Source: Professor Messer CompTIA A+ Core 1 (220-1201) | [[A+]]*