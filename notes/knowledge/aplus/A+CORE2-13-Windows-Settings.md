# Windows Settings

## What it is

Every Windows tech eventually realizes the OS has two control surfaces glued together: the modern **Settings app** (the touch-friendly one Microsoft keeps pushing) and the legacy **Control Panel** (the one that still owns the powerful knobs). Twelve years into the migration, Microsoft still hasn't finished moving everything over. You will live in both.

In plain English: Windows Settings is the personality dial of the machine — display, network, accounts, power, privacy, updates. If the OS is the mind, Settings is the conscious preferences layer. The Control Panel is the older subconscious that still runs half the show.

Technically: **Settings (`ms-settings:`)** is the UWP app introduced in Windows 8 and expanded in 10/11. **Control Panel (`control.exe`)** is the Win32 applet host going back to Windows 3.0. They overlap. They disagree. Knowing which surface owns which knob is the entire skill.

## Why it matters

Objective 220-1202 1.6 is one of the most ticket-relevant objectives on the exam because configuring Windows settings *is the job* on a Tier 1 helpdesk. Power plans that won't let a laptop sleep. File extensions hidden so the user can't tell `invoice.pdf.exe` from `invoice.pdf`. Network discovery off when shared printing breaks. Privacy toggles that block Teams from seeing the camera.

CompTIA will hand you a scenario — "user wants the laptop to do nothing when the lid closes" — and expect you to know exactly which applet, which tab, which dropdown. No partial credit.

> **CompTIA exam trap:** Many of the sub-bullets on this objective (Hibernate, Power plans, Sleep/suspend, Fast startup, Choose what closing the lid does, USB selective suspend) all live in **Power Options** under Control Panel — not the Settings app. Memorize the actual location, not the label.

## At home, at work

**Beat 1 — Technical depth.**

Settings categories: System, Bluetooth & devices, Network & internet, Personalization, Apps, Accounts, Time & language, Gaming, Accessibility, Privacy & security, Windows Update. Control Panel still owns: **Power Options**, **Devices and Printers** (legacy printer right-click context), **File Explorer Options** (hidden files and extensions), **Internet Options** (proxy, certificates, trusted sites), **Programs and Features** (Win32 uninstall with install date and size), **Mail** (classic Outlook profile config), **Windows Tools** (MMC consoles, Event Viewer, Services).

**Device Manager** (`devmgmt.msc`) is the same MMC snap-in from either surface. **Windows Defender Firewall** has both faces; `wf.msc` is where you actually configure inbound/outbound rules.

**Beat 2 — Feynman example via gaming build.**

Fresh Windows 11 install on a new gaming rig. Before Steam finishes downloading, you're in Settings.

**Personalization:** Dark mode, kill lock screen ads, disable transparency if chasing frames. *Transparency genuinely costs GPU cycles on weak iGPUs.*

**Gaming:** Game Mode on. Auto HDR on if the monitor supports it. VRR on. *Game Mode prioritizes the foreground game and suppresses background updates mid-session — the one Gaming-category toggle that actually does something measurable.*

**Power Options (Control Panel, not Settings):** This is the trap. Settings → System → Power & battery shows half the knobs. The other half — **what closing the lid does**, **USB selective suspend**, **Hibernate enable**, the actual **power plan editor** — live in Control Panel → Power Options → Change plan settings → Change advanced power settings. Gaming desktop wants High Performance, sleep set to Never (mid-raid sleep is a war crime), USB selective suspend disabled so your wireless mouse doesn't drop. *Settings shows you the dashboard. Control Panel lets you open the hood.*

**Privacy & security:** Kill "inking and typing personalization," advertising ID, app diagnostics. *Microsoft's defaults assume you're fine being telemetry. You're not.*

**Beat 3 — Bridge from gaming to enterprise.**

Same fresh install, now you're imaging 400 laptops for a law firm. Every toggle you just clicked? You don't click them. You ship them via **Group Policy**, **Intune configuration profiles**, or a **provisioning package**. Power plans get pushed as a `.pow` file via `powercfg /import`. Lid-close gets set centrally — sleep on lid close at the office, hibernate on battery, because legal can't lose unsaved work. Windows Update gets managed by **WSUS**, **Windows Update for Business**, or **Intune** — deferred 7–30 days so IT can test. The user is a Standard User on a domain-joined or Entra-joined machine, not a local admin named "Brandon" with the dog's name as a password.

**Beat 4 — The point.**

Same Windows, same Settings app, completely different ownership model. At home the user owns every knob. In the enterprise, the user owns *almost none of them* — IT owns them via policy, and Settings shows grayed-out toggles with "Some of these settings are managed by your organization." When a user complains "I can't change my power plan," the answer might not be a bug. It might be policy. Half your tickets will hinge on this distinction.

## Key facts

### Where each thing actually lives

