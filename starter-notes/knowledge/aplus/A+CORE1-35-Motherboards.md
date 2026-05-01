---
tags: [knowledge, aplus, core-1-(220-1201)]
created: 2026-04-30
cert: CompTIA A+
chapter: 35
source: rewritten
---

# Motherboards
**The central circuit board that connects every component in your computer—think of it as the nervous system that lets your CPU, RAM, and storage talk to each other.**

---

## Overview

The [[motherboard]] is the backbone of any computing system, whether you're building a full-size desktop tower or a compact media center PC. Every device you encounter—from workstations to home theater systems—relies on a motherboard to orchestrate communication between the [[CPU]], [[memory]], [[storage]], and network components. Understanding motherboard variations is critical for the A+ exam because you'll encounter different form factors and configurations in real-world support scenarios.

---

## Key Concepts

### Form Factor

**Analogy**: Think of form factor like clothing sizes—just because two outfits serve the same purpose (keeping you warm) doesn't mean they fit the same way. A wedding dress and a t-shirt both protect you, but one takes up way more space.

**Definition**: The [[form factor]] is the physical size and layout specification of a motherboard, determining how many expansion slots, power connections, and cooling solutions it can accommodate.

Common motherboard form factors include:

| Form Factor | Dimensions | Use Case | Expansion Slots |
|---|---|---|---|
| **ATX** | 305 × 244 mm | Full-size desktops | Maximum (7+) |
| **Micro-ATX** | 244 × 244 mm | Compact desktops, offices | Moderate (4) |
| **Mini-ITX** | 170 × 170 mm | Media centers, HTPCs | Limited (1) |
| **BTX** | 325 × 267 mm | High-performance cooling | Legacy standard |

---

### Power Delivery

**Analogy**: A motherboard's power system is like a power distribution box in your house—it needs to split incoming electricity to different rooms (components) without overloading any single circuit.

**Definition**: [[Power delivery]] on a motherboard uses standardized connectors to distribute electrical power from the [[power supply unit (PSU)]] to the [[CPU]], [[RAM]], and peripheral components. While most modern systems use similar power standards, variations exist across older and specialized boards.

**Key Power Connectors**:
- **24-pin ATX**: Main motherboard power
- **8-pin (or 4-pin) CPU power**: Dedicated CPU voltage
- **SATA power**: For storage devices
- **PCIe power**: For graphics cards (6-pin or 8-pin)

---

### Thermal Management Considerations

**Analogy**: A motherboard generates heat the same way a crowded subway gets hot—all those people (components) packed together create energy that needs somewhere to go, or everyone gets uncomfortable.

**Definition**: [[Thermal management]] on a motherboard involves physical layout design to ensure proper [[airflow]] throughout the system, preventing heat buildup that could damage components or degrade performance.

**Factors Affecting Thermals**:
- Component density (smaller form factors = tighter spacing)
- [[CPU cooler]] compatibility with form factor
- Case [[airflow]] design
- [[BIOS]] fan curve settings

---

### Motherboard Component Density

**Analogy**: Imagine trying to fit all your kitchen appliances into a shoebox versus a full kitchen—the shoebox limits what you can include, even though both spaces serve the same basic function.

**Definition**: [[Component density]] refers to how many ports, slots, and expansion connectors a motherboard can physically accommodate. Larger boards offer more flexibility; smaller boards prioritize space efficiency at the cost of expandability.

**Density Trade-offs**:

| Aspect | Full-size ATX | Compact ITX |
|---|---|---|
| **Expansion capacity** | High | Low |
| **Future upgrades** | Easy | Limited |
| **Price** | Higher | Lower |
| **Case options** | Abundant | Specialized |

---

## Exam Tips

### Question Type 1: Form Factor Identification
- *"A customer's small office needs a replacement motherboard that fits their compact case. Which form factor is most appropriate?"* → **Micro-ATX or Mini-ITX** depending on case constraints
- **Trick**: Don't assume bigger is always better—exams love testing whether you know when to downsize. A Mini-ITX isn't "broken," it's intentional.

### Question Type 2: Power Connector Matching
- *"A motherboard requires a dedicated 8-pin CPU power connector, but the power supply only provides a 4-pin connector. What should you do?"* → **Replace the power supply**—you cannot safely downgrade power delivery to the CPU
- **Trick**: Students often think "adapters exist, so use one." The exam wants you to know this is a hardware limitation, not a puzzle to hack around.

### Question Type 3: Thermal & Airflow Scenarios
- *"You're installing a large tower CPU cooler in a Mini-ITX case. What's the primary concern?"* → **Physical clearance and airflow obstruction**
- **Trick**: The cooler might technically fit but block air intake/exhaust, creating a worse thermal situation than a smaller cooler.

---

## Common Mistakes

### Mistake 1: Confusing Form Factor with Performance
**Wrong**: "Mini-ITX motherboards are slower than ATX motherboards."
**Right**: Form factor is purely about physical size and port availability—an ITX board with a modern [[CPU]] and [[GPU]] performs identically to an ATX board with the same components.
**Impact on Exam**: You might eliminate correct answers thinking a smaller board can't handle specific workloads. It can.

### Mistake 2: Assuming All Power Connectors Are Interchangeable
**Wrong**: "I can use a SATA power connector for a PCIe slot device since they're both power."
**Right**: Each connector type supplies specific voltage and amperage requirements. Wrong connectors cause equipment damage.
**Impact on Exam**: Safety-focused questions test whether you understand voltage mismatch consequences.

### Mistake 3: Overlooking Case-Motherboard Compatibility
**Wrong**: "Any motherboard fits in any case."
**Right**: Form factor must match case design—an ATX board won't fit an ITX case, period.
**Impact on Exam**: You'll lose points on real-world troubleshooting scenarios if you suggest incompatible upgrades.

### Mistake 4: Treating Thermal Management as Optional
**Wrong**: "As long as there's a CPU cooler, heat isn't a concern."
**Right**: Motherboard layout, case airflow, and cooler placement all interact—a good cooler in a poorly ventilated case still overheats.
**Impact on Exam**: Performance problems and system failures on the exam often trace back to thermal causes that a poor form factor choice exacerbated.

---

## Related Topics
- [[CPU Sockets and Compatibility]]
- [[Power Supply Units (PSU)]]
- [[Computer Cooling Systems]]
- [[BIOS and Firmware]]
- [[Expansion Slots (PCIe, PCI)]]
- [[RAM and Memory Architecture]]
- [[Storage Interfaces (SATA, NVMe)]]

---

*Source: Professor Messer CompTIA A+ Core 1 (220-1201) | [[A+]] | [[Core Hardware Components]]*