---
tags: [knowledge, aplus, core-2-(220-1202)]
created: 2026-04-30
cert: CompTIA A+
chapter: 26
source: rewritten
---

# Physical Security
**Controlling who and what can physically enter your IT infrastructure through strategic barriers and checkpoint design.**

---

## Overview

Physical security forms the first line of defense protecting your organization's hardware, data centers, and sensitive equipment from unauthorized access. In the real world, even the best [[encryption]] and [[firewalls]] become useless if someone walks into your server room and steals the hardware. The A+ exam tests your understanding of how organizations design real-world spaces to channel legitimate traffic while blocking threats.

---

## Key Concepts

### Perimeter Barriers

**Analogy**: Think of a moat around a castle—it doesn't stop a determined swimmer, but it forces anyone approaching to commit to crossing it, making casual intrusions much harder and channeling people toward specific entry points.

**Definition**: Physical [[barriers]] installed around building entrances designed to prevent unauthorized vehicle access while allowing foot traffic to pass through controlled points.

| Barrier Type | Purpose | Common Use |
|---|---|---|
| [[Bollards]] (concrete/steel posts) | Stop vehicles, allow pedestrians | Building lobbies, parking areas |
| [[Barricades]] (removable barriers) | Flexible vehicle prevention | Temporary access control |
| [[Moats]]/Water Features | Natural perimeter barriers | High-security facilities |
| Concrete Planters | Aesthetic + functional blocking | Modern building entrances |

---

### Access Control Vestibule (Mantrap)

**Analogy**: Imagine an airlock on a spaceship—only one door opens at a time, so you're always trapped in a small chamber where security can verify you before allowing passage deeper into the protected area.

**Definition**: A secured intermediate space between the outside world and restricted internal areas, using interlocking [[door systems]] that prevent more than one entry point from being open simultaneously.

#### Vestibule Operation

```
SCENARIO: Employee entering secure data center

State 1: Outer door UNLOCKED → Employee scans badge
         (Inner door LOCKED)

State 2: Outer door LOCKS → Employee now in vestibule
         (Verification happening)

State 3: Inner door UNLOCKS → Employee enters facility
         (Outer door remains LOCKED)

Result: Only ONE person/group passes through at a time
        Prevents "tailgating" (following others in)
```

#### Vestibule Benefits

- [[Tailgating prevention]]—can't slip in behind someone else
- Identity verification opportunity—staff can confirm authorization
- Physical containment—limits who's inside restricted areas at once
- Audit trail creation—you know exactly who entered and when

---

## Exam Tips

### Question Type 1: Barrier Identification
- *"A company wants to prevent vehicles from driving toward the building entrance but allow pedestrians to walk through. What should they install?"* → [[Bollards]] or [[barricades]]
- **Trick**: Don't confuse bollards (permanent, cylindrical) with barricades (temporary, flexible). The exam may ask about removal or cost differences.

### Question Type 2: Vestibule Operation
- *"A data center uses interlocking doors in its entrance. While one door is open, what happens to the other doors?"* → They automatically lock to prevent multiple simultaneous entries
- **Trick**: Some questions test whether you understand this is about preventing [[tailgating]], not just having two doors. The *locking mechanism* is what matters.

### Question Type 3: Physical Security Purpose
- *"What is the primary goal of access control vestibules in sensitive facilities?"* → Control flow of personnel and prevent unauthorized group entry
- **Trick**: Don't choose answers about "preventing weather" or "creating an attractive entrance." Focus on *access control*.

---

## Common Mistakes

### Mistake 1: Confusing Bollards with General Barriers
**Wrong**: "Bollards are security doors that prevent people from entering buildings"
**Right**: "Bollards are short, sturdy posts that stop vehicles while allowing foot traffic to pass around them"
**Impact on Exam**: You could misidentify the appropriate barrier type for a scenario. Always ask: "Is this stopping vehicles, people, or both?"

### Mistake 2: Misunderstanding Vestibule Lock Behavior
**Wrong**: "The vestibule doors stay unlocked so employees don't get stuck inside"
**Right**: "The vestibule maintains interlocking—when one door opens, others lock to ensure only controlled passage"
**Impact on Exam**: Questions about "how do you prevent tailgating?" require understanding that the *locking mechanism* is the security feature, not convenience.

### Mistake 3: Treating Physical Security as Separate from IT Security
**Wrong**: "Physical security is just building maintenance—it's not part of A+ certification"
**Right**: "Physical security directly protects IT infrastructure. Thieves stealing servers bypass all your cybersecurity"
**Impact on Exam**: The exam includes physical security because data centers require both cyber and physical defense. Don't skip these questions.

---

## Related Topics
- [[Access Control Systems]]
- [[Biometric Authentication]]
- [[Badge Readers and Card Access]]
- [[Surveillance and CCTV]]
- [[IT Infrastructure Protection]]
- [[Data Center Design]]
- [[Tailgating Prevention]]

---

*Source: CompTIA A+ Core 2 (220-1202) | Rewritten Study Notes | [[A+]]*