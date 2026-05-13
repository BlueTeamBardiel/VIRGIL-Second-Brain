# Windows Features

## What it is

Every PC has a moment where it starts misbehaving — fans ramping for no reason, a process eating 40% CPU at idle, a service that won't start, a USB device that shows up as "Unknown." The instinct of the new tech is to reboot. The instinct of the experienced tech is to open the right tool and look.

In plain English: Windows ships with a full diagnostic toolkit baked into the OS. You don't need to download anything. You need to know which tool answers which question — and how to launch it fast, because the GUI path is buried three menus deep but the `.msc` or `.exe` shortcut opens it instantly from Run (Win+R).

Technically: these are the **Microsoft Management Console (MMC) snap-ins** and standalone utilities that expose the kernel's view of the running system — processes, services, hardware, logs, performance counters, scheduled tasks, user accounts, and the registry. The OS is the personality of the machine; these tools are how you take its vital signs.

## Why it matters

This is the bread and butter of every helpdesk shift and every A+ Core 2 troubleshooting question. CompTIA Objective 220-1202 1.4 tests these tools by **filename and function** — they will show you a scenario and ask which utility to launch, or give you a filename and ask what it does. Memorizing the `.msc`/`.exe` names is non-negotiable.

In the field, speed matters. Your senior tech doesn't navigate to Control Panel → Administrative Tools → Computer Management → Disk Management. They hit Win+R, type `diskmgmt.msc`, and they're there in two seconds. That fluency is what separates "still in training" from "owns the queue."

## In your build, in the enterprise

**Beat 1 — Technical depth.** The Windows admin toolkit splits into three families. **Task Manager** (Ctrl+Shift+Esc) is the live cockpit — Processes, Performance, Startup, Users, Services, Details tabs. **MMC snap-ins** (`.msc` files) are the deeper consoles loaded into a common management framework: Device Manager, Services, Disk Management, Event Viewer, Performance Monitor, Certificate Manager, Local Users and Groups, Group Policy Editor, Task Scheduler. **Standalone utilities** (`.exe`) handle specific jobs: Registry Editor, System Information, Resource Monitor, System Configuration, Disk Cleanup, Disk Defragmenter. The pattern: `.msc` = console snap-in, `.exe` = standalone tool. Learn the filename, you learn the launcher.

**Beat 2 — Feynman example via your gaming rig.** Your PC starts stuttering mid-raid. Frame drops you've never seen on this hardware. You alt-tab.

**Open Task Manager (Ctrl+Shift+Esc).** Performance tab — CPU pegged at 100%, GPU at 40%. So it's not the GPU. Switch to Processes, sort by CPU. Something called `MoUsoCoreWorker.exe` is eating cores. *Windows Update worker, running a scan while you raid.*

**Drill deeper with Resource Monitor (`resmon.exe`).** Task Manager tells you *what*. Resource Monitor tells you *which files, which network connections, which disk queues*. You see svchost is hammering the SSD reading update payloads. *Resource Monitor is Task Manager with the hood off.*

**Confirm with Event Viewer (`eventvwr.msc`).** System log shows Windows Update started a scheduled scan 12 minutes ago. Matches your stutter timestamp exactly. *Event Viewer is the flight recorder — when something happened, it's logged here.*

**Fix it with Task Scheduler (`taskschd.msc`).** Find the Update scan task, reschedule for 4am. Or open Services (`services.msc`), set Windows Update to Manual so it only runs when you say. *Five tools, one diagnosis chain, ten minutes total.*

**Beat 3 — Bridge from gaming rig to enterprise.** Same chain, different scale. User opens a ticket: "Outlook is slow." At the enterprise helpdesk you remote in and run the same play. Task Manager → see what's hogging CPU. Resource Monitor → see if it's disk-bound (often the case — corporate antivirus scanning OST files). Event Viewer → check for application crashes, profile corruption, GPO application failures. Services → confirm the Outlook-related services are running. The diagnostic discipline is identical. What changes is what you're allowed to *do* about it. On your rig, you disable the update service. On a domain workstation, that service is locked by Group Policy and you can't touch it — you file a ticket with the desktop engineering team instead.

**Beat 4 — The point.** Same fundamental question — *what is this machine actually doing right now?* — same toolkit, different authority level. Get this question into your bones. You'll ask it for the rest of your career.

## Key facts

### Task Manager (Ctrl+Shift+Esc)

The fastest tool, the one you'll open a hundred times a week. Tabs:

| Tab | What it shows |
|---|---|
| **Processes** | Apps and background processes, CPU/Memory/Disk/Network per process |
| **Performance** | Live graphs — CPU, Memory, Disk, Network, GPU |
| **App history** | Resource use over time for Store apps |
| **Startup** | Programs that auto-launch at login — **disable here to speed up boot** |
| **Users** | Who's logged in, what they're running (useful on shared/RDP machines) |
| **Details** | Raw process list with PID, status, user — for advanced kills |
| **Services** | Running services + start/stop — links to full Services console |

### MMC snap-ins (`.msc`) — memorize these

| Tool | Filename | What it does |
|---|---|---|
| **Device Manager** | `devmgmt.msc` | Hardware inventory, driver install/rollback, disable devices. Yellow triangle = problem. |
| **Disk Management** | `diskmgmt.msc` | Partition, format, assign drive letters, initialize disks, extend/shrink volumes |
| **Event Viewer** | `eventvwr.msc` | System/Application/Security logs. The flight recorder. |
| **Services** | `services.msc` | Start, stop, set startup type (Automatic/Manual/Disabled) for Windows services |
| **Task Scheduler** | `taskschd.msc` | Run programs/scripts on a trigger (time, login, event) |
| **Performance Monitor** | `perfmon.msc` | Deep performance counters, data collector sets, long-term logging |
| **Certificate Manager** | `certmgr.msc` | User/computer certificate store — view, import, export certs |
| **Local Users and Groups** | `lusrmgr.msc` | Create local accounts, manage group membership. **Not available on Windows Home.** |
| **Group Policy Editor** | `gpedit.msc` | Local policy settings — password rules, audit policies, software restrictions. **Pro/Enterprise only.** |

