# macOS Features

## What it is

Your buddy who built a Hackintosh in 2014 swore the OS "just worked." He was half right. macOS is Apple's desktop operating system — a Unix-based OS (Darwin kernel, BSD userland) wrapped in a tightly controlled GUI and welded to Apple hardware. The kernel is the soul, the Aqua interface is the personality, and the whole stack assumes you bought the hardware from Apple.

In plain English: it's the OS on every MacBook, iMac, Mac mini, and Mac Studio. Same Unix bones as Linux underneath, completely different experience on top. File paths use forward slashes. The terminal is real. The package management is Apple's, not yours.

Technically: macOS (current major versions in the Sequoia/Sonoma generation) runs on Apple Silicon (M-series ARM) and the last of the Intel Macs. APFS is the default filesystem. The Mach/XNU kernel sits underneath a BSD-derived Unix layer, with Cocoa frameworks on top. System Integrity Protection (SIP) locks down system folders even from root.

## Why it matters

A+ candidates default to Windows. The exam doesn't. Objective 220-1202 1.8 tests whether you can walk up to a Mac and operate it without flailing. Real helpdesk queues mix Windows, macOS, and ChromeOS — design firms, marketing teams, executives, and most software engineering shops run Macs. If you can't find Disk Utility, enable FileVault, or force-quit a frozen app on a Mac, you're not a generalist tech.

CompTIA loves the file-extension distinctions (.dmg vs .pkg vs .app) and the system folder layout. Those are free points if you've touched a Mac for a week. Free misses if you haven't.

## In your build, in the enterprise

**Beat 1 — Technical depth.** macOS ships three installer formats. **.dmg** is a disk image — mount it, drag the .app to /Applications, eject. **.pkg** is an Apple installer package — it runs scripts, places files in system locations, may require admin. **.app** is the application bundle itself — a folder that looks like a single file. Uninstall on macOS is usually "drag the .app to Trash" — no registry, no uninstaller. Pkg-installed software sometimes needs a vendor uninstaller script. FileVault is full-disk encryption using XTS-AES-128 with a 256-bit key, tied to your Apple ID or a recovery key. Time Machine is the built-in versioned backup to an external drive or network share. Spotlight is the system-wide index — Cmd+Space. Mission Control (swipe up with three fingers) shows all windows and virtual desktops (Spaces). Keychain stores passwords, certs, and secure notes — synced via iCloud Keychain if enabled.

**Beat 2 — Feynman example via gaming/personal build.** You finally caved and bought a MacBook Pro to edit your stream VODs in Final Cut.

**Day one — installing apps:** Download OBS — it's a .dmg. Double-click, the disk image mounts on the desktop, drag OBS to the Applications folder shortcut in the window, eject the .dmg. Done. No "next, next, finish." *macOS apps are self-contained bundles. Drag in, drag out.*

**Day two — the .pkg trap:** You install your capture card drivers. That's a .pkg because it needs to drop kernel extensions and write to system locations. It prompts for your admin password and runs through an installer wizard. *Pkg means it touches the system. Read what it's installing.*

**Day three — Final Cut hangs mid-export.** Spinning beach ball. Cmd+Option+Esc opens Force Quit. Kill Final Cut. Relaunch. *Force Quit is Mac's Task Manager — memorize the shortcut.*

**Day four — disk full.** Open Disk Utility (in /Applications/Utilities). See your APFS container, check free space, run First Aid to verify the filesystem. Enable FileVault while you're in System Settings — your VOD drafts are now encrypted at rest. *Disk Utility is fsck with a GUI. First Aid first, panic later.*

