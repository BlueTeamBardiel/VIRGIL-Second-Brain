# Network Architecture & Design

## What it is

In **Halo: Combat Evolved**, the *Pillar of Autumn* doesn't have one big door between the bridge and the engine room. It has bulkheads, blast doors, cryo bays sealed off from the armory, and Cortana gating which sections respond to which terminals. When the Covenant boards, they don't get the ship — they get a hallway. Master Chief fights room by room because the architecture *forces* them to. That's network segmentation. The Autumn isn't unbreachable. It's *compartmented* so the breach costs the attacker time, and time is what defenders convert into detection.

Plain English: how you lay out hosts, networks, identity, and trust boundaries determines how much of your environment an attacker owns once they get a foothold. A flat network is a Warthog ride from DMZ to domain controller. A segmented, zero-trust network is the Library — every door requires a new key.

Technical: **Network architecture** in CS0-003 covers deployment models (on-prem, cloud, hybrid, serverless), segmentation strategy (VLANs, subnets, micro-segmentation, SDN), trust models (perimeter vs zero trust), edge delivery (SASE), identity infrastructure (IAM, PAM, SSO, MFA, federation, PKI), and the data-protection overlays (DLP, CASB, encryption) that ride on top. The shape of the architecture dictates the shape of the SOC's detection and response problem.

## Why it matters

Architecture is the variable you can't tune at 3am. By the time the alert fires, the blast radius is whatever your segmentation said it was six months ago. SOC analysts who don't read network diagrams end up chasing ghosts across VLAN boundaries they didn't know existed. Analysts who do read them can predict where the attacker is going next — same way you know the Covenant Elite is about to flank because you've played the level before.

CompTIA tests this hard under **Objective 1.1**. They want you to explain *why* a hybrid environment leaks more than a pure on-prem one, *why* zero trust isn't a product, *why* east-west traffic visibility matters more than north-south, and *why* identity is the new perimeter. Expect scenario questions where the right answer is "segment the OT network from corporate" and three wrong answers about buying more firewalls.

## Key facts

### Deployment models

| Model | Who runs the metal | Who owns security | SOC pain point |
|---|---|---|---|
| **On-premises** | You | You — top to bottom | Slow to scale, but you see every packet |
| **Cloud (IaaS/PaaS/SaaS)** | Provider | Shared responsibility — identity, data, config are yours | Logging depends on what the provider exposes |
| **Hybrid** | Both | Both, with gaps in the seams | Most breaches live in the handoff |
| **Serverless (FaaS)** | Provider | You own code + IAM; provider owns runtime | Ephemeral hosts — forensic acquisition is hard |

The **shared responsibility model** is the line CompTIA will draw on the exam. You always own data, identity, and access configuration. The provider owns physical, hypervisor, and (in SaaS) the application stack. Misconfigured S3 buckets are your fault, not Amazon's.

*Hybrid is where the breaches live. The federation token that's valid in both environments is the skeleton key, and nobody owns the seam.*

### Segmentation

Three flavors, in order of strength:

- **Physical separation (air gap)** — different cables, different switches. SCADA/ICS, classified networks. Strongest, least flexible.
- **Logical separation (VLANs, subnets, firewall zones)** — same hardware, enforced in software/config. Standard enterprise pattern.
- **Micro-segmentation** — per-workload policy, typically via SDN or host-based firewalls. Each VM is its own zone.

Why it matters: segmentation converts a single compromised host into a *contained* compromised host. Without it, one phished marketing laptop owns the domain controller by lunch.

### Zero trust

Not a product. A model. Three rules:

1. **Never trust, implicitly.** Being inside the LAN proves nothing.
2. **Verify continuously.** Identity, device posture, context — every request, every time.
3. **Least privilege, always.** You get exactly the access you need, for as long as you need it.

The shorthand: **identity + device + context = decision**. The Spartan armor doesn't open for anyone wearing UNSC colors — it opens for *Chief*, on *his* neural lace, in *this* mission context.

### SDN — software-defined networking

Control plane and data plane separated. A controller (the brain) pushes flow rules to switches (the muscles). Pros: change policy fleet-wide in seconds. Cons: a misconfiguration scales just as fast. One bad ACL push and the whole DC is partitioned.

SOC angle: SDN gives you programmatic *inspection points*. You can mirror any flow to a sensor on demand. Use it.

### SASE — secure access service edge

Pronounced "sassy." Bundles SD-WAN with cloud-delivered security services: **SWG** (secure web gateway), **CASB**, **ZTNA** (zero trust network access), **FWaaS** (firewall as a service), and DLP. The pitch: stop backhauling remote-user traffic to the corporate firewall — inspect it at a cloud PoP near the user.

SASE replaces the perimeter with an identity-aware edge. Good fit for hybrid-workforce orgs. Bad fit if you can't get your IAM straight, because identity *is* the policy enforcement point.

### CASB — cloud access security broker

The bouncer between users and SaaS. Sits in-line (proxy) or out-of-band (API). Four pillars: **visibility, compliance, data security, threat protection**. Tells you which intern is uploading the customer list to a personal Dropbox. Enforces DLP on cloud traffic the corporate firewall never sees.

### Identity infrastructure

