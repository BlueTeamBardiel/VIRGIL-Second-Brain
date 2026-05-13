# Cloud Productivity Tools

## What it is

You sign into a new laptop with your work email. Outlook already knows your mailbox. OneDrive starts pulling your files. Teams shows yesterday's chats. You never installed anything by hand. That's cloud productivity working correctly — the **OS is the personality of the machine, but the identity is the personality of the user**, and that identity now lives in the cloud.

Plain English: cloud productivity tools are the email, file storage, chat, video, and document apps your company runs out of someone else's data center — Microsoft 365, Google Workspace, the occasional Zoom or Slack tenant bolted on the side. The user signs in with one identity and the suite follows them across every device.

Technically: a tenant is a cloud-hosted directory (Entra ID for Microsoft 365, Google Cloud Identity for Workspace) holding user accounts, group memberships, license assignments, and policy. Apps authenticate against that tenant via OAuth/SAML, pull config from it, and sync user data (mail, files, calendar) through it. The desktop apps are thin clients now. The truth lives in the cloud.

## Why it matters

CompTIA 220-1202 Objective 1.11 puts this squarely on the Core 2 exam, and your first IT job will be 80% of this work. Password resets in Microsoft 365 admin center. Licensing somebody so Outlook stops nagging them. Walking a confused user through why "Word looks different now" — because it's the browser version, not the desktop app they had for fifteen years. Onboarding a new hire means assigning a license, syncing them into the directory, and watching their mailbox provision.

The shift from "install Office from a disc" to "the user's identity provisions Office" is the single biggest change in end-user IT in twenty years. You need to understand the moving parts: identity, licensing, mail, storage, collaboration. They all hinge on the identity.

## In your daily life, in the enterprise

**Beat 1 — Technical depth.** Microsoft 365 and Google Workspace are SaaS suites tied to a tenant. The tenant holds the directory (Entra ID / Google Cloud Identity), license SKUs (Business Basic, Business Standard, Business Premium, E3, E5 on the Microsoft side; Business Starter, Standard, Plus, Enterprise on the Google side), and tenant-wide policy. Hybrid identity is the common reality: on-prem Active Directory synced up to Entra ID via Entra Connect (formerly Azure AD Connect), so the user has one password that works for the file server and Outlook. SSO via SAML or OAuth lets third-party apps (Salesforce, Zoom, Atlassian) authenticate against the same identity. MFA is enforced at the identity layer — once, not per-app. Mail is Exchange Online or Gmail; storage is OneDrive/SharePoint or Google Drive; collaboration is Teams or Google Meet/Chat.

**Beat 2 — Feynman example via your personal life.** You already run a personal version of this without thinking about it.

**The Google account.** One Gmail login. Your phone's contacts, your photos in Google Photos, your YouTube subscriptions, your Drive docs, your saved passwords in Chrome — all keyed to that one identity. Lose the password, lose all of it. *The identity IS the product.*

**The shared Google Doc.** You and three friends planning a trip, all typing in the same doc, seeing each other's cursors. Nobody emailed a `trip-plan-FINAL-v3-actually-final.docx` around. *Real-time collaboration killed file versioning hell.*

**The Zoom or Discord call.** Video, screen share, chat, file drop, all in one app. You don't think about which protocol carries the video. It just works. *The user does not care about the plumbing. The user cares that it works.*

**The phone swap.** New phone, sign in, everything is back. Photos, contacts, app list. *Identity portability is the whole point.* When your user gets a new laptop and complains "where are my files?" — they expected this experience. Your job is to deliver it.

**Beat 3 — Bridge from home to enterprise.** Now scale it up. Same fundamental architecture, different stakes.

At home: one Google account, free, you manage your own password, if you lose the recovery codes that's your problem.

In a 500-person company on Microsoft 365 Business Premium: 500 user accounts in Entra ID, each assigned a license SKU that unlocks Exchange Online mailbox, OneDrive 1 TB, Teams, desktop Office apps, Intune device management, and Defender for Business. Identity syncs from on-prem AD via Entra Connect every 30 minutes. MFA is enforced via conditional access policy — required from untrusted networks, optional on the corporate LAN. Shared mailboxes for `support@`, `sales@`. Distribution lists for `all-staff@`. SharePoint sites per department with permission inheritance. Retention policies on mail and files for legal hold. DLP rules scanning outbound mail for credit card numbers. eDiscovery for HR investigations. When somebody leaves, you don't delete the account — you convert the mailbox to shared, revoke the license (freeing it for the next hire), block sign-in, and keep the OneDrive data for 30 days per policy.

Same question — "how does this user get to their stuff?" — different right answer for a household versus a regulated enterprise.

**Beat 4 — The point.** Cloud productivity is not "Office in a browser." It's identity-driven service delivery. Get the identity right and everything downstream — mail, files, chat, video, licensing — follows. Get the identity wrong and nothing works. Ask "who is this user, what tenant do they belong to, what license do they have, and what policies apply to them?" — you'll ask that question in every helpdesk ticket for the rest of your career.

## Key facts

### Email systems

Exchange Online (Microsoft) and Gmail (Google) are the two dominant cloud mail platforms. Both speak standard protocols for client connections but the modern default is the native client (Outlook, Gmail web/app) talking over HTTPS / MAPI / Exchange ActiveSync, not legacy IMAP/POP.

| Protocol | Port | Use |
|---|---|---|
| SMTP (submission) | 587 (STARTTLS) or 465 (SSL) | Sending mail |
| IMAP | 993 (SSL) | Reading mail, leaves it on server |
| POP3 | 995 (SSL) | Reading mail, downloads and removes |
| Exchange ActiveSync / MAPI over HTTPS | 443 | Native Outlook / mobile sync |

