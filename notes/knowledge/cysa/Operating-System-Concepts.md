# Operating System Concepts

## What it is

In **Resident Evil**, the Spencer Mansion is the puzzle. You don't survive by shooting zombies — you survive by knowing the building. Where the typewriters are. Which doors need the crests. That the medical staff offices have keys in the desks. That the lab under the courtyard has a self-destruct on a timer. Jill and Chris who clear the mansion know its file structure: every room mapped, every locked door catalogued, every key item logged. The ones who die are the ones who wander into the dining hall without knowing what's behind the second door.

That's exactly what OS concepts do for a SOC analyst — they're the mansion map. The endpoint is a building. You can't triage what runs there if you don't know which processes belong in which rooms, which registry hives are the locked drawers, which config paths are the desk where the spare keys live. Malware hides in the mansion the same way Lisa Trevor hides in the attic: in the part of the building nobody bothered to check.

**Technical definition (CS0-003 1.1):** Operating system concepts are the structural knowledge a security analyst needs about how endpoints store configuration, run processes, manage memory, log events, and enforce access control. Without it, every alert is just noise — you can't tell `svchost.exe` running from `System32` (legitimate) from `svchost.exe` running from `AppData\Roaming` (almost certainly not).

## Why it matters

CompTIA puts OS concepts under Objective 1.1 because every other CySA+ domain assumes you have it. Threat hunting? You need to know where persistence lives. Incident response? You need to know which artifacts to grab before the host is reimaged. Vulnerability management? You need to know what services are exposed and which patches matter. Detection engineering? You're writing rules against process trees, registry keys, and file paths — if you don't know the OS, you're writing rules against names you can't validate.

In real ops: the L1 who can explain why `lsass.exe` should never spawn `cmd.exe` catches credential-dumping attacks. The L1 who can't, doesn't. That's the difference between a 6-figure analyst and a ticket-closer.

## Key facts

### System hardening

**Hardening** is reducing attack surface before the attacker shows up. CompTIA frames it as configuration discipline, not a product.

| Hardening control | What it does | Why analysts care |
|---|---|---|
| Disable unused services | Kill what you don't need | Fewer listening ports = fewer doors |
| Patch aggressively | Close known CVEs | Most breaches use vulns >90 days old |
| Least privilege | Users get minimum needed | Limits blast radius on compromise |
| Application allowlisting | Only approved binaries run | Stops 90% of commodity malware |
| Disable legacy protocols | SMBv1, NTLMv1, TLS 1.0 | EternalBlue still works on unpatched boxes |
| Secure baselines | CIS Benchmarks, STIGs | Provable, auditable starting state |

Hardening isn't about who logs in — it's about what can run after they do. [[Zero trust]] extends this: even an authenticated user gets nothing they didn't explicitly ask for.

### Windows Registry

The Registry is Windows' configuration database. Five root hives, hierarchical, key-value. Malware loves it because persistence is a single key write.

| Hive | Holds |
|---|---|
| `HKEY_LOCAL_MACHINE` (HKLM) | System-wide config |
| `HKEY_CURRENT_USER` (HKCU) | Logged-on user's settings |
| `HKEY_CLASSES_ROOT` (HKCR) | File associations |
| `HKEY_USERS` (HKU) | All loaded user profiles |
| `HKEY_CURRENT_CONFIG` (HKCC) | Current hardware profile |

**Persistence keys you must know cold:**

- `HKLM\Software\Microsoft\Windows\CurrentVersion\Run` — runs at boot for any user
- `HKCU\Software\Microsoft\Windows\CurrentVersion\Run` — runs at logon for that user
- `HKLM\System\CurrentControlSet\Services` — service installations (malware-as-a-service)
- `HKCU\Software\Microsoft\Windows\CurrentVersion\RunOnce` — fires once, deletes itself
- `HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon` — Userinit and Shell keys, classic hijack target

When a SOC sees a new value written to a Run key by a process that isn't a known installer, that's a hunt. *I have never once seen a legitimate app write to RunOnce at 2:47am.*

### File structure and configuration paths

You can't detect tampering without knowing where the file is supposed to live.

| Asset | Windows | Linux |
|---|---|---|
| User profiles | `C:\Users\<name>` | `/home/<name>` |
| System binaries | `C:\Windows\System32` | `/usr/bin`, `/usr/sbin` |
| Temp/staging | `C:\Users\<name>\AppData\Local\Temp` | `/tmp`, `/var/tmp` |
| Service config | Registry (`HKLM\System\...\Services`) | `/etc/systemd/system/` |
| Logs | `C:\Windows\System32\winevt\Logs` | `/var/log/` |
| Scheduled tasks | `C:\Windows\System32\Tasks` | `/etc/cron.*`, crontabs |
| Hosts file | `C:\Windows\System32\drivers\etc\hosts` | `/etc/hosts` |
| SSH/auth | (PuTTY in user profile) | `/etc/ssh/`, `~/.ssh/authorized_keys` |

Attacker tradecraft: drop a binary in `AppData\Roaming` because users have write access without admin. Modify `hosts` to redirect a corporate update URL. Add a key to `authorized_keys` for persistent SSH. *If you don't know these paths cold, you'll miss the artifact in the triage screenshot.*

### System processes

Knowing what should be running lets you spot what shouldn't. Windows core processes have a known parent-child tree:

