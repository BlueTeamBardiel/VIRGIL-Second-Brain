---
tags: [knowledge, aplus, core-1-(220-1201)]
created: 2026-04-30
cert: CompTIA A+
chapter: 27
source: rewritten
---

# Storage Cables
**Your gateway to understanding how drives talk to your motherboard and power supply.**

---

## Overview

When you're building or troubleshooting a desktop PC, you need to know how storage devices physically connect to your system. The cables and connectors you use determine not only whether your drive works, but *how fast* it communicates with the rest of your computer. For the A+ exam, understanding storage cable standards and their evolution is critical—you'll see questions about speeds, connector types, and real-world troubleshooting scenarios.

---

## Key Concepts

### SATA (Serial ATA)

**Analogy**: Think of SATA like a highway system for data. Just as highway engineers upgrade roads from two lanes to four lanes to six lanes to handle more traffic faster, SATA specifications have evolved through multiple "revisions," each one doubling the speed capacity to handle modern drives.

**Definition**: [[SATA]] (Serial AT Attachment) is the standard interface for connecting hard drives and SSDs inside modern desktop computers. It's a point-to-point connection, meaning one drive connects directly to one motherboard port with no sharing.

| SATA Version | Speed | Release Era | Real-World Impact |
|---|---|---|---|
| [[SATA 1.0]] | 1.5 Gbps | Early 2000s | Legacy; rarely seen in exams |
| [[SATA 2.0]] | 3 Gbps | Mid 2000s | Still functional in older builds |
| [[SATA 3.0]] | 6 Gbps | 2009+ | Industry standard; most common |
| [[SATA 3.2]] | 16 Gbps | 2017+ | Modern drives; backwards compatible |

---

### SATA Connectors and Power

**Analogy**: Imagine a SATA drive as a device with two separate "mouths"—one eats electricity (the power connector), and one talks to the brain of the computer (the data connector). They're completely separate pipelines doing different jobs.

**Definition**: SATA drives have two distinct physical connectors on the back:

- **Data Connector (7-pin)**: The smaller connector that plugs into a [[SATA port]] on your motherboard. Handles read/write communication only.
- **Power Connector (15-pin)**: The larger connector that receives 3.3V, 5V, and 12V power from your [[power supply]].

Many drives also support the legacy [[Molex connector]] (the older 4-pin power standard) for backwards compatibility with older power supplies.

---

### ESATA (External SATA)

**Analogy**: ESATA is like SATA's travel-friendly cousin. While SATA is designed to live inside your computer's protective case, ESATA is hardened to survive the outside world—think of it as the difference between a house phone and a ruggedized mobile phone.

**Definition**: [[ESATA]] extends SATA functionality to external drives. It uses the same protocol and speed capabilities as internal SATA but features:

- Reinforced connectors that withstand repeated plugging/unplugging
- Cables up to ~2 meters in length
- Hot-swap capability (connect/disconnect without powering down)

---

### SATA Architecture: The One-to-One Model

**Analogy**: Imagine a telephone switchboard where each operator (motherboard port) has their own dedicated phone line (cable) to exactly one caller (drive). There's no conference calling, no sharing the line—pure one-to-one communication.

**Definition**: [[SATA]] uses point-to-point architecture, meaning:

- Each drive requires its own dedicated data cable to the motherboard
- Each drive requires its own dedicated power line from the PSU
- No [[daisy-chaining]] is supported (unlike older [[IDE]]/[[PATA]] where multiple drives could share one cable)
- A motherboard with 6 SATA ports can support exactly 6 drives maximum

```
Motherboard Port 1 ──→ [Drive 1]
Motherboard Port 2 ──→ [Drive 2]
Motherboard Port 3 ──→ [Drive 3]
(NOT: Port 1 ──→ [Drive 1] AND [Drive 2])
```

---

## Exam Tips

### Question Type 1: Speed and Version Identification

