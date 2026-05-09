# Memory Injections

## What it is

In Doom, the IDDQD cheat code injects new behavior into the running game — you didn't recompile the game, you just slipped instructions into a process that's already alive and running on E1M1. That's exactly what **memory injection** does — an attacker shoves malicious code into the address space of a process that's already executing, so the code runs with that process's privileges and trust.

**Memory injection** is the technique of writing attacker-controlled code or data into the memory of a legitimate running process and causing that process to execute it, typically to gain code execution while evading file-based detection.

## Why it matters

Memory injection is the backbone of modern **fileless malware** and **living-off-the-land** attacks — nothing hits disk, so signature-based AV sees nothing, and the malicious code inherits the legitimacy of the host process (often `explorer.exe`, `svchost.exe`, or a browser). When it works, attackers steal credentials, persist in memory, and pivot before EDR notices.

**Exam angle:** SY0-701 Objective 2.3 lists "memory injection" alongside **buffer overflow** and **race conditions** under application attacks. CompTIA's classic trap: confusing memory injection (writing code into a process) with **DLL injection** (a specific *type* of memory injection) or with **buffer overflow** (which corrupts memory but isn't necessarily injection). Know that DLL injection is a subset, not a synonym.

## Key facts

### How the attack works

1. Attacker identifies or spawns a target process.
2. Allocates memory inside it (`VirtualAllocEx` on Windows).
3. Writes payload into that allocation (`WriteProcessMemory`).
4. Triggers execution (`CreateRemoteThread`, APC queue, thread hijacking).
5. Payload runs with the target's token, PID, and network reputation.

### Common injection variants

| Technique | Mechanism | Detection difficulty |
|---|---|---|
| **[[DLL Injection]]** | Force target to load a malicious DLL | Moderate — DLL on disk |
| **[[Reflective DLL Injection]]** | Map DLL from memory, no LoadLibrary | High — no disk artifact |
| **[[Process Hollowing]]** | Spawn legit process suspended, replace its memory, resume | High |
| **[[Process Doppelgänging]]** | Abuse NTFS transactions to swap image | Very high |
| **[[Thread Execution Hijacking]]** | Suspend a thread, rewrite its context, resume | High |
| **[[APC Injection]]** | Queue Asynchronous Procedure Call into target thread | Moderate |
| **[[Atom Bombing]]** | Abuse Windows global atom tables | High |

### Why it evades defenses

- **No file on disk** → signature AV blind.
- **Trusted parent process** → application allowlists pass it.
- **Inherits network ACLs** → firewall sees `chrome.exe` making the C2 call.
- **Survives until reboot** unless persistence is added.

### Defenses

- **[[EDR]] / [[XDR]]** — behavioral telemetry on `WriteProcessMemory`, `CreateRemoteThread`, suspicious handle opens.
- **[[ASLR]]** — randomizes memory layout, breaks hardcoded offsets.
- **[[DEP]] / NX bit** — marks data pages non-executable; payload in a data page won't run.
- **[[Control Flow Guard]] (CFG)** and **[[CET]]** — validate indirect calls and return addresses.
- **Credential Guard / [[PPL]] (Protected Process Light)** — hardens LSASS against injection.
- **[[Application Allowlisting]]** — limits which binaries can run in the first place.
- **Code signing enforcement** — rejects unsigned modules being loaded.
- **Memory scanning** (YARA in-memory) — catches known payloads post-injection.

### Real-world examples

- **Cobalt Strike** beacons routinely use reflective injection.
- **Meterpreter** (Metasploit) defaults to in-memory payloads.
- **Mimikatz** is frequently injected into LSASS for credential theft.
- **Emotet**, **TrickBot**, **IcedID** — all heavy injection users.

## Related concepts

[[Buffer Overflow]] · [[Fileless Malware]] · [[Living Off The Land]] · [[DLL Injection]] · [[Process Hollowing]] · [[ASLR]] · [[DEP]] · [[EDR]] · [[LSASS]] · [[Privilege Escalation]] · [[Race Condition]]

---
*Source: VIRGIL knowledge base — 2026-05-08*