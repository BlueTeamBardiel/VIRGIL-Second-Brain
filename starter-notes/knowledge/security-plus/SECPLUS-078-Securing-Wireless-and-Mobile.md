---
tags: [knowledge, security-plus, secplus]
created: 2026-05-01
cert: CompTIA Security+
exam: SY0-701
chapter: 078
source: rewritten
---

# Securing Wireless and Mobile
**Conducting thorough wireless environmental assessments ensures optimal coverage, identifies interference risks, and validates network design before deployment.**

---

## Overview
Before deploying a new [[wireless network]] or fixing problems with an existing one, organizations need to understand their radio frequency environment. A [[site survey]] is the foundational process for mapping signal strength, identifying neighboring networks, and planning optimal [[access point]] placement. This matters for Security+ because wireless security begins with understanding your physical environment—if you don't know what signals exist around you, you can't properly configure defenses against interference, rogue access points, or signal leakage.

---

## Key Concepts

### Site Survey
**Analogy**: Like inspecting a building before setting up a security system—you need to walk through every room, understand the walls and obstacles, and see where vulnerabilities exist before installing cameras and alarms.

**Definition**: A methodical assessment of the physical environment where wireless equipment operates, measuring signal propagation, identifying interference sources, and determining optimal [[access point]] placement.

Related processes: [[RF spectrum analysis]], [[channel planning]], [[coverage mapping]]

