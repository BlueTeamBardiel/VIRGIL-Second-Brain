# Installing Applications

## What it is

You bought a new game. You check the system requirements page — CPU, RAM, GPU, VRAM, storage, OS version. You compare against your rig. You decide between the Steam download and the boxed disc your friend handed you. You hit install. Somewhere in the middle you notice it wants 120 GB of SSD space and a 64-bit OS, and your laptop has 200 GB free and runs Windows 11 24H2, so you're fine.

That entire decision tree — *can this machine run it, where does the installer come from, what does installing it cost the system* — is what CompTIA calls "installing applications according to requirements." In plain English: before you double-click `setup.exe`, you verify the machine can handle it, you pick a delivery method, and you understand what the install will change about the box.

Technically: application installation is the process of provisioning executable code, libraries, registry entries, configuration files, and licensing artifacts onto a target system, verified against documented hardware and OS prerequisites, delivered through an approved distribution channel.

## Why it matters

This is the single most common helpdesk request in your first IT job. "Can you install [thing] on my laptop?" Sometimes the answer is yes, sometimes the answer is "your machine can't run that," and sometimes the answer is "that software isn't approved on our network." You need to know which is which and why, fast.

CompTIA tests this on objective 220-1202 1.10. They want you to evaluate system requirements against hardware, predict the impact of an install on device/network/storage/operation, and pick the right distribution method for the situation. They will absolutely give you a scenario where someone wants 64-bit software on a 32-bit OS and ask you what's wrong.

> **CompTIA exam trap:** 64-bit applications **cannot** run on a 32-bit OS. 32-bit applications **can** run on a 64-bit OS via the WoW64 subsystem on Windows. The arrow only goes one direction. CompTIA tests this exact distinction.

## In your build, in the enterprise

**Beat 1 — Technical depth.** Every install has four gates to clear before it'll actually work. **CPU**: architecture (x86 vs x64 vs ARM64) and instruction-set extensions (AVX2, AVX-512). Modern AAA games and AI tools assume AVX2; older CPUs without it get a hard "this application cannot start" wall. **RAM**: the published minimum is a lie, the recommended is honest, and 2x recommended is what you actually want. **Storage**: install footprint plus working space (game caches, shader compilation, swap). **GPU/VRAM**: graphics-intensive apps fail or stutter when VRAM is undersized — modern games at 1440p+ want 12 GB minimum, AI inference wants 16 GB to 24 GB. Then the soft gates: **OS compatibility** (the app supports Windows 11 24H2? macOS Sequoia? which kernel on Linux?), **bitness** (32-bit OS cannot run 64-bit binaries, period), **hardware tokens** (some enterprise apps and CAD packages require a USB dongle to launch — lose the dongle, the seat is dead), and **network** (license server reachable? installer pulling 40 GB through the office uplink at 9 AM Monday?).

**Beat 2 — The gaming rig install.** You bought a new flight sim.

**The CPU check:** Sim wants a recent AVX2-capable CPU. Your Ryzen 7 7800X3D laughs. *Modern Ryzen and Core Ultra clear every consumer CPU gate that exists in 2026.*

**The RAM and VRAM check:** Recommended is 32 GB system RAM, 12 GB VRAM. You have 32 GB DDR5 and a 4070 Ti with 12 GB. You're at recommended, not above it. Textures will pop, the sim will run, ultra settings will swap to system RAM and stutter. *Meeting recommended specs means the app runs. It doesn't mean it runs well.*

**The storage check:** 180 GB install. Your Steam drive has 240 GB free. Technically fits. Except the sim does shader compilation on first launch and wants another 20 GB of scratch. Plus updates. You install it on the 2 TB drive instead. *Always plan for install size plus 25%.*

**The distribution check:** Steam download. 180 GB over your 1 Gbps fiber, two hours. The boxed version your friend has would take ten minutes off a USB stick but the disc-installer is two patches behind and will redownload most of it anyway. Steam wins. *Physical media is a 2026 curiosity unless you're offline.*

**Beat 3 — Bridge to enterprise.** Same install, different building. A junior analyst joins the SOC team and needs Wireshark, a hex editor, a VM platform, and the company's EDR agent on her new ThinkPad.

She does not go to wireshark.org and click download. She opens the **Company Portal** (Intune) or **Software Center** (SCCM/MECM), where IT has pre-approved and pre-packaged Wireshark with the company's licensing, logging hooks, and proxy configuration baked in. She clicks Install. The MSI/MSIX deploys silently in the background with the right command-line switches, registers itself with the asset database, and shows up in her Start menu five minutes later. She never sees a UAC prompt because the package runs as SYSTEM under the Intune management extension. The EDR agent was already there — it was part of the **image** her laptop was deployed from on day one, alongside the OS, the corp certificate, the VPN client, and Office 365.

That's the bridge. Consumer install: user decides, user downloads, user clicks setup, user babysits the wizard. Enterprise install: IT decides, IT packages, the management tool pushes silently, the user clicks once. The system requirements check happens at the procurement stage when IT certifies the app against the standard laptop SKU, not when the user wants the app. The license is corporate, not personal. The install is logged, the asset is tracked, the uninstall is one command away when the analyst leaves the company.

**Beat 4 — The point.** *Same fundamental question — "can this machine run this software and is this the right way to install it" — different answer at home vs at work.* At home, you are the procurement department, the security team, the packager, and the user. At work, three of those four are someone else's job, and your role as a tech is making sure the user gets to "click once, it works" without you having to RDP in and fix it. Get this question — "who decides, who packages, who installs, who supports" — into your bones. You'll ask it for the rest of your career.

## Key facts

### System requirements — the four gates