- **IAM** — the umbrella. Who exists, what they can touch.
- **PAM** — privileged access management. Vault credentials for admin accounts, session recording, just-in-time elevation. The domain admin password isn't a sticky note — it's checked out for 30 minutes, recorded on video, auto-rotated on return.
- **SSO** — one identity, many apps. Reduces password reuse. Expands blast radius if the IdP is popped.
- **MFA** — something you know + have + are. Phishing-resistant MFA (FIDO2, hardware keys) > SMS OTP.
- **Passwordless** — FIDO2/WebAuthn, biometrics, hardware-bound credentials. No password = no password to phish.
- **Federation** — SAML, OIDC. Trust another org's identity assertions. The handshake between Halo and the Banished — if you trust their token, you trust their compromise.
- **PKI** — certificate authorities, key pairs, revocation (CRL/OCSP). Underpins SSL/TLS, code signing, smart cards, mTLS.

*Compromise the IdP and you don't need malware. You just log in.*

### Data protection overlays

- **Encryption** — at rest (disk, DB), in transit (TLS), in use (confidential computing). Not a control on its own — it's a *kill switch* if key management is sane.
- **DLP** — data loss prevention. Pattern-matches PII, CHD, PHI, source code. Blocks/alerts on exfil channels: email, USB, web upload, cloud sync.
- **Sensitive data classes** — **PII** (name + SSN + DoB), **PHI** (HIPAA-covered health), **CHD** (PCI-DSS: PAN, CVV, expiry), **IP/trade secrets**. Different regulators, different breach clocks.

### Hardware, OS, and host concepts

- **Hardware architecture** — TPM (key storage), HSM (high-assurance key ops), Secure Boot, measured boot. Roots of trust live in silicon.
- **Virtualization** — hypervisor (Type 1 bare-metal, Type 2 hosted). Escape vulnerabilities are rare but catastrophic.
- **Containerization** — Docker, Kubernetes. Shares kernel with host — weaker isolation than VMs. Image hygiene matters.
- **OS concepts** — system processes, the **Windows Registry** (HKLM, HKCU — persistence playground), file structure (`/etc`, `%SystemRoot%`, `~/.ssh`), **configuration file locations** that attackers know by heart.
- **System hardening** — CIS Benchmarks, STIGs. Disable unused services, restrict admin shares, enforce SMB signing, kill LLMNR/NBT-NS.

### Logging and time

- **Log ingestion** — pull (agent → SIEM) or push (syslog, Windows Event Forwarding). Cover endpoints, network, identity, cloud, application tiers.
- **Logging levels** — DEBUG, INFO, WARN, ERROR, CRITICAL. Tune to signal-to-noise. DEBUG in prod will bankrupt your SIEM license.
- **Time synchronization** — **NTP is non-negotiable.** Without synced clocks across hosts, your timeline reconstruction is fiction. Stratum 1 source, internal NTP servers, monitor for drift.

*A 90-second clock skew between the proxy and the endpoint will make you swear the attacker had a time machine. They didn't. You did.*

### CompTIA exam traps

> **Trap — Zero trust is not a product.** If the answer choice says "deploy a zero-trust firewall," it's wrong. Zero trust is an architectural model: continuous verification, least privilege, no implicit trust. Vendors sell components *toward* it.

> **Trap — Segmentation vs isolation.** Segmentation = logical separation with controlled traversal. Isolation = no traversal at all (air gap). CompTIA will test the difference.

> **Trap — Shared responsibility direction.** In IaaS *you* secure the OS. In PaaS the provider does. In SaaS the provider secures almost everything except your data and identity config. Read the model in the question stem carefully.

> **Trap — SASE vs ZTNA vs SSE.** ZTNA is a *component* (zero-trust remote access). SSE is SASE minus the SD-WAN networking piece. SASE = SD-WAN + SSE.

> **Trap — Federation expands blast radius.** SSO/federation is a productivity win and a security concentration risk. If the IdP is compromised, every federated app is compromised. Expect a scenario asking why MFA on the IdP matters more than MFA on any individual app.

> **Trap — Time sync as a forensic requirement.** NTP isn't just hygiene; it's chain-of-custody. Unsynchronized timestamps can get evidence thrown out. CompTIA will hide this in a forensics question.

## SOC reality

- The first thing the IR lead asks during a containment call: *"What's on that VLAN? What can it reach?"* If you can't answer in 60 seconds, your architecture documentation is the incident.
- The CASB dashboard is where you catch the "I'll just use my personal Gmail to send this spreadsheet" exfil. Not the firewall. Not the endpoint. The CASB.
- PAM checkout logs are gold during IR. *"Who had the domain admin creds at 02:14?"* If the answer is "nobody, they were vaulted," you've just narrowed the suspect list to people who bypassed PAM — which is a much smaller list.
- The hybrid seam — your on-prem AD synced to Entra ID, your federated SaaS apps, your VPN concentrator that trusts AD — is where 80% of identity-based intrusions actually pivot. Map it before you need to.
- Never tell the CISO "we're zero trust" when what you mean is "we bought a ZTNA product." They will quote you back to the auditor. Zero trust is a multi-year architectural shift, not a PO.

## Related concepts

[[VLANs]] · [[Zero Trust Architecture]] · [[SASE]] · [[CASB]] · [[SDN]] · [[Privileged Access Management]] · [[Multifactor Authentication]] · [[Single Sign-On]] · [[Federation]] · [[Public Key Infrastructure]] · [[Data Loss Prevention]] · [[System Hardening]] · [[Log Ingestion]] · [[Time Synchronization]] · [[Cloud Shared Responsibility Model]] · [[Virtualization]] · [[Containerization]]

*Source: VIRGIL knowledge base — 2026-05-11*