# Memory Forensics

## What it is

In **Silent Hill**, Harry Mason's radio crackles before he sees the monster. The fog hides the geometry of the town; the map only shows streets you've already walked. But the radio tells you something is *here, right now*, in the same room as you, even when nothing is visible. Kill the creature, walk away, and the radio goes quiet. There's no corpse on the ground. The threat existed only while it was active.

That's exactly what memory forensics captures — the live, breathing state of a system that disappears the moment you pull the plug.

**Memory forensics** is the acquisition and analysis of a system's volatile memory (RAM) to recover evidence that exists *only while the machine is running*: active processes, injected DLLs, decrypted payloads, encryption keys, open network sockets, command history, and fileless malware that never touches disk. Per CompTIA CS0-003 Objective 3.2, it's a core evidence acquisition activity during Detection and Analysis, and the order matters — get RAM before you touch the disk, before you reboot, before the radio goes quiet for good.

## Why it matters

Modern attackers know disk forensics is a solved problem. So they live in memory. Cobalt Strike beacons, PowerShell Empire, reflective DLL injection, process hollowing, in-memory .NET assemblies loaded via `Assembly.Load()` — none of it persists to disk in a useful form. Pull the power cord and you've destroyed the only copy of the evidence.

For the exam, memory forensics lives under **Objective 3.2** (incident response activities) and bleeds into **2.x** when fileless malware is on the table. CompTIA tests order of volatility, chain of custody for memory images, and tool selection. They'll write a scenario where the L1 analyst reboots the box and ask what evidence is now gone forever.

Career-wise: every IR firm — Mandiant, CrowdStrike, Unit 42, Kroll — runs memory analysis on every engagement. Knowing Volatility plugins by name is the difference between an L1 alert-acknowledger and an L2 incident handler.

## Key facts

### Why RAM is the crime scene

| Lives only in memory | Why it matters |
|---|---|
| Running processes and command-line args | The malware *is* the process. Disk only has the dropper. |
| Injected DLLs / reflective loaders | Process hollowing and DLL injection leave no file on disk |
| Decrypted strings, config blocks, C2 URLs | On disk it's an encrypted blob |
| Encryption keys (BitLocker, LUKS, TrueCrypt) | Pull the plug and you've locked yourself out of the disk |
| Active TCP connections, listening sockets | netstat is a snapshot of *now*, not history |
| Clipboard contents, typed credentials | Often the only place a plaintext password ever appears |
| PowerShell history, cmd buffer | Attacker's keystrokes, exactly as typed |
| Loaded kernel modules, rootkit hooks | A rootkit hiding from disk-based AV still loads into kernel memory |

*If the attacker did it in the last hour and didn't write to disk, RAM is the only witness.*

### Order of volatility (CompTIA-tested, RFC 3227)

Capture from most volatile to least:

1. **CPU registers, cache** — gone in microseconds, rarely captured
2. **RAM** — gone the moment power is cut
3. **Network state** (routing tables, ARP cache, connections)
4. **Running processes** — die with the process
5. **Disk** — survives reboot
6. **Remote logs, backups** — can be pulled later
7. **Physical configuration, archival media** — effectively permanent

**Memory before disk. Always. The exam will test this.**

### Acquisition tools

| Tool | Platform | Notes |
|---|---|---|
| **DumpIt** | Windows | Single binary, dumps to .raw or crash dump format |
| **WinPmem** | Windows | Open source, part of Rekall/Velociraptor, AFF4 output |
| **FTK Imager** | Windows | GUI-driven, also images disk, widely accepted in court |
| **Magnet RAM Capture** | Windows | Free, simple, common first-responder tool |
| **LiME** | Linux | Loadable kernel module, network streaming so you don't write to host disk |
| **AVML** | Linux | Microsoft's tool, no kernel module, works across distros |
| **OSXPmem** | macOS | Increasingly restricted by Apple's kernel hardening |

### Analysis — Volatility is the workhorse

**Volatility 3** (Python 3 rewrite) is the de facto open-source framework. Plugins to know by name:

| Plugin | What it tells you |
|---|---|
| `windows.pslist` / `pstree` | Processes and parent/child relationships — spot `winword.exe` spawning `powershell.exe` |
| `windows.psscan` | Hidden/unlinked processes — rootkits that unlink from the EPROCESS list |
| `windows.malfind` | RWX memory regions with no backing file — classic injected shellcode |
| `windows.dlllist` / `ldrmodules` | Loaded DLLs per process — compare for injections |
| `windows.netscan` | Active and recent TCP/UDP connections — finds C2 beacons |
| `windows.cmdline` | Process command-line args — captures `-EncodedCommand` blobs |
| `windows.hashdump` / `lsadump` | NTLM hashes and LSA secrets from memory |
| `windows.filescan` | File handles open at time of capture |
| `linux.pslist` / `linux.bash` | Linux equivalents; `bash` recovers shell history |