| Setting | Location |
|---|---|
| **View hidden files / Hide extensions** | Control Panel → **File Explorer Options** → View tab |
| **Power plans / Hibernate / Sleep / Fast startup / Lid close / USB selective suspend** | Control Panel → **Power Options** → Advanced settings |
| **Proxy / Trusted sites / Certificates (legacy)** | Control Panel → **Internet Options** |
| **Installed Win32 programs (uninstall)** | Control Panel → **Programs and Features** |
| **Installed UWP apps + default apps** | Settings → **Apps** |
| **Network discovery / File sharing / Public vs Private** | Control Panel → **Network and Sharing Center** → Advanced sharing settings |
| **Adapter properties, IP config (legacy view)** | Network and Sharing Center → Change adapter settings |
| **Network status, Wi-Fi, VPN (modern view)** | Settings → **Network & internet** |
| **Print queues, printer properties** | Control Panel → **Devices and Printers** |
| **Bluetooth devices, modern printer add** | Settings → **Bluetooth & devices** |
| **Hardware drivers, hidden devices** | **Device Manager** (`devmgmt.msc`) |
| **Account type, password, sign-in options** | Settings → **Accounts** (or Control Panel → User Accounts for UAC config) |
| **Time zone, region, language, keyboard** | Settings → **Time & language** |
| **Display, sound, storage, multitasking, About** | Settings → **System** |
| **Wallpaper, themes, lock screen, taskbar** | Settings → **Personalization** |
| **Windows Update, Delivery Optimization, Recovery** | Settings → **Windows Update** |
| **Firewall rules (advanced inbound/outbound)** | `wf.msc` — Windows Defender Firewall with Advanced Security |
| **Accessibility — magnifier, narrator, contrast** | Settings → **Accessibility** (was "Ease of Access" in Win10) |
| **Email account config (classic Outlook)** | Control Panel → **Mail** |
| **Search indexing locations and file types** | Control Panel → **Indexing Options** |
| **Event Viewer, Services, Task Scheduler, Computer Mgmt** | Control Panel → **Windows Tools** |
| **Game Mode, Xbox Game Bar, Captures** | Settings → **Gaming** |
| **Microphone, location, camera per-app permissions** | Settings → **Privacy & security** |

### Power Options deep dive (high-yield)

Every power-related sub-bullet on this objective lives in **one place**: Control Panel → Power Options → Change plan settings → Change advanced power settings.

- **Power plans** — Balanced, Power Saver, High Performance, Ultimate Performance (hidden, enable with `powercfg /duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61`)
- **Sleep / suspend** — RAM stays powered, everything else off, fast resume
- **Hibernate** — RAM contents written to `hiberfil.sys`, machine fully off, zero power draw. Enable with `powercfg /h on`
- **Hybrid sleep** — sleep + hibernate together, for desktops (defends against power loss mid-sleep)
- **Fast startup** — hybrid shutdown; kernel session is hibernated on shutdown for faster boot. Toggle in "Choose what the power buttons do." *Breaks dual-boot setups and sometimes wrecks driver updates. First thing to disable when troubleshooting weird post-update behavior.*
- **USB selective suspend** — powers down idle USB devices. Saves laptop battery. Also the #1 cause of "my wireless mouse drops every few minutes" tickets.
- **Choose what closing the lid does** — Sleep / Hibernate / Shut down / Do nothing. Separate "On battery" vs "Plugged in." High-frequency helpdesk question.

### CompTIA exam traps

> **Trap:** "View hidden files" and "Hide extensions for known file types" both live in **File Explorer Options** (Control Panel) → View tab. Security-relevant: `invoice.pdf` might actually be `invoice.pdf.exe` with extensions hidden.

> **Trap:** **Devices and Printers** (Control Panel) shows printers with right-click access to "Printer properties" and "Print server properties." **Bluetooth & devices** (Settings) does not. For deep printer config — drivers, ports, sharing — you need the Control Panel version.

> **Trap:** **Internet Options** still controls system-wide proxy settings used by many enterprise apps. Even with IE removed in Windows 11, the applet remains because Edge IE-mode and Win32 apps still read from it.

> **Trap:** **User Accounts** in Control Panel is *not* where you add accounts in modern Windows — it's where you configure UAC level and manage Credential Manager. Account creation is Settings → Accounts → Family & other users.

## Helpdesk reality

- *"My laptop won't go to sleep when I close the lid."* → Control Panel → Power Options → Choose what closing the lid does. Check both columns. Then check if Group Policy is overriding — `gpresult /h report.html`.
- *"My mouse keeps disconnecting."* → USB selective suspend in advanced power settings. Disable it. Ticket closed.
- *"I downloaded a PDF but it won't open, it just asks what to open with."* → File Explorer Options → uncheck "Hide extensions for known file types." If it ends in `.exe`, you have a malware incident, not a file association problem. Escalate.
- *"Windows Update keeps trying to install on my work laptop and I can't stop it."* → Settings shows "Some settings are managed by your organization." Update is on a WUfB ring. You can't override. Explain politely, schedule active hours.
- *"Network discovery is off, I can't see the shared printer."* → Control Panel → Network and Sharing Center → Advanced sharing settings → turn on network discovery and file/printer sharing for the **Private** profile. If the network is Public, change it to Private first.

## Related concepts

[[Control Panel utilities]] · [[Task Manager]] · [[MMC and snap-ins]] · [[Group Policy basics]] · [[Windows Update]] · [[Windows Defender Firewall]] · [[Power management and ACPI states]] · [[User accounts and UAC]] · [[Privacy settings and telemetry]] · [[Device Manager troubleshooting]]

*Source: VIRGIL knowledge base — 2026-05-10*