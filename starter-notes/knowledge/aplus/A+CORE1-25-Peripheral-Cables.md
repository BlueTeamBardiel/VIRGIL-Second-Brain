---
tags: [knowledge, aplus, core-1-(220-1201)]
created: 2026-04-30
cert: CompTIA A+
chapter: 25
source: rewritten
---

# Peripheral Cables
**The standardized connectors and protocols that link your external devices to the computer.**

---

## Overview

Peripheral cables are the physical pathways that allow your computer to communicate with external devices like keyboards, mice, printers, and storage drives. Understanding cable specifications, connector types, and speed limitations is critical for the A+ exam because you'll need to troubleshoot connectivity issues, recommend appropriate cables for different scenarios, and identify compatibility problems. This is one of the foundational hardware concepts that appears frequently on both Core 1 and Core 2 exams.

---

## Key Concepts

### Universal Serial Bus (USB)

**Analogy**: Think of [[USB]] like a highway system—it's a standardized route that all vehicles (devices) can use, with specific speed limits (bandwidth) and lane widths (connector types) that ensure everything works together smoothly.

**Definition**: [[USB]] (Universal Serial Bus) is the dominant peripheral connectivity standard that provides both data transmission and power delivery through a single standardized interface, eliminating the need for proprietary cables.

| USB Version | Speed (Bandwidth) | Max Cable Length | Common Use |
|---|---|---|---|
| [[USB 1.1]] Low Speed | 1.5 Mbps | 3 meters | Legacy keyboards/mice |
| [[USB 1.1]] Full Speed | 12 Mbps | 5 meters | Early peripherals |
| [[USB 2.0]] | 480 Mbps | 5 meters | Printers, external drives |
| [[USB 3.0]] (SuperSpeed) | 5 Gbps | 3 meters | High-speed storage |
| [[USB 3.1]] | 10 Gbps | ~3 meters | Modern external drives |
| [[USB 3.2]] | 20 Gbps | ~3 meters | Latest high-bandwidth devices |

---

### USB Connector Types

**Analogy**: Different USB connectors are like different puzzle piece shapes—they're all part of the same system, but each shape is designed for specific devices (Type-A fits into computer ports, Type-B fits into printers, Type-C is the newer universal shape).

**Definition**: [[USB connectors]] come in multiple form factors (Type-A, Type-B, Type-C, Mini, Micro) designed for different device types and generations.

| Connector Type | Used For | Direction | Notes |
|---|---|---|---|
| [[USB Type-A]] | Computers, hubs, chargers | Directional (one way) | Most common, flat rectangular |
| [[USB Type-B]] | Printers, scanners, older devices | Directional (one way) | Square-ish shape, less common now |
| [[USB Type-C]] | Modern devices, phones, laptops | Reversible (either way) | 24-pin connector, replaces all types |
| [[USB Mini-B]] | Digital cameras, older devices | Directional | Smaller Type-B variant |
| [[USB Micro-B]] | Phones, tablets | Directional | Smaller than Mini |

---

### Cable Length and Signal Integrity

**Analogy**: USB cables are like whisper-down-the-lane—the farther the message travels, the more it degrades. That's why longer cables mean slower speeds; the electrical signal weakens over distance.

**Definition**: [[Signal degradation]] occurs when electrical signals traveling through cables lose integrity over distance, necessitating maximum cable length specifications to maintain advertised speeds.

**Key Point**: The [[USB specification]] does not mandate an exact cable length, but the maximum lengths listed (3-5 meters) represent the practical limits where the signal remains strong enough to maintain that version's maximum speed.

---

## Exam Tips

### Question Type 1: Speed and Compatibility
- *"A user reports their external hard drive is running at 480 Mbps instead of the expected 5 Gbps. The device supports USB 3.0. What is the most likely cause?"* → The cable is [[USB 2.0]], not [[USB 3.0]]. You cannot exceed a cable's rated speed, regardless of device capability.
- **Trick**: A [[USB 3.0]] device plugged into a [[USB 2.0]] cable will always run at [[USB 2.0]] speeds (480 Mbps). Don't assume the device determines speed—the cable's weakest link wins.

### Question Type 2: Connector Identification
- *"Which USB connector type is reversible and can be inserted either direction?"* → [[USB Type-C]]. This is the only bidirectional connector.
- **Trick**: [[USB Type-A]] and [[USB Type-B]] are directional. The exam may show a picture and ask which one you can insert two ways—always [[USB Type-C]].

### Question Type 3: Cable Length Scenarios
- *"An office needs to connect a printer 8 meters away from the nearest USB port. What should the technician do?"* → Use a [[USB hub]] or [[USB extender cable]] to bridge the distance while maintaining signal integrity, since standard cables max out at 5 meters.
- **Trick**: You cannot just use a longer cable and expect it to work. Exceeding length limits causes signal loss and disconnections.

---

## Common Mistakes

### Mistake 1: Confusing Device Speed with Cable Speed

**Wrong**: "I have a USB 3.0 printer, so it will transfer data at 5 Gbps even if I use an old USB 2.0 cable."

**Right**: The cable's specifications determine the maximum speed. A USB 2.0 cable will bottleneck a USB 3.0 device to 480 Mbps, regardless of the device's capability.

**Impact on Exam**: This appears on performance questions. The answer is always "the slowest component in the chain determines the speed."

---

### Mistake 2: Assuming All USB Type-C Devices Are the Same Speed

**Wrong**: "USB Type-C is the newest connector, so it's always USB 3.0 or faster."

**Right**: [[USB Type-C]] is only a connector shape. It can carry [[USB 2.0]] (480 Mbps), [[USB 3.0]] (5 Gbps), or higher speeds depending on the cable and device. A cheap USB Type-C cable might only support USB 2.0.

**Impact on Exam**: The exam distinguishes between connector type and speed generation. You must read carefully—look for "USB 3.0 Type-C" or "USB 2.0 Type-C" to understand actual speed.

---

### Mistake 3: Ignoring Maximum Cable Length Limits

**Wrong**: "I'll just buy a 10-meter USB cable—it might be slow but it'll work fine."

**Right**: Exceeding the maximum cable length causes [[signal degradation]], intermittent disconnections, and complete connection failure. You cannot "just accept slower speeds" beyond spec—the device stops working.

**Impact on Exam**: Troubleshooting scenarios often include distance problems. If a device works at 3 meters but fails at 8 meters, the cable length is the culprit, and a hub or extender is the solution.

---

## Related Topics

- [[USB Hubs and Extenders]]
- [[Power Delivery and USB]]
- [[Connector Types and Form Factors]]
- [[Peripheral Devices]]
- [[Serial vs. Parallel Connections]]
- [[Legacy Cables (Parallel, Serial, PS/2)]]
- [[Troubleshooting Connectivity Issues]]

---

*Source: CompTIA A+ Core 1 (220-1201) | [[A+]] Study Companion*