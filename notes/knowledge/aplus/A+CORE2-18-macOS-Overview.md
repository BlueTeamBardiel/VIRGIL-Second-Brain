# macOS Overview

## What it is

You build a Hackintosh once and you learn something uncomfortable: macOS is picky. It expects specific hardware, specific firmware, specific everything. That pickiness isn't a bug — it's the whole product. Apple controls the silicon, the firmware, the kernel, the userland, and the App Store. The result is an OS that feels seamless because Apple decided what "seamless" means and refused to negotiate.

In plain English: macOS is Apple's desktop OS. It runs on Mac hardware (and only Mac hardware, legally). It's Unix underneath — the same POSIX bones as Linux — wrapped in Apple's Aqua interface and the Cocoa application framework. The kernel is XNU (Darwin), the shell is zsh by default, and the package format is `.app` bundles, `.pkg` installers, and `.dmg` disk images.

In the body metaphor: if Windows is a personality built by committee, macOS is a personality built by one company that owns the brain, the muscles, and the nervous system. Tight integration is the feature. Lock-in is the price.

## Why it matters

You will support Macs. Even if your shop is 95% Windows, the executives have MacBooks, the designers have iMacs, the developers want M-series chips for their containers. CompTIA tests macOS on 220-1202 objective 1.8 because helpdesk techs who only know Windows are useless in mixed environments — and most environments are mixed.

The exam will ask you about Disk Utility, FileVault, Time Machine, Force Quit, Keychain, Mission Control, and the file types `.dmg`, `.pkg`, `.app`. It will ask where things live: `/Applications`, `/Users`, `/Library`, `/System`. It will ask about Apple ID and how it tangles with corporate management. Memorize the geography.

## In your build, in the enterprise

**Beat 1 — Technical depth.** macOS file types split three ways. `.dmg` is a disk image — mount it, drag the `.app` to `/Applications`, eject. `.pkg` is an installer — Installer.app walks prompts, used when an app drops files in privileged locations or runs scripts. `.app` is the application bundle, a folder pretending to be a file. System folders: `/Applications` (all-user apps), `/Users` (home directories), `/Library` (system-wide app support), `/System` (the OS itself, sealed read-only by SIP), and `/Users/<name>/Library` (per-user data, hidden by default). Built-in tools: Disk Utility, FileVault (XTS-AES-128 full-disk encryption), Time Machine, Keychain, Spotlight (`Cmd+Space`), Mission Control (`F3`), Terminal (zsh since Catalina). Force Quit is `Cmd+Option+Esc`.

**Beat 2 — Feynman example via personal build.** You bought a Mac mini M4 for the homelab to run macOS-only tooling — Xcode, the occasional Logic Pro session, Time Machine target for the family laptops.

**First boot:** Setup Assistant asks for an Apple ID. You sign in. Now iCloud, Messages, FaceTime, App Store, and Find My are all live. *Apple ID is the master key to the consumer experience.*

**App install:** You download Firefox. It comes as a `.dmg`. Double-click, mount, drag Firefox.app into `/Applications`, eject. Done. Then you install a printer driver — that's a `.pkg` because it needs to drop a kernel extension and write to `/Library/Printers`. *`.dmg` is drag-to-install, `.pkg` is guided install, `.app` is the actual program.*

**Backups:** You plug in an external SSD, Disk Utility formats it APFS, Time Machine asks "use this as backup disk?" Yes. Hourly snapshots forever, or until the drive fills and old ones get pruned. *Time Machine is the macOS backup answer — set it once, thank yourself the day storage dies.*

**Encryption:** You enable FileVault in System Settings → Privacy & Security. macOS offers a recovery key — store it in iCloud or write it down. Lose both and a forgotten password means the drive is a brick. *FileVault protects the laptop on a barstool. The recovery key protects you from yourself.*

**Beat 3 — Bridge to enterprise.** Now scale that Mac mini up to 300 MacBook Pros in a design agency.

Personal Apple IDs are a compliance disaster — corporate data syncing to a designer's personal iCloud, App Store purchases tied to someone who quits next month. Enterprise answer: **Managed Apple IDs** issued through Apple Business Manager, federated with Entra, scoped to corporate data only. FaceTime, iMessage, and consumer iCloud get disabled by MDM policy.

FileVault becomes mandatory and centrally managed. Jamf or Intune pushes the config, escrows the recovery key to the MDM server, reports compliance. No more sticky notes.

Time Machine doesn't scale. Enterprises use centralized backup — documents in OneDrive or iCloud Drive (corporate tenant), code in Git, design files in the DAM. The Mac is cattle, not pets — wipe and reimage via MDM Automated Device Enrollment.

App installs route through a Self Service portal. Random `.dmg` downloads are blocked by Gatekeeper policy and supplemented by EDR — yes, Macs need EDR, the "Macs don't get viruses" line died a decade ago.

**Beat 4 — The point.** Same OS, same Disk Utility, same `.dmg` install pattern — but the surrounding governance is a different planet. Get the question into your bones: *who owns the identity, who holds the encryption key, who controls the app catalog?* That question follows you across every OS you'll ever support.

## Key facts

### File types and install patterns

| Extension | What it is | How you use it |
|---|---|---|
| `.dmg` | Disk image | Mount → drag `.app` to `/Applications` → eject |
| `.pkg` | Installer package | Double-click → Installer.app walks prompts |
| `.app` | Application bundle | The program itself — a folder treated as a file |

**Uninstallation:** Drag the `.app` from `/Applications` to Trash. `.pkg`-installed apps that drop files in `/Library` need a vendor uninstaller or manual cleanup of `~/Library/Preferences` and `~/Library/Application Support`.