| Survey Phase | Purpose |
|---|---|
| **Inventory** | Identify all nearby [[access points]] (yours and others') |
| **Measurement** | Record signal strength across physical space |
| **Analysis** | Determine interference sources and dead zones |
| **Planning** | Recommend placement, channels, and power settings |
| **Validation** | Periodically re-survey to detect changes |

---

### Access Point Discovery
**Analogy**: Imagine walking into a crowded room and trying to identify who's speaking—you need to listen carefully to distinguish each voice, their location, and whether they belong to your group or are outsiders.

**Definition**: The process of detecting and cataloging all wireless transmitters in an area, distinguishing between your own [[managed access points]] and uncontrolled external sources that may cause [[interference]] or security risks.

Related concepts: [[SSID scanning]], [[rogue access point]] detection, [[neighboring network assessment]]

Distinction from your infrastructure:
- **Internal APs**: Under your control; documented in your network topology
- **External APs**: Outside your control; may operate on overlapping [[channels]] and cause [[co-channel interference]]

---

### Heat Mapping
**Analogy**: Like a thermal image showing warm and cold spots in a building, a heat map uses color gradients to visualize signal strength distribution across physical space.

**Definition**: A visual representation of [[wireless signal strength]] variation across a facility, where warmer colors (red/yellow) indicate strong coverage and cooler colors (blue/dark) indicate weak or absent signals.

Typical heat map characteristics:
- **Strong zones**: Appear red or orange; typically within 20-30 feet of [[access point]]
- **Marginal zones**: Appear yellow or light green; acceptable but degraded performance
- **Weak zones**: Appear blue or dark; unreliable connectivity
- **Dead zones**: Appear black or are unmapped; no practical coverage

Tools that generate heat maps: [[Ekahau]], [[NetSpot]], [[site survey tools]]

---

### Channel Planning
**Analogy**: Like assigning different radio frequencies to different stations so they don't jam each other—you must choose non-overlapping channels for your APs and account for neighbors doing the same.

**Definition**: The process of selecting [[wireless channels]] for your [[access points]] that minimize interference with nearby networks and your own APs.

| Standard | Non-Overlapping Channels | Typical Selection |
|---|---|---|
| **802.11b/g (2.4 GHz)** | 1, 6, 11 (US/Canada) | Choose any three |
| **802.11a (5 GHz)** | 36, 40, 44, 48, 52, 56, 60, 64... | Many available options |
| **802.11ac/ax** | Primarily 5 GHz and 6 GHz | Broader spectrum less congested |

The [[site survey]] reveals which channels neighbors occupy, guiding your selection to avoid [[co-channel interference]] and adjacent-channel interference.

---

### Periodic Re-Assessment
**Analogy**: Like updating a security audit every year—conditions change, new threats emerge, and old solutions may no longer work.

**Definition**: The practice of repeating wireless site surveys at regular intervals to detect changes in the RF environment, new interference sources, or newly installed competing networks.

Why it matters:
- Neighboring organizations may add new [[access points]]
- Physical barriers may change (construction, renovations)
- Interference sources may appear or move
- Your network growth may require new AP placement
- [[regulatory changes]] may affect available [[channels]]

Recommended frequency: Annually, or immediately after physical facility changes

---

## Exam Tips

### Question Type 1: Site Survey Purpose and Timing
- *"A company is deploying wireless access points across a new office building. What should be done FIRST?"* → Conduct a site survey to understand signal propagation, identify interference, and plan optimal AP placement.
- **Trick**: Don't confuse "site survey" with "security audit"—the survey is about RF environment assessment, not authentication or encryption testing.

### Question Type 2: Heat Map Interpretation
- *"A heat map shows red in the executive area and blue in the warehouse. What does this indicate?"* → The executive area has strong [[wireless signal strength]]; the warehouse has weak or no coverage and may need additional [[access points]].
- **Trick**: Remember color meanings (red = strong, blue = weak)—don't reverse them in your mind under exam pressure.

### Question Type 3: Channel Conflict Resolution
- *"You discover neighboring APs on channels 1 and 6. Which channel should your AP use?"* → Channel 11 (in 2.4 GHz) to avoid [[co-channel interference]].
- **Trick**: Only channels 1, 6, and 11 are truly non-overlapping in 2.4 GHz—other channels will still suffer interference.

### Question Type 4: Re-Survey Timing
- *"After installing a wireless network, when should a site survey be repeated?"* → Periodically (annually) and whenever environmental changes occur.
- **Trick**: This is about maintenance, not one-time deployment—expect continuous monitoring on the exam.

---

## Common Mistakes

### Mistake 1: Skipping Site Survey Before Deployment
**Wrong**: Installing [[access points]] based only on floor plan assumptions and estimating coverage without RF measurement.
**Right**: Conducting formal site survey to measure actual signal behavior, account for building materials, and validate coverage before production use.
**Impact on Exam**: You'll see questions testing whether you understand that site surveys prevent costly deployment failures, dead zones, and interference problems that emerge after go-live.

### Mistake 2: Confusing 2.4 GHz and 5 GHz Channel Options
**Wrong**: Assuming all [[channels]] are non-overlapping and treating 2.4 GHz like 5 GHz.
**Right**: 2.4 GHz offers only three non-overlapping channels (1, 6, 11); 5 GHz offers many more, making channel selection easier and reducing [[co-channel interference]].
**Impact on Exam**: Channel-planning questions often test whether you know the practical limits of 2.4 GHz and why 5 GHz is preferred in dense environments.

### Mistake 3: Treating Site Survey as One-Time Activity
**Wrong**: Conducting site survey once at deployment and assuming conditions remain static.
**Right**: Viewing site survey as baseline assessment requiring periodic re-assessment to catch environmental changes, new neighboring APs, and coverage drift.
**Impact on Exam**: Wireless security questions increasingly focus on ongoing monitoring—static assumptions are a red flag answer choice.

### Mistake 4: Misinterpreting Heat Map Colors
**Wrong**: Associating blue with good coverage (confusing RF heat maps with temperature thermal images).
**Right**: Remembering that in RF heat maps, red/yellow = strong signal, blue/dark = weak signal.
**Impact on Exam**: Visual-based questions will test your ability to interpret heat maps correctly under timed pressure.

---

## Related Topics
- [[Wireless Network Standards]] (802.11a/b/g/n/ac/ax)
- [[Co-channel Interference]]
- [[Rogue Access Point Detection]]
- [[RF Spectrum Analysis]]
- [[Access Point Configuration and Hardening]]
- [[Wireless Security Protocols]] ([[WPA2]], [[WPA3]])
- [[Channel Planning and Frequency Selection]]
- [[Signal Propagation and Path Loss]]

---

*Source: Rewritten from Professor Messer CompTIA Security+ SY0-701 Lecture Series | [[Security+]] | [[Wireless and Mobile Security]]*