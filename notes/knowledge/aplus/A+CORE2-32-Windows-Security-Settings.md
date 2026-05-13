# Windows Security Settings

## What it is

Windows ships with a stack of security controls layered like an immune system: identity (who are you), authorization (what can you touch), encryption (what happens if the disk walks out the door), and isolation (what can talk to what). Defender is the white blood cells. BitLocker is the locked vault. NTFS permissions are the door badges. UAC is the supervisor who makes you sign off on anything that touches the soul of the OS.

Configuring Windows security means knowing which control answers which threat — and which ones CompTIA expects you to wire up from a fresh install to a domain-joined production endpoint.

## Why it matters

Objective 220-1202 2.2 is the meat-and-potatoes endpoint configuration objective. You will do this work every week of your IT career: provision a new laptop, join it to the domain, set up the user, lock down the drive, configure the firewall, hand it over. The exam tests every layer because every layer has its own failure mode and its own ticket pattern.

Miss a BitLocker recovery key? Drive is a brick. Wrong NTFS permission? User can read HR's payroll folder. UAC disabled? Malware installs silently. The stakes are real and the muscle memory matters.

## In your build, in the enterprise

**Beat 1 — Technical depth.** Windows security splits into four planes. **Identity:** local accounts, Microsoft accounts, or domain accounts via Active Directory, with sign-in options ranging from password to PIN to Windows Hello (fingerprint, facial recognition) to FIDO2 keys. **Authorization:** NTFS permissions (per-file ACLs, inherited down the tree), share permissions (network-only gate), user account types (Administrator, Standard, Guest, the legacy Power User group), and UAC enforcing the principle of least privilege at execution time. **Encryption:** BitLocker for full-disk on fixed drives, BitLocker To Go for removable drives, EFS for per-file encryption tied to a user's certificate. **Isolation:** Windows Defender Antivirus, Windows Defender Firewall with inbound/outbound rules per profile (Domain, Private, Public), and Group Policy pushing all of it from a domain controller.

**Beat 2 — Feynman example, your gaming rig.** You build a new rig. Fresh Windows 11 install.

**Account setup:** Microsoft account sign-in by default — syncs your settings, BitLocker recovery key saves to your account automatically, Windows Hello PIN replaces the password at the login screen. *Convenience and recovery, baked in.*

**BitLocker:** Settings → Privacy & Security → Device Encryption → On. TPM 2.0 on the motherboard holds the key, drive unlocks automatically at boot, recovery key lives in your Microsoft account. The Steam library doesn't need it but your tax PDFs do, and BitLocker doesn't care which folder is which — it encrypts the volume. *If someone steals the SSD, they get noise.*

**Defender:** runs out of the box. Real-time protection on, definitions auto-update through Windows Update. You don't install a third-party AV because Defender is genuinely good now and stacking AVs causes more problems than it solves. *The white blood cells are already on duty.*

**Firewall:** on by default, Public profile blocks almost everything inbound, Private profile allows file sharing to your NAS. When a game wants to host a LAN session, Windows pops the "allow on Private network" prompt. You click yes. *That prompt is the firewall asking permission, not malware asking forgiveness.*

**UAC:** still on. When you install MSI Afterburner it dims the screen and asks for consent. Annoying for ten seconds, prevents silent installs forever. *Leave it on. Always.*

**Beat 3 — Bridge to the enterprise.** Same machine, now imagine it's a corporate laptop joined to Active Directory.

