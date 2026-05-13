# Troubleshooting Windows

## What it is

The machine boots, the soul wakes up, the personality loads — and something is wrong. Maybe Windows greets you with a blue screen and a sad face. Maybe the login takes four minutes. Maybe Outlook crashes the second you click Send. Maybe the clock is twelve minutes fast and Kerberos is refusing your credentials because of it.

Troubleshooting Windows is detective work on a living system. You have a patient (the OS), symptoms (what the user sees), vital signs (Event Viewer, Reliability Monitor, Resource Monitor, Task Manager), and a finite list of likely causes. Your job is to ask the right questions, observe the right indicators, form a hypothesis, test it, and either fix it or escalate with enough notes that the next tech doesn't start from zero.

Technical definition: applying the CompTIA 7-step troubleshooting methodology — identify, theorize, test, plan, implement, verify, document — to symptoms exhibited by the Windows operating system, ranging from boot failures to application instability to performance degradation.

## Why it matters

Windows owns the enterprise desktop. Every helpdesk ticket queue on Earth is mostly Windows complaints. Objective 220-1202 3.1 is one of the most heavily-weighted sections of Core 2 because this is the actual job — the work you will do every day for years. The exam tests whether you can read a symptom and reach for the right tool without flailing.

The trap candidates fall into: memorizing tools (Event Viewer, MSConfig, Resource Monitor) without internalizing **when** to reach for each one. The exam writes scenarios. You need to read "user reports slow profile load on a domain-joined laptop" and immediately think roaming profile, GPO processing, network share latency — not "I'll check Event Viewer" as a generic answer.

## In your daily life, in the enterprise

**Beat 1 — Technical depth.** Windows symptoms group into roughly six families, and the right diagnostic tool depends on which family you're in.

*Boot failures* (No OS found, boot loops, BSOD before login) live in BCD, the boot partition, disk health, and recent driver/update changes. Tools: WinRE, `bootrec /fixmbr /fixboot /rebuildbcd`, `sfc /scannow`, `chkdsk /f /r`, Startup Repair, Safe Mode.

*Stability issues* (BSOD after login, frequent shutdowns, system instability) live in drivers, RAM, thermals, and PSU. Tools: Event Viewer (System log), Reliability Monitor, BlueScreenView/WinDbg on the minidump in `C:\Windows\Minidump`, MemTest86, temperature monitoring.

*Performance degradation* (slow boot, low memory warnings, degraded performance) lives in startup bloat, runaway processes, disk health, and memory pressure. Tools: Task Manager → Startup tab, Resource Monitor, Performance Monitor, `wmic diskdrive get status` for SMART, page file configuration.

*Application crashes* live in the application event log, missing dependencies, corrupted user profile, or interaction with security software. Tools: Event Viewer → Application log, `sfc /scannow`, repair install of the app, run as different user.

*Services not starting* live in dependency chains, permissions on the service account, or corruption. Tools: `services.msc`, Event Viewer → System log filtered to source "Service Control Manager," `sc query` for dependencies.

*Identity and time* (slow profile load, time drift, Kerberos failures, USB controller resource warnings) live in domain plumbing, hardware resource exhaustion, and BIOS/UEFI settings. Tools: `w32tm /query /status`, `gpresult /h`, Device Manager → View → Resources by connection.

**Beat 2 — Feynman example via the homelab.**

**The BSOD at 2 AM.** You're testing a new GPU driver on your gaming rig. Halfway through a Cyberpunk session: blue screen. `DRIVER_IRQL_NOT_LESS_OR_EQUAL` and a filename — `nvlddmkm.sys`. *The filename in the stop code is the murder weapon. Always.* Boot to Safe Mode, roll back the driver, done.

**The slow boot.** Your homelab Windows VM that used to boot in 15 seconds now takes four minutes. Task Manager → Startup tab shows nineteen things you don't remember installing. Disable the noise, reboot, back to 20 seconds. *Startup bloat is the #1 cause of "my computer got slow" tickets. Always check it first.*

