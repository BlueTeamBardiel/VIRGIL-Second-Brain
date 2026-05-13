# macOS System Preferences

## What it is

Open a fresh Mac, hit the Apple menu, click **System Settings** (called System Preferences pre-Ventura, and CompTIA still uses the old name). That's the control panel for the entire personality of the machine — network, display, users, security, accessibility, sharing, software update. Every knob that tunes how macOS behaves lives in this one app.

In plain English: it's macOS's Control Panel and Settings app fused into one place. Same job as Windows Settings — wallpaper to FileVault encryption, all under one roof.

Technically: System Settings is the GUI front-end to a sprawl of `.plist` preference files in `/Library/Preferences/`, `~/Library/Preferences/`, and the `defaults` database. The pretty toggles you click are just writing keys to plists that daemons read on launch. If the OS is the personality, System Settings is where you tune it.

## Why it matters

Half of macOS support tickets resolve in System Settings. FileVault status, network config, printer queues, accessibility, app permissions, Apple ID sign-in, software update — all here. A+ techs working in mixed Mac/Windows shops (creative agencies, dev shops, executive floors) get Mac tickets whether they signed up for them or not.

Covered by **Objective 220-1202 1.8** — features and tools of macOS. CompTIA loves testing where things live: which preference pane handles which task, what Disk Utility does vs Terminal, what FileVault actually protects. Know the geography.

## In your build, in the enterprise

**Beat 1 — Technical depth.** macOS is Unix underneath (Darwin kernel, BSD userland) with Apple's GUI on top. System Settings touches both layers. Disk Utility handles partitioning, formatting (APFS, HFS+, exFAT, FAT32), First Aid (fsck equivalent), and RAID. FileVault is XTS-AES-128 full-disk encryption tied to your login password and a recovery key. Terminal is a bash/zsh shell with full Unix tooling. Force Quit (Cmd+Option+Esc) is the Mac's Task Manager for hung apps. Spotlight indexes the entire drive for instant search. Time Machine is Apple's built-in incremental backup to an external drive or network share. Keychain stores passwords, certificates, and secure notes encrypted with your login. Mission Control shows every window across every desktop (called Spaces). The `/Applications`, `/Users`, `/Library`, `/System`, and `~/Library` folders each have a specific job — touch the wrong one and things break.

**Beat 2 — Feynman via your homelab Hackintosh.** You decide to dual-boot macOS on a spare gaming rig because Final Cut runs better than Premiere and you want to learn the platform.

**Disk Utility:** First boot, you partition the second NVMe as APFS. Drive shows up, formats clean. Three months later it won't mount. Open Disk Utility, run First Aid. It fixes the catalog. *First Aid is `fsck` with a UI — always try it before reformatting.*

**FileVault:** You enable it because the laptop you'll eventually buy needs it on by default for work. macOS generates a recovery key. You screenshot it. Six months later you forget your password. The recovery key saves you. *Lose both, lose the data — there is no Apple backdoor.*

**Terminal:** A `.dmg` file you downloaded won't mount through Finder. `hdiutil attach ~/Downloads/thing.dmg` from Terminal mounts it and tells you why Finder choked (signature mismatch). *Terminal sees what the GUI hides.*

**Force Quit:** Final Cut hangs mid-render. Cmd+Option+Esc, kill it, reopen. Project autosaved. *Same muscle memory as Ctrl+Alt+Del on Windows — learn it day one.*

**Beat 3 — Bridge to enterprise.** Same five tools, very different stakes. Your Hackintosh: lose FileVault recovery key, you lose your Steam library backups. Annoying. Enterprise: lose 200 employees' FileVault keys, you lose 200 laptops worth of data and probably your job. So enterprise Macs are enrolled in MDM (Jamf, Kandji, Intune for Mac) which escrows every FileVault recovery key to a central server. User forgets password, helpdesk pulls the key from Jamf, user is back in. Same with Apple ID — at home it's your personal account tied to iMessage, FaceTime, iCloud. In the enterprise, personal Apple IDs are often blocked entirely; the device is managed via Apple Business Manager and a Managed Apple ID, with FaceTime and iMessage frequently disabled by policy. Time Machine at home backs up to a USB drive. In the enterprise, that's replaced with Code42, Druva, or a network Time Machine target on a NAS with versioning.

**Beat 4 — The point.** Same OS, same tools, different blast radius. Get the question into your bones: *who holds the recovery key, and what happens when the user is locked out?* You'll ask it for every encrypted device, every cloud account, every MDM enrollment, for the rest of your career.

## Key facts

### System Settings panes worth knowing

| Pane | What it controls |
|---|---|
| **General → Software Update** | macOS updates, Rapid Security Response (RSR) |
| **General → Sharing** | Screen sharing, file sharing, remote login (SSH) |
| **Network** | Wi-Fi, Ethernet, VPN, DNS, proxies |
| **Privacy & Security** | FileVault, Gatekeeper, app permissions, location |
| **Users & Groups** | Add/remove users, admin rights, login items |
| **Accessibility** | VoiceOver, Zoom, Display contrast, Switch Control |
| **Apple ID** | iCloud sync, Find My, iMessage, FaceTime |
| **Displays** | Resolution, arrangement, Night Shift |
| **Printers & Scanners** | Add/remove queues, default printer |
| **Time Machine** | Backup destination, snapshot frequency |

### macOS system folders

| Folder | Purpose |
|---|---|
| `/Applications` | System-wide apps (all users) |
| `/Users` | Home directories for each user |
| `/Users/[name]/Library` (`~/Library`) | Per-user app data, preferences, caches — hidden by default |
| `/Library` | System-wide app support, fonts, preferences |
| `/System` | Read-only OS files, protected by SIP — do not touch |

