# PAM — Privileged Access Management

## What it is

In **Mass Effect 2**, Shepard doesn't get to walk into the AI core, the armory, and the comm room with the same keycard. The Normandy SR-2 has compartmentalized access — EDI runs the ship-wide systems, but locked subsystems require explicit authorization, and the loyalty missions exist partly because Cerberus won't hand a squadmate the keys to sensitive systems until trust is established. When you fly to the Collector Base through the Omega-4 Relay, the suicide mission only works because you assign the right specialist to each role for a limited window — tech expert at the vents, biotic at the seeker swarm, loyal soldier on the second fireteam. Wrong assignment, wrong duration, wrong privilege — somebody dies.

That's exactly what PAM does — it stops anyone from holding the master keycard to the whole ship, and it forces every elevated action to be a short, justified, logged checkout instead of a permanent grant.

**Privileged Access Management** is the discipline and tooling that controls accounts with elevated rights — domain admins, root, service accounts, break-glass emergency accounts, cloud root users, hypervisor admins, database `sa` accounts. PAM enforces credential vaulting, just-in-time (JIT) elevation, session recording, approval workflows, and automated credential rotation across the full lifecycle of a privileged identity.

It is not the same as [[IAM]]. IAM is who-gets-in-the-door for everyone. PAM is the locked safe inside the building where the master keys live, with a camera pointed at the safe, a logbook on every checkout, and a rule that no key leaves the room overnight.

## Why it matters

Almost every published breach report you read — Mandiant M-Trends, Verizon DBIR, CISA advisories — ends with the same paragraph: the attacker got a foothold on a low-value endpoint, found cached privileged credentials, and pivoted. Privilege escalation is the bridge between "interesting alert" and "board-level incident." Kill the bridge, kill most of the catastrophic outcomes.

For CS0-003, PAM sits inside **Objective 1.1** as a system architecture control that shapes how the SOC investigates and contains incidents. If PAM is deployed correctly, the IR team has session recordings, JIT approval logs, and a vault audit trail to reconstruct what an attacker did with stolen admin rights. If PAM is missing, the IR team has Kerberos tickets, event ID 4624 with type 10, and prayer.

Career relevance: every SOC L2+ role expects you to know what a PAM vault looks like in logs, how to spot suspicious checkouts, and how privileged session monitoring feeds the [[SIEM]].

## Key facts

### What PAM actually controls

PAM scope is broader than "domain admin accounts." A complete PAM program covers:

| Account type | Examples | Why it's dangerous |
|---|---|---|
| **Human admin** | Domain Admin, Enterprise Admin, root, sudoers | Full control, used daily, often cached on endpoints |
| **Service accounts** | SQL service account, IIS app pool, scheduled tasks | Rarely rotated, hard-coded in scripts, broad rights |
| **Break-glass** | Emergency root, cloud root user, AD recovery | Used once a year, often forgotten, often unmonitored |
| **Application/API** | App-to-DB credentials, API keys, OAuth client secrets | Hard-coded in repos, leaked to GitHub weekly |
| **Cloud privileged** | AWS root, Azure Global Admin, GCP Organization Admin | One credential, one tenant, total compromise |
| **Infrastructure** | ESXi root, switch enable password, firewall admin | Often local accounts, unmonitored, default creds |

### The three problems PAM solves

**Privilege creep.** Users accumulate rights across roles, projects, departments. The intern who became a sysadmin who became a manager still has all three role sets. PAM enforces periodic access reviews and revocation.

**Hard-coded credentials.** Developers embed passwords in scripts, config files, container images. PAM replaces these with API-based secret retrieval — the app asks the vault at runtime, gets a short-lived credential, never stores it.

**Over-provisioning.** Standing admin rights 24/7 when the user needs them ten minutes a week. PAM enforces **just-in-time elevation** — request, approve, elevate for a window, auto-revoke.

### Core PAM capabilities

- **Credential vault** — encrypted store, no plaintext, no human eyes on the actual password. Think 1Password but for the entire enterprise privileged inventory.
- **Password rotation** — vault changes the credential after every checkout, or on a schedule (every 24h, every 7 days). Stops pass-the-hash and credential reuse cold.
- **Session brokering** — the admin doesn't get the password; the vault opens an RDP/SSH session on their behalf and proxies it. Credentials never touch the endpoint.
- **Session recording** — every keystroke, every command, every mouse click logged. Replayable for IR, audit, dispute resolution.
- **JIT elevation** — request elevation with justification, approver clicks yes, rights granted for 60 minutes, auto-revoked. No standing admin.
- **Approval workflows** — high-risk actions (domain admin checkout, prod DB access) require manager or peer approval before the vault releases the credential.
- **Discovery** — automated scanning to find privileged accounts and orphaned service accounts the security team didn't know existed.

### Deployment models

