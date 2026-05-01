---
tags: [knowledge, aplus, core-1-(220-1201)]
created: 2026-04-30
cert: CompTIA A+
chapter: 52
source: rewritten
---

# Impact Printers
**Ancient technology that still matters for specific business tasks — understand when and why they're used.**

---

## Overview

[[Impact printers]] use physical force to press ink onto paper, making them fundamentally different from modern inkjet and laser technology. For A+, you need to know how they work, their advantages in specific scenarios, and why they've mostly disappeared from offices. This appears on the exam because organizations still use them for carbon-copy forms and specialized printing tasks.

---

## Key Concepts

### Dot Matrix Printers

**Analogy**: Think of a dot matrix printer like a tiny stamp pad where you have 9 or 24 little rubber stamps arranged vertically. Instead of using one big stamp to print a whole letter, you tap multiple small stamps across the page in patterns, building up letters from dots — just like old-school LED displays spell words using individual lights.

**Definition**: A [[dot matrix printer]] is an [[impact printer]] that forms characters and images by firing a vertical grid of pins (typically 9 or 24) against an inked ribbon. The pins strike the ribbon in precise patterns as the print head moves horizontally across the page, creating dot patterns that form readable text.

| Feature | Dot Matrix | Modern Laser | Modern Inkjet |
|---------|-----------|--------------|---------------|
| **Mechanism** | Pin strikes ribbon | Toner fused to page | Ink spray | 
| **Impact** | Yes (physical force) | No (heat) | No (spray) |
| **Carbon Copy** | ✓ Excellent | ✗ Poor | ✗ Poor |
| **Cost Per Page** | Very low | Moderate | Moderate-High |
| **Noise Level** | Very loud | Quiet | Quiet |
| **Print Quality** | Low (dot pattern visible) | High | High |
| **Speed** | Slow-Moderate | Fast | Moderate |

---

### Print Head Mechanism

**Analogy**: Imagine a tiny jackhammer mounted on a track that runs back and forth. The jackhammer has multiple needles stacked vertically. As it slides across your document, it rapidly fires those needles forward, withdrawing them, and firing again — thousands of times per second — building up an image line by line.

**Definition**: The [[print head]] is the moving component housing the solenoid-controlled pins. As it traverses horizontally across the page, electromagnetic coils activate individual pins in rapid sequences, striking the [[ribbon]] (soaked with ink) which transfers ink to the paper below.

```
Print Head Movement (Side View):

← → ← → ← →  (Continuous back-and-forth motion)
┌─────────────┐
│ ●●●●●●●●● │ ← 9 or 24 pins arranged vertically
│ Ribbon (ink)│
└─────────────┘
   Paper
```

---

### Ribbon and Ink System

**Analogy**: The ribbon works like a fabric ink pad at an old-fashioned stamp station — except it's constantly advancing to present fresh, wet sections to the pins.

**Definition**: The [[ribbon]] is a continuous fabric tape saturated with ink that moves between the print head pins and the paper. As pins strike, they compress the ribbon against the paper, transferring ink. Most ribbons wind in a loop, advancing to keep a fresh inked surface available.

---

### Strike Force and Carbon Copies

**Analogy**: When you use a hammer and nail through multiple pieces of wood stacked together, the force transfers through all layers. That's how impact printing handles carbon paper — the physical force goes right through.

**Definition**: [[Impact printers]] apply mechanical force directly to paper, making them ideal for multi-part forms using [[carbon paper]]. This force advantage allows printing on 2-4 page carbon sets simultaneously — something inkjet and laser cannot do.

---

### Print Quality and Resolution

**Analogy**: Imagine trying to draw a detailed portrait using only a checkerboard pattern. The more squares you have, the better the detail. Dot matrix uses fewer "squares" (pins), so images look blocky and dotted.

**Definition**: [[Dot matrix resolution]] is measured by the number of pins in the print head. A 9-pin head produces visibly dotted characters suitable only for forms and basic documents. A 24-pin head provides "near-letter-quality" (NLQ) output that's acceptable for business correspondence, but still inferior to [[laser printers]] and [[inkjet printers]].

---

### Noise Characteristics

**Analogy**: A dot matrix printer is basically a drum line — thousands of little hammers striking in sequence all day long. It's basically the same noise signature as a typewriter on steroids.

**Definition**: [[Impact printers]] generate substantial noise (80-90 dB) because the pins physically strike the ribbon and paper. This mechanical percussion makes them unsuitable for quiet environments like libraries, hospitals, or open office spaces without acoustic enclosures.

---

### Cost Per Page Analysis

**Analogy**: The ribbon is like a washable sponge you reuse hundreds of times. The paper costs pennies. Contrast that to laser toner cartridges or inkjet cartridges — both are expensive consumables.

