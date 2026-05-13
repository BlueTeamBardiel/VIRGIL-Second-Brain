# Defender Antivirus

## What it is

Every Windows install ships with an immune system already running. You don't install it. You don't activate it. It's just *there*, scanning files as they hit disk, watching processes as they spawn, checking signatures against a cloud database that updates multiple times a day. That's Microsoft Defender Antivirus — the built-in anti-malware engine baked into Windows 10, 11, and Server since 2016.

In plain English: it's the free antivirus that comes with Windows, and unlike the free antivirus your uncle installed in 2009, this one is actually good. Independent test labs (AV-TEST, AV-Comparatives) regularly put it in the top tier alongside paid products. The days of "you need to install a real antivirus" are over for most home users.

Technical definition: Microsoft Defender Antivirus is a signature-based and behavior-based anti-malware engine integrated into the Windows Security platform. It provides real-time protection, cloud-delivered protection (MAPS), tamper protection, controlled folder access (anti-ransomware), and integrates with Windows Defender Firewall and SmartScreen. In enterprise environments it extends into Microsoft Defender for Endpoint (MDE) — the EDR product — managed via Intune or Group Policy.

## Why it matters

Covered explicitly in **220-1202 Objective 2.2** (Windows OS security settings). The exam expects you to know what Defender does, where to find it, how to update definitions, and when it gets disabled (third-party AV installs → Defender auto-disables real-time protection to avoid conflicts).

Career relevance: every helpdesk ticket about "my computer is slow" or "I got a weird popup" starts with checking Defender's status and scan history. You will open the Windows Security app five times a week for the rest of your career. Know it cold.

## In your build, in the enterprise

**Beat 1 — Technical depth.** Defender has four protection layers stacked on top of each other. **Real-time protection** scans files on access — open a file, Defender checks it before the kernel hands it to the process. **Cloud-delivered protection** (MAPS, formerly SpyNet) sends file hashes and metadata to Microsoft's cloud for reputation lookup; this catches zero-days that aren't in the local signature database yet. **Tamper protection** prevents malware (or curious users) from disabling Defender via registry edits, PowerShell, or Group Policy — only changes from the Windows Security UI or Intune count. **Controlled folder access** is the anti-ransomware feature: protected folders (Documents, Pictures, etc.) can only be written to by trusted apps. Signature updates ship via Windows Update or standalone definition updates (`MpCmdRun.exe -SignatureUpdate`) typically every 4–6 hours. Defender also includes **offline scan** — reboots into a minimal WinPE environment and scans before Windows fully loads, which kills rootkits that hide from a running OS.

**Beat 2 — Feynman example via gaming PC.**

**The mod download:** Pull a Skyrim mod from a sketchy mirror because Nexus is down. Defender flags it mid-download, quarantines the installer, throws a notification. *Real-time protection earned its keep before the file even finished writing.*

**The false positive:** Three months later, a legit modding tool gets flagged because its DLL injection pattern looks like malware to the heuristic engine. You whitelist the folder in Windows Security → Virus & threat protection → Exclusions. *Exclusions are a loaded gun — every folder you exclude is a folder malware can hide in.*

**The disabled engine:** Install Norton because it came with the laptop. Defender's real-time protection auto-disables — the OS detects another registered AV and steps aside to prevent conflicts. Uninstall Norton six months later, Defender wakes back up. *Two real-time AVs running simultaneously will fight each other and tank your FPS.*

**The offline scan:** Suspect a rootkit because the machine pings out to weird IPs at idle. Run Microsoft Defender Offline scan — reboots, scans before Windows loads, catches what was hiding behind a running kernel. *Some malware can only be seen when it's not running.*

**Beat 3 — Bridge to the enterprise.** Same engine, different management plane. At home, you click checkboxes in Windows Security. In the enterprise, Defender is managed centrally via **Intune** (cloud) or **Group Policy** (on-prem), reports telemetry to **Microsoft Defender for Endpoint** (the EDR portal), and integrates with the **SIEM** for the SOC. Exclusions aren't set by users — they're pushed by policy. Tamper protection is mandatory. End users can't disable real-time protection even if they wanted to. When an alert fires, it lands in the SOC analyst's queue, not on the user's screen.