| Gate | What to check | Why it matters |
|---|---|---|
| **CPU** | Architecture (x86/x64/ARM64), core count, clock, instruction sets (AVX2/AVX-512) | App won't launch if CPU lacks required instructions |
| **RAM** | Installed GB vs recommended; not minimum | Minimum = "it boots." Recommended = "it works." |
| **Storage** | Install size + 25% headroom + scratch/cache | Out-of-space crashes corrupt installs |
| **GPU / VRAM** | Dedicated vs integrated; VRAM size | Integrated graphics fail most modern game/AI workloads |

### Bitness — the rule that never moves

- **64-bit app on 64-bit OS** — native, full performance, can address >4 GB RAM
- **32-bit app on 64-bit OS** — runs under WoW64 (Windows) or Rosetta-equivalent translation layers; works fine for most legacy apps
- **64-bit app on 32-bit OS** — **will not run, ever**
- **32-bit OS** — capped at ~4 GB addressable RAM total. In 2026 you should not be deploying 32-bit Windows. If you find one in the field, that's a finding for the upgrade report.

### Dedicated vs integrated graphics

| Type | Where the VRAM lives | Workloads |
|---|---|---|
| **Integrated** (Intel UHD/Iris Xe, AMD Radeon Graphics in APUs) | Shares system RAM | Office, browsing, video playback, light photo edit |
| **Dedicated** (NVIDIA RTX 4060/4070/4090, AMD RX 7800/7900) | On-card GDDR6/GDDR7 | Gaming, CAD, video editing, 3D rendering, AI inference |

A dedicated GPU with 8 GB VRAM crushes any integrated GPU at gaming. An integrated GPU is fine for the helpdesk laptop running ServiceNow and Teams all day. Match the tool to the workload — don't put a 4090 on a ticketing workstation, don't try to run Blender on a Surface Go.

### Impact considerations — what an install changes about the box

- **Device impact** — drivers installed, services registered, startup items added, registry modified. Some apps install kernel-mode drivers (EDR, anti-cheat, VPN) — these can conflict with each other and tank stability.
- **Network impact** — first-time download (40 GB game = saturated link), telemetry, license check-ins, auto-update behavior. Schedule large deployments outside business hours.
- **Storage impact** — install footprint, plus logs, plus cache, plus user data over time. Apps grow on disk.
- **Operation impact** — RAM and CPU consumed at runtime, background services always on, battery drain on laptops. Slack, Teams, Chrome, and an EDR agent together can eat 6 GB RAM before the user opens their actual work app.
- **Hardware tokens** — some apps (older CAD, some financial/legal software, hardware-locked licenses) require a USB dongle or smart card to launch. Plan for token storage and replacement procedures.

### Distribution methods

| Method | What it is | Where you see it |
|---|---|---|
| **Physical media** | DVD, USB stick, install disc | Niche in 2026 — air-gapped networks, OEM recovery media |
| **Downloadable package** | MSI, EXE, DMG, AppImage, PKG pulled from vendor site | Home use, small business |
| **App store / portal** | Microsoft Store, Mac App Store, Company Portal (Intune), Software Center (SCCM) | Managed device installs |
| **Image deployment** | App baked into the OS image deployed at machine provisioning | Enterprise — apps every user needs (Office, EDR, VPN) live in the gold image |
| **Push deployment** | Intune, SCCM, Jamf, Group Policy software install push silently to fleets | Enterprise — apps not everyone needs but many do |

### CompTIA exam traps

> **Trap:** "User installed a 64-bit app on a 32-bit OS and it won't launch." Correct answer: upgrade the OS to 64-bit (which is a clean install, not an in-place upgrade — Windows does not have a 32→64 upgrade path).

> **Trap:** "App requires AVX2 and user's CPU is older Pentium/Celeron." Correct answer: hardware-level CPU limitation, requires CPU/system replacement. No driver or patch fixes this.

> **Trap:** Image deployment vs push deployment. Image = baked in at provisioning. Push = sent later to already-deployed machines. CompTIA loves the distinction.

> **Trap:** "Integrated graphics" includes the GPU silicon on the CPU die — it shares system RAM, it does not have its own VRAM. "Dedicated" or "discrete" graphics has its own card and its own VRAM.

## Helpdesk reality

- **"Can you install Photoshop on my laptop?"** Check the system requirements page against the user's machine specs in your asset database first. If the laptop has integrated graphics and 8 GB RAM, the honest answer is "you can install it, but it's going to be painful — let's talk to your manager about a workstation refresh." Don't install software the machine can't run; you'll get the ticket back in a week.
- **"It says it needs a 64-bit OS and mine is 32-bit."** That machine is end-of-life. There is no upgrade path that keeps the user's data in place. Escalate to a hardware refresh request.
- **"I downloaded it from a website, can you install it?"** No. Approved software comes from the Company Portal, Software Center, or the approved-software list. Random installers from random websites are how ransomware enters the building. This is a policy conversation, not a technical one.
- **"The install is stuck at 47%."** Check disk space first (the silent killer), then check if an endpoint protection scan is blocking the installer, then check network connectivity if it's pulling files mid-install.
- **"My USB dongle died and now [expensive app] won't open."** Hardware token replacement is a vendor RMA process, usually takes 3–10 business days, and the seat is dead in the meantime. This is why enterprises hate dongles and migrate to software licensing whenever the vendor offers it.

## Related concepts

[[Windows Editions and Features]] · [[Active Directory and Group Policy]] · [[MDM and Intune]] · [[OS Installation and Deployment]] · [[32-bit vs 64-bit Architecture]] · [[Software Licensing]] · [[Endpoint Protection and EDR]] · [[Change Management]]

*Source: VIRGIL knowledge base — 2026-05-10*