---
tags: [knowledge, aplus, core-2-(220-1202)]
created: 2026-04-30
cert: CompTIA A+
chapter: 65
source: rewritten
---

# Safety Procedures
**Protecting yourself and equipment from electrical hazards during hardware maintenance.**

---

## Overview

Working on computers and peripherals exposes technicians to serious electrical dangers that can cause injury or death. The CompTIA A+ exam expects you to understand how to identify hazards, disconnect power safely, and use grounding techniques to prevent damage to yourself and equipment. These aren't just theoretical concepts—they're survival skills in the field.

---

## Key Concepts

### Power Disconnection Protocol

**Analogy**: Think of disconnecting power like removing the batteries from a smoke detector before changing the batteries—you eliminate the source of potential harm before you start working.

**Definition**: The mandatory practice of completely severing [[AC power]] from any device before opening its chassis or working on internal components. This includes [[computers]], [[printers]], [[monitors]], and any equipment with a [[power cord]].

**Critical Rule**: Always disconnect power *before* opening the device. No exceptions.

| Device Type | Safety Concern | Action Required |
|---|---|---|
| Desktop/Laptop | Live power to motherboard | Unplug power cord completely |
| Laser Printer | High-voltage fuser | Kill main power switch + unplug |
| Monitor/Display | CRT/LCD backlight voltage | Unplug from wall outlet |
| Power Supply Unit | Internal capacitor charge | Remove from system entirely |

---

### Capacitor Danger

**Analogy**: Capacitors are like water balloons—even after you turn off the faucet (power), they still hold water (electrical charge) and can burst if you squeeze them.

**Definition**: [[Capacitors]] are electrical components that store electrical energy even after a device is powered down. They maintain this charge indefinitely until properly discharged, creating a shock hazard.

**The Trap**: A [[monitor]] or [[power supply]] that's been unplugged for hours can still deliver a lethal shock from residual capacitor charge. This is why you should never touch unknown components inside a powered-down device.

---

### Residual Power and Live Components

**Analogy**: Imagine a dam that's been closed—water still fills the reservoir behind the gate even though nothing flows downstream anymore.

**Definition**: [[Residual power]] refers to electrical charge remaining in [[capacitors]] and other storage components within [[power supplies]], [[displays]], and [[laser printers]] even after the main power source is disconnected.

**Devices to Fear**:
- [[Power Supply Units]] (PSUs)
- [[CRT monitors]]
- [[LCD displays]] with high-voltage backlights
- [[Laser printers]] (especially the fuser assembly)

**Rule of Thumb**: Assume any device that uses AC power contains residual charge unless you've personally discharged it.

---

### Electrical Grounding

**Analogy**: Grounding is like having a lightning rod on your house—it gives dangerous electrical energy a safe path to the Earth instead of letting it pass through you or your equipment.

**Definition**: [[Grounding]] (or [[earthing]]) is the practice of creating a conductive pathway that channels electrical faults safely into the Earth, preventing that energy from flowing through people or sensitive components.

**How It Works**:
- The third prong on [[AC power cords]] (round or U-shaped) is the ground connection
- Excess electrical energy follows the path of least resistance to ground
- Your body is NOT that path if grounding is properly installed

| Grounding Element | Purpose |
|---|---|
| Third prong on power cord | Diverts fault current away from device/user |
| Rack grounding straps | Bonds all equipment in a [[server rack]] to ground |
| Equipment grounding | Connects chassis to ground via cord or strap |
| Data center floor bonding | Creates unified ground reference for all racks |

---

### Static Discharge Protection

**Analogy**: Static electricity is like shuffling across a carpet—the charge builds up, and touching metal creates a spark. In electronics, that spark destroys microchips.

**Definition**: [[ESD]] ([[Electrostatic Discharge]]) protection prevents static charges from your body from reaching sensitive components like [[RAM]], [[SSDs]], and [[motherboards]].

**Protection Methods**:
```
Anti-Static Wrist Strap: 
  Worn on wrist → connected to grounded mat/equipment
  
Anti-Static Mat: 
  Placed on work surface → grounded to outlet
  
Proper Grounding:
  Touch grounded object before handling components
```

---

## Exam Tips

### Question Type 1: Safety Protocol Scenarios
- *"You're replacing a power supply in a desktop computer. What's your first step?"* → Unplug the power cord from the wall outlet completely. Never assume a powered-down device is safe.
- **Trick**: The exam might say "power button is off" or "system is shut down"—these DO NOT protect you. Only physical disconnection matters.

### Question Type 2: Identifying Hazardous Components
- *"You open a monitor chassis and see a cylindrical component you don't recognize. What do you do?"* → Do not touch it. It's likely a [[capacitor]] storing high voltage.
- **Trick**: "You turned off the monitor 2 hours ago, so it's safe now" — FALSE. Capacitors hold charge indefinitely.

### Question Type 3: Grounding Applications
- *"In a data center, all server racks must be connected using ___."* → Grounding straps/bonding to a common ground reference.
- **Trick**: Distinguishing between grounding (safety) and shielding (EMI prevention). The exam wants safety here.

### Question Type 4: Power Supply Safety
- *"When a power supply fails, you should ___."* → Remove the entire unit and replace it; never attempt to repair internal PSU components.
- **Trick**: Never open a power supply, even for "quick fixes." They're field-replaceable units (FRUs).

---

## Common Mistakes

### Mistake 1: Assuming "Off" Means "Safe"
**Wrong**: "I'll just turn off the computer and work inside—the power's off now, so it's safe."
**Right**: A turned-off computer still has capacitors holding charge. Always unplug the power cord from the wall outlet before opening any chassis.
**Impact on Exam**: This is tested repeatedly because it kills technicians in the real world. A+ examiners make this a priority question.

### Mistake 2: Touching Unknown Components
**Wrong**: "I don't know what this component is, but I need to move it to access the RAM, so I'll just grab it."
**Right**: If you don't recognize a component, don't touch it. Assume it's a capacitor or other high-voltage storage device.
**Impact on Exam**: You'll lose points on scenario questions if you show a lack of respect for unidentified components.

### Mistake 3: Neglecting Grounding in Data Centers
**Wrong**: "I'll just plug in equipment to different racks without grounding them together."
**Right**: All racks and equipment in a data center must be bonded to a common ground reference using grounding straps.
**Impact on Exam**: Data center questions increasingly appear on 220-1202. Expect at least one grounding scenario.

### Mistake 4: Confusing Grounding with Shielding
**Wrong**: "Grounding prevents electromagnetic interference (EMI)."
**Right**: [[Grounding]] safely discharges faults; [[shielding]] (like Faraday cages) blocks EMI. Different purposes, often confused.
**Impact on Exam**: You might see a question asking which technique prevents electrical shock vs. which prevents signal interference. Know the difference.

### Mistake 5: Attempting PSU Repairs
**Wrong**: "The power supply is broken, but I can fix the internal components if I'm careful."
**Right**: Never open a power supply. It's a field-replaceable unit (FRU). Replace the entire PSU.
**Impact on Exam**: The exam explicitly tests whether you know power supplies are non-serviceable internally.

---

## Related Topics
- [[ESD Protection Techniques]]
- [[Power Supply Fundamentals]]
- [[Laser Printer Maintenance Safety]]
- [[OSHA Electrical Safety Standards]]
- [[Capacitor Discharge Methods]]
- [[Data Center Infrastructure]]
- [[Grounding Systems]]

---

*Source: Professor Messer CompTIA A+ Core 2 (220-1202) | [[A+]] | [[CompTIA Certification]]*