**Beat 4 — The point.** Same antivirus engine, two completely different operational models. At home, you're the admin, the analyst, and the user. In the enterprise, those are three separate people on three separate teams, and Defender is one tile in a much larger security stack. Get used to that mental shift — every Windows security feature you've used personally has an enterprise-scale version that looks nothing like the consumer experience.

## Key facts

### Where Defender lives

| Path | What you find there |
|---|---|
| Windows Security app (Start → "Windows Security") | The user-facing dashboard. Virus & threat protection, Firewall, App & browser control, Device security |
| `Settings → Privacy & security → Windows Security` | Same thing, modern Settings entry point |
| `MpCmdRun.exe` (CLI) | Manual scans, signature updates, offline scan trigger |
| `Get-MpComputerStatus` (PowerShell) | Defender state, signature version, last scan time |
| `Get-MpThreatDetection` (PowerShell) | Threat history |

### Scan types

- **Quick scan** — common malware locations (Program Files, registry run keys, startup folders). Minutes.
- **Full scan** — every file on every drive. Hours.
- **Custom scan** — specific folder or drive. Right-click → Scan with Microsoft Defender.
- **Offline scan** — reboots into WinPE, scans before Windows boots. For suspected rootkits.

### Definition updates

Signature definitions auto-update via Windows Update. Manual update: Windows Security → Virus & threat protection → Virus & threat protection updates → **Check for updates**. Or PowerShell: `Update-MpSignature`. Stale definitions (>3 days old) trigger a yellow warning in the Security Center — common on machines that have been offline or in storage.

### Defender vs. third-party AV

Install a registered third-party AV (Norton, McAfee, Bitdefender, etc.) → Defender's real-time protection auto-disables. The engine doesn't uninstall — it stays present, signatures keep updating, and you can still run on-demand scans manually. Uninstall the third party → Defender wakes back up. You can also enable **Periodic Scanning** under Defender even when a third-party AV is the primary — Defender will run scheduled scans as a second-opinion engine.

### CompTIA exam traps

> **CompTIA exam trap:** Defender Antivirus vs. Windows Defender Firewall vs. Microsoft Defender for Endpoint — three different products that all start with "Defender." Antivirus is the AV engine. Firewall is the host firewall. Defender for Endpoint (MDE) is the enterprise EDR/XDR cloud product. The exam will mix the names to see if you can tell them apart.

> **CompTIA exam trap:** "How do you update Defender definitions?" The answer CompTIA wants is **Windows Update** or the Virus & threat protection updates pane — not "it does it automatically" (true but not the answer). Know the click path.

> **CompTIA exam trap:** A user reports Defender is "off." First check: is a third-party AV installed? That's the most common cause and the answer the exam expects before you start troubleshooting Group Policy or services.

> **CompTIA exam trap:** Tamper protection prevents *malware* from disabling Defender. It does not prevent a local administrator from disabling it through the Windows Security UI. Know the distinction.

## Helpdesk reality

- **"My antivirus expired, am I unprotected?"** — They're talking about the Norton trial that came with the laptop. Uninstall Norton, Defender takes over automatically. They've had free antivirus this whole time.
- **"Defender keeps deleting my file!"** — Check the file. If it's a legitimate tool (modding utility, pen-test script, keygen-adjacent dev tool), add a folder exclusion. If they can't tell you what the file does, it stays quarantined.
- **"Can you turn off the antivirus, it's blocking my install?"** — No. You add an exclusion for the installer path, run the install, then remove the exclusion. Never disable real-time protection to "make something work" — that's how ransomware gets in during the 90 seconds it's off.
- **"Why is my PC slow?"** — Check Task Manager. If `MsMpEng.exe` is pinning a core, Defender is mid-scan. Either let it finish or reschedule the scan window. Don't disable it.
- **"I clicked something I shouldn't have."** — Disconnect from the network. Run a full scan. Then an offline scan. Then check the threat history. Then escalate if anything fired. Document everything in the ticket — if it turns out to be ransomware, the timeline matters.

## Related concepts

[[BitLocker]] · [[Windows Firewall]] · [[User Account Control (UAC)]] · [[Windows Security app]] · [[Group Policy]] · [[Microsoft Defender for Endpoint]] · [[SmartScreen]] · [[Anti-malware]] · [[EDR]] · [[Controlled Folder Access]]

*Source: VIRGIL knowledge base — 2026-05-10*