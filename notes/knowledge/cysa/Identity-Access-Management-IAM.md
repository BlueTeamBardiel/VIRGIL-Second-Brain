# Identity & Access Management (IAM)

## What it is

In **Valorant**, your Riot account is the whole identity. The account holds your rank, your skins, your match history, your friend list, your store credit. When you launch the client, Vanguard verifies the system, Riot's auth server checks your credentials, and only then does the agent select screen load — Jett, Omen, Cypher, whoever you've unlocked. Now imagine a smurf got your password. They don't just play one match. They queue ranked and tank your rating, they trade your knife skin to a burner, they get your main account banned for toxic comms you never sent. One credential, total ownership. *That's exactly what IAM controls in an enterprise — the single source of truth for who you are and what you can touch, which is also the single point of catastrophic failure if it falls.*

**Identity and Access Management (IAM)** is the framework of policies, processes, and technologies that govern digital identities and their access to resources. It answers two questions in sequence: **authentication** (who are you, prove it) and **authorization** (what are you allowed to do once I believe you). In modern architectures — cloud, hybrid, remote-first — IAM has replaced the network firewall as the primary security perimeter. The new rule: *identity is the perimeter.*

## Why it matters

Verizon's DBIR puts credential abuse in the top initial-access vector year after year. Phishing, password spray, MFA fatigue, OAuth consent abuse — these are not exotic attacks. They are Tuesday. When attackers don't need an exploit because they have a valid login, your EDR sees normal user behavior and your firewall sees authorized sessions. IAM failures are the cheapest, quietest breaches in the industry.

For the CySA+ exam, IAM threads through **Objective 1.1** (infrastructure and identity concepts the SOC must understand to detect attacks against them), **2.3** (vulnerability response — many remediations involve identity controls), and **3.0** (incident response — half of containment is revoking sessions and rotating credentials). Know the components, know the failure modes, know how they show up in logs.

## Key facts

### Authentication vs authorization vs accounting (AAA)

Three different things, easy to conflate, CompTIA will test it.

| Function | Question answered | Mechanism |
|---|---|---|
| **Authentication** | Who are you? | Passwords, MFA, biometrics, certs, tokens |
| **Authorization** | What can you do? | RBAC, ABAC, ACLs, group membership, policies |
| **Accounting** | What did you do? | Logs, audit trails, session records |

Accounting is what gets ingested into your [[SIEM]] and feeds detection. Without accounting, the other two are unverifiable.

### Authentication factors

- **Something you know** — password, PIN, security question
- **Something you have** — hardware token, smart card, phone (push or TOTP)
- **Something you are** — fingerprint, face, iris, voice
- **Somewhere you are** — geolocation, IP range
- **Something you do** — behavioral biometrics (typing cadence, mouse movement)

**Multifactor Authentication ([[MFA]])** requires two or more *different* categories. Two passwords is not MFA. Password + SMS is technically MFA but the SMS leg is weak — SIM swap, SS7 abuse, social engineering of the carrier. Push notification fatigue (attacker spams approval prompts until the user taps Accept just to make it stop) defeats poorly-configured MFA. **Number matching** and **FIDO2/WebAuthn** hardware keys are the current gold standard.

### Passwordless

Replaces the password entirely with cryptographic proof of possession plus a local biometric or PIN to unlock the key.

- **FIDO2 / WebAuthn** — hardware key (YubiKey) or platform authenticator (Windows Hello, Touch ID) holds a private key that signs an auth challenge. The server only ever sees public keys.
- **Phishing-resistant by design** — the key is bound to the origin domain. A lookalike site can't get a signature because the browser refuses to sign for the wrong origin.
- **Reduces credential theft surface** — no password to steal, no password to phish, no password to reuse.

### Single Sign-On ([[SSO]])

One authentication event grants access to many services through token exchange. Protocols: **SAML** (older, XML-based, common in enterprise SaaS), **OAuth 2.0** (authorization framework, often paired with), **OIDC** (OpenID Connect — modern authentication layer on top of OAuth 2.0, JSON-based).

Benefits: one strong credential to protect, centralized policy enforcement, fewer passwords for users to mishandle, clean offboarding (disable one account, lose all access).

Cost: **the failure domain expands**. Compromise the SSO identity and you compromise everything federated to it. *Golden SAML attacks against ADFS taught the industry that the SSO signing key is now a crown jewel — Solorigate used exactly this pivot.*

### Federation

Trust relationship between identity providers (IdPs) across organizational boundaries. Your vendor's employees authenticate against their IdP, you trust the assertion, they access your portal without ever having a credential in your directory.

- **IdP** (Identity Provider) — issues the assertion (Okta, Azure AD/Entra ID, Ping, ADFS)
- **SP** (Service Provider) — consumes the assertion (Salesforce, AWS, your custom app)
- **Assertion** — signed token containing identity claims (SAML response, JWT)

Federation enables B2B integrations without provisioning external accounts. It also means a breach at the IdP cascades to every SP that trusts it.

### Privileged Access Management ([[PAM]])

Admins, service accounts, domain controllers, root, break-glass accounts — the high-value targets. PAM is the discipline of treating these credentials as radioactive material: locked in a vault, checked out for a defined window, audited every keystroke, rotated after use.

