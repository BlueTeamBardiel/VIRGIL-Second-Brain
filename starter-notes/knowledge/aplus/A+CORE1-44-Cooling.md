---
tags: [knowledge, aplus, core-1-(220-1201)]
created: 2026-04-30
cert: CompTIA A+
chapter: 44
source: rewritten
---

# Cooling
**Your computer's internal components generate serious heat, and smart airflow management is the foundation of system stability.**

---

## Overview

Every electronic component in a PC—from the [[CPU]] to the [[GPU]]—produces thermal energy as electricity flows through them. Without proper heat dissipation, your system throttles performance, crashes, or dies. Cooling is a core A+ competency because technicians must understand [[airflow]] principles, [[fan]] types, and thermal management to build stable systems and troubleshoot overheating issues.

---

## Key Concepts

### Airflow Strategy

**Analogy**: Think of your computer case like a factory assembly line—you want raw materials (cool air) flowing in one side, passing by the hot machinery (components), and exiting on the other side as waste heat. Block the line, and everything backs up and overheats.

**Definition**: [[Airflow]] is the deliberate movement of cool air through a case to absorb heat from components and expel warm air outside. Effective airflow requires intake fans pulling cool air forward and exhaust fans pushing hot air out.

| Airflow Direction | Purpose | Common Location |
|---|---|---|
| **Intake** | Brings cool ambient air into case | Front/bottom of case |
| **Exhaust** | Removes heated air from case | Rear/top of case |
| **Bypass** | Allows some air to recirculate | Depends on case design |

**Key Point**: Poor [[airflow]] is the #1 cause of thermal throttling on the A+ exam.

---

### Case Design & Obstruction

**Analogy**: A messy garage where tools block the doorways is like a PC case full of tangled cables—air can't move freely, and everything gets trapped and hot.

**Definition**: [[Case design]] impacts cooling effectiveness through internal layout, cable management, and component positioning. Obstructed pathways, loose wires, and poor [[motherboard]] spacing all reduce [[airflow efficiency]].

**Best Practice**: Route cables behind the [[motherboard]] tray, bundle excess wire, and leave space between components for air to circulate.

---

### Dedicated Component Cooling

**Analogy**: Just like a high-performance race car has specialized cooling for the engine, high-end components get their own cooling solution because ambient case airflow isn't enough.

**Definition**: [[Onboard fans]] are dedicated cooling systems mounted directly on expansion cards (especially [[GPU|graphics cards]] and [[RAID]] adapters) to target heat-intensive components. These fans draw cool air directly to hot spots.

**Why It Matters**: 
- High-end [[GPU|graphics cards]] generate extreme heat and require active cooling
- Larger cards have space for fans; smaller cards rely on case airflow
- Onboard fans increase efficiency by 15-30% over passive cooling alone

---

### Standard Fan Sizes

**Analogy**: Just like doorways come in standard widths, PC fans are manufactured in universal diameters so you can swap them easily.

**Definition**: [[Fan sizing]] is standardized in millimeters to ensure compatibility. The most common case fan sizes are:

| Fan Size | Typical Use | Airflow (CFM) | Noise Level |
|---|---|---|---|
| **80mm** | Small builds, older systems | 30-50 | High (faster RPM) |
| **120mm** | Standard mid-tower cases | 50-100 | Moderate |
| **200mm** | Large cases, airflow optimization | 80-150 | Low (slower RPM) |

**Pro Tip**: Larger fans run at lower [[RPM|speeds]] to move the same air volume, which means less noise and longer lifespan.

---

### Variable Speed Fans

**Analogy**: Like cruise control on a car, variable-speed fans adjust their effort based on temperature—full power when hot, idle when cool.

**Definition**: [[PWM (Pulse Width Modulation)]] fans automatically adjust rotational speed based on [[temperature sensors]]. As components heat up, fans spin faster; as they cool, they slow down.

**Benefit**: Quieter operation under light loads, maximum cooling during gaming/rendering, and energy efficiency.

---

## Exam Tips

### Question Type 1: Airflow Troubleshooting
- *"A user's system is thermal throttling. You notice cables blocking the intake fan. What should you do first?"* → Route cables behind the motherboard tray and test again.
- **Trick**: Don't assume the cooling system is broken—check [[airflow obstruction]] first; it's the most common culprit.

### Question Type 2: Component Cooling
- *"A high-end graphics card has its own fan. Why?"* → The card generates heat that case airflow alone cannot dissipate efficiently.
- **Trick**: The exam may ask why onboard fans are only on *larger* cards—answer: **smaller cards lack physical space** for additional cooling.

### Question Type 3: Fan Sizing
- *"You need to replace a case fan. The original was 120mm. What size options are compatible?"* → 120mm only (unless the case mount supports multiple sizes, which is rare).
- **Trick**: Standard sizes are 80mm, 120mm, and 200mm—don't invent sizes like "100mm" or "150mm."

---

## Common Mistakes

### Mistake 1: Ignoring Cable Management
**Wrong**: "The cooling system is fine; the case just has a lot of wires."
**Right**: Tangled cables directly block airflow paths and reduce cooling efficiency by 20-40%.
**Impact on Exam**: You'll see "system runs hot" scenarios where cable routing is the hidden solution.

### Mistake 2: Confusing Fan Size with Cooling Power
**Wrong**: "A 200mm fan cools better than a 120mm fan because it's bigger."
**Right**: Larger fans move more air at *lower speeds*, which is more efficient—but airflow depends on both size and [[RPM]].
**Impact on Exam**: Questions may trick you by asking why larger fans are preferred (answer: efficiency and noise, not raw power).

### Mistake 3: Forgetting Intake vs. Exhaust Direction
**Wrong**: Putting all fans as intake or all as exhaust.
**Right**: At least one intake and one exhaust fan creates [[positive pressure]] or [[negative pressure]], enabling controlled airflow.
**Impact on Exam**: "You have 3 fans in a case—which should be intake?" → At least one intake, at least one exhaust.

### Mistake 4: Assuming Onboard Fans Are Always Present
**Wrong**: "Every expansion card has a fan."
**Right**: Only high-heat components ([[GPU]], high-end [[RAID]] cards) have onboard fans due to space and thermal constraints.
**Impact on Exam**: Don't assume cooling—recognize which components *need* dedicated cooling.

---

## Related Topics

- [[CPU Cooling Solutions]] (heatsinks, liquid cooling)
- [[Thermal Paste]] (interface material between CPU and cooler)
- [[Temperature Monitoring]] (BIOS, software tools)
- [[Power Supply]] (generates its own heat)
- [[BIOS Settings]] (fan speed control, thermal thresholds)
- [[System Performance]] (throttling from overheating)

---

*Source: Rewritten from Professor Messer CompTIA A+ Core 1 (220-1201) | [[A+]]*