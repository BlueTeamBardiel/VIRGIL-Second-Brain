# OS — Operating System

## What it is

In **Half-Life**, when the Resonance Cascade hits Black Mesa, Gordon Freeman doesn't fight headcrabs by punching the walls — he fights them through the facility itself. The blast doors, the security keypads, the tram system, the ventilation shafts, the surface-to-Lambda elevators — every interaction with the world goes through Black Mesa's infrastructure. The facility *is* the interface. When the HECU marines breach, they don't hack Gordon's HEV suit directly; they take the security console, lock the blast doors, and starve him out. Control the facility, control the fight.

That's exactly what an operating system is — **the facility between the user and the hardware**. Every process, every file read, every network packet, every privilege check goes through the OS. Compromise the OS and you don't need to hack the application; you own the floor it stands on.

Technical definition: an **operating system** is the software layer that manages hardware resources (CPU, memory, disk, NIC), provides services to user-space applications via system calls, enforces process isolation, and mediates access to files, devices, and the network. For a CySA+ analyst, the OS is where the telemetry lives and where the attacker fights for control — privilege escalation, persistence, credential theft, lateral movement all happen at the OS layer.

## Why it matters

Objective **CS0-003 1.1** puts OS concepts under "system and network architecture for security operations." Translation: you can't triage an alert if you don't know what normal looks like on the host. A SOC analyst who can't read a process tree, find a registry persistence key, or identify which log source covers authentication is an analyst who closes real intrusions as false positives.

