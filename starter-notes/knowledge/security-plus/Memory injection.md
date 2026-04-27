---
domain: "offensive-security"
tags: [memory-injection, process-injection, malware, evasion, endpoint-security, exam-sy0-701]
---
# Memory injection

**Memory injection** is an offensive technique in which an attacker inserts and executes arbitrary code inside the address space of a **legitimate running process**, rather than deploying a standalone executable. By borrowing the identity, privileges, and trust of a benign host process — commonly `explorer.exe`, `svchost.exe`, or a browser — the attacker bypasses application allowlisting, hides from casual process inspection, and evades signature-based [[antivirus]] scanners. It is a cornerstone of modern [[fileless malware]], [[post-exploitation]] frameworks, and tradecraft used by advanced persistent threats ([[APT]]).

---

## Overview

Memory injection exploits the fact that every process on a modern operating system runs in its own **virtual address space**, and that the OS exposes APIs allowing one process — with sufficient privileges — to read from, write to, and execute code inside another process. On Windows, this capability is provided by the `OpenProcess`, `VirtualAllocEx`, `WriteProcessMemory`, and `CreateRemoteThread` family of Win32 calls; on Linux, equivalents include `ptrace`, `process_vm_writev`, and `/proc/<pid>/mem`. These APIs exist for legitimate reasons — debuggers, profilers, accessibility software, anti-cheat systems, and live-patching tools all depend on them — but they are equally useful for adversaries who want to move silently through a system.

The technique rose to prominence in the early 2000s with the spread of **DLL injection** across game-cheating toolkits and commercial malware families such as Bancos and ZeuS. Over the following decade it became a standard component of every major crimeware and espionage toolkit. Modern attackers rarely drop a malicious `.exe` to disk; instead, they stage a small loader that pulls an encrypted payload from memory, decrypts it, and injects it into a signed Microsoft process. This defeats a large class of legacy defenses: hash-based detection sees nothing on disk, process listings show only trusted binaries, and network inspection sees traffic from processes that are expected to communicate externally — browsers, Windows Update services, print spoolers, and so on.

Memory injection is frequently paired with **[[living off the land binaries]] (LOLBins)** and **[[reflective loading]]** to create stealthy in-memory execution chains. Notable malware that depends heavily on injection includes [[Cobalt Strike]]'s Beacon, Emotet, TrickBot, Qakbot, and Dridex, as well as nation-state implants such as Stuxnet — which injected into `lsass.exe` and `services.exe` — and Duqu. The [[MITRE ATT&CK]] framework catalogues the technique as **T1055 – Process Injection**, with over a dozen sub-techniques covering everything from classic DLL injection to process hollowing to APC abuse.

For defenders, memory injection is dangerous because it crosses a **trust boundary**: the malicious code inherits not only the privileges of the target process but also its security tokens, cached credentials, and open network connections. A successful injection into `lsass.exe`, for example, grants direct access to credential material, making it a common prelude to [[credential dumping]] and lateral movement. The attack is also notoriously difficult to attribute in incident response because the malicious code may leave no on-disk artifact whatsoever — it lives and dies entirely in RAM.

For Security+ candidates, memory injection is explicitly listed as an attack category in **objective 2.3** of the SY0-701 exam (explaining types of vulnerabilities and attack indicators) and connects directly to the broader themes of evasion, [[endpoint detection and response]], and fileless malware covered in the exam domains.

---

## How It Works

The canonical Windows memory-injection sequence — often called **classic DLL injection** — follows five discrete steps that map directly onto Win32 API calls:

**Step 1 — Acquire a handle to the target process with the necessary access rights:**
```c
HANDLE hProc = OpenProcess(
    PROCESS_CREATE_THREAD | PROCESS_VM_OPERATION |
    PROCESS_VM_WRITE      | PROCESS_VM_READ,
    FALSE, targetPid);
```

**Step 2 — Allocate memory inside the target's virtual address space**, initially marked read/write only to avoid an immediate `RWX` flag that many EDRs alert on:
```c
LPVOID pRemote = VirtualAllocEx(hProc, NULL, payloadSize,
                                MEM_COMMIT | MEM_RESERVE,
                                PAGE_READWRITE);
```

**Step 3 — Write the payload** — either a DLL path string (for classic injection) or raw shellcode — into that allocation:
```c
WriteProcessMemory(hProc, pRemote, payload, payloadSize, NULL);
```

**Step 4 — Flip the page protection** to executable after the write, so the transition `RW → RX` is a separate event rather than a single `RWX` allocation:
```c
DWORD old;
VirtualProtectEx(hProc, pRemote, payloadSize,
                 PAGE_EXECUTE_READ, &old);
```

