---
tags: [knowledge, aplus, core-1-(220-1201)]
created: 2026-04-30
cert: CompTIA A+
chapter: 39
source: rewritten
---

# The BIOS

**The firmware that boots your computer before Windows even knows what's happening.**

---

## Overview

Before your operating system takes the wheel, something else has to get the engine running—that's the [[BIOS]]. When you power on your machine, the BIOS is the invisible mechanic under the hood, running diagnostics and preparing all the hardware before handing control to Windows, Linux, or macOS. For the A+, understanding the BIOS is critical because you'll need to troubleshoot startup issues, identify hardware problems, and know how the computer initializes itself from power button to login screen.

---

## Key Concepts

### BIOS (Basic Input/Output System)

**Analogy**: Think of BIOS like the startup checklist a pilot runs through before takeoff—it checks every critical system, verifies everything works, and then hands control to the flight crew (your OS).

**Definition**: [[BIOS]] is [[firmware]] stored in [[flash memory]] on the [[motherboard]] that initializes hardware components and prepares the system to load the [[operating system]]. It's the first software to run when you press the power button.

**Other Names You'll See**:
- System BIOS
- ROM BIOS (legacy term—modern systems use [[flash memory]], not [[ROM]])
- [[Firmware]]

---

### POST (Power-On Self-Test)

**Analogy**: POST is like a bouncer checking IDs at a club—it verifies that all the essential equipment is present and working before letting the operating system inside.

**Definition**: The [[POST]] is an automated diagnostic routine that runs immediately after power-up, checking for critical hardware like the [[CPU]], [[RAM]], [[keyboard]], and [[mouse]]. If hardware fails this test, you'll hear beep codes or see error messages instead of a normal boot.

**What POST Checks**:
- CPU is present and functioning
- RAM is installed and accessible
- Input devices connected (keyboard, mouse)
- Storage devices recognized
- System bus and motherboard components operational

**Timeline**: The entire POST process takes only a few seconds, then the system moves to the next stage.

---

### Boot Loader

**Analogy**: The boot loader is like an usher at a theater—it appears at the end of the line and tells you which direction to go (which OS to load).

**Definition**: The [[boot loader]] is a small program that runs after POST completes successfully. It presents you with a menu (if multiple operating systems are installed) or automatically loads your default OS from the [[hard drive]].

**Key Point**: If you see a boot menu letting you choose Windows, Ubuntu, or macOS—that's the boot loader at work. Once you (or the system) make a selection, the actual OS begins loading into [[RAM]].

---

### Flash Memory (BIOS Storage)

**Analogy**: Flash memory is like a sticky note on a light switch—it keeps its information even when the power turns off, unlike the RAM that forgets everything.

**Definition**: [[Flash memory]] is non-volatile storage on the [[motherboard]] where the BIOS firmware lives. Unlike [[RAM]], it retains data when powered down, making it perfect for storing boot instructions.

**Modern vs. Legacy**:

| Aspect | Legacy (ROM BIOS) | Modern (Flash BIOS) |
|--------|-------------------|-------------------|
| Storage Type | Read-only memory (truly static) | Rewritable flash memory |
| Updatability | Required chip replacement | Software update ([[BIOS flashing]]) |
| Flexibility | Limited; couldn't be modified | Can be updated for new hardware support |
| Exam Relevance | Know the term; rarely used today | This is the standard |

---

### UEFI (Unified Extensible Firmware Interface)

**Analogy**: UEFI is like upgrading from a flip phone to a smartphone—it's the modern successor to BIOS with better graphics, more power, and support for larger drives.

**Definition**: [[UEFI]] is the modern replacement for traditional [[BIOS]]. It provides a graphical boot interface, faster startup, support for drives larger than 2TB, and secure boot features. You'll see UEFI in all modern systems manufactured after ~2012.

**Quick Comparison**:

| Feature | BIOS | UEFI |
|---------|------|------|
| Interface | Text-based, simple | Graphical, mouse support |
| Startup Speed | Slower | Faster |
| Hard Drive Size Limit | 2TB max | No practical limit |
| Security | Basic | Secure Boot, TPM support |
| Exam Weight | Still tested | Heavily tested |

