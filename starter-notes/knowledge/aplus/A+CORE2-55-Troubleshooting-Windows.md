---
tags: [knowledge, aplus, core-2-(220-1202)]
created: 2026-04-30
cert: CompTIA A+
chapter: 55
source: rewritten
---

# Troubleshooting Windows
**Master the art of diagnosing and fixing critical Windows system failures that bring entire computers to a halt.**

---

## Overview

Windows encounters various failure modes that require systematic troubleshooting—from catastrophic crashes to driver conflicts. Understanding how to identify, isolate, and resolve these issues is essential for A+ technicians, as you'll regularly encounter systems exhibiting anything from [[Blue Screen of Death]] errors to boot loops. This knowledge separates competent support technicians from the rest.

---

## Key Concepts

### Blue Screen of Death (BSOD) / Stop Error

**Analogy**: Think of your operating system as a conductor leading an orchestra. When a musician (hardware component, driver, or application) plays so badly out of tune that the entire performance becomes impossible, the conductor stops everything immediately and puts up a sign explaining what went wrong. That's a BSOD.

**Definition**: A critical system error that forces [[Windows]] to cease all operations and display a stop screen with error information. The system requires a reboot to recover. Modern versions show a cleaner interface, but the underlying issue remains identical to earlier iterations.

**Root Causes**:
- Faulty [[Hardware]] (RAM, HDD, GPU)
- Corrupted or incompatible [[Device Drivers]]
- Problematic third-party applications
- [[Kernel]] corruption or memory issues

| Cause | Indicator | Solution |
|-------|-----------|----------|
| Driver issue | BSOD after driver install | [[Driver Rollback]] |
| Hardware failure | Random BSOD at boot | Test RAM/HDD |
| Software conflict | BSOD during app use | Safe Mode boot |
| OS corruption | Persistent BSOD loops | [[System Restore]] |

---

### Last Known Good Configuration

**Analogy**: Imagine your car suddenly won't start after you modified the engine. You'd roll it back to the last moment it worked perfectly. Windows does exactly this with system settings.

**Definition**: A [[Windows]] startup recovery option that boots your system using the last saved stable configuration before recent changes were applied. This is particularly effective when a newly installed [[driver]] or software caused instability.

**When to Use**:
- After installing problematic drivers
- Following failed Windows updates
- When system worked yesterday but fails today

---

### Safe Mode

**Analogy**: Safe Mode is like opening a restaurant with only the essential staff and basic operations—no fancy decorations, no extra servers, just the core team running the kitchen. This helps you identify if the problem is with the "extras" or the foundation itself.

**Definition**: A diagnostic [[boot mode]] that loads [[Windows]] with minimal [[drivers]] and services, using only essential components needed for basic operation. This isolates whether issues stem from third-party software or core system problems.

**Three Variants**:

| Mode | Loads | Best For |
|------|-------|----------|
| Safe Mode | Keyboard, mouse, display, network disabled | Basic troubleshooting |
| Safe Mode with Networking | Adds [[NIC]] drivers | Accessing updates, remote support |
| Safe Mode with Command Prompt | Text-only interface | Advanced diagnostics |

**Access Method** (Windows 10/11):
```
Restart → Hold Shift
Settings → System → Recovery → Restart now
Select Troubleshoot → Advanced options → Startup Settings
```

---

### System Restore

**Analogy**: System Restore is like a time machine for your software environment. It takes a snapshot of your working system and can rewind to that moment without affecting personal files.

**Definition**: A [[Windows]] utility that reverts system files, [[Registry]] entries, and installed programs to a previous restore point while preserving documents and media files.

**Key Limitations**:
- Does NOT recover deleted personal files
- Only restores system-related changes
- Requires pre-existing restore points
- May fail if [[System Drive]] is corrupted

---

### Driver Rollback

**Analogy**: A driver rollback is like asking your new employee to leave and bringing back your experienced veteran. If the new person caused chaos, reverting to the previous worker fixes the problem immediately.

