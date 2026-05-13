# Upgrading Windows

## What it is

You're not building a new body. You're transplanting the brain into an upgraded skull while the patient is still talking to you. The hardware stays. The OS — Windows 10 → Windows 11, or Windows 11 Home → Pro — gets swapped underneath the user's files and apps. When it works, they log in the next morning and notice the Start menu moved. When it doesn't, you're restoring from backup at 3 AM.

**Plain English:** An in-place upgrade replaces the OS while preserving user data, installed applications, and most settings. An edition upgrade (Home → Pro) unlocks features without touching files. A clean install wipes everything and starts over. Same hardware, different OS state.

**Technical definition:** A Windows upgrade is a controlled OS version transition that uses the Windows Setup engine (`setup.exe` from install media, or Windows Update's servicing stack) to migrate the system partition's OS files while preserving the user profile, registry hives where compatible, and installed software. Edition upgrades use digital licensing tied to the Microsoft account or a product key to activate latent features already present in the binaries.

## Why it matters

Windows 10 reached end-of-support on October 14, 2025. Every machine still running it past that date receives no security patches unless the org is paying for ESU (Extended Security Updates). That's the entire reason this objective exists right now — CompTIA expects you to walk into a fleet of 800 Windows 10 boxes and know which ones can upgrade, which need new hardware, and how to drive the process without bricking accounting on a Tuesday.

The exam (Objective 1.6, 220-1202) tests upgrade *methods*, *boot methods*, *feature differences between editions*, and the Settings/Control Panel locations where you verify or configure post-upgrade state. The job tests whether you can actually pull it off without losing data.

## In your build, in the enterprise

**Beat 1 — Technical depth.** Three upgrade paths exist. **In-place upgrade** runs Windows Setup over the existing install, keeps files/apps/settings, takes 30–90 minutes per machine. **Clean install** wipes the drive, requires reinstalling everything, takes longer but produces the cleanest result. **Edition upgrade** (Home → Pro, Pro → Enterprise) is a license change executed in Settings → System → Activation; no reboot beyond a quick services restart, the feature bits are already on disk.

Windows 11 hard requirements: TPM 2.0, UEFI with Secure Boot, 64-bit CPU on the approved list (Intel 8th gen+ / Ryzen 2000+ as the floor), 4 GB RAM minimum (8 GB realistic), 64 GB storage. Run **PC Health Check** or `WhyNotWin11` to verify before you commit. Boot methods for clean installs: USB (Rufus or Media Creation Tool), network/PXE (enterprise deployment via WDS/MDT/SCCM/Intune Autopilot), ISO mount, or recovery partition.

**Beat 2 — Feynman: upgrading the gaming rig.**

**The pre-flight check:** You've got a 2020 build. Ryzen 5 3600, B450 board, 16 GB DDR4, NVMe boot drive. Windows 10 still works. Run PC Health Check. TPM fails — fTPM is disabled in BIOS. *Half the "incompatible" PCs out there just need fTPM/PTT toggled on in UEFI.*

**The backup nobody skips twice:** Before any upgrade, image the boot drive. Macrium Reflect, Veeam Agent Free, even a `wbAdmin` image to an external. Skip this once, lose your Tarkov save once, never skip again. *The upgrade that destroys data is always the one you didn't back up.*

**The in-place run:** Mount the Windows 11 ISO, run `setup.exe`, choose "Keep personal files and apps." 45 minutes later it reboots into Windows 11. Steam works. Discord works. The NVIDIA driver auto-updated. Start menu is centered and you hate it — `Settings → Personalization → Taskbar` fixes that. *In-place upgrades work shockingly well on healthy systems. They fail spectacularly on systems that were already sick.*

**The post-upgrade audit:** Check `Settings → System → Activation` (digital license carried over), `Device Manager` (no yellow bangs), `Windows Update` (pull the latest cumulative), `Settings → Privacy & security → Windows Security` (Defender re-enabled itself), `Power Options` (your custom plan survived — usually). *Every upgrade needs a 10-minute walkthrough afterward. The OS reset three settings you cared about and you need to find them now, not next week.*

**Beat 3 — Bridge to enterprise.** Same fundamental question — "can this machine run Windows 11, and how do we get it there?" — different scale. At home: one machine, one afternoon, one ISO on a USB stick. In a 2,000-seat enterprise: an Intune/SCCM compliance report tells you which machines pass Win11 readiness, which need TPM enabled (push a BIOS update via the management tool), which need replacement entirely. Deployment goes out as a phased ring — IT pilots first, then early adopters, then general population. Autopilot reimages machines from the cloud; the user signs in with their AAD account and the box configures itself.

**Beat 4 — The point.** Same question, three scales: one PC, one department, one enterprise. The decision tree is identical — *is this hardware capable, is the data backed up, what's the rollback plan?* Get this question into your bones. You'll ask it every Patch Tuesday for the rest of your career.

## Key facts

### Upgrade paths

| Path | What survives | When to use |
|---|---|---|
| **In-place upgrade** | Files, apps, most settings | Healthy system, want minimal user disruption |
| **Clean install** | Nothing (unless you migrate manually) | Sick system, malware suspicion, major version jump |
| **Edition upgrade** | Everything (it's just a license change) | Need BitLocker, Group Policy, Hyper-V, RDP host |
| **Reset this PC** | Optional: keep files, lose apps | User-facing recovery, faster than clean install |

### Windows 11 hardware requirements (the floor)

- **TPM 2.0** — discrete chip or firmware (fTPM on AMD, PTT on Intel)
- **UEFI** with **Secure Boot** capable (doesn't have to be enabled to install, but must be capable)
- **64-bit CPU**, 1 GHz+, 2+ cores, on Microsoft's approved CPU list
- **4 GB RAM** minimum
- **64 GB storage** minimum
- **DirectX 12 / WDDM 2.0** graphics
- **720p display** 9"+ diagonal

### Edition upgrade matrix (Home → Pro is the one you'll do most)

| From | To | Method |
|---|---|---|
| Win 11 Home | Win 11 Pro | Settings → Activation → Change product key, or buy from Store |
| Win 11 Pro | Win 11 Pro for Workstations | Product key |
| Win 11 Pro | Win 11 Enterprise | Volume license, joined to AAD/AD |
| Win 11 Pro | Win 11 Education | Volume license (academic) |

Pro adds: BitLocker, Group Policy, Hyper-V, Remote Desktop host, AAD join, Windows Sandbox. Enterprise adds: AppLocker, DirectAccess, Credential Guard, long-term servicing options.

### Boot methods for clean installs

- **USB** — Media Creation Tool or Rufus. Default for techs.
- **Network/PXE** — enterprise only, WDS/SCCM/MDT pushes image over LAN
- **Optical** — DVD, still occasionally used for offline environments
- **ISO mount** — for in-place from inside running Windows, or VM installs
- **Recovery partition** — OEM "reset" path, restores factory image
- **Internet recovery** — Windows 11 22H2+ supports cloud download for Reset

### Where to verify upgrade state (post-upgrade checklist)

| Setting | Path |
|---|---|
| OS version, edition | Settings → System → About, or `winver` |
| Activation | Settings → System → Activation |
| Driver health | Device Manager — check for yellow ⚠️ |
| Pending updates | Settings → Windows Update |
| Firewall enabled | Windows Defender Firewall (Control Panel) |
| Defender enabled | Settings → Privacy & security → Windows Security |
| Power plan | Control Panel → Power Options |
| Default apps | Settings → Apps → Default apps |
| Startup programs | Task Manager → Startup apps (Win11) |

### CompTIA exam traps

> **CompTIA exam trap: in-place upgrade vs. reset vs. clean install.** In-place upgrade *changes the Windows version* while keeping data. Reset *reinstalls the same Windows version* and optionally keeps personal files. Clean install *wipes everything*. The exam will give you a scenario and expect the right verb.

> **CompTIA exam trap: TPM 2.0 vs. Secure Boot.** Both are Win11 requirements, both live in UEFI, both are commonly disabled by default on older boards. They are *separate features*. TPM is the chip that stores keys. Secure Boot is the firmware policy that only loads signed bootloaders. The exam will ask about one or the other — don't conflate them.

> **CompTIA exam trap: edition upgrade does not require reinstall.** Home → Pro is a license key change in Settings → Activation. The Pro feature binaries are already on the disk; the key unlocks them. The exam loves this distinction.

> **CompTIA exam trap: 32-bit Windows is dead in Windows 11.** Win11 ships 64-bit only. If a user is on 32-bit Win10, there is no in-place upgrade path — it has to be a clean install of 64-bit Win11.

### The consumer vs. enterprise split

**At home:** You boot from a USB stick or run `setup.exe` from a mounted ISO. You click through the wizard, pick "Keep files and apps," wait an hour, log back in. Activation carries over via digital license tied to your Microsoft account or the motherboard's hardware hash. You handle one machine, on your own schedule.

**In the enterprise, this changes:**
- **Compatibility scanning is automated.** Intune/SCCM/ConfigMgr runs readiness reports across the fleet. You don't open PC Health Check 2,000 times.
- **Deployment is staged in rings.** IT → pilot users → broad deployment. Catch the driver issue in ring 1, not ring 4.
- **Image management replaces ISOs.** A golden image, sysprepped and captured, deploys via PXE or Autopilot. Apps come from Intune/Company Portal, not user installers.
- **Licensing is volume-based.** KMS (Key Management Service) or Azure AD-based activation. No product keys typed by hand.
- **User data lives elsewhere.** OneDrive Known Folder Move, roaming profiles, or FSLogix containers mean the local machine is disposable. Reimage, sign in, work continues.
- **Rollback plans are mandatory.** Change management approves the deployment, a maintenance window is scheduled, and there's a documented rollback (restore from image, reactivate Win10 license) if it goes sideways.
- **GPO and Intune policies reapply.** The moment the upgraded machine joins the domain or syncs with Intune, the security baseline pushes back down — BitLocker, Defender policy, password requirements, restricted apps.

## Helpdesk reality

- **"My computer says it can't run Windows 11."** Nine times out of ten it's fTPM/PTT off in BIOS, or Secure Boot disabled. Reboot, into UEFI, enable both, re-run PC Health Check. Tenth time it's a CPU older than the support list and the answer is "you need new hardware" — be honest, don't promise a workaround that doesn't exist.
- **"I upgraded and now [application] doesn't work."** Check the vendor's Win11 compatibility page. If the app is unsupported, options are: compatibility mode (right-click → Properties → Compatibility), a vendor update, or rolling back within 10 days via Settings → System → Recovery → Go back.
- **"Where did my files go?"** They didn't. They're in `C:\Users\[name]` exactly where they were. Search → type the filename. If the upgrade genuinely lost data, check `C:\Windows.old` — it's the previous install, kept for 10 days.
- **"Can you just leave me on Windows 10?"** Post-October 2025, the honest answer is: only if the org is paying for ESU, and even then it ends. Explain that running unpatched Windows is a security risk, not a preference. Document the conversation in the ticket.
- **Never promise an upgrade will be lossless without a backup.** "It usually works fine" is not a recovery strategy. Image the drive first. Every time.

## Related concepts

[[Windows Editions]] · [[Installation Methods]] · [[TPM and Secure Boot]] · [[Windows Update]] · [[BitLocker]] · [[Active Directory and Azure AD]] · [[Group Policy]] · [[Backup Strategies]] · [[Device Manager]] · [[Control Panel vs Settings]]

*Source: VIRGIL knowledge base — 2026-05-10*