# CHD — Cardholder Data

## What it is

In **Madden**, the playbook isn't just plays — it's the rules around how those plays get called. Audibles at the line, hot routes, motion adjustments, who can read the wristband and who can't. The QB has the full playbook. The receiver gets the route. The lineman gets the protection call. Nobody on the sideline screams the full play into the open air, because the other team is watching. And when the play clock hits zero, every call gets logged in the post-game film so the coordinator can review what happened, when, and who touched the ball.

That's exactly what **Cardholder Data (CHD)** controls do — segment the people who can see the full play, restrict the channels the data moves through, and log every touch for the post-game review.

Technically: **CHD is the data set defined by PCI DSS** as the Primary Account Number (PAN) plus, when stored with the PAN, cardholder name, expiration date, and service code. It lives inside the broader **Cardholder Data Environment (CDE)** — every system component that stores, processes, or transmits CHD, plus anything connected to it. CySA+ tests CHD as a category of [[sensitive data]] you architect around: segment it, encrypt it, log every access, restrict who authenticates to it.

## Why it matters

CHD is the data type that triggers the most prescriptive compliance regime in commercial IT. Get it wrong and you get fined by the card brands, dropped by your acquirer, and sued in civil court. Target 2013, Home Depot 2014, every breach with "POS malware" in the headline — that's CHD exfil through a CDE that wasn't segmented hard enough.

For the SOC analyst this is the exam-and-job intersection point. **CS0-003 Objective 1.1** lists CHD alongside PII as the sensitive data classes you architect controls around. You're expected to know why the CDE is a separate network zone, why [[network segmentation]] reduces PCI scope, why [[DLP]] watches for PAN patterns leaving the environment, and why CHD log access is itself logged.

The career angle: any analyst working retail, hospitality, banking, healthcare-with-payments, or SaaS-billing will touch a CDE. Knowing CHD is what gets you onto the PCI-aware SOC rota, which is where the senior IR work lives.

## Key facts

### What counts as CHD vs SAD

PCI DSS splits payment data into two categories. CompTIA mixes them deliberately.

| Category | Elements | Storage rules |
|---|---|---|
| **Cardholder Data (CHD)** | PAN (Primary Account Number), cardholder name, expiration date, service code | PAN must be rendered unreadable in storage (encryption, truncation, tokenization, hashing). Other elements are CHD only when stored *with* the PAN. |
| **Sensitive Authentication Data (SAD)** | Full track data, CAV2/CVC2/CVV2/CID, PIN/PIN block | **Never** stored after authorization, even encrypted. |

> **CompTIA exam trap:** CVV/CVC is **SAD, not CHD**. If the question asks what's allowed in storage after authorization, the answer excludes the three-digit code. The exam loves swapping these.

### The Cardholder Data Environment (CDE)

The CDE is everything that touches CHD plus everything connected to it. Three system categories:

- **In-scope systems** — store, process, or transmit CHD directly (POS terminals, payment gateways, the database holding tokenized PAN with the key)
- **Connected-to systems** — can reach in-scope systems on the network (jump hosts, admin workstations, AD domain controllers if shared)
- **Security-impacting systems** — provide security services to the CDE (SIEM, vulnerability scanner, [[PKI]] for CDE TLS, [[NTP]] server)

**Scope reduction = compliance survival.** The fewer systems in the CDE, the less audit surface, the less attestation work, the less breach blast radius.

### Network architecture and segmentation

[[Network segmentation]] is the primary scope-reduction control. Without it, your entire flat network is the CDE.

- **VLAN + firewall isolation** — CDE on dedicated VLANs, default-deny rules, only documented business-justified flows allowed inbound or outbound
- **[[Zero Trust]] architecture** — no implicit trust based on network location; every CDE access decision re-authenticates and re-authorizes
- **[[SDN]] inspection** — software-defined networking lets you enforce micro-segmentation policies that follow workloads across moves
- **[[SASE]]** — secure access service edge, useful when CDE-adjacent users are remote; consolidates [[ZTNA]], [[CASB]], SWG, FWaaS
- **[[CASB]]** — if any CDE function lives in SaaS (rare but real for tokenization vendors), the CASB enforces DLP and access policy at the cloud edge

### Hardening and access

- **[[System hardening]]** — CIS or vendor benchmark applied to every CDE host; default credentials gone; unused services disabled; PCI DSS Requirement 2 explicitly demands this
- **[[Identity and access management]]** — unique IDs per user (no shared accounts), least privilege, quarterly access review
- **[[MFA]]** — required for all non-console administrative access into the CDE and all remote access from outside the corporate network. PCI DSS v4.0 expanded this to all access into the CDE, not just admin.
- **[[Passwordless]] / FIDO2** — increasingly accepted as the MFA strong factor; phishing-resistant by design
- **[[PAM]]** — privileged access management broker for admin sessions into CDE; session recording, credential vaulting, just-in-time elevation. On-prem PAM (CyberArk, Delinea) or cloud-delivered.
- **[[SSO]] + [[Federation]]** — fine for the corporate identity layer, but step-up MFA must still trigger at the CDE boundary

### Encryption

PCI DSS Requirement 3 (storage) and Requirement 4 (transit).