---

## Exam Tips

### Question Type 1: Identifying BIOS Purpose

- *"A technician powers on a computer and sees a manufacturer logo with progress bars before Windows loads. What is this process called?"* → [[POST]] (Power-On Self-Test)
- *"Where is modern BIOS firmware stored on a computer?"* → [[Flash memory]] on the [[motherboard]]
- **Trick**: Don't say "ROM"—that's legacy terminology. Modern systems use flash memory. The test will trick you with "ROM BIOS" as a distractor.

---

### Question Type 2: Boot Sequence Troubleshooting

- *"A user has Windows and Ubuntu on their system. During startup, they see a menu asking which OS to load. What component displays this menu?"* → [[Boot loader]]
- *"POST completes successfully, but the computer won't load Windows. Where should you look first?"* → [[BIOS settings]] for boot device order; verify hard drive is listed first
- **Trick**: Questions might ask "What runs before POST?" — The answer is nothing; POST is the first thing after power-up.

---

### Question Type 3: Hardware Detection Issues

- *"A technician installs a new CPU, powers on the machine, and hears a continuous beep pattern. What happened?"* → [[POST]] failed (CPU not recognized); continuous beeps = CPU failure code
- *"A computer won't recognize the newly installed keyboard during startup. What could cause this?"* → [[POST]] detected missing keyboard; check BIOS settings for legacy USB support or reinstall keyboard
- **Trick**: Remember—POST checks for keyboard/mouse presence. If BIOS can't find them, POST reports an error.

---

## Common Mistakes

### Mistake 1: Confusing BIOS and POST

**Wrong**: "POST is the BIOS software that runs on your computer."

**Right**: [[POST]] is a *process* (diagnostic routine) that the [[BIOS]] firmware *executes*. BIOS is the software; POST is what it does.

**Impact on Exam**: You might see questions like "What does BIOS stand for?" answered with POST-related definitions. Know they're different—BIOS is the program, POST is its job.

---

### Mistake 2: Thinking Modern BIOS Uses ROM

**Wrong**: "BIOS is stored in read-only memory, so you can never update it."

**Right**: Modern [[BIOS]] (and especially [[UEFI]]) is stored in [[flash memory]], which *can* be rewritten through [[BIOS flashing]] (a software update). You *can* update BIOS without replacing hardware.

**Impact on Exam**: A question asking "How can you update BIOS?" should be answered with "BIOS flash/firmware update," not "replace the ROM chip." That's 1990s tech.

---

### Mistake 3: Assuming BIOS Loads the Operating System

**Wrong**: "BIOS loads Windows from the hard drive into RAM."

**Right**: [[BIOS]] and [[POST]] prepare the system, then the [[boot loader]] takes over and initiates OS loading. BIOS doesn't load the OS—it sets up the stage for the boot loader to do so.

**Impact on Exam**: Questions about "What initializes the system?" = BIOS. Questions about "What loads the OS?" = Boot loader. Don't conflate them.

---

### Mistake 4: Forgetting UEFI Exists

**Wrong**: "All modern computers use traditional BIOS."

**Right**: Systems built after 2012 predominantly use [[UEFI]], which is the successor to BIOS. You'll see both on the exam, but UEFI is the modern standard.

**Impact on Exam**: If a question mentions "Secure Boot," "graphical firmware interface," or "GUID Partition Table (GPT)," the answer involves [[UEFI]], not legacy BIOS.

---

## Related Topics

- [[POST (Power-On Self-Test)]]
- [[UEFI]]
- [[Boot Loader]]
- [[Motherboard]]
- [[Flash Memory]]
- [[Firmware]]
- [[BIOS Settings and Configuration]]
- [[BIOS Flashing and Updates]]
- [[Startup Troubleshooting]]
- [[CMOS Battery]]

---

*Source: Rewritten from Professor Messer CompTIA A+ Core 1 (220-1201) | [[A+]]*