Mail flow in a tenant: MX record points to the cloud provider (`*.mail.protection.outlook.com` or `aspmx.l.google.com`). SPF, DKIM, and DMARC records in DNS authenticate outbound mail — without them your mail lands in junk folders.

Shared mailboxes (no license required up to 50 GB in Exchange Online) handle team aliases. Distribution lists fan out to multiple recipients. Resource mailboxes book conference rooms.

### Identity synchronization

The pivot point of the whole suite.

- **Cloud-only identity** — accounts created directly in Entra ID or Google Cloud Identity. Small shops, no on-prem AD.
- **Hybrid identity** — on-prem AD synced to the cloud via Entra Connect (Microsoft) or Google Cloud Directory Sync. User exists in both places, password hash synced, one credential.
- **Federated identity** — on-prem identity provider (ADFS, Okta, Ping) handles authentication via SAML; the cloud just trusts the assertion. Older deployments, mostly being replaced by password hash sync + conditional access.

SSO lets one identity unlock dozens of SaaS apps. MFA enforced at the identity layer covers all of them at once.

### Storage

OneDrive (personal user storage, typically 1 TB) and SharePoint (team/department storage) on the Microsoft side. Google Drive (My Drive for personal, Shared Drives for team) on the Google side.

The sync client (OneDrive sync, Drive for Desktop) mounts cloud storage as a folder on the local machine. **Files On-Demand** (Microsoft) and **Drive Streaming** (Google) show every file in the folder tree but only download contents when opened — saves disk space, requires connectivity to access untouched files. Known Folder Move redirects Desktop, Documents, and Pictures into OneDrive so a laptop reimage doesn't lose user data.

### Licensing assignment

Licenses are SKUs attached to user accounts. No license = no service. Common Microsoft 365 SKUs:

| SKU | Includes |
|---|---|
| Business Basic | Web/mobile Office, Exchange, OneDrive, Teams. No desktop apps. |
| Business Standard | Above + desktop Office apps |
| Business Premium | Above + Intune, Defender for Business, Entra ID P1 |
| E3 / E5 | Enterprise tiers, advanced compliance, ATP, analytics |

Assign via Microsoft 365 admin center → user → Licenses and apps. Group-based licensing (assign license to a security group, anyone added to the group inherits it) scales for hundreds of users. Removing a license revokes the service — mailbox enters a 30-day grace period, OneDrive data goes into retention.

**Sync/folder settings** are configured per-license or per-policy: which folders sync, whether Files On-Demand is enabled, whether the user can pause sync, whether external sharing is allowed. Admin controls these centrally via OneDrive admin center or Group Policy / Intune.

### Collaboration tools

Same building blocks across both suites.

| Function | Microsoft 365 | Google Workspace |
|---|---|---|
| Word processing | Word (desktop + web) | Docs |
| Spreadsheets | Excel | Sheets |
| Presentations | PowerPoint | Slides |
| Videoconferencing | Teams | Meet |
| Instant messaging | Teams chat | Chat |
| Email | Outlook / Exchange | Gmail |
| File storage | OneDrive / SharePoint | Drive |

Real-time co-authoring is the killer feature — multiple users in the same document simultaneously, presence indicators, comment threads, version history. The browser versions are stripped down; the desktop versions are full-featured. Most enterprise users get both.

### CompTIA exam traps

> **CompTIA exam trap:** Confusing OneDrive and SharePoint. OneDrive is the **user's personal** cloud storage (`OneDrive - Contoso`). SharePoint is **shared team storage** (sites, document libraries). Teams files actually live in SharePoint behind the scenes — every Team has a backing SharePoint site. The exam will ask where a Team's files are stored. Answer: SharePoint.

> **CompTIA exam trap:** Removing a license does NOT delete the mailbox or OneDrive data immediately. Exchange Online holds the mailbox for 30 days; OneDrive retains for 30 days by default (configurable). The exam tests "user left, what happens to their data" — the answer is grace period, not instant deletion.

> **CompTIA exam trap:** SSO and MFA are not the same thing. SSO is "one login unlocks many apps." MFA is "the login requires more than just a password." You can have one without the other. The exam will mix them up — read carefully.

## Helpdesk reality

- **"Outlook keeps asking me to sign in."** Token expired, conditional access policy triggered, or the mailbox got moved. Sign out of Office (File → Account → Sign Out), close all Office apps, sign back in. If that fails, clear cached credentials in Credential Manager.
- **"Word looks different / where did my toolbar go?"** They're in the browser version, not the desktop app. Walk them through opening the desktop Word from the Start menu. This conversation happens daily.
- **"I can't find my files on my new laptop."** Check if OneDrive sync is signed in and Known Folder Move completed. The files are usually fine — the sync client just hasn't finished pulling them down, or the user is looking in `C:\Users\...\Documents` instead of `C:\Users\...\OneDrive\Documents`.
- **"My license expired."** Check admin center. Either the subscription lapsed (finance problem) or someone removed the license assignment (provisioning problem). Reassign and tell the user to restart Office.
- **"Why is the company forcing MFA?"** Because credential phishing is the #1 attack vector and MFA stops 99% of it. Don't apologize for the policy. Set up the authenticator app with them and move on.

**The AI assist:** if a user sends a screenshot of an unfamiliar M365 admin error, paste it into Copilot or your company-approved tool and ask what the error code means. The AI does the recognition; you make the call. **Never paste user data, mailbox contents, or credentials into any AI tool that hasn't been security-approved.**

## Related concepts

[[Cloud Computing Concepts]] · [[Active Directory and Entra ID]] · [[Multifactor Authentication]] · [[Email Protocols]] · [[Single Sign-On]] · [[Mobile Device Management]] · [[Data Loss Prevention]] · [[File Sync and Backup]]

*Source: VIRGIL knowledge base — 2026-05-10*