**Step 5 — Trigger execution** of the injected code inside the victim process. The simplest method is creating a remote thread whose start address is `LoadLibraryA` (for DLL injection) or the raw shellcode entry point:
```c
CreateRemoteThread(hProc, NULL, 0,
    (LPTHREAD_START_ROUTINE)GetProcAddress(
        GetModuleHandle("kernel32.dll"), "LoadLibraryA"),
    pRemote, 0, NULL);
```

Because `CreateRemoteThread` is heavily monitored by modern EDRs, sophisticated attackers pivot to stealthier execution variants:

**Reflective DLL Injection** — The payload is a specially crafted DLL that parses its own PE headers, relocates itself, resolves its imports, and jumps to its entry point entirely in memory — never calling `LoadLibrary`. No module is registered in the PEB's loaded-modules list, making it invisible to standard `EnumProcessModules` calls and most forensic tools.

**Process Hollowing (RunPE)** — The loader spawns a legitimate binary (e.g., `notepad.exe`) in `CREATE_SUSPENDED` state, calls `ZwUnmapViewOfSection` to unmap its image, writes a malicious PE in its place, adjusts the `CONTEXT` structure to point `RIP`/`EIP` at the new entry point, then calls `ResumeThread`. To the OS scheduler and most tooling, the process identity is `notepad.exe`; in reality its code section belongs to the attacker.

**Thread Execution Hijacking** — Rather than creating a new thread, the attacker calls `SuspendThread`, reads the thread's `CONTEXT` to record the original instruction pointer, overwrites `RIP`/`EIP` to point at injected shellcode via `SetThreadContext`, and resumes. The shellcode typically restores the original context and jumps back to create the appearance of normal execution.

**Asynchronous Procedure Call (APC) Injection** — `QueueUserAPC` inserts a function pointer into a thread's APC queue. The code executes the next time that thread enters an **alertable wait state** (e.g., `SleepEx`, `WaitForSingleObjectEx`). The **Early Bird** variant queues the APC before a newly-spawned process has fully initialized — before most EDR hooks are in place — making it one of the more evasion-resistant techniques currently in active use.

**Process Doppelgänging / Herpaderping** — These variants abuse NTFS transactions or file-handle timing races so that what the security scanner sees on disk is a legitimate signed binary, while what is actually mapped into the process image is malicious. Windows Defender and other scanners read the file at scan time; by the time the process is launched the contents have changed or the transaction has been rolled back.

**AtomBombing** — Abuses the Windows global atom table: shellcode is stored in an atom (a global key-value store accessible across processes), then retrieved using `GlobalGetAtomName` called via `NtQueueApcThread` inside the target process — entirely avoiding `WriteProcessMemory`.

On **Linux**, the equivalent primitives are `ptrace(PTRACE_ATTACH)` followed by `PTRACE_POKETEXT` to overwrite instructions word-by-word, writes to `/proc/<pid>/mem`, and `LD_PRELOAD` for pre-execution library injection. Kernel-level injection uses loadable kernel modules (LKMs) or, increasingly, eBPF programs that execute in the kernel context with no on-disk presence.

Across all variants, the common defensive chokepoint is that a **cross-process write and a remote execution trigger** must occur somewhere. Detection therefore focuses on telemetry around suspicious `OpenProcess` calls with dangerous access-right combinations, allocations of executable memory not backed by a file on disk, and threads whose start addresses fall outside any loaded module's image range.

---

## Key Concepts

- **Virtual address space** — Every process receives its own isolated memory map from the OS; injection attacks cross this isolation boundary by leveraging OS-provided cross-process APIs rather than exploiting a memory-safety bug.
- **Remote thread** — A thread created by one process inside another's address space using `CreateRemoteThread` or `NtCreateThreadEx`; it is the classic and most observable vehicle for triggering injected code.
- **Reflective loading** — A technique in which a DLL bootstraps its own loading entirely in memory, resolving imports and applying relocations without calling `LoadLibrary`, leaving no trace in the PEB loaded-modules list or on disk.
- **Process hollowing** — Spawning a trusted process in a suspended state, unmapping its original image, and replacing it with a malicious PE, so that the process inherits the binary's name, path, and signature metadata while executing attacker-controlled code.
- **Unbacked executable memory** — Memory pages marked executable that are not backed by a file on disk; a high-fidelity detection indicator because legitimate code in a healthy system is almost always loaded from a signed binary on disk.
- **Token inheritance** — Injected code automatically operates under the security token of the host process; injecting into a high-privilege process such as `lsass.exe` or a SYSTEM service grants those privileges to the payload without any separate escalation step.
- **APC (Asynchronous Procedure Call)** — A mechanism in Windows that queues a function for execution in a specific thread's context when that thread enters an alertable wait; weaponized in APC injection to execute code without spawning a new thread or calling `CreateRemoteThread`.
- **Hooking** — Injected code frequently patches API function entry points in the host process (IAT hooks or inline `JMP` patches) to intercept or redirect calls, enabling credential interception, keylogging, or evasion of security tools.

---

## Exam Relevance

