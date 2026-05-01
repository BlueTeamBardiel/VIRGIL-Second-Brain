---
tags: [knowledge, aplus, core-2-(220-1202)]
created: 2026-04-30
cert: CompTIA A+
chapter: 60
source: rewritten
---

# Asset Management
**The backbone of IT operations — tracking every device from purchase to retirement.**

---

## Overview

Every organization runs on a sprawling ecosystem of technology: [[endpoints]] like laptops and phones, [[network infrastructure]] like switches and firewalls, and countless internal components. Without a systematic way to know what you own, where it lives, and what condition it's in, IT support becomes firefighting instead of strategy. Asset management transforms chaos into control—letting you answer critical questions instantly when problems arise, justify spending to finance teams, and stay compliant with tax and audit regulations.

---

## Key Concepts

### Asset Inventory Database

**Analogy**: Think of it like a police evidence room. Every item gets logged with its serial number, condition, date received, and location. When you need to know where something is or what happened to it, you have one master registry instead of hunting through dozens of filing cabinets.

**Definition**: A centralized [[database]] that houses complete information about every hardware asset in an organization—including [[device models]], [[serial numbers]], [[purchase dates]], [[depreciation values]], and [[hardware specifications]].

| Benefit | How It Helps |
|---------|-------------|
| **Support Speed** | Technician pulls up customer's entire system configuration instantly |
| **Financial Tracking** | Accounting department calculates [[depreciation]] and budget allocation |
| **Compliance Auditing** | IT verifies all devices are actively deployed and accounted for |
| **Procurement Planning** | Leadership sees spending patterns across device categories |

### Asset Tags

**Analogy**: Like a luggage tag on your suitcase at the airport—a permanent identifier that connects the physical object to the digital record system.

**Definition**: Physical labels (typically [[barcode]] or [[QR code]]) affixed to hardware devices that link the tangible asset to its corresponding entry in the [[asset management database]]. Each tag contains a unique organizational identifier and sequential number.

```
Asset Tag Format:
[Company Name] [Barcode/QR Code] [Unique Asset Number]
Example: ACME-CORP [|||||||] 50847
```

### Depreciation Tracking

**Analogy**: Like knowing your car loses value every year—you track how much your technology investments are worth on the company's balance sheet.

**Definition**: Recording the [[purchase date]] and calculating the decreasing monetary value of assets over time for [[accounting]] and [[tax purposes]]. Most tech depreciates rapidly in the first 3-5 years.

| Device Type | Typical Depreciation |
|-------------|---------------------|
| [[Laptop]] | 20-25% annually |
| [[Desktop Computer]] | 15-20% annually |
| [[Network Switch]] | 10-15% annually |
| [[Mobile Device]] | 25-30% annually |

### Audit Reconciliation

**Analogy**: Like a restaurant doing inventory—physically checking that everything on the list actually exists and is where it's supposed to be.

**Definition**: Periodically verifying that all assets recorded in the database still exist, are functional, and are actively deployed within the organization. Catches missing, stolen, or decommissioned equipment.

---

## Exam Tips

### Question Type 1: Purpose & Benefit Questions
- *"Your organization needs to determine which device category consumed the most budget last quarter. Which tool would you use?"* → Asset management database (provides spending analytics and reports)
- **Trick**: Don't confuse [[asset management]] with [[inventory management]]—asset management is financial + operational; inventory is just counting.

### Question Type 2: Implementation Questions
- *"New company laptop gets distributed to an employee. What should happen first?"* → Assign and apply [[asset tag]]; register in [[database]] with [[serial number]] and [[purchase date]]
- **Trick**: The tag is a **tracking mechanism**, not security—it's not meant to prevent theft, just identification.

### Question Type 3: Compliance & Audit Questions
- *"During an IT audit, three devices on the asset list cannot be located. What does this indicate?"* → Need for reconciliation; possible theft, loss, or premature decommissioning
- **Trick**: Audits catch equipment that was never properly retired from the system—still appears active when it's physically gone.

---

## Common Mistakes

### Mistake 1: Confusing Asset Management with Physical Inventory
**Wrong**: Asset management is just keeping a list of what hardware exists.
**Right**: Asset management tracks ownership, value, depreciation, location, condition, and financial impact.
**Impact on Exam**: You might choose "count the devices" when the question asks for financial reporting—the database serves accounting AND support teams.

### Mistake 2: Thinking Asset Tags Prevent Theft
**Wrong**: Asset tags are security labels that stop someone from taking a device.
**Right**: Asset tags are **identification labels** that link physical hardware to the database for tracking and accountability.
**Impact on Exam**: A question might ask "why do we use asset tags?"—the answer is "inventory tracking and accountability," not "loss prevention."

### Mistake 3: Overlooking Depreciation for Tax Planning
**Wrong**: We track assets just so IT knows what we have.
**Right**: [[Depreciation]] data is critical for [[accounting]], [[tax deductions]], and [[capital budgeting]].
**Impact on Exam**: You might see a scenario where finance needs to know "is this 5-year-old laptop still depreciating?"—the purchase date in the asset database answers this.

### Mistake 4: Assuming All Devices Need the Same Tracking Detail
**Wrong**: Every device (even $50 mice) gets the same level of asset management attention.
**Right**: Organizations typically track **capital assets** (high-value equipment) rigorously; **consumables** (cables, peripherals) are managed differently or not individually tracked.
**Impact on Exam**: A question might ask what should be in the asset database—focus on computers, servers, networking gear, and expensive peripherals, not every cable.

---

## Related Topics
- [[Hardware Inventory]]
- [[Depreciation and Capitalization]]
- [[Network Infrastructure Tracking]]
- [[ITAM (IT Asset Management)]]
- [[Audit Procedures]]
- [[Database Management]]
- [[Barcode and QR Code Systems]]

---

*Source: Professor Messer CompTIA A+ Core 2 (220-1202) | [[A+]]*