### System folders

| Path | What lives there |
|---|---|
| `/Applications` | All-user installed apps |
| `/Users` | Home directories |
| `/Users/<name>/Library` | Per-user app data, prefs, caches (hidden — `Cmd+Shift+.` to reveal) |
| `/Library` | System-wide app support, fonts, printer drivers |
| `/System` | The OS itself — sealed read-only by SIP, do not touch |

### Built-in tools

- **System Settings** (renamed from System Preferences in Ventura) — control panel for Displays, Network, Privacy & Security, Users & Groups, Software Update.
- **Disk Utility** — partition, format (APFS, HFS+, ExFAT, FAT32), First Aid, erase, restore, RAID.
- **FileVault** — AES-XTS full-disk encryption. Recovery key in iCloud or escrowed to MDM.
- **Time Machine** — incremental backups to local or network volume. Hourly for 24 hours, daily for a month, weekly until full.
- **Keychain Access** — credential vault for Wi-Fi passwords, certs, app passwords. iCloud Keychain syncs across Apple devices.
- **Terminal** — zsh since Catalina. POSIX plus `diskutil`, `pmset`, `softwareupdate`, `defaults`.
- **Force Quit** (`Cmd+Option+Esc`) — kill hung apps.
- **Spotlight** (`Cmd+Space`) — system-wide search.
- **Mission Control** (`F3`) — exposes all windows; manages Spaces (multiple desktops).
- **Finder** — file manager, always running.
- **Dock** — app launcher with pinned apps, running apps, Trash.

### Features worth naming

- **iCloud** — sync for Photos, Files, Mail, Contacts, Calendar, iMessage, Keychain, Find My.
- **Continuity** — Handoff, Universal Clipboard, AirDrop, Sidecar (iPad as second display), Universal Control.
- **Gestures** — three-finger swipe up (Mission Control), swipe left/right (Spaces), four-finger pinch (Launchpad).
- **Accessibility** — VoiceOver, Zoom, Voice Control, Switch Control.
- **Rapid Security Response (RSR)** — critical security patches between full macOS updates, often no reboot. Version shown as `14.4.1 (a)`.

### Apple ID and corporate restrictions

Personal Apple ID unlocks iCloud, App Store, iMessage, FaceTime, Find My. In a corporate environment, MDM (Jamf, Intune, Kandji, Mosyle) typically:

- Disables iCloud sync for documents
- Disables iMessage/FaceTime on corp devices
- Disables AirDrop to non-managed devices
- Forces Managed Apple ID for App Store and Apple Business Manager deployments
- Escrows FileVault recovery keys
- Enforces Gatekeeper, SIP, and notarization

### Best practices

- **Updates** — System Settings → General → Software Update. Enable automatic. Install RSRs immediately.
- **Backups** — Time Machine to external SSD minimum. Cloud for documents. Test restore yearly.
- **FileVault on every laptop, no exceptions.** Stolen MacBook without FileVault is a stolen filesystem.
- **Antivirus** — built-in XProtect handles known signatures; Gatekeeper blocks unsigned apps. Layer EDR in enterprise.
- **Finder** — `Cmd+Shift+.` shows hidden files. `Cmd+Shift+G` jumps to a path.

### CompTIA exam traps

> **CompTIA exam trap:** `.dmg` vs `.pkg` vs `.app`. `.dmg` is a disk image you mount, `.pkg` is an installer you run, `.app` is the application bundle itself. Confusing the three is the most common A+ macOS mistake.

> **CompTIA exam trap:** Force Quit is `Cmd+Option+Esc`, not `Ctrl+Alt+Delete`.

> **CompTIA exam trap:** FileVault recovery key. If the user forgets the password AND loses the recovery key, the data is gone. Apple cannot recover it. By design.

> **CompTIA exam trap:** Time Machine is backup, not sync. iCloud Drive is sync, not backup. Deleting a file in iCloud Drive deletes it everywhere.

> **CompTIA exam trap:** System Preferences was renamed **System Settings** in macOS Ventura (13). Newer questions use System Settings.

## Helpdesk reality

- *"My Mac is frozen."* — `Cmd+Option+Esc`, Force Quit the hung app. If the whole system is locked, hold the power button. Then check Console.app for the crash log.
- *"I forgot my login password."* — If FileVault is on and there's no recovery key escrowed, the drive is encrypted forever. In a managed environment, MDM has the key. Never promise data recovery without confirming the key exists.
- *"How do I uninstall this app?"* — Drag from `/Applications` to Trash. For `.pkg`-installed apps with leftover files, point them at AppCleaner. Don't manually delete from `/System` — SIP blocks it anyway.
- *"AirDrop / Handoff / Universal Clipboard isn't working."* — Same Apple ID on both devices, Bluetooth on, Wi-Fi on, Handoff enabled. Most "Continuity is broken" tickets are one of these four.
- *"My personal iCloud has my work files in it."* — Policy conversation, not a tech one. Escalate to whoever owns endpoint management. Document everything.

## Related concepts

[[Windows OS Overview]] · [[Linux OS Overview]] · [[FileVault and Full-Disk Encryption]] · [[Time Machine and Backup Strategy]] · [[Apple ID and MDM]] · [[Disk Utility and APFS]] · [[macOS Terminal and zsh]] · [[Gatekeeper and XProtect]] · [[Mobile Device Management]] · [[Endpoint Encryption]]

*Source: VIRGIL knowledge base — 2026-05-10*