- **At rest** — PAN rendered unreadable: strong cryptography (AES-256), truncation (show only first 6 / last 4), tokenization (replace PAN with a non-sensitive surrogate), or one-way hashing with salt
- **In transit** — strong cryptography over open/public networks. **[[TLS]] 1.2 minimum, TLS 1.3 preferred.** [[SSL]] and early TLS (1.0/1.1) are explicitly prohibited.
- **Key management** — keys stored separately from data, dual control for key custodians, documented key rotation, HSM-backed where possible
- **[[PKI]]** — internal CA issues certs for CDE service-to-service TLS; cert lifecycle is a logged, audited process

> **CompTIA exam trap:** "SSL" is a deprecated term but still appears in objectives and exam items. If the answer choice says "SSL encryption protects CHD in transit," it's wrong on protocol grounds — SSL is dead, TLS 1.2+ is the only acceptable answer.

### Logging and time

PCI DSS Requirement 10 — the requirement that keeps SOC analysts employed.

- **[[Log ingestion]]** — every access to CHD, every admin action, every auth event, every change to security controls, ingested into the [[SIEM]] daily and retained ≥1 year (3 months immediately available)
- **[[Logging levels]]** — verbose enough to reconstruct who-did-what-when; PCI specifies user ID, event type, date/time, success/failure, origination, affected resource
- **[[Time synchronization]]** — all CDE systems synced to a common, authoritative [[NTP]] source. Without synced time, your forensic timeline is fiction.
- **File integrity monitoring (FIM)** — alerts on changes to critical CDE files, [[Windows Registry]] hives for cardholder-handling apps, system binaries
- **Daily log review** — required by PCI; in practice, this is SIEM correlation rules and analyst triage

### Data loss prevention

[[DLP]] watches for CHD attempting to leave the CDE through unsanctioned channels.

- **Pattern matching** — PAN regex with Luhn check digit validation to reduce false positives (a random 16-digit string fails Luhn; a real card number passes)
- **Egress points** — email, web upload, USB, cloud sync, chat platforms
- **Detection vs prevention modes** — start in detect/alert, tune for FPs, then move to block. CASB-integrated DLP for SaaS-bound traffic.

### Infrastructure variants

CHD can live across deployment models, and the controls shift with them.

| Model | CHD considerations |
|---|---|
| **On-premises** | Full responsibility — physical security, hypervisor, OS, app, data. PCI scope is yours top to bottom. |
| **Cloud (IaaS/PaaS)** | Shared responsibility. Use the provider's PCI AOC; you still own IAM, encryption keys, network controls, app layer. |
| **Hybrid** | Hardest to scope — CHD flows across boundaries. Encrypt in transit between zones, document flows, log at every hop. |
| **[[Virtualization]] / [[Containerization]]** | Hypervisor and container runtime are in-scope if they host CDE workloads. Image hardening, runtime scanning, secrets management. |
| **[[Serverless]]** | Function code, function configuration, and the data the function touches are in-scope. Ephemeral compute makes forensic acquisition painful — log aggressively. |

### OS-level concerns

[[OS hardening]] specifics that show up on CHD systems:

- **[[File structure]] and config file locations** — payment app configs (`/etc/`, `C:\ProgramData\`, registry hives) need ACLs and FIM
- **[[System processes]]** — only required services running; baseline known-good process trees so EDR can flag anomalies
- **[[Windows Registry]]** — payment apps often store config in registry; monitor `HKLM\Software\` paths for payment software changes
- **[[Hardware architecture]]** — POS devices are P2PE candidates; hardware-encrypted card readers keep clear-text PAN out of the host OS entirely, collapsing scope

## SOC reality

- The **CDE SIEM alert** that fires at 3am is usually one of three: (1) PAN pattern detected in egress traffic by DLP, (2) admin login to a CDE jump host from an unexpected source IP, (3) FIM alert on a payment app binary or config file. Triage order: validate the alert isn't a known scanner, pull the host into isolation if it's CDE, page the IR lead.
- **L1 first action** — never dump the raw PAN into the ticket. Truncate, mask, or reference by record ID. The ticket system is almost certainly not in PCI scope, and putting PAN in it just expanded the CDE by one Jira instance.
- **What the CISO asks** — "Is this in the CDE? Was clear-text PAN involved? Do we have a notification obligation to the card brands or acquirer?" The card brand notification clock is fast and unforgiving. PCI Forensic Investigator (PFI) may need to be engaged.
- **Never promise** "the CDE is contained" until segmentation has been verified, not assumed. Flat networks that were *supposed* to be segmented are the most common breach root cause. The firewall rule existed; the bypass route around it did too.
- **Handoff** — L1 confirms scope and isolates; L2 pulls logs and correlates; IR lead engages legal and compliance; legal handles card brand notification and any state breach notification triggers. Compliance owns the post-incident attestation conversation.

*The CDE is the smallest possible blast radius around your most regulated data. Every system you let touch it pays rent in audit hours, and any system that touches it without justification is just a bigger target wearing your logo.*

## Related concepts

[[PII]] · [[PHI]] · [[PCI DSS]] · [[Network segmentation]] · [[Zero Trust]] · [[DLP]] · [[SIEM]] · [[SASE]] · [[CASB]] · [[PAM]] · [[MFA]] · [[PKI]] · [[TLS]] · [[Tokenization]] · [[System hardening]] · [[Log ingestion]] · [[Time synchronization]] · [[Virtualization]] · [[Containerization]] · [[Serverless]]

*Source: VIRGIL knowledge base — 2026-05-11*