The local Microsoft account goes away — the user signs in with a **domain account** (`CONTOSO\jsmith`). Windows Hello still works but the PIN is now backed by **Azure AD / Entra ID** and enforced by policy. **SSO** kicks in: one sign-in unlocks Outlook, SharePoint, the VPN, the line-of-business app. A **login script** mapped via Group Policy runs at logon — maps the H: drive (the user's **home folder**), maps the S: drive (the department share), connects the printer.

BitLocker is no longer optional — it's enforced by GPO, recovery keys escrow to Active Directory or Intune, and IT can pull a key from the console when a user forgets their PIN at 7am. The firewall is configured centrally, with **port** and **application rules** pushed via GPO so that only approved software talks outbound on approved ports. Defender becomes **Defender for Endpoint** with EDR telemetry streaming to the SOC.

NTFS permissions on the file server enforce who reads what — HR's folder denies everyone except the HR security group. **Share permissions** gate the network connection itself (typically "Authenticated Users — Full Control" at the share layer, with the real enforcement done by NTFS underneath). Users land in **security groups** (`HR-Staff`, `Finance-ReadOnly`), groups land in folder ACLs, and **inheritance** flows permissions down the tree so admins aren't clicking individual files. **Folder redirection** policy points the user's Documents folder at `\\fileserver\users\jsmith\Documents` so their files live on the server, get backed up nightly, and follow them to any machine they log into.

UAC stays on, always — and standard users don't have local admin, so when they need to install something they call the helpdesk, who **Runs as administrator** with a privileged account. Guest accounts are disabled by GPO. The Power Users group is a relic — Microsoft kept it for backward compatibility, it has no real elevated rights anymore, and you should never use it.

**Beat 4 — The point.** Same operating system, same security primitives, two completely different operating models. At home you are the administrator, the user, and the IT department. In the enterprise those three roles are deliberately separated — and Group Policy is the mechanism that enforces the separation across thousands of machines. *Learn the controls on your own rig first. The enterprise version is the same controls, centrally managed and non-optional.*

## Key facts

### Accounts and groups

| Account type | Rights | Use case |
|---|---|---|
| **Administrator** | Full system control | Break-glass, IT staff only |
| **Standard user** | Run apps, change own settings, no system-wide installs without UAC prompt | Every end user |
| **Guest** | Heavily restricted, no persistent profile | Disabled by default — leave it disabled |
| **Power User** | Legacy group from XP era, effectively equivalent to Standard now | Don't use it |

**Local account** = credentials stored in the SAM database on that one machine. **Microsoft account** = credentials tied to a Microsoft cloud identity, syncs settings, stores BitLocker recovery. **Domain account** = credentials authenticated by an Active Directory domain controller, central management.

### NTFS vs. share permissions

| | NTFS | Share |
|---|---|---|
| **Scope** | Local and network access | Network access only |
| **Granularity** | Per-file, per-folder, six standard permissions plus special | Three permissions: Read, Change, Full Control |
| **Inheritance** | Yes, flows down the tree | No |
| **Effective permission** | **The most restrictive of NTFS and Share wins** | Same |

Standard practice: set Share to "Authenticated Users — Full Control" and do the real work in NTFS. Users get permissions through **security group membership**, not direct user-to-file ACLs.

### BitLocker vs. BitLocker To Go vs. EFS

| | Scope | Unlock method | Use case |
|---|---|---|---|
| **BitLocker** | Full fixed drive (OS or data volume) | TPM, TPM+PIN, recovery key | Laptop disk encryption |
| **BitLocker To Go** | Removable drives (USB, external HDD) | Password or smart card | Encrypt USB sticks before they leave the building |
| **EFS** | Individual files/folders on NTFS | User's EFS certificate, tied to their login | Per-file encryption when full-disk isn't enough |

BitLocker recovery keys must escrow somewhere — Microsoft account for home, Active Directory or Intune for enterprise. **A BitLocker drive without a known recovery key is a brick.**

### Windows Hello sign-in options

- **Password** — what you know
- **PIN** — what you know, but bound to the device (TPM-backed, can't be replayed elsewhere)
- **Fingerprint** — what you are
- **Facial recognition** — what you are, IR-camera required
- **Security key (FIDO2)** — what you have
- **Picture password** — exists, nobody uses it

PIN is more secure than password in practice because it's device-bound — stealing the PIN gets the attacker nothing without the physical machine.

### Active Directory essentials

AD organizes objects (users, computers, groups, printers) into **Organizational Units (OUs)**. **Group Policy Objects (GPOs)** link to OUs and push settings to everything inside — security baselines, firewall rules, BitLocker enforcement, login scripts, folder redirection, software deployment. **Moving an object** between OUs changes which GPOs apply to it. Build your OU structure around how you want to apply policy: by department, by location, by device type.

**Login scripts** assigned via GPO run at user logon — map drives, set printers, log the session start.

### Defender and Firewall

Defender Antivirus updates definitions through Windows Update by default. In enterprise, definitions push through WSUS, Intune, or Defender for Endpoint's own channel. Real-time protection, cloud-delivered protection, tamper protection — leave them all on.

Windows Defender Firewall has three profiles: **Domain** (auto-applied when DC is reachable), **Private** (trusted home/office), **Public** (coffee shop, airport — most restrictive). Rules can target specific ports, protocols, applications, or remote addresses. In a domain, firewall rules are pushed centrally via GPO.

### UAC and Run as administrator

UAC intercepts any action that requires admin rights and prompts for consent (or credentials, if the current user isn't admin). **Run as administrator** is the explicit elevation — right-click an executable, choose Run as administrator, UAC prompts, the process launches with the admin token. Never disable UAC. Never give end users local admin.

### CompTIA exam traps

> **Exam trap:** **NTFS vs. share permissions — most restrictive wins.** If Share says "Read" and NTFS says "Full Control," the user gets Read over the network. If Share says "Full Control" and NTFS says "Read," same answer — Read. Memorize this. CompTIA tests it every exam.

> **Exam trap:** **BitLocker requires TPM (or a workaround).** Default BitLocker config needs TPM 1.2 or 2.0. Without TPM you can enable BitLocker via GPO setting "Allow BitLocker without a compatible TPM," using a USB startup key instead. Know both.

> **Exam trap:** **EFS is per-user, BitLocker is per-volume.** EFS-encrypted files are readable only by the user whose certificate encrypted them — copy the file to a FAT32 drive and the encryption is lost. BitLocker doesn't care which user, it encrypts the whole volume.

> **Exam trap:** **Power Users group is a trap answer.** It looks like it should grant elevated rights. It doesn't, not since XP. Standard user is the correct least-privilege answer.

## Helpdesk reality

- **"My laptop is asking for a BitLocker recovery key and I don't know what that is."** → Pull the recovery key from AD or Intune (enterprise) or their Microsoft account (home). This is the most common BitLocker ticket. Hardware changes, BIOS updates, and Secure Boot toggles all trigger recovery mode.
- **"I can't access the shared folder."** → Check group membership first, NTFS permissions second, share permissions third. 90% of the time it's group membership — they were moved to a new department and nobody updated their groups.
- **"UAC keeps popping up, can you turn it off?"** → No. You can't. Explain it's protecting them and the company. The prompt is the feature.
- **"I forgot my password."** → Domain account: reset in AD Users and Computers (or self-service portal if you have one). Local account: depends on whether it's Microsoft-account-linked. Document the reset in the ticket.
- **"Can I install [random software]?"** → Standard users can't, by design. Either Run as administrator with your privileged account after verifying the software is approved, or escalate to whoever owns the software approval process. Never hand out local admin to make a ticket go away.

## Related concepts

[[Active Directory]] · [[Group Policy]] · [[BitLocker and Drive Encryption]] · [[NTFS Permissions]] · [[User Account Control]] · [[Windows Defender]] · [[Windows Firewall]] · [[Authentication Methods]] · [[Principle of Least Privilege]] · [[Windows Hello]]

*Source: VIRGIL knowledge base — 2026-05-10*