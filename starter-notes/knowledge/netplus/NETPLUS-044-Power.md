---
tags: [knowledge, netplus, network-plus]
created: 2026-05-01
cert: CompTIA Network+
exam: N10-009
chapter: 044
source: rewritten
---

# Power
**Electrical safety and fundamental measurements form the foundation of safe infrastructure work.**

---

## Overview

Working with network infrastructure means you'll encounter powered equipment, and understanding electrical fundamentals is critical for both safety and troubleshooting. Power management isn't just about keeping devices running—it's about protecting yourself, your colleagues, and expensive equipment from electrical hazards. The Network+ exam expects you to recognize hazardous conditions and understand basic electrical measurements that affect device performance and power delivery.

---

## Key Concepts

### Electrical Safety Protocol
**Analogy**: Think of electrical current like a fast-moving river—you can't see the water moving quickly, but it can sweep you away. Similarly, you can't see electricity, but it can harm you instantly.

**Definition**: The fundamental practice of de-energizing equipment before touching internal components and maintaining awareness of residual [[charge]] stored in [[capacitors]].

**Critical Details**:
- Always disconnect power at the source before servicing
- [[CRT monitors]], [[laser printers]], and similar devices retain dangerous [[voltage]] even when unplugged
- Never create a path between yourself and [[ground]] or any energized component
- Respect for electrical systems prevents injury to yourself and others

---

### Ampere (Amp)
**Analogy**: If electricity flowing through a wire is like water through a garden hose, then amperage measures how much water volume passes through that hose per second.

**Definition**: The [[ampere]] (symbol: **A**) is the standard unit measuring the rate of [[electron]] flow past a single point in a circuit, measured per second.

**Key Relationships**:
- Higher amperage = more electrons moving = more current
- Wire diameter affects how much amperage it can safely handle
- Exceeding wire capacity causes heat and fire hazard

| Measurement | Symbol | Purpose |
|---|---|---|
| Ampere | A | Measures current flow |
| [[Voltage]] | V | Measures electrical pressure |
| [[Resistance]] | Ω | Measures opposition to flow |
| [[Wattage]] | W | Measures power consumption |

---

### Voltage
**Analogy**: Voltage is like the water pressure in a hose—it's the force pushing electrons through the wire, not the amount of electrons moving.

**Definition**: The electrical [[potential difference]] that creates the "push" driving [[electrons]] through a circuit, measured in [[volts]] (V).

---

### Wattage
**Analogy**: While voltage is the pressure and amperage is the flow volume, wattage is the total work being done—like the combined power of a water jet.

**Definition**: Measured in [[watts]] (W), this represents the total electrical power consumed, calculated as [[voltage]] × [[amperage]].

**Formula**: `W = V × A`

---

## Exam Tips

### Question Type 1: Safety Scenarios
- *"You need to replace a power supply in a laser printer. What should you do first?"* → Disconnect the device from AC power AND allow capacitors to discharge (some devices have discharge buttons)
- **Trick**: The question might emphasize the device is "turned off"—turned off ≠ safe; it must be unplugged

### Question Type 2: Electrical Measurements
- *"A device draws 5 amps at 120 volts. How much power does it consume?"* → 120V × 5A = 600W
- **Trick**: Don't confuse voltage with amperage; they're independent measurements

### Question Type 3: Power Delivery
- *"Which factor limits the amount of current a cable can safely carry?"* → Wire [[gauge]] (diameter)
- **Trick**: Thicker wires (lower gauge numbers) handle more amperage safely

---

## Common Mistakes

### Mistake 1: Confusing "Off" with "Safe"
**Wrong**: "The printer is off, so it's safe to open the power supply."
**Right**: Even powered-off devices with [[capacitors]] can deliver lethal shocks; always unplug and follow discharge procedures.
**Impact on Exam**: Safety questions test whether you understand residual energy, not just powered-off status. This distinction appears in scenario-based questions.

### Mistake 2: Mixing Up Current and Pressure
**Wrong**: "Higher voltage means more electricity flowing through the wire."
**Right**: [[Voltage]] is electrical pressure; [[amperage]] is flow rate. You can have high voltage with low current.
**Impact on Exam**: Calculation questions and troubleshooting scenarios require distinguishing these concepts; mixing them leads to wrong answers on power consumption problems.

### Mistake 3: Ignoring Wire Gauge Requirements
**Wrong**: "Any copper wire works for any amperage."
**Right**: Wire [[gauge]] must match the expected [[current]] draw; undersized wire creates fire hazards.
**Impact on Exam**: Infrastructure design questions test whether you know proper cable specifications for different power loads.

---

## Related Topics
- [[Voltage]]
- [[Amperage]]
- [[Wattage]]
- [[Capacitors]]
- [[Power Supply]]
- [[Electrical Safety Standards]]
- [[Circuit Protection]]
- [[Grounding Systems]]

---

*Source: Professor Messer CompTIA Network+ N10-009 | [[Network+]]*