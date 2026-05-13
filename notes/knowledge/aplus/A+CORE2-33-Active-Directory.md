# Active Directory

## What it is

You built a homelab. Three machines, maybe four. Each one has its own local accounts — `gamer-pc\jake`, `nas\jake`, `proxmox\jake`. Different passwords, different permissions, no relationship between them. If you want to share a folder from the NAS to the gaming rig, you punch in credentials. Fine for four machines.

Now imagine 4,000 machines. 12,000 user accounts. Forty office locations. You cannot manage that with local accounts. You'd quit.

**Active Directory (AD)** is Microsoft's centralized identity and policy system. One database, hosted on **Domain Controllers (DCs)**, that holds every user, every computer, every group, every printer, every shared folder in the company. Every Windows machine **joined to the domain** authenticates against that database instead of its local SAM file. Log in once at the desktop, your identity is recognized everywhere on the network.

Technically: AD is an **LDAP-compliant directory service** with **Kerberos** authentication, organized as a **forest** of **domains**, internally subdivided into **Organizational Units (OUs)** for delegation and policy targeting. The immune system that decides who you are and what you're allowed to touch — extended across the entire enterprise nervous system.

## Why it matters

Every business Windows environment of meaningful size runs Active Directory or its cloud sibling, **Microsoft Entra ID** (formerly Azure AD). Your first helpdesk job will involve resetting AD passwords, unlocking AD accounts, and adding users to AD groups within your first hour on the floor. This is the single most-touched system in IT.

CompTIA **220-1202 Objective 2.2** lists Active Directory directly, alongside the surrounding cast: users and groups, Group Policy, login scripts, home folders, folder redirection, OUs, domain joining. The exam tests whether you understand the model — not just the buttons.

## In your homelab, in the enterprise

**Beat 1 — Technical depth.** AD's hierarchy goes **Forest → Domain → OU → Object**. A **forest** is the top-level security boundary. A **domain** is a partition inside the forest with its own DCs and replication scope (`corp.contoso.com`). **OUs** are folders inside the domain used for two things: **delegating admin rights** (let the helpdesk reset passwords for the Sales OU only) and **targeting Group Policy** (apply this lockdown GPO only to kiosks in the Retail OU). **Objects** are users, computers, groups, printers, and service accounts.

Authentication uses **Kerberos** — the DC issues time-stamped tickets, the client presents them to resources, no password crosses the wire after the initial login. This is what enables **Single Sign-On (SSO)**: log in once at the desktop, file shares and intranet sites and Exchange all accept your ticket without prompting again.

Group strategy follows **AGDLP**: Accounts go into Global groups, Global groups go into Domain Local groups, Domain Local groups get Permissions. Sounds bureaucratic. Saves your life at scale.

**Beat 2 — Feynman: your homelab is already an AD in miniature.**

**The local accounts:** You've got `jake` on the gaming rig and `jake` on the NAS. Same name, different SIDs, different passwords. Windows treats them as totally unrelated people. *Local accounts don't scale past about three machines before you start hating yourself.*

**The Microsoft account:** You sign your gaming PC into a Microsoft account so OneDrive and Xbox sync. That's the consumer version of directory-based identity — one cloud identity, recognized across your devices. *Microsoft accounts are training wheels for AD.*

**Spin up a DC in the homelab:** Install Windows Server in a VM, promote it to a domain controller, create `homelab.local`. Join the gaming rig to the domain. Now `HOMELAB\jake` exists once, and the gaming rig trusts the DC's word on who you are. *You just built the same model that runs Fortune 500 networks. The scale is different. The mechanism is identical.*