**The mystery crash.** Your stream rig crashes randomly — no BSOD, just powers off. Event Viewer System log shows `Kernel-Power Event ID 41` — meaning Windows didn't crash, the power was yanked. Open the case, the CPU heatsink has dust the thickness of a felt pad. *Kernel-Power 41 with no BSOD means hardware, not software. Almost always thermal or PSU.*

**The corrupted profile.** Your kid's Windows account suddenly loads to a black desktop with default wallpaper, none of their files visible. The profile loaded as TEMP because `NTUSER.DAT` is locked or corrupted. Event Viewer → Application log → User Profile Service confirms it. Fix: log in as admin, rename the busted profile folder, let Windows rebuild on next login. *Slow or broken profile load = always check the User Profile Service event log first.*

**Beat 3 — Bridge from homelab to enterprise.** Same symptoms, bigger blast radius.

The driver BSOD on your gaming rig is a one-machine problem. The same BSOD on 400 enterprise laptops after a Windows Update is a full P1 incident — you're rolling back the update via WSUS or Intune, communicating with the business, and writing an incident postmortem.

The slow boot on your VM is annoying. Slow boot across an OU of domain-joined laptops is a GPO problem — too many group policies, slow logon scripts, or a roaming profile share on a saturated server. You're pulling `gpresult /h report.html`, reading which GPOs are slow, and escalating to the AD team.

The Kernel-Power 41 on your stream rig is dust. The same event ID across a rack of servers is a failing UPS, a bad PDU, or a building power issue — and now you're on a bridge call with facilities at 3 AM.

The corrupted profile on your kid's account is a five-minute fix. The same symptom on a domain user with a roaming profile or FSLogix container is a profile share problem, a quota problem, or a corruption in the VHDX — and you're restoring from a snapshot.

**Beat 4 — The point.** Same symptoms. Different scale. Different right answers. The reason CompTIA hammers troubleshooting methodology is that the *steps* don't change — identify, theorize, test, plan, implement, verify, document — but the tools and stakes do. Get the methodology into your bones at home, and the enterprise version is just bigger plumbing.

## Key facts

### Symptom → first move cheat sheet

| Symptom | First check | Likely cause |
|---|---|---|
| BSOD | Stop code + minidump in `C:\Windows\Minidump` | Driver, RAM, recent update |
| No OS found | Boot order in UEFI, then disk health | Drive failure, BCD corruption, wrong boot device |
| Boot loop | Safe Mode, then check recent updates/drivers | Bad update, driver, corrupt system file |
| Services not starting | Event Viewer → System → Service Control Manager | Dependency failure, account/permission issue |
| System instability | Reliability Monitor for timeline of crashes | Driver, hardware, malware |
| Degraded performance | Task Manager → Performance, Startup tab | Bloat, runaway process, disk failure |
| Application crashing | Event Viewer → Application log | Corrupt install, dependency, profile, AV interference |
| Low memory warnings | Task Manager → Memory + page file settings | Insufficient RAM, leak, page file disabled/too small |
| Slow profile load | Event Viewer → User Profile Service, `gpresult /h` | Roaming profile, GPO bloat, slow network share |
| Frequent shutdowns | Event Viewer → Kernel-Power 41, thermals | Power, thermal, PSU, BSOD-then-reboot loop |
| USB controller resource warnings | Device Manager → Resources by connection | IRQ/resource exhaustion, too many USB devices on one controller |
| Time drift | `w32tm /query /status` | Bad CMOS battery, NTP misconfiguration, VM clock skew |

### The tools, in order of which you reach for first