Memory injection appears directly in **SY0-701 objective 2.3** ("Explain various types of vulnerabilities") and **objective 2.4** ("Given a scenario, analyze indicators of malicious activity"). Key tips:

- **Distinguish injection from overflow.** Buffer overflow corrupts memory *unintentionally* due to missing bounds checks; memory injection *deliberately* writes code into a target process. The exam may list both as distractors — pick injection when the scenario involves *intentional* cross-process code placement.
- **Distinguish injection from SQL/LDAP/command injection.** "Injection" on the exam is a broad category. When the target is a *running process's memory* (not a database or shell), the answer is memory injection specifically.
- **Pair injection with fileless malware and LOLBins.** Exam scenarios describing malware that leaves no file on disk, runs inside a signed Windows process, or is detected only by memory scanning are pointing at memory injection as the mechanism.
- **Know the key detection controls.** The exam expects you to associate injection with **EDR** as the primary control, **Sysmon** as a logging tool, and **Protected Process Light (PPL)** as a hardening mechanism for `lsass.exe`.
- **Common gotcha — evasion context.** Memory injection is almost always presented as a *post-initial-access* evasion technique, not initial access itself. If the question asks how an attacker *maintained stealth after gaining access*, injection is the right answer; if the question asks how they *first got in*, look for phishing, exploitation, or credential theft instead.
- **Process hollowing is a sub-technique.** If the exam describes spawning `svchost.exe` and replacing its code before resuming it, that specific term is **process hollowing** — a named variant the exam may test by name.

---

## Security Implications

Memory injection is the central mechanism behind a large fraction of high-profile breaches:

**Stuxnet (2010)** injected code into `lsass.exe` and `services.exe` to intercept Siemens Step 7 PLC communications and spread laterally via network shares and USB devices — demonstrating that injection could be weaponized for physical-world sabotage.

**Duqu and Flame** used injection into `iexplore.exe` and `winlogon.exe` for covert C2 communications, persisting for months inside government networks before discovery.

**Cobalt Strike Beacon** — observed in thousands of intrusions including the **SolarWinds Orion supply-chain attack (2020)** — injects by default into `spoolsv.exe`, `dllhost.exe`, or a user-defined `spawnto` process. Its `inject`, `shinject`, and `dllinject` commands are documented in leaked Cobalt Strike source and in hundreds of incident-response reports.

**CVE-2020-0601 (CurveBall / Windows CryptoAPI spoofing)** allowed attackers to forge trusted code-signing certificates, enabling injection payloads to masquerade as signed, legitimate DLLs — defeating signature-chain validation entirely.

**CVE-2021-34527 (PrintNightmare)** and **CVE-2022-26809 (SMB RCE)** were both rapidly paired with reflective DLL injection payloads in proof-of-concept and real-world exploitation, illustrating how remote code execution vulnerabilities are immediately chained with injection for stealth.

**Mimikatz** uses direct `OpenProcess` + `ReadProcessMemory` against `lsass.exe`, and modern variants load reflectively to avoid triggering on-disk detections. The **DCSync** technique uses injection into the domain replication pathway to extract all domain hashes without ever touching `lsass.exe` directly.

From a **detection** standpoint, injection is valuable to attackers precisely because it defeats category-based detection: no new binary executes, no new service is installed, and network traffic appears to originate from a trusted process. Detection requires **behavioral telemetry** at the API call level, not file-based signatures.

---

## Defensive Measures

**Endpoint Detection and Response (EDR)** — CrowdStrike Falcon, Microsoft Defender for Endpoint, SentinelOne, and Elastic Defend all instrument `NtWriteVirtualMemory`, `NtCreateThreadEx`, `NtQueueApcThread`, and page-protection change syscalls via kernel callbacks and userland hooks. Alert on: cross-process `OpenProcess` with `PROCESS_VM_WRITE` + `PROCESS_CREATE_THREAD`, `RWX` allocations, and threads starting in unbacked memory.

**Microsoft Attack Surface Reduction (ASR) rules** — Enable these rules via Intune, Group Policy, or PowerShell:
```powershell
# Block credential stealing from LSASS
Add-MpPreference -AttackSurfaceReductionRules_Ids `
    9e6c4e1f-7d60-472f-ba1a-a39ef669e4b2 `
    -AttackSurfaceReductionRules_Actions Enabled

# Block process injection from Office macros
Add-MpPreference -AttackSurfaceReductionRules_Ids `
    75668C1F-73B5-4CF0-BB93-3ECF5CB7CC84 `
    -AttackSurfaceReductionRules_Actions Enabled
```

**Credential Guard and Protected Process Light (PPL)** — Running `lsass.exe` as a PPL process prevents even SYSTEM-level processes from opening a handle with `PROCESS_VM_READ`. Enable via:
```
HKLM\SYSTEM\CurrentControlSet\Control\Lsa → RunAsPPL = 1
```
Windows Credential Guard