**Add a Group Policy:** Create a GPO that maps `H:\` to `\\dc\users\%username%` and link it to your Users OU. Log in — `H:` drive appears automatically. *That's how every corporate "home drive" works. One policy, thousands of users.*

**Beat 3 — Bridge from homelab to enterprise.** Same question across every environment: **where does identity live, and what does it grant access to?**

- **Home PC:** identity lives in the local SAM. Grants access to that one machine.
- **Homelab with DC:** identity lives in your one DC. Grants access to anything joined to `homelab.local`.
- **Small business (50 users):** identity lives in two redundant on-prem DCs. Grants access to file servers, the line-of-business app, the network printer.
- **Enterprise (10,000+ users):** identity lives in a multi-DC forest with sites in every region, **hybrid-joined** to Entra ID so cloud apps (Microsoft 365, Salesforce, Zoom) accept the same login via SSO. Grants access to thousands of resources, gated by hundreds of group memberships, governed by **Conditional Access** policies that check device compliance and location before issuing tickets.

**Beat 4 — The point.** Same fundamental question — where does identity live, what does it unlock — different answers at every scale. The mechanism doesn't change. The blast radius does. *Get the AGDLP model and the OU/GPO targeting model into your bones now. You will use them every day for the rest of your career.*

## Key facts

### Domain join

**Joining a domain** moves a machine's trust boundary from "my local SAM" to "whatever the DC says." Done via **Settings → System → About → Rename this PC (advanced) → Change → Domain**. Requires:
- Network reachability to a DC (DNS pointing at the DC is critical — AD is allergic to bad DNS)
- A domain-join credential with rights to add computers to the domain
- Reboot

After join, **domain users** can log in to that machine, the machine receives policies from linked GPOs, and `\\fileserver\share` works without re-prompting for credentials.

### Users and groups

| Account type | What it is | When you see it |
|---|---|---|
| **Administrator** | Full local or domain control | Built-in, rename or disable it |
| **Standard user** | Daily-driver account, can't install software or change system settings | Every domain user, by default |
| **Power user** | Legacy holdover from XP era — slightly elevated but mostly deprecated | Rare; treat as standard |
| **Guest** | Heavily restricted, no profile persistence | Disabled in any sane environment |
| **Local account** | Lives in the SAM of one machine | Workgroup PCs, break-glass admin |
| **Microsoft account** | Cloud identity tied to an email | Consumer Windows, OneDrive sync |
| **Domain account** | Lives in AD, recognized across the forest | Every corporate user |

**Security groups** are how you grant access at scale. Never assign permissions to individual users — assign to a group, then add the user to the group. When someone changes roles, you swap their group memberships, not 400 ACLs.

### Group Policy

**Group Policy Objects (GPOs)** are bundles of settings linked to a site, domain, or OU. They push down to every user or computer in scope. Common uses:
- **Login scripts** — `.bat` or `.ps1` that runs at logon (map drives, sync time, log the event)
- **Home folders** — assign `H:\` to `\\server\users\%username%`
- **Folder redirection** — redirect `Documents`, `Desktop`, `Pictures` to a network path so the profile follows the user across machines
- **Lockdown** — disable Control Panel, block USB storage, enforce screen lock timeout
- **Software deployment** — push MSI installers

**Inheritance** flows top-down: Site → Domain → OU → child OU. Closer wins. Block inheritance and enforced links exist for edge cases.

### NTFS vs. share permissions

| | NTFS permissions | Share permissions |
|---|---|---|
| **Where applied** | The filesystem itself | The SMB share |
| **Scope** | Local and network access | Network access only |
| **Granularity** | Full Control, Modify, Read & Execute, Read, Write, plus advanced ACEs | Full Control, Change, Read |
| **Best practice** | Lock down here | Set to "Authenticated Users: Full Control" and let NTFS do the real work |

**When both apply, the most restrictive wins.** If share grants Read and NTFS grants Modify, the user gets Read over the network. NTFS-only when accessed locally.

**File and folder attributes** (Read-only, Hidden, System, Archive) are not permissions — they're metadata flags. Don't confuse them.

### EFS and BitLocker

**Encrypting File System (EFS)** — per-file encryption tied to a user's certificate. Right-click → Properties → Advanced → Encrypt contents. Only that user (or holders of the recovery key) can decrypt. NTFS only. *Lose the cert with no recovery agent and the data is gone.*

**BitLocker** — full-volume encryption. Encrypts the entire drive, ties the key to the **TPM** chip, optionally requires a **PIN** or USB key at boot. Activate via Control Panel → BitLocker Drive Encryption → Turn On. **Store the recovery key** — in AD, in Entra, or printed in a safe. Without it, a TPM failure means the drive is a brick.

**BitLocker To Go** — same idea, applied to removable drives. USB stick gets encrypted, prompts for password or PIN when plugged in. Enterprise policy can require this on all removable media.

### Login options

- **Password** — the baseline
- **PIN** — device-bound, can't be reused if stolen, backed by the TPM
- **Windows Hello** — biometric: **fingerprint** or **facial recognition**, tied to the local TPM, never transmits the biometric off the device
- **Passwordless / FIDO2 security keys** — hardware token, no password at all
- **Smart card** — PIV/CAC card with a cert, common in gov/defense

All of these feed into **SSO** once you're authenticated — Kerberos tickets do the rest.

### UAC and Run as administrator

**User Account Control (UAC)** prompts when a process requests elevation. Even when logged in as an administrator, you run with a standard-user token by default; UAC asks before handing you the admin token. *This is why "Run as administrator" exists as a right-click option — it explicitly requests the elevated token for that one process.*

Disabling UAC is almost always wrong. Lowering its notification level is fine for power users. Turning it off entirely breaks the security model Windows assumes.

### CompTIA exam traps

> **CompTIA exam trap:** **NTFS vs. share permissions when combined.** The most restrictive of the two wins for network access. Many candidates assume they stack additively. They don't.

> **CompTIA exam trap:** **Local account vs. Microsoft account vs. domain account.** A Microsoft account is a consumer cloud identity (Outlook.com/Hotmail). A domain account is an AD identity. Entra ID accounts are the cloud-AD hybrid. Know which is which.

> **CompTIA exam trap:** **OUs are not security groups.** OUs organize objects for delegation and GPO targeting. Security groups grant permissions. You cannot assign file permissions to an OU. CompTIA loves this distinction.

> **CompTIA exam trap:** **EFS encrypts files, BitLocker encrypts volumes.** EFS is per-user, per-file. BitLocker is whole-drive, machine-bound. They solve different problems and can coexist.

## Helpdesk reality

- **"I can't log in"** — 80% of the time it's a locked account from too many bad password attempts, or an expired password. Unlock in AD Users and Computers (ADUC) or the Entra admin center. Reset, force change at next logon.
- **"My H drive disappeared"** — GPO didn't apply. Run `gpupdate /force`, check `gpresult /r` to see which policies hit. Usually a network or DNS issue keeping the client from talking to a DC.
- **"I need access to the Finance share"** — never grant directly. Find the security group that owns that share, get manager approval, add the user to the group. Document the ticket. Access reviews happen quarterly and someone will ask why.
- **"BitLocker is asking for a recovery key"** — TPM state changed (BIOS update, hardware swap, secure boot toggle). Pull the key from AD or Entra, paste it in, then re-seal BitLocker once the machine boots. **Never** promise the user their data is recoverable until you've confirmed the key exists in the directory.
- **"Why does it keep asking me to approve things?"** — that's UAC. Don't tell them to disable it. Explain it's the system asking "are you sure?" before changing protected settings.

## Related concepts

[[Windows Security Settings]] · [[Group Policy]] · [[NTFS Permissions]] · [[BitLocker and Encryption]] · [[User Account Control]] · [[Windows Hello and MFA]] · [[Microsoft Entra ID]] · [[Domain vs Workgroup]] · [[Kerberos and SSO]]

*Source: VIRGIL knowledge base — 2026-05-10*