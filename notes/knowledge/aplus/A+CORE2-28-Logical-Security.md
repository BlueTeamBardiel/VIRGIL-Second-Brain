# Logical Security

## What it is

Your house has a deadbolt, a Ring camera, and a dog. That's physical security — it stops a body from reaching the asset. Logical security is the second layer: even if someone walks past the dog and sits at your keyboard, they still can't open your password manager, decrypt your drive, or get into your bank without credentials they don't have.

In plain English: logical security is everything that gates access to data and systems through software — identities, permissions, authentication factors, policies, and the directory infrastructure that tracks who is allowed to do what.

Technically: logical security is the control plane that enforces authentication (proving who you are), authorization (deciding what you can do), and accountability (logging what you did) across all digital resources. It's enforced by the OS, the directory service, the identity provider, and the policies layered on top.

If physical security is the skin and skeleton, logical security is the immune system — it decides what gets recognized as self, what gets flagged as foreign, and what gets quarantined.

## Why it matters

Every breach you read about in the news is a logical security failure in a different costume. Phished credentials. Over-privileged service account. Forgotten admin account from a former employee. Misconfigured ACL on a public S3 bucket. The attacker rarely picks the lock — they walk in with a stolen badge.

For the exam, this is **220-1202 Objective 2.1**. CompTIA wants the vocabulary cold: MFA, SSO, SAML, PAM, IAM, ACLs, DLP, least privilege, zero trust, JIT. They love the distinction between authentication (who) and authorization (what), and between SSO (one login, many apps) and MFA (one login, many factors).

For your career, this is the language of every security conversation you'll have for the next twenty years. You will provision accounts, reset MFA, audit ACLs, and explain to a furious VP why his admin rights got revoked.

## In your build, in the enterprise

**Beat 1 — Technical depth.** Logical security stacks in layers. At the bottom: the directory service — Active Directory on-prem, Entra ID in the cloud — storing identities and group memberships. On top: an IAM system handling the lifecycle (provision, modify, deprovision). On top of that: authentication protocols — Kerberos for AD, SAML for federated web apps, OAuth/OIDC for modern cloud. Then authorization controls — ACLs, RBAC, and policies. Wrapped around the whole stack: MFA, conditional access, and logging. Privileged Access Management (PAM) is a separate vault for the keys to the kingdom — domain admin, root, break-glass accounts — that checks credentials out for limited windows and records everything.

**Beat 2 — Feynman example via your gaming rig.**

**Your Windows login:** Local account, password, maybe Windows Hello fingerprint. If someone gets your password they're in. *Single-user box, single layer.*

**Your Steam account:** Now you've added Steam Guard — a code to your phone or app. Password (something you know) plus phone (something you have). Same for Battle.net, Discord, Riot. *You already live the MFA model — you just don't call it that.*

**Your password manager:** Bitwarden or 1Password holds every credential. One master password unlocks the vault; the vault auto-fills the rest. *That's SSO at home — one strong authentication unlocks many downstream resources.*

**The kicker:** Your kid sister uses the same PC. You make her a Standard user, not Administrator. She plays Minecraft; she can't install sketchy mods that trigger UAC. *That's least privilege. You've been doing it since Windows XP without naming it.*

**Beat 3 — Bridge to enterprise.** At home you have one identity store. In the enterprise: Active Directory with 10,000 users, 50,000 groups, and forest trusts. At home MFA is Steam Guard. In the enterprise it's Microsoft Authenticator wrapped in conditional access policies that block logins from countries you don't operate in, require MFA on unmanaged devices, and silently allow it on a corporate laptop on the corporate network.

At home SSO is your password manager. In the enterprise SSO is SAML or OIDC — you log into Okta or Entra once and Salesforce, Workday, ServiceNow, GitHub, and forty other apps trust that login via signed assertions. At home "least privilege" is your sister's Standard account. In the enterprise it's a 200-page RBAC matrix, a PAM vault issuing domain admin for 60-minute windows with session recording, and a JIT system that grants production access only when a change ticket is open. At home an "ACL" is the NTFS permissions tab. In the enterprise ACLs live on file shares, firewalls, S3 buckets, database tables, and API gateways — audited quarterly because regulators care.

**Beat 4 — The point.** Same fundamental question — *who is this person, what are they allowed to touch, and how do I prove it later?* — different workloads, different right answers. *Get this question into your bones. You'll ask it every day for the rest of your career.*

## Key facts

### The authentication factors

| Factor | What it is | Examples |
|---|---|---|
| Something you **know** | A secret in your head | Password, PIN, security question |
| Something you **have** | A physical object | Smart card, key fob, hardware token, phone receiving SMS/push, authenticator app |
| Something you **are** | A biometric | Fingerprint, face, retina/iris, palm, voice |
| Somewhere you **are** | Location | GPS, IP geolocation, on-network vs off-network |
| Something you **do** | Behavior | Typing cadence, gait, mouse patterns |

**MFA** = two or more factors from *different* categories. Password + PIN is not MFA — both are "something you know." Password + authenticator app code *is* MFA.

### MFA delivery methods, ranked