| Model | Where it lives | Trade-off |
|---|---|---|
| **On-premises** | Self-hosted vault, customer-managed HSMs | Full control, full operational burden |
| **Cloud** | Vendor-hosted SaaS PAM | Fast deploy, vendor holds the keys to the kingdom |
| **Hybrid** | On-prem vault, cloud-managed control plane | Common in regulated industries |

### How PAM connects to the rest of Domain 1.0

PAM doesn't live in isolation. It chains into:

- [[Zero trust]] — never trust, always verify, every privileged action re-authenticated
- [[MFA]] — PAM vault checkout requires step-up auth, not just password
- [[SSO]] / [[Federation]] — admin logs in once to the vault via SAML, gets brokered into target systems
- [[SIEM]] — every checkout, every session, every approval streams as logs
- [[Network segmentation]] — privileged session jump boxes sit in a hardened admin VLAN
- [[CASB]] / [[SASE]] — cloud-side PAM enforcement for SaaS admin consoles
- [[Passwordless]] — modern PAM uses certificate-based or FIDO2 auth, not passwords at all

### Passwordless and PAM

The endgame is no human-typed passwords for privileged access. The admin authenticates with a FIDO2 token or certificate ([[PKI]]) to the PAM vault, the vault brokers a session, the session uses Kerberos or a short-lived certificate, the admin never sees a password. Phishing-resistant by design.

### CompTIA exam traps

> **CompTIA exam trap:** PAM vs IAM. IAM governs identity lifecycle for *everyone* — provisioning, authentication, role assignment. PAM is a specialized layer for *privileged* identities only, focused on session control, vaulting, and JIT elevation. CompTIA will give you a scenario about controlling domain admin access and offer "IAM" as a tempting answer. PAM is the precise answer when the question mentions privileged accounts, vaulting, session recording, or just-in-time.

> **CompTIA exam trap:** PAM ≠ MFA. MFA is an authentication factor. PAM is a control framework that *uses* MFA among many other things. A question mentioning "rotate admin credentials after every use and record sessions" is PAM, not MFA.

> **CompTIA exam trap:** Break-glass accounts are a PAM concept CompTIA loves. They are intentionally exempt from normal MFA/SSO so they work when those systems fail. The trade-off is they must be vaulted with split-knowledge, alerted on every use, and tested quarterly. "Why is the emergency account not protected by MFA?" is the trap — the answer is because MFA might be the thing that's broken.

> **CompTIA exam trap:** Service accounts. CompTIA will test that service accounts should be *non-interactive*, have *no human owner sharing the password*, and be rotated by the PAM platform. A service account with a human-known password is the worst of both worlds.

## SOC reality

- **The alert at 3am:** PAM vault checkout for `da-emergency` outside business hours, from a workstation that's never checked it out before. L1 acknowledges, pulls the session recording, sees the admin typing `net group "Domain Admins" attacker /add`. That's not the admin. Containment call goes out at 03:11.
- **What L1 actually does first:** open the PAM dashboard, filter by checkouts in the last hour, sort by risk score. PAM platforms (CyberArk, BeyondTrust, Delinea, HashiCorp Vault) all expose this as a single pane. Cross-reference against [[SIEM]] events 4624 logon type 10 and 4672 special privileges assigned.
- **What the IR lead asks:** "Do we have session recording on that checkout? Pull the video. What did they touch? Did they create any persistence — new accounts, scheduled tasks, registry run keys?" If PAM session recording is on, you have a literal screen recording. If it's not, you're reconstructing from [[Windows Registry]] artifacts and process telemetry.
- **What never to promise leadership:** "The attacker didn't escalate." You don't know that until you've audited every privileged checkout, every service account login, every cached credential on every endpoint the attacker touched, and every cloud admin API call. PAM logs narrow the search; they don't eliminate it.
- **The handoff:** L1 confirms suspicious checkout → L2 pulls session recording and SIEM correlation → IR lead calls containment (disable account, rotate all credentials checked out by that admin in the last 30 days, force re-auth on every active privileged session) → identity team rotates the credential vault master keys if the vault itself is suspected → legal gets the recording for chain of custody.

*The fastest way to lose an incident is to find out the attacker had standing domain admin rights for six months because nobody enforced JIT. The fastest way to win one is to find a PAM session recording that shows every command the attacker ran, in order, with timestamps.*

## Related concepts

[[IAM]] · [[MFA]] · [[SSO]] · [[Federation]] · [[Zero trust]] · [[Passwordless]] · [[PKI]] · [[SIEM]] · [[Log ingestion]] · [[Network segmentation]] · [[CASB]] · [[SASE]] · [[System hardening]] · [[Windows Registry]] · [[Encryption]] · [[Cyber Kill Chain]] · [[MITRE ATT&CK]] · [[Privilege escalation]] · [[Lateral movement]] · [[Service accounts]] · [[Break-glass accounts]]

*Source: VIRGIL knowledge base — 2026-05-11*