**Definition**: [[Cost per page]] (CPP) for impact printers is exceptionally low — often less than a penny per page for ribbons and paper. This explains their continued use in high-volume transaction printing (shipping labels, receipts, forms) despite poor quality.

| Printer Type | Cost Per Page |
|--------------|---------------|
| Dot Matrix | $0.005 - $0.01 |
| Inkjet | $0.05 - $0.25 |
| Laser | $0.03 - $0.15 |

---

### Niche Applications Today

**Definition**: Modern [[impact printer]] use is limited to:
- Multi-part form printing (invoices, receipts with carbon layers)
- High-volume transaction printing where speed and cost matter more than aesthetics
- Environments requiring mechanical reliability without software complexity
- Industrial settings where inkjet clogging or laser toner temperature sensitivity is problematic

---

## Exam Tips

### Question Type 1: Identifying Printer Technology
- *"A customer needs to print three-part forms with customer receipts, merchant copies, and accounting copies simultaneously. Which printer type is most appropriate?"* → **Impact/Dot Matrix** — only technology that uses physical force to create impressions through multiple layers.
- **Trick**: Don't confuse "color capability" with "function." Impact printers can't do color easily, but that's irrelevant if the question emphasizes multi-part forms.

### Question Type 2: Troubleshooting Printer Problems
- *"A dot matrix printer is producing faint output on the third page of a four-part form. What is the most likely cause?"* → **Worn or faded ribbon** — the ink saturation has diminished after multiple strikes.
- **Trick**: The exam might suggest "broken pins" as an answer. A broken pin would produce **gaps** in output, not overall faintness.

### Question Type 3: Selecting Appropriate Printer
- *"Which of the following best describes why impact printers are rarely found in modern offices?"* → **Combination of high noise, low print quality, and slow speed** when compared to laser/inkjet alternatives for standard documents.
- **Trick**: Don't say "they don't work anymore" — they absolutely do. Say "they're not suitable for general office use" or "they're specialized equipment."

### Question Type 4: Maintenance and Parts
- *"What component in a dot matrix printer most frequently requires replacement?"* → **Ribbon** — consumable item. Pins last far longer.
- **Trick**: The exam might list "solenoids" or "electromagnets" — these rarely fail and are not consumer-replaceable.

---

## Common Mistakes

### Mistake 1: Confusing "Impact" with "Noisy"
**Wrong**: "Impact printers are impact because they're loud."
**Right**: "Impact means the printing mechanism strikes paper physically. Noise is a *consequence* of impact, not its definition."
**Impact on Exam**: You might select the wrong answer if a question asks "why are impact printers called 'impact'" — it's about the printing method, not the volume.

### Mistake 2: Thinking Carbon Copies Are Obsolete
**Wrong**: "Nobody uses carbon forms anymore, so impact printers don't matter for A+."
**Right**: "Carbon forms are still used in healthcare, logistics, and financial industries. This is a legitimate reason impact printers still exist."
**Impact on Exam**: You'll get a scenario-based question about a warehouse, medical office, or small business. Don't dismiss the scenario as "outdated."

### Mistake 3: Conflating Pin Count with Speed
**Wrong**: "24-pin dot matrix is faster than 9-pin."
**Right**: "24-pin is slower because more pins require more electromagnetic actuation, but produces better quality."
**Impact on Exam**: A question might ask "why would a business choose 9-pin over 24-pin?" Answer: **Speed and cost** — they don't need the quality and want maximum throughput.

### Mistake 4: Misunderstanding "Near-Letter-Quality"
**Wrong**: "NLQ output looks as good as a laser printer."
**Right**: "NLQ means the dots are small enough that characters appear solid at arm's length, but magnification shows the dot grid."
**Impact on Exam**: When a question mentions "NLQ mode," recognize it as a quality setting that trades speed for readability — it's still inferior to true letter-quality technologies.

### Mistake 5: Assuming All Impact Printers Are Dot Matrix
**Wrong**: "Impact printer = dot matrix printer."
**Right**: "Dot matrix is the most common impact printer type, but impact is a broader category (includes line printers, band printers, and drum printers)."
**Impact on Exam**: The A+ exam focuses heavily on dot matrix, but you should recognize that other impact technologies exist in the printer landscape.

---

## Related Topics
- [[Laser Printers]] — comparison in quality and function
- [[Inkjet Printers]] — comparison in mechanism and cost
- [[Printer Connectivity]] — how impact printers connect to computers
- [[Printer Maintenance]] — ribbon replacement procedures
- [[Printer Troubleshooting]] — common issues and solutions
- [[Consumables and Supplies]] — ribbons, paper, and toner
- [[Impact]] — the broader printing technology category
- [[A+]] — certification framework

---

*Source: Rewritten from Professor Messer CompTIA A+ Core 1 (220-1201) | [[A+]]*