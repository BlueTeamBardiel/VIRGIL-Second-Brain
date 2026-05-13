# An Overview of Windows

## What it is

Every Windows machine you've ever used is the same OS wearing a different name tag. Home, Pro, Enterprise — same kernel underneath, same soul. What changes is which features Microsoft unlocked, which management hooks are exposed, and how much they charge for the license.

In plain English: Windows editions are tiers. Pay more, get more knobs. Home is the locked-down consumer trim. Pro adds the things IT departments need to manage a fleet. Enterprise adds the things megacorps need to manage tens of thousands of machines. Pro for Workstations is the niche edition for people pushing server-class hardware on a desktop OS.

Technically: Windows 10 and Windows 11 are both NT-kernel operating systems with edition-gated feature flags. The features aren't separate code — they're the same binaries with licensing-controlled enablement. BitLocker, Group Policy, domain join, Hyper-V, RDP host — all gated by SKU.

## Why it matters

Objective 220-1202 1.3 lives at the helpdesk reality line. A user calls saying they can't join the domain. You check — they're on Home. That's the whole ticket. You can't enable domain join on Home. You upgrade them to Pro or you reimage. There is no third option.

Knowing the edition map by heart saves you twenty minutes of poking at GUI menus that don't exist. Knowing the Windows 11 hardware requirements saves you from promising an upgrade to a 2017 laptop that's never getting one. Get the edition wrong on a deployment image and your domain-join automation breaks at the OOBE step on every machine.

## In your daily life, in the enterprise

**Beat 1 — Technical depth.** Windows 10 retired October 14, 2025; ESU (Extended Security Updates) is the paid life-support program keeping it alive for organizations that haven't migrated. Windows 11 is what's shipping. Both share the same edition lineup: Home, Pro, Pro for Workstations, Enterprise, plus Education and IoT variants you'll rarely touch. N versions are EU-mandated SKUs with Media Player and related media stack removed — same OS, no codecs out of the box. Windows 11 hardware requirements added the part that breaks everything: TPM 2.0, UEFI with Secure Boot, an 8th-gen Intel or Ryzen 2000-or-newer CPU, 4 GB RAM minimum, 64 GB storage. The CPU list is the wall most older machines hit.

**Beat 2 — Feynman example via your build.**

**You build a gaming PC.** Windows 11 Home, OEM key, $139. Boots, signs into a Microsoft account, plays Helldivers. *Home does everything a gaming rig needs.*

**You start a homelab.** Now you want to run a VM with Hyper-V, RDP into your desktop from the couch, encrypt the drive with BitLocker. Home blocks all three. *Upgrade to Pro. Same install, $99 in-place upgrade, no reformat.*

**You take a part-time IT gig.** Your boss says join this machine to the domain. You try. The "Join a domain" button doesn't exist on Home. *Domain join is Pro-and-up. Always.*

**You spec a workstation for video editing.** 256 GB of RAM, dual Xeons, ReFS filesystem for the scratch array. Pro caps at 2 TB RAM and 2 CPUs but ReFS-as-boot and persistent memory support need Pro for Workstations. *Pro for Workstations exists for one reason: server hardware in a desktop role.*

**Beat 3 — Bridge from home to enterprise.** Same question — "which edition does this machine need?" — different right answers.

Home machine: Home. Done.

Small-business workstation that needs to join a domain: Pro.

CAD operator with 512 GB RAM and four NVMe drives in ReFS: Pro for Workstations.

A bank with 40,000 endpoints managed by Intune, locked down by Group Policy, with DirectAccess and AppLocker and Credential Guard: Enterprise, licensed through volume agreement, never sold at retail.

**Beat 4 — The point.** Edition selection is a sourcing decision made before the machine boots. Get it wrong and you're either reimaging or paying for features you'll never use. *Ask which features the machine actually needs. Buy the lowest tier that includes them. Get this question into your bones — you'll ask it for every deployment for the rest of your career.*

## Key facts

### Windows 10 and Windows 11 editions

| Edition | Target user | Key gated features |
|---|---|---|
| **Home** | Consumers, gaming | No domain join, no Group Policy editor, no BitLocker (device encryption only on supported hardware), no RDP host, no Hyper-V |
| **Pro** | Small business, power users | Domain join, Group Policy (gpedit.msc), BitLocker, RDP host, Hyper-V, Windows Sandbox |
| **Pro for Workstations** | High-end workstations | Everything in Pro + ReFS, persistent memory, SMB Direct, up to 6 TB RAM, up to 4 CPUs |
| **Enterprise** | Large organizations (volume licensing only) | Everything in Pro + AppLocker, DirectAccess, BranchCache, Credential Guard, Device Guard, long-term servicing options |
| **Education** | Academic | Roughly equivalent to Enterprise, academic licensing |

### Hardware requirements

| Requirement | Windows 10 | Windows 11 |
|---|---|---|
| CPU | 1 GHz, 1 core | 1 GHz, 2 cores, 64-bit, on the approved CPU list (Intel 8th gen+, AMD Ryzen 2000+) |
| RAM | 1 GB (32-bit) / 2 GB (64-bit) | 4 GB |
| Storage | 16 GB (32-bit) / 32 GB (64-bit) | 64 GB |
| Firmware | BIOS or UEFI | UEFI with Secure Boot capability |
| TPM | Not required | TPM 2.0 required |
| Display | 800×600 | 720p, >9" diagonal |

