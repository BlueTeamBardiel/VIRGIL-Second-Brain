# New Account Creation

## What it is

In **Bloodborne**, the hunter you killed at the Forbidden Woods doesn't stay dead. Kill enough NPCs and the Bloody Crow of Cainhurst, or Yurie, or some other invader you didn't invite into your campaign will walk into your dream and start hunting you in zones you already cleared. The map looks the same. The lanterns are lit. But there's a new hunter in the world now, and they have a weapon and a covenant and an agenda. That's exactly what a malicious new account does — *the threat actor plants a fresh identity inside your trusted environment so they can keep walking through the door after you patch the one they came in through.*

Technical definition: **Introduction of new accounts** is a CS0-003 Objective 1.2 indicator of potentially malicious activity, classified as **application-related**. It's the creation of local, domain, cloud, service, or application-layer identities by an actor whose goal is persistence, privilege staging, or evasion of identity-based detection. The account itself is the artifact; the creation event is the IoC.

CompTIA puts this in the application-related bucket because the creation almost always happens through an application interface — Active Directory, Azure AD/Entra ID, IAM consoles, SaaS admin portals, the SQL `CREATE USER` statement, the local `net user /add` call. The OS doesn't make accounts; applications do.

## Why it matters

Persistence is the whole game post-compromise. The initial access vector — the phished credential, the unpatched CVE, the exposed RDP — gets closed. The patch lands. The phished user resets their password. If the attacker only had that one foothold, they're out. But if they spent ten minutes after initial access creating `svc_backup_helper` in the Domain Admins group, they're still in tomorrow, next month, and the day after you finished the IR report.

The MITRE ATT&CK framework calls this **T1136 — Create Account**, with sub-techniques for local (T1136.001), domain (T1136.002), and cloud (T1136.003). It sits in the Persistence tactic, which is where the attacker stops being a guest and starts being a tenant.

For the exam: Objective 1.2 names it explicitly. Expect a scenario with a SIEM alert, a list of indicators, and a question asking you to identify which one suggests an attacker establishing persistence versus one that suggests initial access or exfiltration. New accounts are the persistence answer almost every time.

## Key facts

### Where accounts get created (and where to watch)

| Layer | Creation surface | Primary log source |
|---|---|---|
| Local OS (Windows) | `net user /add`, `New-LocalUser`, lusrmgr.msc | Security Event ID **4720** |
| Active Directory | `New-ADUser`, ADUC, dsadd | Security Event ID **4720** (DC), **4728/4732/4756** (group adds) |
| Azure AD / Entra ID | Graph API, portal, AAD Connect | Azure AD audit log — "Add user" |
| AWS IAM | `CreateUser`, `CreateAccessKey` | CloudTrail |
| Linux | `useradd`, `adduser`, direct `/etc/passwd` edit | `/var/log/auth.log`, `/var/log/secure`, auditd |
| Database | `CREATE USER`, `CREATE LOGIN` | DB audit log |
| SaaS apps | Admin console, SCIM provisioning, API | App-specific audit log |

The lesson buried in this table: **new account creation is a multi-source IoC**. If you're only watching Windows Event 4720, you're missing the cloud and SaaS surface entirely. Modern attackers prefer cloud account creation because half of SOCs aren't watching it.

### What "suspicious" looks like

A normal new account event has context — a ticket, an HR onboarding workflow, a manager's approval, a sane creation time, a service catalog entry. A malicious one has none of these. The signals:

- **Off-hours creation.** Account created at 02:47 local time on a Saturday. HR doesn't onboard at 02:47.
- **Created by a workstation, not a provisioning system.** Legitimate accounts come from HRIS → IAM → AD. Malicious ones come from `WKSTN-FINANCE-04` running a PowerShell one-liner.
- **Created by a compromised admin.** The creating principal is a domain admin who hasn't touched user management in eight months.
- **Naming that mimics service accounts.** `svc_update`, `svc_backup2`, `svc_helpdesk_temp`, `iisadmin$`, `MSOL_xxxxx` (the AAD Connect mimic). Trailing `$` to look like a computer account. Cyrillic lookalikes — `аdmin` with a Cyrillic *а*.
- **Bulk creation.** Five accounts in ninety seconds, none in the ticket queue.
- **Immediate privilege assignment.** Account is created and within minutes added to Domain Admins, Enterprise Admins, or a sensitive role group (Event ID 4728/4732/4756 chained after 4720).
- **Created and never used by a human.** No interactive logon ever follows — only API calls, scheduled tasks, or service ticket requests. Suggests the account exists purely for automation/persistence.
- **Created in a directory the attacker just compromised.** AAD Connect server, jump host, or a DC the IR team just flagged.

### Cloud-specific patterns

Cloud is the new persistence playground. The patterns to know:

- **IAM user with programmatic access keys** created in AWS, no console password, immediate `sts:AssumeRole` activity from a foreign IP.
- **Azure AD guest invitation** to an attacker-controlled email, followed by role assignment.
- **Service principal / app registration** created with `Directory.ReadWrite.All` or similar Graph permissions. Service principals don't get MFA prompts.
- **AAD Connect sync account abuse** — attackers create on-prem accounts that get synced to cloud, inheriting trust.
- **OAuth consent grants** — adversary tricks a user into consenting to a malicious app; no new "user" account, but a new *identity* with API access. Same persistence outcome.

### Persistence patterns that pair with new accounts

New accounts rarely travel alone. The IR timeline usually shows:

1. Initial access (phish, RCE, exposed service)
2. Privilege escalation (token theft, kerberoasting, UAC bypass)
3. **Account creation (the IoC we're studying)**
4. Group membership change (the new account gets privileges)
5. Backdoor configuration (the new account is added to RDP-allow, granted SSH key, given a SaaS API token)
6. Quiet for days or weeks
7. Re-entry through the new account

When you see step 3, immediately hunt for steps 4–7. The account creation is the loose thread; pull it.

### CompTIA exam traps

> **CompTIA exam trap:** New account creation is classified as **application-related**, not host-related. Test writers will offer "host-related" as a plausible distractor because account creation happens *on* a host. The creation surface is an application (AD, IAM, the OS user-management subsystem treated as an app), so it belongs in the application bucket. Memorize the category, not the intuition.

> **CompTIA exam trap:** Don't confuse **new account creation** (persistence — T1136) with **unauthorized privileges** (privilege escalation — T1078, T1068). A new account being created is a different IoC than an existing account suddenly being added to Domain Admins. The exam will pair them in a scenario and ask which technique is shown. Account *creation* → persistence. Account *elevation* → privilege escalation. Both can happen in the same intrusion; the question is which IoC the scenario emphasizes.

> **CompTIA exam trap:** **Service accounts** are not exempt from this control. Candidates assume "service account = legitimate." Attackers love to create accounts named `svc_*` precisely because of that bias. If the question describes a service account created outside the normal provisioning workflow, it's still a malicious new-account IoC.

### Detection logic that actually works

The SIEM rule isn't `EventID = 4720`. That fires on every new hire. The rule is:

```
EventID = 4720
AND CreatingPrincipal NOT IN (HR_provisioning_service_accounts)
AND (CreationTime outside business hours
     OR CreatedAccount added to PrivilegedGroups within 1 hour
     OR CreatingHost NOT IN (approved_IAM_servers))
```

Layered conditions. The base event is too noisy alone; the *context* is the alert. This is the same logic as a Bloodborne anti-cheat heuristic — the action isn't suspicious, the *combination* is.

## SOC reality

- The 4720 alert at 03:14 reads: *"User account `helpdesk_tmp2` created on the primary DC by `j.smith` (Domain Admin) from workstation `WKSTN-MKTG-19`."* Three things wrong with that sentence. Marketing workstation, off-hours, domain admin who doesn't do user management. That's a P1 in any sane SOC.
- L1's first move: pivot. Pull every action by `j.smith` in the last 24 hours. Pull every process on `WKSTN-MKTG-19`. Pull every authentication for the new account `helpdesk_tmp2`. Don't disable the account yet — you'll tip the attacker.
- The IR lead asks two questions: *"Is the creating account compromised, or is it the attacker logged in as a real admin?"* and *"What else did they create?"* Persistence rarely comes alone — check scheduled tasks, services, registry Run keys, and other directories for sibling accounts.
- Never promise leadership *"we removed the backdoor account, we're clean."* You removed *one* backdoor. Until forensics confirms the full timeline, assume there are more accounts, more keys, more tokens. *The first new account you find is rarely the only one — attackers stage redundancy because they expect you to find the first one.*
- Escalation path: L1 confirms the IoC and pivots → L2 contains the creating principal and isolates the workstation → IR team runs full timeline reconstruction and hunts for siblings → identity team forces credential rotation on the suspect admin and reviews privileged group memberships across the forest.

## Related concepts

[[Persistence Mechanisms]] · [[Privilege Escalation]] · [[MITRE ATT&CK T1136]] · [[Active Directory Security]] · [[Azure AD Audit Logs]] · [[IAM Security]] · [[Service Accounts]] · [[Windows Security Event IDs]] · [[Unauthorized Privileges]] · [[Indicators of Compromise]] · [[Kerberoasting]] · [[Golden Ticket Attack]] · [[Cloud Persistence]] · [[OAuth Consent Phishing]] · [[SIEM Correlation Rules]]

*Source: VIRGIL knowledge base — 2026-05-11*