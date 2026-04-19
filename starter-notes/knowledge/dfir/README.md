# DFIR — Digital Forensics and Incident Response
> Finding what happened, when, how, and who — the post-incident autopsy that tells you everything.

DFIR is two disciplines that almost always happen together:
- **Digital Forensics:** Evidence collection, preservation, analysis of artifacts
- **Incident Response:** Structured process to contain, eradicate, and recover from an incident

If IR is surgery, forensics is the autopsy. IR uses forensic findings to make decisions in real-time.

---

## Evidence Sources — Where to Look

### Windows Artifacts (the gold mine)

#### Process and Execution Artifacts
| Artifact | Location | What It Tells You |
|---|---|---|
| **Prefetch** | `C:\Windows\Prefetch\*.pf` | What executed and when (last 8 run times) |
| **Amcache.hve** | `C:\Windows\AppCompat\Programs\Amcache.hve` | Program execution history, install dates, hash |
| **Shimcache / AppCompatCache** | `HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\AppCompatCache` | Every executed binary (survives deletion) |
| **BAM/DAM** | `HKLM\SYSTEM\CurrentControlSet\Services\bam\UserSettings\` | Background Activity Moderator — last execution time per user |

**Prefetch is critical:** Even if an attacker deletes their tool, Prefetch records execution. `cmd.exe-ABC12345.pf` exists forever unless manually removed.

#### File System Artifacts
| Artifact | Location | What It Tells You |
|---|---|---|
| **$MFT** | `C:\$MFT` | Master File Table — metadata for every file ever created |
| **$LogFile** | `C:\$LogFile` | NTFS journal — recent file operations |
| **$UsnJrnl** | `C:\$Extend\$UsnJrnl:$J` | USN change journal — file create/modify/delete log |
| **LNK files** | `%APPDATA%\Microsoft\Windows\Recent\` | Recently accessed files and their original paths |
| **Jump Lists** | `%APPDATA%\Microsoft\Windows\Recent\AutomaticDestinations\` | Recently opened files per application |

**$MFT timestamp forensics:** 4 timestamps per file (MACB: Modified, Accessed, Changed, Born). Attackers can timestomp Modified/Accessed but $MFT $STANDARD\_INFORMATION vs $FILE\_NAME discrepancy reveals tampering.

#### Registry Persistence Artifacts
```
# Autorun locations — check these first
HKCU\Software\Microsoft\Windows\CurrentVersion\Run
HKLM\Software\Microsoft\Windows\CurrentVersion\Run
HKLM\Software\Microsoft\Windows\CurrentVersion\RunOnce
HKCU\Software\Microsoft\Windows NT\CurrentVersion\Winlogon
HKLM\System\CurrentControlSet\Services\          # Malicious services
HKLM\Software\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\  # Debugger hijacking

# UserAssist — GUI program execution with timestamps (ROT13 encoded)
HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\UserAssist\

# MRU (Most Recently Used)
HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\RecentDocs\
```

#### Network Artifacts
| Artifact | Location | What It Tells You |
|---|---|---|
| **DNS cache** | `ipconfig /displaydns` | Recent hostname resolutions (live only) |
| **ARP cache** | `arp -a` | Recent LAN communications (live only) |
| **NetBIOS cache** | `nbtstat -c` | Recent NetBIOS resolutions |
| **Browser history** | Chrome: `%LOCALAPPDATA%\Google\Chrome\User Data\Default\History` | Web access history (SQLite DB) |
| **Browser history** | Firefox: `%APPDATA%\Mozilla\Firefox\Profiles\*.default\places.sqlite` | Web access history |

### Windows Event Logs — The Investigator's Bible
See [[Windows Event IDs]] for the full reference. Key logs:
- `Security.evtx` — authentication, account management, policy changes
- `System.evtx` — service installs, driver loads, reboots
- `Application.evtx` — application errors (sometimes reveals exploitation attempts)
- `Microsoft-Windows-PowerShell/Operational` — PowerShell execution (if logging enabled)
- `Microsoft-Windows-Sysmon/Operational` — if Sysmon deployed (gold standard visibility)

### Linux Artifacts
| Artifact | Location | What It Tells You |
|---|---|---|
| **Auth log** | `/var/log/auth.log` or `/var/log/secure` | SSH logins, sudo, PAM events |
| **Syslog** | `/var/log/syslog` | General system events |
| **Bash history** | `~/.bash_history` | Commands run (can be cleared/disabled) |
| **Last logins** | `/var/log/wtmp` (`last` command) | Login history |
| **Crontabs** | `/etc/cron*`, `/var/spool/cron/` | Scheduled persistence |
| **Systemd services** | `/etc/systemd/system/` | Malicious service persistence |
| **.ssh/authorized_keys** | `~/.ssh/authorized_keys` | Backdoor SSH keys |

---

## Memory Forensics — What's Not on Disk

**Why RAM matters:** Malware that only exists in memory leaves no file artifacts. Encryption keys, passwords, running processes, network connections — all in RAM.

### What You Find in Memory
- Running processes (including injected code, hollowed processes)
- Open network sockets and connections
- Loaded DLLs and drivers
- Decrypted malware payloads (packed malware unpacks in memory)
- Browser session cookies, passwords in plaintext
- Encryption keys (ransomware holds them in memory during encryption)
- Command history from shell sessions

### Volatility Framework
The standard open-source memory analysis tool.

```bash
# Identify OS profile
volatility -f memory.dmp imageinfo

