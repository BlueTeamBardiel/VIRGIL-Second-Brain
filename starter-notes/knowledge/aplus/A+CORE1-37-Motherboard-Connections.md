---
tags: [knowledge, aplus, core-1-(220-1201)]
created: 2026-04-30
cert: CompTIA A+
chapter: 37
source: rewritten
---

# Motherboard Connections
**The physical pathways that deliver power and data between your motherboard and every component in your system.**

---

## Overview

Your motherboard is like the nervous system of a computer—it needs constant power and communication channels to keep everything working. Understanding how [[motherboards]] connect to [[power supplies]] and expansion cards is critical for the A+ exam because you'll need to identify, install, and troubleshoot these connections in real scenarios. Get these connectors wrong, and your entire build fails to boot.

---

## Key Concepts

### ATX Power Connector (24-pin)

**Analogy**: Think of your motherboard's power connector like a home's electrical panel—it's the main breaker that distributes different voltage levels (3.3V, 5V, 12V) throughout the entire house, with each wire carrying a specific voltage to different "rooms" (components).

**Definition**: The [[ATX power connector]] is the primary 24-pin connector that supplies multiple voltage rails to the motherboard. Modern boards use this configuration, though legacy systems used a 20-pin version that can still be adapted.

| Feature | Details |
|---------|---------|
| **Pin Count** | 24 pins (modern); 20 pins (legacy) |
| **Voltages Supplied** | 3.3V, 5V, 12V DC |
| **Keying** | Shaped pins prevent incorrect insertion |
| **Locking Mechanism** | Latch/clip secures connection |
| **Compatibility** | 24-pin compatible with 20-pin boards (4 pins unused) |

---

### Keying and Mechanical Fit

**Analogy**: Keying works like a puzzle piece—you can't force the wrong shape into a slot no matter how hard you push. The connector only slides in one correct way.

**Definition**: [[Keying]] refers to the unique asymmetrical pin and socket shapes on connectors that prevent installation in reverse or incorrect orientation. This passive safety mechanism ensures [[polarization]] and protects components from damage.

**Key Points**:
- All pins on the 24-pin have different shaped receptacles
- Matching the connector shape to the motherboard socket is mandatory
- Attempting to force an incorrectly oriented connector can damage pins permanently

---

### Modular Power Supply Cables

**Analogy**: Like a LEGO building system, modular cables let you disconnect unused pieces so your case doesn't look like a rat's nest of wires.

**Definition**: [[Modular power supplies]] feature detachable cables, allowing technicians to remove unused connectors (like the extra 4-pin section of a 24-pin) and keep only what they need connected.

**Benefit**: Reduces cable clutter, improves airflow, and simplifies troubleshooting.

---

### Locking Mechanisms

**Analogy**: Your power connector works like a car's seatbelt clip—once locked, it won't come loose during normal operation, but you need to deliberately release the latch to remove it.

**Definition**: [[Latching mechanisms]] (clips or levers) on power connectors lock the cable firmly to the motherboard, preventing accidental disconnection during system operation.

---

## Exam Tips

### Question Type 1: Identifying Power Connectors

- *"A technician has a 20-pin motherboard but only a 24-pin power supply cable. What should they do?"* → Use the 24-pin connector; the extra 4 pins will simply not connect, or disconnect them if using a [[modular power supply]].
- **Trick**: The exam might suggest you need a special adapter—you don't for modern boards. However, older boards genuinely need 20-pin cables.

### Question Type 2: Connector Keying and Orientation

- *"You're installing a power connector but it won't seat all the way. What's the likely cause?"* → Misaligned keying—the connector is being forced at the wrong angle. Remove it and rotate to match the key.
- **Trick**: Don't assume the connector is damaged; 95% of the time it's just rotated 180 degrees.

### Question Type 3: Modular vs. Non-Modular

- *"Which power supply type allows removal of unused cables?"* → [[Modular power supplies]].
- **Trick**: Semi-modular supplies have some fixed cables and some detachable ones—the exam loves this distinction.

---

## Common Mistakes

### Mistake 1: Forcing a Misaligned 24-pin Connector

**Wrong**: "The connector looks fine, I'll just push harder until it clicks."
**Right**: "The connector doesn't seat easily—stop immediately, check keying alignment, and reposition before trying again."
**Impact on Exam**: You could be asked what prevents damage during installation. The answer is respecting the keying mechanism, not brute force.

---

### Mistake 2: Confusing 20-pin vs. 24-pin as Incompatible

**Wrong**: "A 20-pin motherboard requires a 20-pin power supply cable exclusively."
**Right**: "A 24-pin cable works with a 20-pin motherboard; the extra pins simply won't connect (or can be disconnected on modular supplies)."
**Impact on Exam**: You might see a scenario where only a 24-pin supply is available—the correct answer is that it will work.

---

### Mistake 3: Forgetting About Supplemental Power Connectors

**Wrong**: "The 24-pin connector provides all power needed for any motherboard."
**Right**: "Modern boards often have additional 4-pin or 8-pin connectors (CPU power) near the processor that must also be connected."
**Impact on Exam**: A system that boots partially but fails under load or during CPU operations often has the 24-pin connected but supplemental power missing.

---

## Related Topics

- [[ATX Power Supply Standards]]
- [[CPU Power Connectors (4-pin and 8-pin)]]
- [[PCI-E Power Connectors]]
- [[SATA Power Connectors]]
- [[Motherboard Form Factors]]
- [[Power Supply Wattage and Rail Calculations]]
- [[Troubleshooting Boot Failures]]

---

*Source: Professor Messer CompTIA A+ Core 1 (220-1201) | [[A+ Core 1 Study Guide]]*