1. **Event Viewer** — `eventvwr.msc`. System log for hardware/driver/service, Application log for app crashes, Security log for auth. Filter by Critical/Error/Warning. This is your patient chart.
2. **Reliability Monitor** — `perfmon /rel`. Visual timeline of crashes and installs. Best tool to answer "what changed?"
3. **Task Manager** — Ctrl+Shift+Esc. Processes, Performance, Startup, Users tabs. First stop for performance complaints.
4. **Resource Monitor** — `resmon`. Deeper than Task Manager — shows which process is hammering the disk, which file handles are open, which network connections are active.
5. **Services console** — `services.msc`. Start/stop/configure services, check dependencies, change recovery actions.
6. **System Configuration** — `msconfig`. Boot options, Safe Boot, service masking for clean-boot troubleshooting.
7. **SFC and DISM** — `sfc /scannow` checks system file integrity; `DISM /Online /Cleanup-Image /RestoreHealth` repairs the component store SFC pulls from. Run DISM first, then SFC, when system files are suspect.
8. **WinRE** — Windows Recovery Environment. Startup Repair, command prompt for `bootrec`, System Restore, reset PC.

### The minidump

When Windows BSODs, it writes a minidump to `C:\Windows\Minidump\<date>.dmp`. Open it in WinDbg (or the simpler BlueScreenView) and read the stack trace. The driver file named at the top is almost always the culprit. *Treat the minidump like a black box recorder — it tells you what crashed the plane.*

### Time drift specifically

Domain-joined machines sync time from the domain controller. The DC syncs from a configured NTP source (pool.ntp.org, time.windows.com, or an internal stratum-1 appliance). If a workstation's clock drifts more than 5 minutes from the DC, Kerberos authentication fails — user gets locked out of everything.

Causes: dead CMOS battery (clock resets on reboot), VM with paused/migrated state, NTP service stopped, firewall blocking UDP 123. Fix: `w32tm /resync`, replace CMOS battery, check `w32tm /query /source`.

### CompTIA exam traps

> **CompTIA exam trap:** "User reports slow performance" → candidates jump to "reinstall Windows." Wrong. First check Task Manager → Startup, then Resource Monitor for runaway processes, then disk health. Nuke-and-pave is the last resort, not the first.

> **CompTIA exam trap:** "Time is off by 10 minutes, user can't authenticate" — the answer isn't "reset the password." It's the time drift breaking Kerberos. Sync time first.

> **CompTIA exam trap:** SFC vs DISM order. DISM repairs the component store; SFC uses the component store to repair system files. Run DISM **first** if you suspect deep corruption, then SFC. The exam asks about order.

> **CompTIA exam trap:** "No OS found" does not always mean a dead drive. Check boot order in UEFI first — a USB stick left in the port is the most common cause. Then check BCD, then disk health.

## Helpdesk reality

- "My computer is slow" — 80% of the time it's startup bloat, a Chrome with 60 tabs, or a failing drive. Check Task Manager first, in that order.
- "I got a blue screen" — ask for a photo of the stop code. Pull the minidump. Don't promise a fix in 10 minutes; BSODs can be driver, RAM, disk, or update-related, and you need the evidence.
- "I can't log in, it says my password is wrong" — check the clock. Time drift breaks Kerberos. Users never think to mention "oh and my clock is 20 minutes off."
- "It takes forever to log in" — domain user, roaming profile, FSLogix, or GPO bloat. Pull `gpresult /h`, check the profile service event log, escalate to AD team if the network share is the bottleneck.
- "It just shuts off randomly" — Kernel-Power 41 with no BSOD = hardware. Thermals, PSU, or power delivery. Don't reinstall Windows for a hardware problem.
- Document everything in the ticket. The next tech (or future-you in six months) needs to know what you tried, what worked, what didn't. *A ticket with no notes is worse than no ticket — it lies to the queue.*

## Related concepts

[[Troubleshooting Methodology]] · [[Event Viewer]] · [[Safe Mode]] · [[Windows Recovery Environment]] · [[BSOD Analysis]] · [[Group Policy]] · [[User Profiles]] · [[Windows Boot Process]] · [[SFC and DISM]] · [[Task Manager and Resource Monitor]]

*Source: VIRGIL knowledge base — 2026-05-11*