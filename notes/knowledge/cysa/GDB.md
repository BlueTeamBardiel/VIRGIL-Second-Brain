# GDB — GNU Debugger

## What it is

In **Mortal Kombat**, the Fatality input window is the most unforgiving teaching tool in fighting games. You watched Scorpion rip a spine out — fine. Now you have to figure out *how*. So you go to the practice stage, slow the game to frame-by-frame, and step through the inputs one button at a time: Back, Back, Down, Back, Front Punch. Miss a frame and nothing happens. Hit them all in sequence and the screen goes black, the announcer growls *FATALITY*, and you finally understand what was happening at the input layer the whole time.

GDB is the practice stage for binaries. You take a compiled program — usually one that crashed, or one you suspect is exploitable — and you step through it one instruction at a time, watching the registers, the stack, the memory addresses, until you understand exactly which input frame turned a normal function call into a buffer overflow.

In plain English: **GDB is a command-line debugger that lets you pause a running program, inspect its memory, walk through it instruction by instruction, and figure out why it broke or how to break it on purpose.**

Technical: GDB is the GNU Project's open-source source-level and machine-level debugger. It supports C, C++, Rust, Go, Fortran, Ada, and assembly. It can attach to running processes (`gdb -p PID`), load core dumps post-mortem, set breakpoints and watchpoints, modify memory and registers at runtime, and disassemble functions live. On CySA+, GDB shows up as the canonical Linux **debugger** under [[vulnerability assessment tools]] — the counterpart to **Immunity Debugger** on Windows.

## Why it matters

CompTIA objective 2.2 lists GDB by name. The exam will ask you to identify which tool you use to analyze a suspected malicious binary, examine a crash dump from a fuzzed application, or step through an exploit proof-of-concept to confirm whether it actually works against your version of the affected service.

In real work, the CySA+ analyst doesn't write exploits — but they do receive vendor advisories that say *"CVE-2025-XXXX, heap corruption in libfoo, exploitability unknown"*, and someone has to decide whether that gets patched this weekend or next quarter. GDB is how you answer that question instead of guessing. It's also how the malware analyst confirms what an unknown binary is doing when the sandbox report came back inconclusive.

> **CompTIA exam trap:** GDB is the **Linux** debugger; **Immunity Debugger** is the **Windows** debugger (Python-scriptable, popular for exploit dev). If the scenario is a Linux ELF binary or a core dump from a Linux service, the answer is GDB. If it's a Windows PE binary, it's Immunity (or WinDbg, or OllyDbg). CompTIA loves swapping these in distractors.

## Key facts

### What a debugger actually does

A debugger has four superpowers. Lose any one of them and it stops being useful.

| Capability | What it means | GDB command |
|---|---|---|
| **Pause execution** | Stop the program at a chosen instruction | `break`, `b main`, `b *0x4011a0` |
| **Inspect state** | Read registers, stack, heap, variables at the pause point | `info registers`, `x/20wx $rsp`, `print var` |
| **Step instructions** | Move forward one source line or one CPU instruction | `step`, `next`, `stepi`, `nexti` |
| **Modify state** | Overwrite memory or registers mid-flight to test theories | `set $rax=0`, `set {int}0x601040=0xdeadbeef` |

That's it. Everything else GDB does — scripting, reverse debugging, multi-thread tracing — is built on those four primitives.

### Core workflow for analysis

```
gdb ./suspicious_binary       # load the binary
(gdb) info functions          # list all symbols
(gdb) disas main              # disassemble main()
(gdb) break *0x4011c4         # breakpoint at a specific instruction
(gdb) run                     # start execution
(gdb) info registers          # dump RAX, RBX, RIP, RSP at pause
(gdb) x/40wx $rsp             # examine 40 words on the stack
(gdb) stepi                   # one CPU instruction forward
(gdb) continue                # resume until next breakpoint
```

For a crash post-mortem, swap `run` for loading the core dump: `gdb ./binary core.1234`. GDB drops you directly at the faulting instruction with the register state preserved from the moment of death.

### Attaching to a live process

```
gdb -p $(pgrep nginx)
```

Used by the analyst when a process is misbehaving in production and you can't restart it. Requires either root or matching UID, and on modern Linux you fight `ptrace_scope` in `/proc/sys/kernel/yama/ptrace_scope` — set to `1` by default, which blocks non-parent ptrace. Lower it to `0` to attach freely, but never in production without a change ticket. *Attaching a debugger to a running service pauses it — every connected client will hang until you `continue`. Found that out the hard way on a Friday afternoon database.*

### GDB in vulnerability work

The CySA+ analyst uses GDB for three concrete jobs:

1. **Crash triage.** A fuzzer (AFL++, libFuzzer) generated 400 crashing inputs against an internal service. You load each core dump in GDB, check the faulting instruction and register state, and bucket them: NULL deref (annoying, not exploitable), out-of-bounds read (info disclosure), stack/heap corruption with attacker-controlled data in RIP (critical, drop everything).
2. **PoC verification.** Someone posts a CVE exploit for the version of OpenSSL you're running. Before you panic the change board, you reproduce it locally, attach GDB, and confirm RIP control. Half the time the PoC is theatrical and only crashes the process. The other half it's real and you call the on-call.
3. **Malware reverse engineering.** A binary came off a compromised host. The sandbox said "suspicious network activity, indeterminate." You load it in GDB, set breakpoints on `connect()` and `send()`, and watch what gets pushed onto the stack right before each call. That's the C2 address and the exfil payload, in clear text, in the register dump.

### GDB enhancements analysts actually use

Vanilla GDB is hostile. Everyone runs a frontend:

- **pwndbg** — exploit-dev focused. Auto-displays registers, stack, disassembly on every break.
- **GEF** (GDB Enhanced Features) — same idea, slightly different output, more reversing-focused.
- **PEDA** — older, Python-based, still in tutorials.

If you see an exam scenario or a job posting mentioning "GDB with pwndbg" — that means binary exploitation work, not generic Linux debugging.

### Where GDB sits in the CS0-003 tool zoo

CompTIA objective 2.2 throws a long list of tools at you. Here's the map so you can pattern-match on the exam:

| Tool | Category | What it does |
|---|---|---|
| **GDB** | Debugger (Linux) | Step through binaries, analyze crashes |
| **Immunity Debugger** | Debugger (Windows) | Same idea, Windows PE, exploit dev |
| **Nmap** | Network scanner | Host discovery, port scanning, service/OS fingerprinting |
| **Angry IP Scanner** | Network scanner | Lightweight IP/port sweep, GUI |
| **Maltego** | OSINT / link analysis | Visual relationship mapping for recon |
| **Recon-ng** | OSINT framework | Modular, CLI, automates passive recon |
| **Nessus** | Vulnerability scanner | Commercial, credentialed scans, plugin-based |
| **OpenVAS** | Vulnerability scanner | Open-source Nessus equivalent |
| **Nikto** | Web vuln scanner | Loud, fast, checks for known web misconfigs |
| **Arachni** | Web app scanner | Crawler + scanner for web apps |
| **Burp Suite** | Web proxy / app testing | Intercept, modify, replay HTTP — the web tester's GDB |
| **OWASP ZAP** | Web proxy / app testing | Open-source Burp, automation-friendly |
| **Metasploit** | Exploitation framework | Modular exploits, payloads, post-ex |
| **Scout Suite** | Cloud assessment (multi-cloud) | AWS/Azure/GCP misconfig auditing |
| **Prowler** | Cloud assessment (AWS-focused) | CIS benchmark + compliance checks |
| **Pacu** | Cloud exploitation (AWS) | Offensive AWS framework, the cloud Metasploit |

> **CompTIA exam trap:** Don't confuse **vulnerability scanners** (Nessus, OpenVAS — find known CVEs against patch level) with **debuggers** (GDB, Immunity — analyze a single binary at the instruction level). Scanners answer *"what's unpatched across 10,000 hosts?"* Debuggers answer *"why is this one process crashing, and can an attacker control where?"* Different questions, different tools, different answer choices.

> **CompTIA exam trap:** **Pacu** is for **AWS exploitation** (offense). **Prowler** and **Scout Suite** are for **AWS assessment** (defense/audit). All three are cloud — easy to swap in distractors. If the question says "post-compromise enumeration of an AWS account," it's Pacu. If it says "audit our AWS environment against CIS benchmarks," it's Prowler or Scout Suite.

### Limits of GDB

GDB is precise but slow. It will not scan a fleet, it will not enumerate CVEs, it will not find an SSRF in your web app. It analyzes **one binary at a time**, usually one **function** at a time, and the operator has to know what they're looking for. Modern defenses also fight back: stripped symbols make function names disappear, anti-debug tricks (`ptrace(PTRACE_TRACEME)` self-checks, timing checks) make malware refuse to run under GDB, and ASLR randomizes addresses between runs.

*If you're loading a stripped, packed, anti-debug binary into GDB cold with no prep, you're going to burn four hours and learn nothing. Triage with strings, `file`, and a sandbox first. GDB is the scalpel, not the can opener.*

## SOC reality

- A vendor advisory drops at 4pm Friday: *"CVE-2026-XXXX, RCE in libxyz, PoC public, exploitability rated 'likely.'"* You spin up an isolated VM with the affected version, fetch the PoC, run it under GDB, and check whether the crash gives RIP control or just a NULL deref. That answer determines whether the IR lead pages the on-call DBA tonight or files a normal ticket Monday.
- A fuzzer the AppSec team set up flagged 200 crashes against an internal billing service. The triage queue is yours. You write a 30-line GDB script that loads each core, checks the faulting address and whether $rip is in a mapped region, and auto-tags each one *exploit-likely* / *exploit-unlikely* / *NULL-deref*. The 12 exploit-likely ones go to AppSec; the rest go in a JIRA epic with a P3.
- The CISO does not ask about GDB. The CISO asks "is this CVE exploitable in our environment, yes or no, and if yes when is it patched?" GDB is how you produce a defensible answer instead of forwarding the vendor's CVSS and hoping.
- Never run unknown binaries under GDB on your daily-driver workstation. Use an isolated VM with no network or a snapshot you can revert. *Malware that fingerprints the debugger and detonates a wiper when it sees ptrace is not hypothetical. Saw it in 2024.*
- Escalation path: L1 spots the crash in the alert queue → L2 reproduces under GDB and characterizes exploitability → IR/AppSec owns remediation → vendor or internal dev owns the patch. The CySA+ analyst lives at the L2 spot.

## Related concepts

[[Immunity Debugger]] · [[Nmap]] · [[Nessus]] · [[OpenVAS]] · [[Metasploit]] · [[Burp Suite]] · [[OWASP ZAP]] · [[Nikto]] · [[Arachni]] · [[Maltego]] · [[Recon-ng]] · [[Angry IP Scanner]] · [[Scout Suite]] · [[Prowler]] · [[Pacu]] · [[CVSS]] · [[Buffer overflow]] · [[Reverse engineering]] · [[Malware analysis]] · [[Core dump analysis]] · [[ptrace]] · [[ASLR]]

*Source: VIRGIL knowledge base — 2026-05-11*