**Definition**: The process of reverting a recently updated [[device driver]] to its previous version when the new version causes [[BSOD]], performance degradation, or hardware malfunction.

**Implementation**:
```
Device Manager → Right-click device
Properties → Driver → Roll Back Driver
Select previous version → Confirm
```

---

### Hardware Diagnostics

**Analogy**: Diagnosing hardware is like being a doctor running tests. You don't just treat symptoms; you identify the actual illness by running specific scans.

**Definition**: Systematic physical testing of [[computer hardware]] components to identify failing or defective parts before attempting software solutions.

**Common Scenarios**:
- Open case and reseat [[RAM]] modules
- Check [[Hard Drive]] with built-in diagnostics
- Test [[Power Supply]] under load
- Monitor [[CPU]] and [[GPU]] temperatures
- Run [[CHKDSK]] for disk errors

```
CHKDSK /F /R
(Repairs file system and recovers readable information)
```

---

## Exam Tips

### Question Type 1: BSOD Troubleshooting Sequence

- *"A user reports their workstation displays a blue screen every time Windows boots. What should you try FIRST?"* → **Last Known Good Configuration** or **Safe Mode** (software/driver issue most likely before hardware)
- **Trick**: Don't immediately assume hardware failure—most BSOD issues are driver-related. The exam rewards methodical troubleshooting order.

### Question Type 2: Safe Mode Application

- *"A technician suspects a third-party antivirus is preventing Windows from booting normally. Which boot option isolates the core OS?"* → **Safe Mode**
- **Trick**: Remember that Safe Mode with Networking is different from regular Safe Mode—you need networking capability for some diagnoses, not others.

### Question Type 3: System Recovery Tools

- *"After updating a graphics driver, a computer will not start. Personal files must be preserved. What's the best solution?"* → **Driver Rollback** (fastest) or **System Restore** (if rollback unavailable)
- **Trick**: System Restore is NOT the same as a factory reset—it's much less destructive.

---

## Common Mistakes

### Mistake 1: Assuming BSOD Always Means Hardware Failure

**Wrong**: "I see a BSOD, so the RAM must be bad. I need to replace it immediately."

**Right**: "A BSOD could be driver corruption, faulty software, or hardware. I'll boot into Safe Mode first to isolate the cause before considering hardware replacement."

**Impact on Exam**: The A+ exam emphasizes troubleshooting methodology. Jumping to hardware replacement without proper diagnosis is inefficient and costly. Examiners reward methodical approaches.

---

### Mistake 2: Confusing System Restore with Factory Reset

**Wrong**: "System Restore will wipe my documents and revert me to purchase state."

**Right**: "System Restore only changes system files and installed programs, not personal documents, photos, or downloads."

**Impact on Exam**: You might incorrectly advise a user that they'll lose files, damaging trust. The exam tests your understanding of what data persists through various recovery methods.

---

### Mistake 3: Overlooking Driver Rollback Before System Restore

**Wrong**: "The system crashed after a driver update, so I'll do a System Restore immediately."

**Right**: "If a driver update caused the crash, rolling back that specific driver is faster and less invasive than System Restore."

**Impact on Exam**: Efficiency matters in real-world scenarios. The exam rewards choosing the least disruptive solution that solves the problem.

---

### Mistake 4: Not Checking Physical Hardware First When Possible

**Wrong**: "Safe Mode and System Restore didn't work, so I'm out of options."

**Right**: "I should open the case, reseat RAM and connections, and check for physical damage before declaring the system unfixable."

**Impact on Exam**: CompTIA values hands-on hardware knowledge. Overlooking simple physical checks makes you look inexperienced.

---

## Related Topics
- [[Device Drivers]]
- [[Windows Boot Process]]
- [[Registry]]
- [[Event Viewer]]
- [[Disk Management]]
- [[Command-Line Tools]]
- [[Windows Recovery Environment]]
- [[Startup Repair]]

---

*Source: Professor Messer CompTIA A+ Core 2 (220-1202) | [[A+]]*