Real stakes: most endpoint detections fire on OS-layer behavior — a child process spawning from `winword.exe`, a service binary path pointing at `\AppData\`, a scheduled task running `powershell.exe -enc`. The signal is at the OS layer. So is the noise. Knowing the difference is the job.

## Key facts

### Hardware architecture — what the OS sits on

The OS abstracts hardware so applications don't have to care about the silicon. From a defender's view, the layers that matter:

- **CPU rings** — Ring 0 is kernel, Ring 3 is user. Kernel-mode rootkits live in Ring 0 and are invisible to user-space EDR. This is why [[EDR]] hooks at the kernel.
- **TPM** — Trusted Platform Module, hardware crypto chip. Stores BitLocker keys, attests boot integrity. Pulled into [[Zero Trust]] device-health checks.
- **Secure Boot / UEFI** — verifies the bootloader signature before kernel load. Defeats bootkits if enabled. Often disabled on legacy hosts. Check it.
- **HSM** — Hardware Security Module, the enterprise-grade TPM. Stores PKI root keys offline.

### File structure — where artifacts hide

| OS | Key paths | What lives there |
|---|---|---|
| Windows | `C:\Windows\System32\` | Core OS binaries — attackers drop lookalikes (`scvhost.exe` vs `svchost.exe`) |
| Windows | `C:\Users\<u>\AppData\Roaming\` | User-writable, no admin needed — malware loves it |
| Windows | `C:\ProgramData\` | Machine-wide user data, often world-writable |
| Linux | `/etc/` | Config files — `passwd`, `shadow`, `sudoers`, `crontab` |
| Linux | `/var/log/` | Logs — `auth.log`, `syslog`, `secure` |
| Linux | `/tmp/`, `/dev/shm/` | World-writable, memory-backed — fileless payload staging |
| Linux | `~/.ssh/authorized_keys` | SSH persistence — check this on every Linux compromise |

### Windows Registry — the Windows config database

The registry is a hierarchical key-value store. Five root hives matter:

- **HKLM** (Local Machine) — system-wide config. Service definitions, installed software, boot config.
- **HKCU** (Current User) — per-user settings.
- **HKCR, HKU, HKCC** — derived/linked views.

Persistence keys the SOC checks first:

| Key | What it does |
|---|---|
| `HKLM\...\Run` and `RunOnce` | Auto-run on boot/login |
| `HKCU\...\Run` | Per-user auto-run, no admin needed |
| `HKLM\...\Services\` | Service definitions — change `ImagePath`, own the service |
| `HKLM\...\Image File Execution Options\` | Debugger hijack — sticky-keys backdoor |
| `HKLM\...\Winlogon\Shell` and `Userinit` | Logon hijack |

Linux equivalent: `/etc/systemd/system/`, `/etc/cron.*`, `~/.bashrc`, `/etc/rc.local`.

### System processes — what should be running

Windows baseline processes every analyst memorizes:

| Process | Parent | Notes |
|---|---|---|
| `System` (PID 4) | none | Kernel |
| `smss.exe` | System | Session manager — one instance |
| `csrss.exe` | smss | Multiple OK, but parent should be smss |
| `wininit.exe` | smss | One instance, Session 0 |
| `services.exe` | wininit | Spawns services — one instance |
| `lsass.exe` | wininit | **Credential store** — Mimikatz target. One instance, ever. |
| `svchost.exe` | services.exe | Many instances OK, but parent must be services.exe |
| `explorer.exe` | userinit | Desktop shell |

> **CompTIA exam trap:** If a question shows `lsass.exe` with a parent other than `wininit.exe`, or two instances of `lsass.exe`, that's credential-dumping or a process-hollowing impersonator. Not a normal Windows state. The trap answer is "system service" — the right answer is "investigate for credential theft."

### Configuration file locations

- **Linux:** `/etc/` for system, `~/.<app>` or `~/.config/` for user
- **Windows:** registry primarily, plus `%ProgramData%`, `%AppData%`, `%LocalAppData%`
- **macOS:** `/Library/`, `~/Library/`, plist files
- **Web servers:** `/etc/nginx/`, `/etc/apache2/`, `C:\inetpub\` for IIS

When malware drops config, it lives somewhere writable by the process's identity. That narrows the hunt.

### Logging and log ingestion

The OS generates the telemetry; [[SIEM]] ingests it. What you collect determines what you can detect.

**Windows event logs** (Event Viewer / `wevtutil`):
- **Security** — auth events. 4624 (logon), 4625 (failed logon), 4672 (privileged logon), 4688 (process creation — only if enabled).
- **System** — service start/stop, driver load.
- **Application** — app-specific.
- **Sysmon** (not default — install it) — process creation with full command line, network connections, file writes, registry mods. The single biggest endpoint visibility upgrade you can deploy.

**Linux:**
- `/var/log/auth.log` or `/var/log/secure` — SSH, sudo, PAM
- `/var/log/syslog` — general
- `auditd` — kernel-level audit (the equivalent of Sysmon)

**Logging levels** (syslog severity, 0–7):

| Level | Name | Use |
|---|---|---|
| 0 | Emergency | System unusable |
| 1 | Alert | Action required immediately |
| 2 | Critical | Hard failures |
| 3 | Error | Errors |
| 4 | Warning | Warnings |
| 5 | Notice | Significant but normal |
| 6 | Informational | Routine |
| 7 | Debug | Verbose, noisy, expensive |

> **CompTIA exam trap:** Production hosts should **not** ship at debug level — the volume crushes the SIEM and costs real money in ingestion licensing. But during incident response, you crank a specific host to debug temporarily for visibility. Knowing when to turn the dial is the answer CompTIA wants.

### Time synchronization

Every log timestamp must agree or your timeline reconstruction is fiction. **NTP** (Network Time Protocol, UDP 123) syncs hosts to a stratum source. Windows uses **W32Time**, often pointed at the domain controller, which points at an external source.

> **CompTIA exam trap:** "Why are the SIEM correlation rules missing the attack?" Common right answer: **clock drift**. If the web server logs say 14:02 and the auth server says 14:09, the correlation window misses the link. NTP isn't glamorous; it's load-bearing.

### System hardening

The OS ships with everything turned on for compatibility. Hardening is the act of turning off what you don't need.

- Disable unused services and protocols (SMBv1, Telnet, FTP)
- Apply CIS Benchmarks or DISA STIGs as the baseline
- Patch — both OS and third-party
- Local admin password rotation ([[LAPS]] on Windows)
- AppLocker / WDAC for application allowlisting
- Host firewall on, default deny inbound
- BitLocker / LUKS for full-disk encryption
- Disable LLMNR, NBT-NS, mDNS to kill Responder attacks
- Remove or restrict PowerShell v2; enable script-block logging

### Virtualization, containers, serverless

- **Virtualization** — hypervisor (Type 1: ESXi, Hyper-V; Type 2: VirtualBox) runs full guest OS. Each VM has its own kernel. Strong isolation, heavy.
- **Containers** — share the host kernel via namespaces and cgroups (Docker, containerd). Lighter, faster, weaker isolation. A kernel exploit escapes the container.
- **Serverless** — Lambda, Azure Functions. No OS to manage, no patching, but you also can't install an EDR agent. Telemetry comes from the cloud provider's logs ([[CloudTrail]], Azure Activity).

This matters for logging strategy: a containerized app's logs come from the container runtime, not the guest OS. A serverless function logs to the provider's logging service. You don't get [[Sysmon]] in Lambda.

## SOC reality

- At 3am the EDR fires on `powershell.exe` with parent `winword.exe`. First action: pull the full process tree from Sysmon, check the command line, check the user, check whether the host has [[MFA]] on remote access. Macro-borne payload until proven otherwise.
- The IR lead's first three questions: *what process, what parent, what command line?* If you can't answer from the console in 60 seconds, your logging baseline is broken. Fix it before the next incident, not during.
- "We patched it" is not the same as "we hardened it." The CISO will ask both. A patched host with SMBv1 still enabled and a local admin password that hasn't rotated in three years is still a soft target.
- Clock drift will lose you a case. Every IR retro that ends "we couldn't correlate the auth event with the file write" traces back to NTP. Check it on the gold image, not after the incident.
- Never promise "we have full endpoint visibility" until you've checked which hosts actually have the agent installed, reporting, and not in bypass mode. *An EDR console that shows 9,847 of 10,000 endpoints means 153 hosts are dark — and the attacker only needs one.*

## Related concepts

[[SIEM]] · [[EDR]] · [[Sysmon]] · [[Windows Event Logs]] · [[Zero Trust]] · [[PAM]] · [[MFA]] · [[System Hardening]] · [[Virtualization]] · [[Containerization]] · [[Serverless]] · [[PKI]] · [[NTP]] · [[Privilege Escalation]] · [[Persistence]] · [[Process Tree Analysis]]

*Source: VIRGIL knowledge base — 2026-05-11*