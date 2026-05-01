---
tags: [knowledge, aplus, core-2-(220-1202)]
created: 2026-04-30
cert: CompTIA A+
chapter: 10
source: rewritten
---

# Windows Command Line Tools
**Master the text-based interface that separates casual users from power troubleshooters.**

---

## Overview

The [[Command Line Interface|command line]] is your gateway to deeper system control in Windows. While graphical interfaces handle routine tasks, techs who master command-line utilities can diagnose problems faster, automate repetitive work, and access system-level controls that GUIs can't touch. For A+, you need to know which tools exist, what they do, and when you have permission to use them.

---

## Key Concepts

### Command Prompt (cmd.exe)

**Analogy**: Think of Command Prompt like the control panel in an airplane cockpit — pilots can access every system directly here, whereas the passenger cabin only shows you basic controls.

**Definition**: [[cmd.exe]] is the Windows command interpreter — a text-based shell that accepts typed commands and executes them directly against the operating system. It's your text-based alternative to clicking through menus.

**How to Launch**:
```
Search → "cmd" → Press Enter (standard user mode)
Search → "cmd" → Right-click → "Run as administrator" (elevated mode)
```

---

### User Privileges vs. Administrator Privileges

**Analogy**: Imagine a library where standard patrons can check out books, but only librarians can reorganize the entire catalog or lock sections — same building, different permission levels.

**Definition**: [[User Privileges|Standard user mode]] allows you to run everyday utilities and view information. [[Administrator Privileges|Elevated/admin mode]] grants the keys to system-level modifications, driver installations, and configuration changes.

| Privilege Level | What You Can Do | What You Cannot Do |
|---|---|---|
| **Standard User** | View system info, run diagnostics, access network tools | Modify OS settings, install drivers, uninstall programs system-wide |
| **Administrator** | Everything standard users can do PLUS modify services, change security policies, edit critical config files | Theoretically nothing — you're the highest local authority |

**When You Need Elevated Privileges**:
- Installing or updating drivers
- Modifying [[Windows Services]]
- Changing [[Network Configuration]]
- Editing [[Registry]] entries
- Running system repair utilities

---

### Launching an Elevated Command Prompt

**Three Methods**:

1. **Search Method**
   ```
   Search → "cmd" → Right-click → "Run as administrator" → Yes (UAC prompt)
   ```

2. **Right-Click Method**
   ```
   Right-click Command Prompt icon → "Run as administrator"
   ```

3. **Keyboard Shortcut** (fastest)
   ```
   Ctrl + Shift + Enter (after typing "cmd" in search)
   ```

---

## Exam Tips

### Question Type 1: Privilege Escalation & Elevation

- *"A technician needs to modify network adapter settings on a Windows 10 machine. Which of the following is required?"* → Administrator/elevated privileges
- *"You're running ipconfig in Command Prompt but can't release/renew the DHCP lease. Why?"* → You're in standard mode; run the command prompt as administrator
- **Trick**: The exam loves asking "Why did my command fail?" — 80% of the time, it's because the student didn't elevate. Don't skip this!

### Question Type 2: Identifying the Right Tool

- *"Which utility lets you view running processes from the command line?"* → [[tasklist]] (standard) or [[tasklist /v]] (detailed)
- *"A user reports slow system performance. Which command shows real-time CPU and memory usage?"* → [[Performance Monitor]] or [[Resource Monitor]] (though tasklist can list processes)
- **Trick**: Know the difference between viewing data and modifying it — viewing usually works in standard mode; killing processes or changing priorities needs elevation.

---

## Common Mistakes

### Mistake 1: Assuming All Commands Work Without Elevation

**Wrong**: "I'll just type the command in the regular Command Prompt window — the utility should work anyway."

**Right**: Some utilities require administrator privileges and will either fail silently or throw an "Access Denied" error if you're not elevated. Always check the A+ objectives for which tools need elevation.

**Impact on Exam**: You might choose the right command but the wrong execution method. Expect questions like, "The technician ran this command but got an access error. What should they do?" Answer: Open Command Prompt as administrator.

---

### Mistake 2: Confusing "Running As Administrator" with Full System Control

**Wrong**: "If I run cmd as administrator, I can do literally anything on any network computer."

**Right**: Elevated privileges give you maximum local control on *that computer*, but you still need network permissions to reach remote machines. You're an admin of this box, not the domain.

**Impact on Exam**: Questions about managing remote computers require network credentials AND admin access on that remote machine. Don't assume elevation solves everything.

---

### Mistake 3: Forgetting UAC Prompts Stop the Process

**Wrong**: "I typed the command, so it should be executing right now."

**Right**: When you request elevation (especially on Windows 10/11 with User Account Control enabled), the system pauses and asks for permission. You must click "Yes" to proceed. If you don't respond, nothing happens.

**Impact on Exam**: Scenario questions might describe someone launching a command as administrator but forgetting to approve the UAC prompt. The answer is "the command hasn't run yet because UAC is waiting for approval."

---

## Related Topics

- [[Command Line Interface (CLI)]]
- [[Windows Services Management (sc.exe)]]
- [[Task Manager vs. tasklist]]
- [[Network Diagnostics (ipconfig, ping, tracert)]]
- [[System File Checker (sfc)]]
- [[Disk Management Command Line Tools (diskpart)]]
- [[User Account Control (UAC)]]
- [[Windows Registry (regedit)]]
- [[Event Viewer]]

---

*Source: Rewritten from Professor Messer CompTIA A+ Core 2 (220-1202) | [[A+]] | [[Windows Administration]]*