**Beat 3 — Bridge from gaming to enterprise.** Same MacBook, now you started a job at a design agency. IT hands you the laptop already enrolled in Jamf (Apple's enterprise MDM). The differences hit immediately:

- **Apps:** You can't install whatever .dmg you find. The Self Service app shows IT-approved software. Anything else needs a ticket.
- **Apple ID:** At home, your Apple ID is yours — iMessage, FaceTime, iCloud Photos, App Store purchases. At work, the Mac is bound to a **Managed Apple ID** issued by the company, or your personal Apple ID is restricted from signing into iCloud services. FaceTime and iMessage may be disabled by policy. iCloud Drive sync is often blocked to prevent corporate data leaking to personal Apple accounts.
- **FileVault:** Mandatory and enforced by MDM. The recovery key escrows to the management server, not to you. If you forget your password, IT unlocks it — not Apple.
- **Updates:** Rapid Security Response (RSR) patches push automatically — small, fast security fixes that don't require a full OS update. Major updates are deferred and scheduled by IT.
- **Backups:** Time Machine to a personal external drive is replaced by enterprise backup agents or expectations that real work lives in OneDrive, Google Drive, or a sanctioned share.

**Beat 4 — The point.** Same OS, two contexts. At home you are root in spirit — your Apple ID, your apps, your backups. At work the Mac is a managed endpoint and Apple ID is a corporate identity question, not a personal one. *Get this question into your bones: "is this Mac mine, or is it the company's?" The answer changes every other decision you make on it.*

## Key facts

### File types

| Extension | What it is | How you handle it |
|---|---|---|
| **.dmg** | Disk image — mountable virtual disk | Double-click to mount, drag .app to /Applications, eject |
| **.pkg** | Installer package — runs scripts, system-level install | Double-click, walk through installer, enter admin password |
| **.app** | Application bundle (a folder treated as a file) | Lives in /Applications, drag to Trash to uninstall |

### System folders

| Folder | Contents |
|---|---|
| **/Applications** | All installed apps, system-wide |
| **/Users** | Home folders for each user account |
| **/Users/[name]/Library** | Per-user app data, caches, preferences (hidden by default) |
| **/Library** | System-wide app support, fonts, preferences |
| **/System** | Core OS — read-only, protected by SIP |

> **CompTIA exam trap:** /Library vs /Users/[name]/Library — system-wide vs per-user app data. CompTIA tests which one holds a specific user's preferences (the one in their home folder) vs shared resources (top-level /Library).

### Built-in tools

- **System Settings** (formerly System Preferences) — control panel for displays, network, users, privacy, accessibility, Apple ID, Time Machine
- **Disk Utility** — partition, format, verify, repair (First Aid), create disk images, manage APFS containers
- **Terminal** — zsh shell by default since Catalina, full Unix toolchain
- **Force Quit** — Cmd+Option+Esc, kills hung apps
- **Activity Monitor** — Mac's resource monitor (CPU, memory, disk, network, energy)
- **Keychain Access** — view and manage stored credentials and certificates
- **Spotlight** — Cmd+Space, system-wide search and app launcher
- **Mission Control** — three-finger swipe up, see all open windows and Spaces (virtual desktops)
- **Finder** — the file manager, always running, the smiley face in the Dock

### Features that get tested

- **Multiple desktops (Spaces)** — managed via Mission Control, swipe between them with four fingers
- **Gestures** — three/four-finger swipes on the trackpad, configurable in System Settings → Trackpad
- **Dock** — app launcher and switcher at screen edge
- **iCloud** — sync for Photos, Drive, Keychain, iMessage, FaceTime, contacts, calendar
- **Continuity** — Handoff, Universal Clipboard, AirDrop, Sidecar (use iPad as second display), iPhone Mirroring — pass work between Apple devices on the same Apple ID
- **Time Machine** — automated hourly/daily/weekly backups to external or network drive
- **FileVault** — full-disk encryption, mandatory on managed Macs
- **Rapid Security Response (RSR)** — out-of-band security patches between major updates

### System Settings panes worth knowing

- **Displays** — resolution, arrangement, color profile, Night Shift, mirroring
- **Network** — Wi-Fi, Ethernet, VPN configs, DNS, proxies
- **Privacy & Security** — app permissions for camera, mic, location, screen recording, full disk access, accessibility
- **Accessibility** — VoiceOver, Zoom, Switch Control, captions
- **Printers & Scanners** — add via IP, AirPrint, USB; scanners may show as a tab inside the printer's pane

### Best practices

- **Backups** — Time Machine to an external drive minimum; cloud backup for the stuff you can't lose
- **Updates/patches** — let RSR install automatically, schedule major OS updates
- **Antivirus** — macOS has XProtect and Gatekeeper built in; enterprise endpoints add EDR (CrowdStrike, SentinelOne). At home you usually don't need third-party AV — common sense and Gatekeeper handle most threats
- **FileVault on, always** — especially on laptops
- **Don't disable SIP** — System Integrity Protection blocks tampering with /System even as root. Disabling it is a 2014 Hackintosh forum move

### CompTIA exam traps

> **.dmg is not an installer, it's a disk image.** The .app inside is what you install. CompTIA will offer ".dmg installs the application" as a wrong-but-tempting answer.

> **Force Quit is Cmd+Option+Esc, not Ctrl+Alt+Del.** Mac keyboards have no Ctrl+Alt+Del. Memorize the Cmd shortcuts.

> **System Settings vs System Preferences.** Apple renamed it in Ventura (2022). Both names appear in exam questions — same thing, different era.

> **Spotlight vs Mission Control vs Finder.** Spotlight searches, Mission Control shows windows/Spaces, Finder browses files. Easy to conflate under exam pressure.

## Helpdesk reality

- *"My app is frozen."* — Cmd+Option+Esc, Force Quit the app. If the whole machine is locked, hold the power button for 10 seconds.
- *"I forgot my Mac password."* — On a personal Mac, reset with Apple ID at the login screen. On a managed Mac, you do not reset it — you ticket IT for the FileVault recovery key escrowed in MDM. Never promise users you can recover their data if FileVault is on and the key is lost.
- *"My iMessages aren't syncing to my work Mac."* — Often by design. Corporate policy frequently blocks iCloud services on managed Macs. Confirm with the MDM policy before troubleshooting.
- *"How do I uninstall this app?"* — Drag the .app from /Applications to Trash for most apps. For .pkg-installed software (drivers, Office, Adobe), use the vendor's uninstaller. Leftover prefs in ~/Library/Preferences are usually harmless.
- *"Where do I find Disk Utility?"* — /Applications/Utilities, or Cmd+Space and type it. Same for Terminal, Activity Monitor, Keychain Access.

## Related concepts

[[Windows Features and Tools]] · [[Linux Commands]] · [[FileVault and BitLocker]] · [[Apple ID and MDM Enrollment]] · [[Time Machine and Backup Strategies]] · [[Disk Utility and Storage Management]] · [[Mobile Device Management (MDM)]] · [[Endpoint Encryption]]

*Source: VIRGIL knowledge base — 2026-05-10*