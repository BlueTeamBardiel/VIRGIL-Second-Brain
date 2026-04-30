---
domain: "2.0 - Threats, Vulnerabilities, and Mitigations"
section: "2.3"
tags: [security-plus, sy0-701, domain-2, memory-injection, malware, dll-injection]
---

# 2.3 - Memory Injections

Memory injection is a critical malware deployment and evasion technique where attackers insert malicious code into the memory space of legitimate running processes. This topic is essential for the Security+ exam because memory injection enables attackers to hide malware, escalate privileges, and evade detection while operating with the same permissions as the compromised process. Understanding how memory injection works—and how to detect it through memory forensics—is fundamental to threat detection and incident response.

---

## Key Concepts

- **Memory Injection**: The act of inserting malicious code into the address space of an already-running process to hide the malware and gain access to that process's data and permissions.

- **DLL Injection (Dynamic-Link Library Injection)**: A Windows-specific memory injection technique where an attacker forces a legitimate process to load a malicious Dynamic-Link Library (DLL), causing it to execute arbitrary code within the target process's context.

- **Dynamic-Link Library (DLL)**: A Windows library file containing reusable code, functions, and data that multiple applications can reference and use. DLLs are a core component of Windows application architecture.

- **Process Memory Footprint**: The collection of all data structures resident in a process's virtual address space, including executable code, loaded libraries ([[DLL]]s), threads, buffers, heap memory, and stack frames.

- **Privilege Escalation via Injection**: When malware injects into a higher-privileged process (e.g., a system service running as SYSTEM or Administrator), the injected code inherits those elevated permissions, allowing the attacker to perform privileged operations.

- **Process Hollowing**: A related memory injection variant where an attacker creates a legitimate process in a suspended state, unmaps its original executable image, writes malicious code into the empty memory space, and resumes execution.

- **Memory Forensics**: The post-incident analysis of system memory (RAM) to identify malware, reconstruct attacker actions, and recover evidence of compromise without relying on potentially-compromised disk storage.

- **Detection Evasion**: A primary goal of memory injection—by running inside a legitimate process, the malware blends in with normal system activity and avoids file-system detection signatures.

- **Code Injection vs. Code Execution**: Injection is the *placement* of code into memory; execution is when that code actually runs. Both must occur for a successful attack.

---

## How It Works (Feynman Analogy)

**The Trojan Horse in a Legitimate Delivery Truck:**

Imagine a city that inspects all delivery trucks arriving at the gate (file-system scanning). An attacker can't sneak a truck full of contraband through the checkpoint. But if the attacker can slip onto an *already-authorized* delivery truck that's already inside the city (a running process), no one stops them at the gate. Once aboard, the attacker's goods are protected by the truck's legitimate status and credentials. Not only does the truck never get searched again, but the attacker can now use the truck's special permissions (e.g., access to secure warehouses) to cause damage.

**Technical Reality:**

In memory injection, the "truck" is a legitimate running process (e.g., `explorer.exe`, `svchost.exe`). The malware (the contraband) is written directly into that process's address space by exploiting [[Windows API]] calls like `VirtualAllocEx()`, `WriteProcessMemory()`, and `CreateRemoteThread()`. The injected code then executes with the same security context, access tokens, and permissions as the legitimate process—including any elevated privileges. This makes detection harder because security tools see a trusted process behaving abnormally, not a foreign executable launching from disk.

---

## Exam Tips

- **DLL Injection is the "go-to" answer for Windows memory injection**: When the exam asks about memory injection on Windows, and a DLL-specific context is given, DLL injection is almost always the correct answer. Know that DLLs are Windows libraries, not standalone executables.

- **Memory injection = privilege escalation opportunity**: Recognize that injecting into a SYSTEM or Administrator-level process grants the attacker those permissions. This is a key attack motivation and a common exam question: "Why would an attacker perform memory injection?" Answer: to hide code and escalate privileges.

- **Distinguish memory injection from process injection**: Memory injection is broader (code goes into memory); process injection is the specific technique of hijacking an existing process. Don't conflate it with starting a new malicious process.

- **Memory forensics is the detection method**: The exam often pairs memory injection with memory forensics as the investigative tool. If asked "How do you find memory-resident malware?", the answer is memory forensics tools and RAM analysis.

- **Common DLL injection detection red flags**: Legitimate process loading unexpected DLLs, unsigned DLLs, DLLs from unusual locations, or processes spawning threads with unusual entry points. The exam may ask you to identify suspicious behavior patterns.

---

## Common Mistakes

- **Confusing DLL injection with DLL sideloading**: DLL injection *injects* a malicious DLL into an existing process's memory. DLL sideloading exploits a legitimate application to load a malicious DLL from a non-standard path (usually the same directory as the application). They're related but distinct; sideloading doesn't require active injection code.

- **Assuming memory injection requires admin privileges**: While elevated privileges make injection easier and more powerful, some injection techniques (e.g., injecting into low-privileged processes you own, or exploiting a process-local vulnerability) can work without admin rights. The exam may test this nuance.

- **Forgetting that legitimate processes can be hijacked**: Candidates sometimes think "memory injection" only applies to malware files on disk. In reality, attackers inject into `explorer.exe`, `winlogon.exe`, `lsass.exe`, and other system processes. The process isn't "malware"; the injected code is.

---

## Real-World Application

In the [YOUR-LAB] homelab environment, memory injection is a threat that [[Wazuh]] endpoint agents monitor for by tracking suspicious process behavior, unexpected DLL loads, and anomalous API call sequences. As you manage [[Active Directory]] and domain-joined workstations, understanding memory injection helps when tuning [[Wazuh]] SIEM rules to alert on lateral movement via injected code in privileged processes. During incident response, a memory dump of a compromised host can be analyzed with [[Forensics]] tools to recover and examine injected shellcode before the system is reimaged.

---

## Related Topics & Connections

- [[Malware]]: The payload delivered via memory injection
- [[Buffer Overflow]]: A common technique used to trigger memory injection vulnerabilities
- [[Privilege Escalation]]: A common goal of injecting into higher-privileged processes
- [[Process Hollowing]]: An advanced variant of memory injection
- [[Windows API]]: The system calls (VirtualAllocEx, WriteProcessMemory, CreateRemoteThread) that enable injection
- [[Memory Forensics]]: The detection and investigation method for memory-resident malware
- [[MITRE ATT&CK]]: Framework documentation under Techniques like T1055 (Process Injection)
- [[Incident Response]]: Detecting and remediating memory injection during active compromise
- [[Malware Analysis]]: Understanding injection behavior in the lab
- [[Wazuh]]: Endpoint monitoring and SIEM for detecting injection attempts
- [[Active Directory]]: A common target for memory injection via LSASS or other system processes

---

## Tags

`domain-2` `security-plus` `sy0-701` `memory-injection` `dll-injection` `malware` `privilege-escalation` `evasion` `memory-forensics` `windows-threats`

---
_Ingested: 2026-04-15 23:34 | Source: professor-messer-sy0-701-comptia-security-plus-course-notes-v107.pdf_
