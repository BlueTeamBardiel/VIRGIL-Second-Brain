---
tags: [knowledge, security-plus, secplus]
created: 2026-05-01
cert: CompTIA Security+
exam: SY0-701
chapter: 008
source: rewritten
---

# Physical Security
**Digital threats are only half the battle—controlling who and what can physically reach your infrastructure is equally critical to overall security posture.**

---

## Overview
Physical security represents the tangible defenses that prevent unauthorized personnel and vehicles from accessing restricted facilities and sensitive infrastructure. For Security+ professionals, understanding these barriers is essential because a compromised data center or server room bypasses all your firewalls and encryption. The exam expects you to know how organizations layer physical controls to create multiple obstacles for potential attackers.

---

## Key Concepts

### Bollards and Barricades
**Analogy**: Think of a bollard like a bouncer at a nightclub who lets people through but stops cars—it's a selective filter that works at the entrance level.

**Definition**: [[Bollards]] are fixed or removable vertical posts designed to control pedestrian and vehicle traffic flow. [[Barricades]] serve similar purposes but can be less permanent and more flexible in deployment.

| Type | Material | Best Use | Permanence |
|------|----------|----------|-----------|
| **Concrete Bollard** | Reinforced cement | Vehicle prevention | Permanent |
| **Metal Bollard** | Steel/aluminum | Entry control | Semi-permanent |
| **Water Barrier** | Natural moat/pond | Perimeter defense | Permanent |
| **Temporary Barricade** | Plastic/metal gates | Event/construction zones | Temporary |

**Key Features**:
- Create [[access control points]] that funnel traffic through monitored locations
- Serve dual purpose as visual security deterrents (psychological effect)
- Can be designed to stop vehicles while allowing pedestrians (anti-ramming protection)
- Often brightly colored to signal "restricted area" messaging

---

### Access Control Vestibules
**Analogy**: An access vestibule is like an airlock on a spaceship—you can't pressurize the main cabin until the airlock is fully sealed, preventing anyone from rushing in.

**Definition**: An [[access control vestibule]] (also called a [[mantrap]] or [[air lock]]) is a small enclosed room with two or more doors where only one door can be unlocked at any given time.

**Operating Modes**:

| Configuration | Function | Security Level |
|---------------|----------|-----------------|
| **Unlocked Entry/Locked Exit** | Single door operates; others remain secure | Standard |
| **All Doors Locked (Interlock)** | Badging first door locks it; second door only unlocks | High Security |
| **One Always-Locked Door** | Perpetually secured entrance; other door manages flow | Medium-High |

**Why This Matters for [[Authentication]]**:
- Prevents [[tailgating]]/piggybacking by ensuring only one authenticated person enters per credentialing event
- Provides a buffer zone for [[biometric verification]] or secondary authentication
- Creates an audit trail because movement through the vestibule must be individually authorized
- Enables [[security personnel]] to observe and challenge unauthorized entry attempts

---

## Exam Tips

### Question Type 1: Bollard/Barricade Purpose
- *"Which physical security control prevents vehicles from entering a facility parking area while allowing pedestrians to pass?"* → **Bollards**
- **Trick**: Don't confuse bollards with [[fencing]]—fencing creates a perimeter, bollards control *flow* at specific points

### Question Type 2: Vestibule Configuration
- *"Your facility requires that only ONE person can enter the secure area per badge swipe, and if the outer door is unlocked, the inner door cannot open. What's this called?"* → **Interlocked access control vestibule** (with [[fail-safe locks]])
- **Trick**: The question might describe the outcome (preventing tailgating) rather than naming it directly—recognize the "one-at-a-time" mechanism

### Question Type 3: Layer Recognition
- *"What combination of controls creates a multi-factor physical security perimeter?"* → Bollards (stop vehicles) + vestibule (stop unauthorized humans) + [[badge readers]] (verify identity)
- **Trick**: Security+ expects you to see these as *layered controls*, not standalone solutions

---

## Common Mistakes

### Mistake 1: Thinking Bollards Only Stop Cars
**Wrong**: "Bollards are just vehicle blockers—they don't provide real security."
**Right**: Bollards funnel all traffic through monitored entry points, enabling personnel screening and [[access logging]].
**Impact on Exam**: You may miss questions asking what bollards accomplish beyond vehicle prevention. They're about *control flow*, not just blocking.

### Mistake 2: Confusing Vestibule Types
**Wrong**: "An access vestibule just has two doors; configuration doesn't matter."
**Right**: The *interlock logic* (which doors can open simultaneously) is what determines security strength. An interlock vestibule is far more secure than a standard two-door room.
**Impact on Exam**: Questions distinguish between vestibule *types*. Know that interlocked systems prevent tailgating, while basic vestibules just slow people down.

### Mistake 3: Missing the Psychological Element
**Wrong**: "Bright colors on barricades are just cosmetic."
**Right**: Visual deterrents (colored barriers, signage) increase perceived security, making attackers think twice about approaching. This is a *preventive* control.
**Impact on Exam**: Security+ may ask why organizations use highly visible barriers instead of hidden ones—the answer involves both physical prevention and behavioral psychology.

### Mistake 4: Overlooking Perimeter Layers
**Wrong**: "We have bollards at the entrance; that's sufficient physical security."
**Right**: Best practice combines bollards (outer layer) + vestibules (entry layer) + [[CCTV]] (monitoring layer) + [[badge systems]] (authentication layer).
**Impact on Exam**: Expect questions asking to identify *gaps* in a physical security description. A facility with only bollards is vulnerable to social engineering at the vestibule.

---

## Related Topics
- [[Access Control Systems]]
- [[Tailgating and Piggybacking Prevention]]
- [[Fail-Safe vs Fail-Secure Locks]]
- [[Perimeter Security]]
- [[CCTV and Surveillance]]
- [[Security Guards and Personnel]]
- [[Badge/Card Access Systems]]
- [[Mantrap]]
- [[Environmental Controls]]

---

*Source: Professor Messer CompTIA Security+ SY0-701 | [[Security+]]*