# List running processes
volatility -f memory.dmp --profile=Win10x64 pslist

# Show process tree (spot injected processes by weird parent-child relationships)
volatility -f memory.dmp --profile=Win10x64 pstree

# Find network connections
volatility -f memory.dmp --profile=Win10x64 netscan

# Find DLL injection
volatility -f memory.dmp --profile=Win10x64 malfind

# Dump process memory
volatility -f memory.dmp --profile=Win10x64 procdump -p <PID> --dump-dir=./dumps/

# Command history (console history)
volatility -f memory.dmp --profile=Win10x64 consoles
```

### Memory Acquisition Tools
- **WinPmem** — open source, Windows live memory capture
- **DumpIt** — simple Windows memory dump
- **LiME (Linux Memory Extractor)** — kernel module for Linux RAM capture
- **Magnet RAM Capture** — free, GUI, Windows

---

## DFIR Tools

| Tool | Purpose | Cost |
|---|---|---|
| **Autopsy** | Full forensic suite — disk images, timelines, keyword search | Free |
| **FTK Lite / Imager** | Disk imaging + evidence integrity | Free |
| **Volatility** | Memory forensics framework | Free |
| **KAPE** (Kroll Artifact Parser and Extractor) | Rapid artifact collection + parsing | Free |
| **Eric Zimmerman Tools** | Registry, LNK, prefetch, MFT parsers | Free |
| **Velociraptor** | Enterprise DFIR — remote artifact collection at scale | Free/OSS |
| **Plaso / Log2Timeline** | Multi-source timeline construction | Free |
| **CyberChef** | Data transformation — decode/decrypt/parse artifacts | Free |
| **Sysinternals Suite** | Live Windows investigation (ProcMon, Autoruns, TCPView) | Free |

### Eric Zimmerman Tools (Must-Know for Windows DFIR)
- **MFTECmd** — parse $MFT
- **PECmd** — parse Prefetch
- **RECmd** — parse Registry hives
- **LECmd** — parse LNK files
- **JLECmd** — parse Jump Lists
- **AmcacheParser** — parse Amcache.hve
- **AppCompatCacheParser** — parse Shimcache
All available at: https://ericzimmerman.github.io/

---

## Chain of Custody

Why it matters: Evidence must be provable to be admissible. Even for internal investigations, chain of custody proves your findings aren't fabricated.

### Documentation Requirements
1. **Who** collected the evidence and when
2. **What** — exact description, serial numbers, disk hashes
3. **Where** — physical location and storage conditions
4. **How** — tools used, methods, write blockers used?
5. **Handoffs** — everyone who touched it, with timestamps

### Evidence Integrity
- Hash all disk images with MD5 + SHA256 (belt and suspenders)
- Use hardware write blockers for physical drives
- Never work on originals — always work on forensic copies
- Document everything in real-time, not retrospectively

---

## Timeline Analysis

Building a unified timeline from multiple artifact sources is the core skill of DFIR.

### Timeline Construction Approach
1. **Establish known-good baseline:** when was the last known-clean state?
2. **Identify anchor events:** confirmed attacker activity (e.g., ransomware note creation)
3. **Work backwards:** what happened before the anchor?
4. **Correlate sources:** match event log timestamps with file system timestamps with network logs
5. **Fill gaps:** what *should* have happened that *didn't*? (deleted logs = red flag)

### Tools
- **Plaso / Log2Timeline** — ingests dozens of artifact types, outputs unified timeline CSV
- **Timeline Explorer** (Eric Zimmerman) — GUI timeline analysis
- **Splunk** — if you have forwarded logs, SPL timeline queries

---

## Common Attack Scenarios and What Artifacts They Leave

### Ransomware Attack
Artifacts: mass file renames in $UsnJrnl, Prefetch for encryption tool, Event ID 7045 (new service), VSS deletion in System.evtx, Ryuk/LockBit/etc in Amcache

### Insider Data Theft
Artifacts: USB connection in System.evtx (Event 20001), large file access in LNK/JumpLists, cloud sync client activity, DLP bypass in browser history

### Pass-the-Hash / Lateral Movement
Artifacts: Event ID 4624 Type 3 from unusual sources, NTLM auth in Security.evtx, new logon sessions in expected time windows, SMB connections in network logs

---

## Tags
`#dfir` `#forensics` `#memory-forensics` `#artifact-analysis` `#incident-response`

[[Windows Event IDs]] [[Incident Response]] [[Splunk]] [[CySA+]] [[Velociraptor]] [[Wazuh]] [[Volatility]]
