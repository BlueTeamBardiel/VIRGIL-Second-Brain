# SaaS — Software as a Service

## What it is

In **Assassin's Creed**, Desmond Miles climbs into the Animus and runs his ancestor's memories. He doesn't own the machine, doesn't maintain the genetic database, doesn't patch the firmware — Abstergo (and later the Assassins) run all of that. Desmond just logs in, lives Ezio's life for eight hours, and logs out. The Animus is somebody else's hardware, somebody else's software, somebody else's problem. He's a tenant in a memory-rental service. That's exactly what SaaS does — you consume an application over the network and the vendor owns everything underneath it.

Plain English: SaaS means you rent the app. You don't install it, you don't patch it, you don't run the server. You log in through a browser or thin client, you pay per seat or per usage, and the provider handles the OS, the database, the load balancer, the storage, the backups, and the uptime SLA.

Technical CS0-003 definition: **Software as a Service** is a cloud service model where the [[Cloud Service Provider]] (CSP) delivers a fully managed application stack to the consumer over the internet. The CSP manages the application, runtime, middleware, OS, virtualization, servers, storage, and networking. The consumer manages identity, data, access policies, and configuration within the app. Examples: Microsoft 365, Salesforce, Google Workspace, Okta, ServiceNow, Slack.

Sits alongside [[IaaS]] (you manage OS up) and [[PaaS]] (you manage app up) in the shared responsibility stack. SaaS is the model where the customer surface is smallest — and the customer's blind spot is largest.

## Why it matters

**CS0-003 Objective 1.1** explicitly tests cloud architecture concepts — SaaS, IaaS, PaaS, hybrid, serverless — because SOC analysts now spend more of their day pulling SaaS audit logs than reading firewall denies. Your CEO's email lives in Microsoft 365. Your sales pipeline lives in Salesforce. Your engineering tickets live in Jira Cloud. Your HR records — including PII and sometimes CHD — live in Workday. If you can't ingest, correlate, and alert on SaaS logs, you are blind to roughly 70% of where the business actually operates.

The breach pattern is consistent: attacker phishes a credential, logs into the SaaS tenant from a residential proxy in a country the user has never visited, exfiltrates a SharePoint library or a Salesforce report, and leaves. No malware on an endpoint. No EDR alert. Just OAuth tokens and API calls. If you only watch endpoints and firewalls, you watched the wrong door.

## Key facts

### Shared responsibility model

| Layer | IaaS | PaaS | SaaS |
|---|---|---|---|
| Data & access | Customer | Customer | **Customer** |
| Application | Customer | Customer | Provider |
| Runtime / middleware | Customer | Provider | Provider |
| OS | Customer | Provider | Provider |
| Virtualization / hypervisor | Provider | Provider | Provider |
| Physical / network | Provider | Provider | Provider |

In SaaS the customer owns **identity, data classification, access policy, and tenant configuration**. Everything else is the vendor's. This is non-negotiable and frequently misunderstood by leadership who think "the cloud is secure" means "I have no job to do."

### Log ingestion from SaaS

The vendor is the only source of truth for what happened in their app. You don't have packet capture, you don't have host logs — you have the API they expose. Pull the audit log, ship it to [[SIEM]], correlate.

- **Microsoft 365** → Unified Audit Log via Graph API or Office 365 Management Activity API
- **Google Workspace** → Reports API / Admin SDK
- **Salesforce** → Event Monitoring (paid add-on; this matters)
- **Okta** → System Log API
- **AWS-managed SaaS-like services** → CloudTrail

Each vendor logs at a different **logging level**. Some give you full API call detail, some give you summarized events, some charge extra for the verbose tier. Tune your ingestion to capture: authentication events, MFA challenges, admin role changes, OAuth app grants, mailbox rule creation, file sharing changes, and bulk downloads.

**Time synchronization** matters here. SaaS logs arrive in UTC, your on-prem [[SIEM]] may normalize to local, your endpoints might drift. Correlate on UTC, store on UTC, display whatever the analyst wants. A 15-second clock skew across sources will scatter a beacon pattern across your timeline and you'll never see it.

### Identity is the new perimeter

There is no network perimeter around SaaS. The login page is on the internet. The perimeter is **identity**.

- **[[IAM]]** — every SaaS tenant needs role-based access, least privilege, regular access reviews
- **[[SSO]]** — federate every SaaS app to one IdP (Okta, Entra ID, Ping). One identity, one offboarding path. If HR offboards a user and the IdP propagates, the SaaS access dies with it.
- **[[Federation]]** — SAML 2.0 or OIDC between the IdP and the SaaS vendor. The SaaS app trusts assertions from your IdP. Don't let users create local accounts in the SaaS tenant that bypass the IdP — those become the orphaned doors the attacker walks through.
- **[[MFA]]** — mandatory on every SaaS account, especially admins. Phishing-resistant factors (FIDO2, WebAuthn) beat SMS and push.
- **[[Passwordless]]** — FIDO2 keys, platform authenticators, certificate-based auth. Closes the credential-phishing path entirely for the accounts that adopt it.
- **[[PAM]]** — privileged SaaS admin accounts (Global Admin in M365, System Administrator in Salesforce) live in a vault, require check-out, session-recorded. Treat the M365 Global Admin like the [[Domain Admin]] of your tenant.

### CASB — the choke point you need

A **[[Cloud Access Security Broker]]** sits between your users and the SaaS apps. Four pillars: visibility, compliance, data security, threat protection.