### RAM support limits

| Edition | Max RAM (64-bit) |
|---|---|
| Home | 128 GB |
| Pro | 2 TB |
| Pro for Workstations | 6 TB |
| Enterprise | 6 TB |

32-bit Windows is dead. All current editions ship 64-bit only.

### N versions

EU regulatory SKUs. Identical to standard editions minus Windows Media Player, Groove, Movies & TV, Voice Recorder, and the related media frameworks. Codecs can be added back via the Media Feature Pack from Windows Update. You'll see N versions on machines imported from Europe or on EU corporate images.

### Upgrade paths

**In-place upgrade**: Run setup.exe from the new version's media on a running OS. Keeps files, apps, and settings. The big rules:

- **Same architecture only.** 32-bit → 64-bit requires a clean install.
- **Same or higher edition only.** Home → Pro works. Pro → Home does not — you have to clean install.
- **Same language only.** US English → UK English does not in-place.
- Windows 10 Pro → Windows 11 Pro: supported, free, hardware must meet Win11 requirements.

**Clean install**: Boot from media, wipe the partition, install fresh. Use this when:
- Going down in edition
- Changing architecture
- The existing install is corrupted
- You want a known-good baseline (the right answer for any image deployment)

**Edition upgrade (no media)**: Settings → Activation → Change product key. Pays for the SKU bump, unlocks the features, no reinstall. This is how you go Home → Pro on a running machine without wiping it.

### Feature differences worth memorizing

**Domain vs. workgroup**: Workgroup is peer-to-peer — every machine manages its own users, no central authority. Default for Home (it has no choice). Domain join means the machine trusts Active Directory for authentication and policy. Pro and up only.

**Desktop styles / UI**: Windows 11 centered the taskbar, rounded the corners, redesigned the Start menu, and killed live tiles. The Settings app expanded; Control Panel is still there but shrinking every release. Right-click context menus got the "Show more options" sub-menu that hides the old full menu — universally hated, still there.

**Remote Desktop**: All editions can be an RDP *client* (the one connecting out). Only Pro and up can be an RDP *host* (the one being connected to). This trips up users who paid for Home and assumed they could RDP into it from work. They can't.

**BitLocker**: Full-volume encryption tied to TPM. Pro and up get full BitLocker with management. Home gets "Device Encryption" — a stripped-down version that only activates on machines meeting specific hardware requirements (TPM 2.0, Modern Standby, Microsoft account sign-in). Functionally similar, far less manageable.

**gpedit.msc**: The Local Group Policy Editor. Pro and up. Home doesn't ship it. There are registry hacks to enable it on Home — never do this on a production machine.

### CompTIA exam traps

> **CompTIA exam trap:** RDP client vs RDP host. Every edition can connect out. Only Pro and up can be connected to. The exam will phrase this as "user wants to remotely access their home PC from work" — the answer is upgrade to Pro.

> **CompTIA exam trap:** BitLocker vs Device Encryption. CompTIA treats "BitLocker" as a Pro-and-up feature. If the question says Home, the answer is not BitLocker — even though Device Encryption exists, the exam doesn't acknowledge it as the same thing.

> **CompTIA exam trap:** In-place upgrade rules. Home → Pro = in-place. Pro → Home = clean install. 32-bit → 64-bit = clean install. The exam loves the "user wants to switch from Pro to Home, what method?" question. Answer: clean install.

> **CompTIA exam trap:** Windows 11 TPM 2.0 requirement. Not TPM 1.2. Not "a TPM." Specifically 2.0. The exam will list TPM 1.2 as a wrong answer.

> **CompTIA exam trap:** UEFI with Secure Boot for Windows 11. Legacy BIOS will not install Windows 11, even with a workaround. The exam answer is always UEFI.

## Helpdesk reality

- **"I can't find the option to join the domain."** Check the edition first. If it says Home in Settings → System → About, that's the ticket. Quote the Pro upgrade or escalate to procurement.
- **"I tried to upgrade to Windows 11 and it says my PC isn't compatible."** Run the PC Health Check tool or just check the CPU model against Microsoft's supported list. 99% of the time it's an old CPU or TPM 2.0 disabled in BIOS. Sometimes TPM is there and just needs to be enabled — check BIOS settings before telling them to buy a new machine.
- **"Can I RDP into my home PC from the office?"** Only if home PC is Pro+. Home edition is RDP client only. Recommend they check Settings → System → About, or look at Chrome Remote Desktop / TeamViewer as alternatives if they're stuck on Home.
- **"Why does my Windows look different from my coworker's?"** Probably a Windows 10 vs Windows 11 thing, or a feature update version difference. Confirm the build (winver.exe) before assuming it's an edition issue.
- **"Can you install gpedit on my Home machine?"** No. Don't run the registry hacks you find on forums. If they need Group Policy, they need Pro. That's the answer.

## Related concepts

[[Windows 11 Installation and Configuration]] · [[Active Directory Basics]] · [[BitLocker and Drive Encryption]] · [[TPM and Secure Boot]] · [[Group Policy Fundamentals]] · [[Remote Desktop Protocol]] · [[Hyper-V and Client Virtualization]] · [[Windows Upgrade Paths and Methods]]

*Source: VIRGIL knowledge base — 2026-05-10*