> **CompTIA exam trap:** `~/Library` (user) vs `/Library` (system-wide) vs `/System/Library` (OS only). CompTIA loves asking which one holds a specific font or preference. User-installed fonts go in `~/Library/Fonts`. Fonts available to all users go in `/Library/Fonts`. System fonts live in `/System/Library/Fonts` and you don't touch them.

### Installation and uninstallation

- **`.dmg`** — disk image, mounts like a virtual drive. Drag the app to `/Applications`, eject the image. Most common Mac install.
- **`.pkg`** — Apple installer package, runs a guided install (often used for drivers, system extensions, anything needing privileged install).
- **`.app`** — the application itself, a bundle (technically a folder macOS treats as one file).
- **Uninstallation:** drag the `.app` from `/Applications` to the Trash. That's it for most apps. Leftover preferences live in `~/Library/Application Support` and `~/Library/Preferences` — usually harmless, but tools like AppCleaner sweep them up.
- **App Store apps** uninstall from Launchpad: click and hold, then click the X.

### Force Quit options

| Method | When to use |
|---|---|
| **Cmd+Option+Esc** | Force Quit window — like Task Manager |
| **Right-click Dock icon → Force Quit** | App is visibly hung in the Dock |
| **Activity Monitor** | Need to see CPU/RAM/network, kill by PID |
| **Terminal: `kill -9 [pid]`** | When the GUI itself is unresponsive |

### Key macOS features

- **Mission Control** (F3 or three-finger swipe up) — every window across every Space at a glance.
- **Multiple desktops (Spaces)** — virtual desktops. Drag windows to a Space at the top of Mission Control.
- **Spotlight** (Cmd+Space) — universal search: apps, files, math, unit conversion, web. Power user's launcher.
- **Keychain Access** — encrypted password and certificate vault. iCloud Keychain syncs it across Apple devices.
- **iCloud** — sync for Photos, iMessage, FaceTime, Drive, Keychain. Tied to Apple ID.
- **Continuity** — Handoff (start an email on iPhone, finish on Mac), AirDrop, Universal Clipboard, Sidecar (iPad as second monitor).
- **Gestures** — trackpad swipes: three-finger swipe between Spaces, pinch for Launchpad, two-finger scroll. Configurable in Trackpad settings.

### FileVault

- XTS-AES-128 full-disk encryption.
- Enabled per-user; password unlocks the disk at boot.
- Recovery key: store it somewhere safe, or escrow to iCloud (personal) or MDM (enterprise).
- Encrypts all file types — there's no "encrypt only documents" mode. Whole volume, all the time.
- Works over any network — encryption is local, network type is irrelevant.

> **CompTIA exam trap:** FileVault encrypts the disk, not individual files. There is no per-file FileVault. If the disk is unlocked (user logged in), files are accessible. If the Mac is off or at the login screen, the disk is encrypted at rest.

### Apple ID and corporate restrictions

- Personal Apple ID syncs iMessage, FaceTime, iCloud Drive, Photos, App Store purchases.
- Enterprise often blocks personal Apple ID sign-in via MDM and issues **Managed Apple IDs** through Apple Business Manager.
- FaceTime, iMessage, AirDrop, and Continuity features are commonly disabled by policy on corporate Macs to prevent data leaving the managed environment.

### Best practices

- **Updates/patches:** enable automatic macOS updates. Apple's **Rapid Security Response (RSR)** ships emergency security patches between full macOS releases — fast, no reboot for most. Don't disable.
- **Backups:** Time Machine to an external drive or NAS. At minimum daily. Verify the backup occasionally.
- **Drive:** keep at least 10–15% free. APFS hates a full disk.
- **Antivirus:** macOS has Gatekeeper, XProtect, and MRT built in. Most home users don't need third-party AV. Enterprise often deploys EDR (CrowdStrike, SentinelOne) anyway for visibility, not because Macs are riddled with malware.
- **Finder:** show file extensions and hidden files (Cmd+Shift+. toggles hidden) if you're doing tech work.
- **Dock:** trim the default apps you don't use. Add Terminal, Activity Monitor, System Settings if you're techy.
- **Gestures:** learn three-finger swipe (Spaces), four-finger pinch (Launchpad), three-finger up (Mission Control). They're faster than any keyboard shortcut.
- **Continuity:** if you live in the Apple ecosystem, turn it on. If you're in a corporate environment, expect it disabled.

## Helpdesk reality

- **"My Mac won't update."** Check free disk space first (needs 20+ GB usually), then check it's plugged in, then check the update server isn't blocked by corporate proxy.
- **"I forgot my Mac password."** If FileVault is on and you have the recovery key, you're fine. If it's a corporate Mac, the MDM has the key. If neither — wipe and reinstall, restore from backup. There's no other path.
- **"My printer disappeared."** System Settings → Printers & Scanners. Re-add it. If it's a network printer, confirm DNS and the print server are reachable.
- **"FaceTime/iMessage won't work on my work Mac."** It's almost certainly blocked by MDM policy. Don't promise a fix — escalate to whoever manages the MDM.
- **"My app is frozen."** Cmd+Option+Esc, Force Quit, reopen. If it freezes again, check Console logs or Activity Monitor for the actual cause before reinstalling.

## Related concepts

[[macOS Disk Utility and FileVault]] · [[macOS Terminal]] · [[macOS Time Machine]] · [[Windows Settings vs Control Panel]] · [[MDM and Apple Business Manager]] · [[Full Disk Encryption]] · [[Operating System File Structures]]

*Source: VIRGIL knowledge base — 2026-05-10*