- **API-based CASB** — connects directly to the SaaS vendor's API, sees everything in the tenant (sanctioned apps, after the fact)
- **Proxy-based CASB** — sits inline, can block in real time, but only sees traffic routed through it (good for sanctioned apps, weak for shadow IT)

CASB is where you enforce [[DLP]] on SaaS — block uploads of [[CHD]], detect [[PII]] in shared SharePoint links, alert when someone shares a customer list externally. Pair with [[SASE]] for branch and remote users so the proxy follows the user, not the office.

### Zero Trust applied to SaaS

[[Zero Trust]] says never trust, always verify, assume breach. For SaaS:

- Every API call authenticated and authorized (no implicit tenant trust)
- Conditional access policies — block logins from anonymizers, require compliant device, require MFA on every session for sensitive apps
- Continuous evaluation — token gets revoked mid-session if risk score spikes
- Microsegmentation of admin roles — no single account holds the keys to every SaaS tenant

### Encryption and key management

Data in transit: **[[TLS]]** 1.2 minimum, 1.3 preferred. ([[SSL]] is dead — if a vendor still says "SSL," they mean TLS, but flag it.) Validate certificates via [[PKI]] — the SaaS vendor's cert chain must be trusted and current.

Data at rest: vendor-managed keys by default. For sensitive workloads ([[CHD]], regulated [[PII]], healthcare data) demand **Bring Your Own Key (BYOK)** or **Hold Your Own Key (HYOK)** so the vendor cannot decrypt without your KMS cooperating. This is the difference between a subpoena hitting them vs hitting you.

### CompTIA exam traps

> **CompTIA exam trap:** SaaS does **not** absolve the customer of data protection responsibility. The vendor secures the infrastructure; you secure the identity, data, and configuration. "We use SaaS so we're compliant" is the wrong answer — you are still on the hook for [[PII]], [[CHD]], and regulatory reporting under GDPR, HIPAA, PCI DSS, and CIRCIA.

> **CompTIA exam trap:** SaaS, PaaS, IaaS responsibility order — customer responsibility *increases* as you move from SaaS → PaaS → IaaS. In SaaS you only own data/identity; in IaaS you own everything above the hypervisor. CompTIA will give you a scenario and ask "who patches the OS?" — in SaaS it's the provider, in IaaS it's you.

> **CompTIA exam trap:** [[CASB]] vs [[SASE]] vs [[SWG]]. CASB = cloud app visibility and control. SASE = converged network + security at the edge (combines SWG, CASB, ZTNA, FWaaS). SWG = web proxy. CompTIA loves to ask which one handles shadow IT (CASB), which one replaces MPLS (SASE), which one filters URLs (SWG).

> **CompTIA exam trap:** SSO does **not** equal MFA. SSO is one credential across many apps; MFA is multiple factors for one auth event. You want both. CompTIA will offer "SSO" as a defense against credential phishing — wrong. SSO without MFA actually *amplifies* a phish because one stolen credential opens every federated app.

### What you don't get with SaaS

- No OS-level telemetry. You can't run [[EDR]] inside Microsoft's datacenter.
- No network capture. You can't sniff Salesforce's east-west traffic.
- No [[Windows Registry]] artifacts, no [[file structure]] forensics on the SaaS host, no process tree.
- Limited forensic acquisition — you get whatever logs the vendor retained for whatever window they retained them. Default M365 audit retention is 180 days for E5, 90 days for lower tiers. **Check this before the incident, not during.**

## SOC reality

- The 3am alert is **"impossible travel"** — user logged into M365 from Chicago at 02:14 and from Lagos at 02:31. L1 acknowledges, pulls the [[Okta]] system log and the M365 Unified Audit Log, checks for inbox rules created (classic BEC tell), checks for OAuth app grants, checks for mass file downloads from OneDrive/SharePoint.
- L1's first action: disable the account in the IdP (this cascades through SSO), revoke active sessions, revoke refresh tokens. Do **not** just reset the password — the attacker's session token survives a password reset.
- The IR lead asks: "What did they access? What did they exfiltrate? Did they create persistence (forwarding rule, OAuth app, new admin)? Is this one user or twenty?"
- Never tell leadership "it's contained" until you've revoked tokens, reviewed OAuth grants, audited mailbox rules, and confirmed no admin role changes. SaaS persistence hides in places endpoint people don't think to look.
- Escalation path: L1 triage → L2 investigates audit logs and CASB alerts → IR lead scopes blast radius → legal evaluates breach notification timers (GDPR 72h, CIRCIA, state laws) → comms drafts the customer notice if [[PII]] or [[CHD]] left the tenant.

*The SaaS tenant is not your network, but the data inside it is still your problem. The vendor logs are not your logs, but they're all you have — ingest them, correlate them, retain them, or accept that you will investigate breaches with one eye closed.*

## Related concepts

[[IaaS]] · [[PaaS]] · [[Serverless]] · [[Hybrid Cloud]] · [[CASB]] · [[SASE]] · [[SSO]] · [[MFA]] · [[Federation]] · [[IAM]] · [[PAM]] · [[Zero Trust]] · [[DLP]] · [[PII]] · [[CHD]] · [[SIEM]] · [[Log ingestion]] · [[PKI]] · [[TLS]] · [[Shared Responsibility Model]] · [[OAuth]] · [[SAML]] · [[Conditional Access]]

*Source: VIRGIL knowledge base — 2026-05-11*