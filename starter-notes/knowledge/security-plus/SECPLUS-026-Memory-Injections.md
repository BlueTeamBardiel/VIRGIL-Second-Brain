---
tags: [knowledge, security-plus, secplus]
created: 2026-05-01
cert: CompTIA Security+
exam: SY0-701
chapter: 026
source: rewritten
---

# Memory Injections
**A technique where attackers embed malicious code into running processes to hide from detection and inherit elevated privileges.**

---

## Overview
Memory injection attacks work because every program on your computer—whether legitimate or malicious—must execute from [[RAM]] rather than sitting dormant on disk. Since attackers need their code to actually run on target systems, they have a critical choice: launch malware as a standalone [[Process|process]] or hide it inside an already-running legitimate application. This concept is crucial for Security+ because understanding injection vectors helps you recognize how attackers maintain stealth and privilege escalation without creating obvious new processes that security tools can detect.

---

## Key Concepts

### Process Memory Space
**Analogy**: Think of a running application like an apartment building with clearly marked boundaries—a ground floor (starting address) and a roof (ending address). An intruder can sneak in and hide anywhere between those boundaries while the building continues operating normally.

**Definition**: Every [[Process|process]] occupies a protected memory region with defined starting and ending addresses. Only code loaded between these boundaries can execute within that process's context.

| Characteristic | Details |
|---|---|
| Starting Address | Memory location where process begins |
| Ending Address | Memory boundary where process terminates |
| Protected Isolation | Each process operates in separate memory space |
| Access Control | [[Kernel]] enforces which code can run here |

---

### DLL Injection
**Analogy**: Imagine a toolbox (legitimate application) that workers (processes) share. An attacker slips a fake tool into the box; when workers grab tools, they unknowingly use the malicious one alongside legitimate ones.

**Definition**: [[DLL|Dynamic Link Libraries]] are reusable code libraries that multiple [[Process|processes]] can load and execute. Attackers inject malicious DLLs into legitimate process memory so the existing application loads and runs attacker code with its own permissions.

| Aspect | Impact |
|---|---|
| Detection Evasion | Malware hides inside legitimate process name |
| Privilege Inheritance | Injected code runs with host process's access level |
| Persistence Method | DLL loads automatically when parent process executes |
| Common Targets | explorer.exe, svchost.exe, system processes |

---

### Privilege Escalation Through Injection
**Analogy**: Like a guest slipping into a VIP section by following the venue owner—you inherit their access without earning it.

**Definition**: When malware injects into a high-privilege [[Process|process]] (like a Windows service or administrative application), the injected code automatically inherits that process's elevated [[Access Control|permissions]] and rights.

---

### Host Process Selection
**Analogy**: A parasite chooses a strong host animal—the healthier and more important the host, the better the parasite's chances of survival and reproduction.

**Definition**: Attackers deliberately inject into legitimate system processes (svchost.exe, explorer.exe, rundll32.exe) because these are trusted by security tools and run with necessary privileges.

---

## Exam Tips

### Question Type 1: Identifying Injection Characteristics
- *"A security analyst observes explorer.exe consuming unusual memory and making unexpected network connections. What technique likely allowed this behavior?"* → **Memory injection** — the legitimate process inherited malicious code's functionality while maintaining its trusted appearance.
- **Trick**: Don't assume the process name = legitimate behavior. Injected processes show anomalies in resource usage, network behavior, or loaded libraries despite appearing trusted.

### Question Type 2: Detection and Evasion
- *"Why is memory injection effective against antivirus software scanning for new processes?"* → **It hides within existing processes**, so the malware never appears in the process list—only suspicious activity within a legitimate process name becomes visible.
- **Trick**: Remember that [[Endpoint Detection and Response|EDR]] tools must monitor *behavior* (API calls, network activity), not just process names.

### Question Type 3: Privilege Context
- *"An attacker injects code into a process running under SYSTEM account. What is the primary advantage?"* → **Instant privilege escalation**—the injected code executes with SYSTEM-level rights without needing to exploit a privilege vulnerability.
- **Trick**: This is about *inheritance*, not exploitation. The attacker doesn't escalate; they simply borrow existing privileges.

---

## Common Mistakes

### Mistake 1: Confusing Injection with Separate Malware Process
**Wrong**: "Memory injection means launching malware as Process ID 2956—the attacker is creating a new process."
**Right**: "Memory injection means embedding code *inside* an existing process (like PID 1234 explorer.exe), so malware runs under that process's identity."
**Impact on Exam**: Questions test whether you understand that injection is *stealth through inheritance*, not just launching separate executables. You'll see scenarios where anomalous behavior occurs under legitimate process names.

### Mistake 2: Assuming All DLL Loading is Malicious
**Wrong**: "If a process loads a DLL not in the application's original manifest, it's definitely injected malware."
**Right**: "Legitimate software legitimately loads plugins and libraries. Injection occurs when unauthorized code sneaks a DLL into a process's memory space without the application's knowledge or permission."
**Impact on Exam**: You need to distinguish between [[Dynamic Link Library|DLL]] injection (unauthorized code loading) versus normal [[Dependency|dependencies]]. Context matters.

### Mistake 3: Misunderstanding the Privilege Inheritance Window
**Wrong**: "The injected malware code runs with its original malware's privileges; it doesn't gain access to the host process's rights."
**Right**: "Injected code executes in the host process's memory space and security context, automatically inheriting all that process's permissions—this is injection's primary value to attackers."
**Impact on Exam**: Questions will ask *why* attackers target specific processes (answer: those processes run with needed privileges). Missing this means you'll misidentify the attack's objective.

---

## Related Topics
- [[Process]] — Understanding process memory and context
- [[DLL]] — What libraries are and how they load
- [[Privilege Escalation]] — Methods attackers gain higher access
- [[Endpoint Detection and Response]] — How tools detect behavior-based attacks
- [[Rootkit]] — Similar persistence technique that modifies kernel space
- [[API Hooking]] — Related technique where injected code intercepts system calls
- [[Code Signing]] — Defense against unsigned DLL injection
- [[Memory Protection]] — ASLR and DEP defenses against injection

---

*Source: Professor Messer CompTIA Security+ SY0-701 | [[Security+]]*