| Method | Security | Notes |
|---|---|---|
| Hardware token (YubiKey, FIDO2) | Highest | Phishing-resistant, can't be intercepted |
| Authenticator app (TOTP) | High | 6-digit code every 30 seconds |
| Push notification | High | Vulnerable to MFA fatigue attacks |
| SMS / voice call | Low | SIM swap attacks — weakest MFA |
| Email OTP | Low | Only as strong as the email account |

### The acronym buffet

| Acronym | Meaning | What it does |
|---|---|---|
| **IAM** | Identity and Access Management | Umbrella for the identity lifecycle |
| **SSO** | Single Sign-On | One authentication, many downstream apps |
| **MFA** | Multi-Factor Authentication | Two+ factors from different categories |
| **SAML** | Security Assertion Markup Language | XML-based federated auth for enterprise SaaS |
| **PAM** | Privileged Access Management | Vault and gate for admin credentials |
| **ACL** | Access Control List | Per-resource list of who can do what |
| **MDM** | Mobile Device Management | Policy and control over phones/tablets/laptops |
| **DLP** | Data Loss Prevention | Watches for sensitive data leaving the org |
| **TOTP** | Time-based One-Time Password | The 6-digit code in your authenticator app |
| **FRT** | Facial Recognition Technology | Biometric face match |

### Core concepts

- **Least privilege** — every account gets the minimum permissions needed. The accountant doesn't need domain admin. The intern doesn't need the salary database.
- **Just-in-time (JIT) access** — privileges granted only when needed, for a limited window, then revoked. Dev needs prod for a deploy? 60 minutes, logged, gone.
- **Zero Trust** — "never trust, always verify." No implicit trust based on network location. Every request authenticates and authorizes independently. The opposite of "castle and moat."
- **PAM** — separate vault for admin credentials with check-in/check-out, session recording, and rotation.
- **Directory services** — Active Directory, Entra ID, LDAP. The phonebook of who exists and what groups they're in.
- **MDM** — Intune, Jamf, Workspace ONE. Enforces encryption, password policy, app whitelist, remote wipe, conditional access.
- **DLP** — Microsoft Purview, Forcepoint. Inspects outbound email, file uploads, and USB writes for sensitive data, then blocks or alerts.

### Consumer vs enterprise

| Layer | Home | Enterprise |
|---|---|---|
| Identity store | Local Windows accounts | AD + Entra ID with thousands of users |
| MFA | Steam Guard, bank app | Conditional access, FIDO2 hardware tokens for admins |
| SSO | Password manager autofill | SAML/OIDC federation across 40+ SaaS apps |
| Privileged access | UAC prompt | PAM vault, JIT elevation, session recording |
| Device control | Whatever you install | MDM-enforced encryption, app whitelist, remote wipe |
| Data leak prevention | Don't email your password | DLP scans every outbound email and upload |
| Policy enforcement | Honor system | Group Policy, Intune compliance, conditional access |

### CompTIA exam traps

> **CompTIA exam trap: SSO is not MFA.** SSO means one login unlocks many apps (convenience). MFA means one login requires multiple factors (security). Complementary, not interchangeable.

> **CompTIA exam trap: SMS MFA still counts as MFA.** Weakest form, but on the exam, password + SMS code is multi-factor. The question is whether two *different categories* are used.

> **CompTIA exam trap: Least privilege vs Zero Trust.** Least privilege is *how much* access each account gets. Zero Trust is *when* trust is granted — never implicitly, always re-verified.

> **CompTIA exam trap: Authentication vs authorization.** Authentication = proving who you are. Authorization = what you're allowed to do. The exam will swap these to trip you up.

## Helpdesk reality

- **"My MFA isn't working."** Nine times out of ten: phone time drifted, killing TOTP sync. Settings → Date & Time → enable automatic. Or they got a new phone and didn't migrate the authenticator. Reset their MFA enrollment after verifying identity through the approved channel — never just because they asked nicely on chat.
- **"I need admin rights to install this."** No. Submit a software request ticket. If legitimately needed, the change goes through approval and either you push it via Intune or grant temporary local admin via PAM. *Never hand out permanent admin — that's how breaches start.*
- **"Why am I locked out? I just typed it right."** Account lockout from too many bad attempts, usually because a cached credential on another device is retrying a stale password. Unlock in AD, find the source in the security event log.
- **"The shared folder won't open."** ACL mismatch. Check effective permissions, not just the share tab. Group membership changes don't take effect until they log out and back in (Kerberos ticket refresh).
- **"I got a push notification I didn't ask for."** MFA fatigue attack — someone has their password and is hammering the prompt hoping they'll tap approve. Force a password reset immediately, revoke active sessions, escalate to security.

## Related concepts

[[Physical Security]] · [[Active Directory]] · [[Authentication Methods]] · [[MFA Implementation]] · [[Password Best Practices]] · [[Group Policy]] · [[Account Management]] · [[BitLocker and Encryption]] · [[Mobile Device Management]] · [[Workstation Security Best Practices]]

*Source: VIRGIL knowledge base — 2026-05-10*