---
tags: [knowledge, aplus, core-1-(220-1201)]
created: 2026-04-30
cert: CompTIA A+
chapter: 45
source: rewritten
---

# Computer Power
**Electricity powers everything in your machine — handle it with respect or it'll handle you.**

---

## Overview

Electrical safety and power conversion form the foundation of hardware competency. Understanding how [[AC power]] becomes [[DC power]], and knowing the dangers lurking inside a computer case, separates safe technicians from injured ones. This topic appears constantly on the A+ exam because field technicians must work inside live systems without becoming a statistic.

---

## Key Concepts

### Electrical Safety Protocol

**Analogy**: Before you change the oil in a car, you turn off the engine AND let it cool down. Similarly, before touching computer internals, you kill the power AND wait for residual energy to dissipate.

**Definition**: The mandatory practice of [[power disconnection]] and [[capacitor discharge]] before performing any internal hardware work. This prevents [[electrocution]] and damage to components.

**Critical Rules**:
- Always pull the power cable from the wall outlet (not just powering down the OS)
- Never connect yourself to building electrical systems (including ground wires—they can be live)
- Assume [[capacitors]] store lethal charge even after power is removed
- Use proper [[ESD]] grounding techniques before touching internals

---

### AC to DC Conversion

**Analogy**: Your home's water system delivers high-pressure flow (AC). A regulator reduces it to steady, one-directional flow for your appliance (DC). The [[power supply unit]] does exactly this for electricity.

**Definition**: [[Alternating Current (AC)]] flows back-and-forth from wall outlets. [[Direct Current (DC)]] flows one direction. The [[PSU]] (Power Supply Unit) converts wall AC into the stable DC that [[motherboards]] and components require.

| Property | AC Power | DC Power |
|----------|----------|----------|
| **Source** | Building electrical system | Power supply output |
| **Direction** | Oscillates (back-and-forth) | Unidirectional (constant flow) |
| **Voltage** | ~120V or ~240V (residential) | +3.3V, +5V, +12V (typical rails) |
| **Used by** | PSU input stage | Motherboard, RAM, drives, fans |
| **Danger Level** | Extremely high | Lower, but still hazardous |

---

### Power Supply Unit (PSU)

**Analogy**: A PSU is like a currency exchange booth—it takes one form of power (AC) and converts it into multiple denominations (different DC voltages) that different departments (components) need.

**Definition**: The [[PSU]] rectifies incoming AC power into stable DC outputs across multiple voltage rails, supplying [[motherboards]], [[storage devices]], [[cooling systems]], and peripheral components.

**Key Outputs**:
```
+12V Rail    → Graphics cards, some CPU power
+5V Rail     → Motherboard logic, USB devices
+3.3V Rail   → Memory, SSD controllers
-12V Rail    → Legacy serial ports (rarely used)
Ground (0V)  → Reference point for all circuits
```

**Wattage Rating**: Indicates maximum sustained power delivery. A 650W PSU doesn't mean it outputs 650W constantly—it means it *can* under peak load.

---

### Capacitor Charge Hazard

**Analogy**: A capacitor is like a balloon full of electricity. Even after you stop inflating it (power off), it still holds pressure and can burst in your face.

**Definition**: [[Capacitors]] store electrical energy in the PSU and motherboard. They maintain charge even after the system powers down, posing electrocution risk. Proper [[discharge procedures]] (grounding exposed PCBs) neutralize this danger.

---

## Exam Tips

### Question Type 1: Safety Procedures
- *"You're about to replace a power supply. What's the first step?"* → Disconnect the power cable from the wall outlet (not the system), wait 30-60 seconds, then work.
- **Trick**: Exam questions often say "shut down Windows" as the first step. Wrong—physical disconnection comes first.

### Question Type 2: AC vs DC Identification
- *"Which type of power comes from a building's wall outlet?"* → AC (Alternating Current)
- *"Which type does the motherboard use?"* → DC (Direct Current)
- **Trick**: Questions may ask "what does the PSU output?" expecting "AC power"—it outputs **DC power** on all rails.

### Question Type 3: Hazard Recognition
- *"Which component can hold a dangerous charge even after power is removed?"* → Capacitors
- **Trick**: Many candidates forget about capacitors and think disconnecting the cable eliminates all risk. It doesn't.

---

## Common Mistakes

### Mistake 1: Trusting the Power Switch
**Wrong**: "I shut down the computer, so it's safe to open now."
**Right**: Power button only signals the OS to gracefully close. The PSU circuitry remains live until the wall cable is physically disconnected.
**Impact on Exam**: You'll lose points on safety-scenario questions and, worse, risk your health in real work.

### Mistake 2: Confusing AC/DC Functions
**Wrong**: "The PSU receives DC power and converts it to AC for the motherboard."
**Right**: The PSU receives AC from the wall and converts it to DC for all internal components.
**Impact on Exam**: Direct question points lost; may also affect troubleshooting logic questions.

### Mistake 3: Grounding Yourself to Building Systems
**Wrong**: "I'll touch the metal frame of the building (or the ground wire in the outlet) to discharge static."
**Right**: Use a [[wrist strap]] connected to the PSU chassis or a proper [[anti-static mat]]. Building grounds can be energized.
**Impact on Exam**: Safety scenario questions will penalize this approach; also creates genuine hazard in the field.

### Mistake 4: Ignoring Capacitor Discharge
**Wrong**: "I disconnected the power cable, so capacitors are automatically discharged."
**Right**: Capacitors retain charge. You must manually discharge them by using an [[insulated screwdriver]] to short the capacitor terminals to ground, or wait several minutes.
**Impact on Exam**: Exam questions test knowledge of this step; field work risks electrocution.

---

## Related Topics
- [[Power Supply Unit (PSU) Selection and Wattage]]
- [[Motherboard Power Connectors (24-pin, 8-pin)]]
- [[Electrostatic Discharge (ESD) Protection]]
- [[Capacitor Technologies]]
- [[Voltage Rails and Power Distribution]]
- [[Troubleshooting Power-Related Hardware Failures]]

---

*Source: Rewritten from Professor Messer CompTIA A+ Core 1 (220-1201) Lecture Series | [[A+ Core 1 (220-1201)]] | [[CompTIA A+]]*