### Standalone utilities (`.exe`)

| Tool | Filename | What it does |
|---|---|---|
| **Registry Editor** | `regedit.exe` | Direct edit of the Windows registry (HKLM, HKCU, etc.) |
| **System Information** | `msinfo32.exe` | Read-only hardware/software inventory — model, BIOS version, drivers, conflicts |
| **Resource Monitor** | `resmon.exe` | Per-process disk/network/memory detail beyond Task Manager |
| **System Configuration** | `msconfig.exe` | Boot options, safe mode, services, basic startup. Mostly legacy — Task Manager handles startup now. |
| **Disk Cleanup** | `cleanmgr.exe` | Delete temp files, old Windows Update files, recycle bin |
| **Disk Defragmenter** | `dfrgui.exe` | Defrag HDDs / TRIM SSDs (Windows auto-detects drive type) |

### CompTIA exam traps

> **CompTIA exam trap:** `lusrmgr.msc` vs `gpedit.msc`. **Local Users and Groups** manages accounts. **Group Policy Editor** manages policy settings. CompTIA will pair these in distractors. Also: **both are missing on Windows Home edition** — Home only gets `netplwiz` for basic user management.

> **CompTIA exam trap:** `msconfig` vs Task Manager Startup tab. Old material says msconfig manages startup programs. **Wrong on modern Windows** — Microsoft moved startup management to Task Manager in Windows 8 and never moved it back. Msconfig still handles boot options (safe mode, diagnostic startup), but startup *programs* live in Task Manager.

> **CompTIA exam trap:** Disk Defragmenter on an SSD. Windows is smart enough to issue TRIM instead of a mechanical defrag — but if a question says "defrag the SSD," the correct answer is **don't manually defrag SSDs; let Windows handle optimization on its schedule.** Mechanical defrag of an SSD just wears out cells for no benefit.

> **CompTIA exam trap:** Event Viewer log names. **System** = OS and driver events. **Application** = installed software events. **Security** = audit events (logins, permission changes). They'll give you a scenario and ask which log to check. Failed login → Security. Driver crash → System. App crash → Application.

### Consumer vs enterprise

**At home on your gaming/personal rig:** You launch these tools yourself when something breaks. You have admin rights. You can disable services, edit the registry, kill processes, change boot options. If you wreck something, you restore from your backup and you've learned a lesson. The OS is yours.

**In an enterprise environment, this changes:**

- **Group Policy locks half the toolkit.** Domain admins can disable Registry Editor, Task Manager, Control Panel, and Command Prompt for end users via GPO. As helpdesk you'll get a user account that *can* run these tools — or you'll remote in with a privileged account.
- **Local Users and Groups is irrelevant on domain machines.** Accounts live in Active Directory, not on the local box. You manage users in **Active Directory Users and Computers (`dsa.msc`)** on a domain controller, not in `lusrmgr.msc`.
- **Group Policy Editor (`gpedit.msc`) on a workstation is the *local* policy.** It gets overridden by domain GPO. You'll rarely touch local gpedit at work — domain GPO is the source of truth.
- **Event Viewer logs ship to a SIEM.** Splunk, Sentinel, QRadar. You still open Event Viewer on the local machine for quick triage, but the long-term forensic record lives centrally where security can correlate across thousands of endpoints.
- **Task Scheduler tasks are deployed via configuration management** — Intune, SCCM, Group Policy Preferences. You don't hand-build scheduled tasks on production machines.
- **Performance Monitor data collector sets feed into enterprise monitoring** — SolarWinds, Datadog, PRTG. Local perfmon is for ad-hoc diagnosis; enterprise monitoring is always-on.

The tools don't change. The authority and the scale do.

## Helpdesk reality

- **User says "my computer is slow."** Open Task Manager → Performance tab. CPU pegged? Find the process. Memory pegged? Check for leaks or undersized RAM. Disk at 100%? Almost always antivirus, Windows Update, or a failing drive. *That single tab solves 60% of "slow computer" tickets.*
- **User says "the USB thing doesn't work."** Device Manager. Yellow triangle = driver problem. No entry at all = it's not even being detected, suspect the cable or port. *Don't troubleshoot software for a hardware-detection problem.*
- **User says "I can't print" and the print spooler is the culprit.** `services.msc` → Print Spooler → Restart. Daily occurrence. Memorize it.
- **User says "this error keeps popping up."** Event Viewer → Application log → filter by Error level. The exact error code and source give you something searchable. *Never troubleshoot from the user's paraphrase when the actual error text is one tool away.*
- **Never edit the registry without a backup.** File → Export before any change. One wrong key in HKLM and you're rebuilding the profile or the OS. The senior techs who seem fearless with regedit are the ones who export religiously.
- **Never paste a user's machine name, username, or error screenshot into a non-approved AI tool.** Use Microsoft Copilot or your company's approved assistant for triaging unfamiliar errors. Privacy policy applies (220-1202 Objective 4.6).

## Related concepts

[[Windows Editions]] · [[Command Line Tools]] · [[Control Panel]] · [[Windows Settings]] · [[Active Directory]] · [[Group Policy]] · [[Windows Troubleshooting Methodology]] · [[Event Logs and SIEM]] · [[Windows Services]]

*Source: VIRGIL knowledge base — 2026-05-10*