- *"A customer's SATA drive transfers at 6 Gbps. Which SATA version are they using?"* → **SATA 3.0**
- *"Your client needs a drive that supports 16 Gbps speeds. What's the minimum SATA standard required?"* → **SATA 3.2**
- **Trick**: The exam often tests whether you know the speeds in order. Don't memorize backward (3.0 = 3 Gbps is a common wrong guess—it's actually 6 Gbps). Create a mnemonic: 1.5 → 3 → 6 → 16 (each roughly doubles).

### Question Type 2: Connector and Cable Scenarios

- *"You're installing a new SSD in a desktop. How many cables do you need?"* → **Two: one data cable (7-pin), one power cable (15-pin)**
- *"A technician connects two drives to one SATA data cable. Why won't this work?"* → **SATA doesn't support daisy-chaining; each drive needs its own cable**
- **Trick**: Don't confuse SATA architecture with older IDE/PATA, which *did* allow two drives per cable.

### Question Type 3: External Drive Connectivity

- *"A client wants to connect an external hard drive with hot-swap capability. What interface would you recommend?"* → **ESATA or USB (ESATA is legacy; USB is modern)**
- *"What's the maximum cable length for ESATA?"* → **Approximately 2 meters**
- **Trick**: ESATA is becoming obsolete in favor of USB 3.0+ and Thunderbolt, but the A+ exam still includes it for historical knowledge.

---

## Common Mistakes

### Mistake 1: Confusing SATA Speed with Drive Speed

**Wrong**: "My SATA 3.0 drive runs at 6 Gbps, so it transfers files at 6 Gbps."

**Right**: 6 Gbps is the *maximum theoretical bandwidth* of the interface. The actual drive speed (measured in MB/s or random IOPS) depends on the drive technology itself. A mechanical hard drive on SATA 3.0 might only achieve ~150 MB/s, while an SSD can reach the theoretical limit.

**Impact on Exam**: You might see scenario questions where a slow drive on fast SATA is presented as a problem. The answer isn't "upgrade the cable"—it's recognizing that the cable isn't the bottleneck.

---

### Mistake 2: Assuming All SATA Versions Are Incompatible

**Wrong**: "SATA 2.0 drives won't work in a SATA 3.0 motherboard."

**Right**: [[SATA]] is fully backwards compatible. A SATA 1.0 drive will work in a SATA 3.2 port (it'll just run at the slower 1.5 Gbps speed). The newer standard won't "force" the drive to run faster.

**Impact on Exam**: Legacy system questions may show mixed SATA versions working together. This is normal and expected.

---

### Mistake 3: Mixing Up Connector Types

**Wrong**: "The 15-pin SATA power connector and 7-pin data connector are interchangeable."

**Right**: They are *not* interchangeable. The 15-pin connector has voltage pins; the 7-pin connector carries only signal. Forcing one into the other will damage the drive.

**Impact on Exam**: Physical connector identification questions will show actual images. Know the shapes and pin counts cold.

---

### Mistake 4: Forgetting About Molex Power

**Wrong**: "Modern drives use only SATA power connectors."

**Right**: Many drives support *both* SATA and [[Molex]] power for compatibility with older or diverse power supplies. Older drives may use Molex exclusively (requiring an adapter for newer PSUs).

**Impact on Exam**: Troubleshooting scenarios might involve a drive that's "not getting power." The answer could be "check for both SATA and Molex connections" or "use a Molex-to-SATA power adapter."

---

## Related Topics
- [[SATA vs. NVMe vs. M.2]] — Modern storage interface comparison
- [[Power Supply Connectors]] — Understanding all PSU outputs
- [[IDE and PATA]] — The predecessor to SATA (legacy knowledge)
- [[Storage Device Types]] — HDDs vs. SSDs and their interfaces
- [[Hot-Swap and External Storage]] — ESATA and USB alternatives
- [[Motherboard Connectors]] — Where SATA ports live on the board

---

*Source: Professor Messer CompTIA A+ Core 1 (220-1201) | [[A+]] | Rewritten by VIRGIL*