| Capability | What it does |
|---|---|
| **Credential vault** | Stores privileged passwords/keys encrypted, never exposes them to humans |
| **Session brokering** | Admin connects through PAM proxy; raw credential never touches the workstation |
| **Just-in-time (JIT) access** | Permissions granted for a time window, then revoked automatically |
| **Session recording** | Full video/keystroke capture of every privileged session for forensic replay |
| **Credential rotation** | Auto-rotates passwords/keys after each use or on schedule |

Vendors: CyberArk, BeyondTrust, Delinea (formerly Thycotic), HashiCorp Vault for secrets. On-prem PAM lives in a hardened tier-0 environment; cloud-native PAM integrates with the cloud IAM provider's privileged identity features (Azure PIM, AWS IAM Identity Center).

### Authorization models

- **RBAC** (Role-Based) — permissions attached to roles, users assigned to roles. "Helpdesk role can reset passwords." Simple, common, scales poorly when roles multiply.
- **ABAC** (Attribute-Based) — permissions evaluated against attributes of user, resource, environment. "Engineers in EU, on managed devices, during business hours, can read EU customer data." Powerful, complex to debug.
- **Least privilege** — the default. Grant the minimum required to do the job. Everything else denied.
- **Zero standing privilege** — nobody is admin by default; admin rights are requested, approved, time-boxed.

### Identity lifecycle

Joiner — Mover — Leaver. Every identity has a lifecycle, and **the leaver step is where breaches start**. Dormant accounts, stale service principals, contractor access that outlived the contract, ex-employees who kept their personal device synced.

- **Onboarding** — provision identity, assign baseline access, enroll MFA
- **Role change** — re-evaluate access, *remove old entitlements* (this is the step everyone skips, producing access creep)
- **Offboarding** — disable account, revoke sessions, rotate any shared secrets they knew, audit access in last 30 days

### IAM in the cloud and hybrid world

- **Cloud-native IAM** — AWS IAM, Entra ID, GCP IAM. Roles, policies, service accounts, conditional access.
- **Hybrid** — on-prem AD synced to cloud IdP (Entra Connect / AD Connect). The sync engine itself becomes a tier-0 asset.
- **CASB** ([[Cloud Access Security Broker]]) — sits between users and cloud apps, enforces IAM policy across SaaS that doesn't natively integrate.
- **[[Zero Trust]]** — IAM is the foundation. Every request authenticated, authorized, encrypted, regardless of network position. "Never trust, always verify."

### CompTIA exam traps

> **CompTIA exam trap:** MFA categories. Two factors from the **same** category is *not* MFA. Password + security question = both "something you know" = single-factor with extra steps. The right answer is always two *different* categories.

> **CompTIA exam trap:** SSO vs federation vs SAML. SSO is the user experience (one login, many apps). Federation is the trust relationship (cross-organization). SAML is the protocol that often implements both. CompTIA will offer all three as answers and the correct one depends on the question's framing.

> **CompTIA exam trap:** Authentication vs authorization. If the question asks who someone is, it's authentication. If it asks what they can do *after* logging in, it's authorization. The word "access" in IAM often points to authorization, not authentication.

> **CompTIA exam trap:** PAM vs IAM. IAM is the umbrella covering all identities. PAM is the subset specifically for privileged identities. Every PAM control is an IAM control; not every IAM control is PAM.

## SOC reality

- **The alert at 3am**: "Impossible travel — user logged in from Dallas at 02:47 and Bucharest at 03:01." Your move: pull the sign-in logs from Entra/Okta, check the device IDs, check the IP reputation, check if a token was replayed vs a fresh auth. If both legs hit the same IdP and one bypassed MFA — that's a session token theft, not a password compromise. Different IR path.
- **The MFA fatigue alert**: 47 push prompts denied, then one accepted, then a new device registered three minutes later. Containment: revoke all sessions for that user (`Revoke-MgUserSignInSession` or the Okta equivalent), force password reset, re-enroll MFA on a known good device, hunt for any OAuth app consents granted in the last 24 hours.
- **The CISO question**: "Did the attacker get domain admin?" Pull the privileged role assignments, check PAM session logs for any check-outs outside normal patterns, check for new accounts created or group memberships modified. *"We don't see evidence of escalation"* is honest; *"they didn't escalate"* is a promise you can't keep without forensic confirmation.
- **Never promise leadership** that an account is "secure" after a single password reset. Tokens persist. Refresh tokens persist. App passwords persist. OAuth grants persist. Containment is *revoke all the things*, not just rotate the password.
- **The handoff**: L1 confirms the IoC and disables the account → L2 hunts for blast radius (lateral movement, data access, persistence) → IR lead decides on full credential rotation and notifies legal if the account touched regulated data → identity team rebuilds the user with clean factors.

## Related concepts

[[MFA]] · [[SSO]] · [[PAM]] · [[Zero Trust]] · [[Cloud Access Security Broker]] · [[SASE]] · [[PKI]] · [[Federation]] · [[Conditional Access]] · [[Least Privilege]] · [[Network Segmentation]] · [[SIEM]] · [[Log Ingestion]] · [[Account Compromise]] · [[Phishing]] · [[Golden SAML]] · [[OAuth Consent Abuse]] · [[Active Directory]]

*Source: VIRGIL knowledge base — 2026-05-11*