- `System` (PID 4) → has no parent, owns kernel threads
- `smss.exe` → spawned by System, spawns `csrss.exe` and `wininit.exe`
- `wininit.exe` → spawns `services.exe`, `lsass.exe`, `lsm.exe`
- `services.exe` → spawns all `svchost.exe` instances (and they should run from `System32`)
- `lsass.exe` → handles auth; **never** spawns cmd, powershell, or anything else
- `explorer.exe` → user shell, spawned by `userinit.exe`

> **CompTIA exam trap:** When asked to identify suspicious behavior, the right answer is rarely "the malware-named process." Real malware names itself `svchost.exe` or `chrome.exe`. The tell is **wrong parent, wrong path, wrong signing, wrong time**. CompTIA tests parent-child relationships specifically.

### Hardware architecture

CPU architecture (x86, x64, ARM) determines exploit viability and forensic tooling.

- **x86 vs x64** — 32-bit shellcode won't execute on a 64-bit-only process. WoW64 (`SysWOW64`) is where 32-bit binaries live on 64-bit Windows; *yes, the naming is backwards on purpose.*
- **ARM** — most modern Macs and increasing Windows endpoints. Forensic tools must match architecture.
- **TPM 2.0** — hardware root of trust, stores BitLocker keys, required for Windows 11.
- **Secure Boot / UEFI** — validates bootloader signature; bypass requires physical access or firmware-level malware (bootkits).

### Logging levels

CompTIA explicitly tests logging-level discipline because under-logging hides incidents and over-logging burns SIEM license.

| Level | What it captures | When to use |
|---|---|---|
| Emergency / Critical | System unusable | Always on |
| Error | Operation failed | Always on |
| Warning | Something off but recovered | Production default |
| Informational | Normal events, logons, service starts | Security investigations |
| Debug / Verbose | Every API call, every branch | Dev only; never prod long-term |

Windows Event Viewer maps these to Event IDs. Memorize: **4624** (successful logon), **4625** (failed logon), **4672** (admin logon), **4688** (process creation — *the most important security event ID in the OS*), **4720** (account created), **7045** (service installed).

### Time synchronization

Every host on the network must agree on time, or correlation across SIEM logs becomes impossible.

- **NTP** (Network Time Protocol, UDP/123) — standard sync
- Domain-joined hosts sync to the PDC emulator FSMO role holder
- Drift tolerance for Kerberos: **5 minutes**. Beyond that, tickets fail and users get locked out

> **CompTIA exam trap:** If a question describes inconsistent log timestamps preventing event correlation, the answer is NTP / time sync — not log aggregation or SIEM tuning. The root cause is clock drift, not the SIEM.

### Encryption at the OS layer

- **BitLocker** (Windows) / **LUKS** (Linux) / **FileVault** (macOS) — full-disk encryption, keys typically in TPM
- **EFS** (Encrypting File System) — per-file Windows encryption tied to user cert
- **DPAPI** — Windows Data Protection API, used by browsers to store saved passwords; *attackers target DPAPI master keys for credential theft*

[[Public key infrastructure]] underpins all of this — certs, signing, validation. [[Secure sockets layer]] / TLS protects data in transit; full-disk encryption protects data at rest.

### CompTIA exam traps

> **CompTIA exam trap:** "System hardening" vs "patching" — patching closes known vulns; hardening reduces attack surface (disabling services, removing default accounts, applying CIS benchmarks). Patching is a *subset* of hardening, not a synonym.

> **CompTIA exam trap:** Registry hives — HKLM affects all users, HKCU affects only the current user. Persistence in HKLM requires admin; HKCU doesn't. If a question describes malware persisting without elevation, the answer is HKCU\...\Run.

> **CompTIA exam trap:** Event ID 4688 (process creation) is **disabled by default** on Windows. CompTIA will describe an org that "can't see what processes ran" — the answer is enable command-line auditing via Group Policy, not buy a new EDR.

## SOC reality

- **The 3am alert:** EDR fires "suspicious process tree — `lsass.exe` spawned `cmd.exe`." That's credential dumping (Mimikatz, ProcDump). L1 isolates the host immediately; lsass never legitimately spawns a shell. *This is the alert you never debate — you contain first, ask questions second.*
- **What the IR lead asks:** "What's the parent process? What's the binary path? Is it signed? When did it first appear on the host? Is it on any other host?" — every one of these is an OS-layer question. If you can't answer, you don't have the artifact.
- **The hunt query you'll write a hundred times:** processes running from `AppData`, `Temp`, `ProgramData`, or `Public` that aren't on the known-good list. 80% noise (installers, updaters), 20% real findings.
- **What never to promise leadership:** "The host is clean, we re-imaged it." Re-imaging doesn't clean firmware-level persistence, doesn't clean network shares the host wrote to, and doesn't clean the credentials that were stolen before you isolated. The right phrase is *"the host is rebuilt; we're rotating credentials and hunting for lateral movement."*
- **Escalation point:** L1 catches the registry persistence and isolates → L2 pulls memory and timeline → IR confirms scope → if credentials were dumped, identity team rotates and threat hunt expands to anywhere those creds could have been used.

## Related concepts

[[System Hardening]] · [[Windows Registry]] · [[Linux File System]] · [[System Processes]] · [[Logging Levels]] · [[Time Synchronization]] · [[Zero Trust]] · [[Public Key Infrastructure]] · [[Privileged Access Management]] · [[Endpoint Detection and Response]] · [[Process Injection]] · [[Persistence Mechanisms]] · [[Event ID 4688]]

*Source: VIRGIL knowledge base — 2026-05-11*