Typical flow: `pslist` → suspicious PID → `malfind` → `cmdline` for launch args → `netscan` for C2 → `dlllist` for injected modules.

### Validating data integrity

The moment the memory image hits disk, hash it. **SHA-256** is current standard; MD5 and SHA-1 are legacy and not collision-resistant. Document the hash in your acquisition log *before* you transfer the file. Re-hash on the analysis workstation and confirm match. If they don't match, the image is inadmissible.

```
sha256sum memory.raw > memory.raw.sha256
```

### Chain of custody for memory images

Same rules as physical evidence:

- **Who** acquired it (analyst name, employee ID)
- **What** (hostname, IP, MAC, OS version, tool + version)
- **When** (UTC timestamp)
- **Where** (physical or logical location)
- **How** (acquisition command and technique)
- **Every transfer** logged with timestamp and signature

Missing one transfer entry torches the case. Defense counsel asks "where was this file between 0200 and 0700 on the 14th?" — if you can't answer, the evidence is excluded.

### What the image actually answers

- **Scope** — `pslist` + `malfind` across hosts gives the blast radius
- **Impact** — `cmdline`, `bash` history, `netscan` show actions and where data went
- **Persistence** — registry hives in memory reveal Run keys, services, scheduled tasks
- **Lateral movement** — `netscan` plus `hashdump` tells you what else the attacker had keys to

### CompTIA exam traps

> **CompTIA exam trap:** L1's first instinct is to "isolate the machine by powering it off." Wrong. Powering off destroys RAM. **Isolation** in a memory-relevant incident means network isolation — pull the cable, quarantine VLAN, or EDR network containment. The machine stays *running* until memory is captured.

> **CompTIA exam trap:** Order of volatility — **memory before disk**. If a scenario involves fileless malware, in-memory C2, or suspected credential theft and asks what to capture first, it's RAM. Not the disk image. Not the event logs.

> **CompTIA exam trap:** "Re-imaging" is a **recovery** activity, not eradication. Eradication removes the threat (kill processes, delete persistence, revoke creds). Re-imaging restores the host to known-good. CompTIA will swap these.

> **CompTIA exam trap:** **Legal hold** preserves evidence — including memory images — from routine deletion once litigation is reasonably anticipated. It's a *legal* directive, not technical. The hold can come from in-house counsel before law enforcement is involved.

### Where memory forensics fits in the lifecycle

- **Detection and Analysis** — memory acquisition happens here. IoCs extracted (C2 IPs, file hashes, mutex names, injected process names) feed the rest of the response.
- **Containment** — network isolation while the host stays powered. EDR network containment is the modern "pull the cable." A **compensating control** like blocking the C2 IP at the perimeter firewall buys time if you can't isolate immediately.
- **Eradication** — kill malicious processes, remove persistence, rotate any creds that appeared in `hashdump` or `lsadump`.
- **Recovery** — re-image from known-good media. Restore from backup *predating* the compromise window memory analysis established.
- **Preservation** — image, hashes, acquisition log, and analysis notes stored per legal hold. Don't delete when the ticket closes.

## SOC reality

- **The 3am page**: EDR fires "suspicious memory injection — `lsass.exe` accessed by `notepad.exe`." L1 acknowledges, confirms it's not a known FP, and *does not* reboot. Network-contain via EDR, page L2.
- **L2 picks it up**: pulls a memory image via EDR remote acquisition (CrowdStrike RTR, SentinelOne, Defender for Endpoint all do this). Hashes it, uploads to evidence storage, opens a Volatility session.
- **The IR lead asks three things, in order**: (1) Is it contained? (2) What's the scope — one host or many? (3) Is the evidence preserved? "Yes, three, yes" lets them sleep. "I think so" gets you a longer conversation.
- **Never promise**: "we have full memory coverage of the incident." You have a snapshot at time T. The attacker may have been active for weeks. Memory shows you *right now*, not history.
- **Handoff point**: L2 → IR team when TTPs match a known threat actor, when credentials are confirmed stolen, or when scope exceeds three hosts. IR team → legal + executive when exfil is confirmed or regulated data (PHI, PCI, PII) is in the blast radius.

## Related concepts

[[Forensics]] · [[Chain of Custody]] · [[Order of Volatility]] · [[Disk Imaging]] · [[Volatility Framework]] · [[Fileless Malware]] · [[Indicators of Compromise]] · [[EDR]] · [[Incident Response Lifecycle]] · [[Containment Eradication Recovery]] · [[Legal Hold]] · [[Evidence Preservation]] · [[Data Integrity Validation]] · [[Compensating Controls]] · [[Re-imaging]] · [[Process Injection]] · [[Credential Dumping]] · [[LSASS]]

*Source: VIRGIL knowledge base — 2026-05-11*