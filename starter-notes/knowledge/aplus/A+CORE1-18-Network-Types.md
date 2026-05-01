---
tags: [knowledge, aplus, core-1-(220-1201)]
created: 2026-04-30
cert: CompTIA A+
chapter: 18
source: rewritten
---

# Network Types
**Understanding the scope and scale of networks that connect your devices.**

---

## Overview

Networks come in different sizes depending on how far apart the connected devices are from each other. Your A+ exam will hammer you on identifying which network type you're dealing with based on geographic scope and performance characteristics. Getting these distinctions locked down is critical because they determine troubleshooting approaches, technology choices, and expected speeds.

---

## Key Concepts

### Local Area Network (LAN)

**Analogy**: Think of a LAN like a neighborhood mailbox system—all the houses on your street can reach the mailbox quickly because everything is physically close together. If you need to mail something across the country, it takes much longer and involves more complex infrastructure.

**Definition**: A [[LAN]] is a network confined to a small geographic area, typically within a single building, floor, or campus. Devices communicate using [[Ethernet]] cables or [[802.11 Wireless|802.11 wireless protocols]].

**Key Characteristic**: LANs deliver the fastest data transfer speeds because there's minimal distance for signals to travel and fewer intermediary devices to slow things down.

| Feature | LAN |
|---------|-----|
| **Range** | Single building/campus |
| **Speed** | Fastest (100 Mbps–10 Gbps+) |
| **Technology** | [[Ethernet]], [[Wi-Fi]] |
| **Latency** | Lowest |

---

### Wide Area Network (WAN)

**Analogy**: A WAN is like international shipping—your package must travel through multiple sorting facilities, potentially across oceans, taking much longer than local delivery and passing through many more intermediaries.

**Definition**: A [[WAN]] connects networks across vast distances (different cities, states, countries, or continents). It's built from multiple [[LAN]]s linked together through various transmission technologies.

**Key Characteristic**: WANs sacrifice speed for distance. The geographic separation creates inherent latency and throughput limitations.

| Feature | WAN |
|---------|-----|
| **Range** | Unlimited (city to global) |
| **Speed** | Slower than LAN (varies widely) |
| **Technology** | [[Point-to-Point]], [[MPLS]], [[Frame Relay]] |
| **Latency** | Higher |

**WAN Transmission Methods**:

- **Terrestrial**: [[Fiber optic cables]], [[Copper lines]], [[Leased lines]] on Earth's surface
- **Non-Terrestrial**: [[Satellite]] links (high latency but covers remote areas)

---

### Personal Area Network (PAN)

**Analogy**: A PAN is like the devices in your pocket or on your wrist—they're so close they can whisper to each other without shouting, using very short-range radio signals.

**Definition**: A [[PAN]] is an ultra-short-range network connecting personal devices directly to an individual user. Common technologies include [[Bluetooth]], [[Infrared]], and [[Near Field Communication (NFC)]].

**Key Characteristic**: PANs operate at arm's length (typically 10 meters or less) and prioritize convenience and low power consumption over raw speed.

| Feature | PAN |
|---------|-----|
| **Range** | 1–10 meters |
| **Devices** | Phones, smartwatches, headphones, fitness trackers |
| **Technology** | [[Bluetooth]], [[IR]], [[NFC]] |
| **Power** | Ultra-low |

---

## Exam Tips

### Question Type 1: Network Type Identification
- *"A company connects three office buildings 5 miles apart using dedicated leased lines. What type of network is this?"* → **WAN** (crosses geographic distance beyond a single campus)
- *"An employee's smartwatch syncs data to their phone via wireless. What technology does this use?"* → **PAN with Bluetooth**
- *"All workstations on the third floor connect via Ethernet to a central switch. This is what type of network?"* → **LAN** (single building, high speed)

**Trick**: The exam loves asking you to distinguish between "same building, different floors" (still LAN) versus "different cities" (definitely WAN). Don't overthink it—it's about distance.

---

### Question Type 2: Performance Expectations
- *"Why do WAN connections typically show higher latency than LANs?"* → Distance = more hops = more delay
- *"What's the primary advantage of a PAN over a LAN?"* → Convenience and immediate proximity; no infrastructure needed

**Trick**: Watch for questions framing slow speeds as network failures when they're actually WAN characteristics. A 10 Mbps WAN is slow but normal; a 10 Mbps LAN is a problem.

---

## Common Mistakes

### Mistake 1: Confusing LAN Scope
**Wrong**: "Our network spans two adjacent buildings, so it's a WAN."
**Right**: "Two adjacent buildings connected by company fiber still constitute a LAN because they're part of a single local network infrastructure."
**Impact on Exam**: You'll misidentify network types and suggest wrong technologies. Loss of easy points.

---

### Mistake 2: Assuming All Wireless = LAN
**Wrong**: "My phone connected to a satellite internet is basically a LAN."
**Right**: "Satellite internet is part of a WAN because the data travels through space to distant infrastructure, creating high latency."
**Impact on Exam**: You'll fail questions about satellite networks and PANs. Know that [[802.11]] wireless *can be* a LAN technology, but wireless alone doesn't define scope.

---

### Mistake 3: Underestimating PAN Relevance
**Wrong**: "PANs aren't important for A+; they're too simple."
**Right**: "PANs appear on the exam as legitimate network types, and you need to identify when [[Bluetooth]] or [[NFC]] is appropriate."
**Impact on Exam**: You'll miss gimme questions about smartwatch connectivity or wireless earbuds.

---

### Mistake 4: Mixing Up WAN Technologies
**Wrong**: "All WANs use the same transmission method."
**Right**: "WANs can use terrestrial infrastructure ([[MPLS]], [[Frame Relay]], [[Leased Lines]]) or non-terrestrial infrastructure ([[Satellite]]), each with trade-offs."
**Impact on Exam**: You won't be able to justify why satellite WAN has different latency than fiber WAN, costing you comparison questions.

---

## Related Topics

- [[Ethernet Standards]] (LAN physical layer)
- [[Wi-Fi Standards]] ([[802.11a/b/g/n/ac/ax]])
- [[Bluetooth Versions]] (PAN standard)
- [[WAN Technologies]] ([[MPLS]], [[Frame Relay]], [[Leased Lines]])
- [[Satellite Networking]]
- [[Network Topologies]]
- [[OSI Model]] (understand which layers differ between LANs and WANs)
- [[Latency and Throughput]]

---

*Source: Rewritten from Professor Messer CompTIA A+ Core 1 (220-1201) Lecture Series | [[CompTIA A+]]*