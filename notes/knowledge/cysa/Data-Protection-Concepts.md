# Data Protection Concepts

## What it is

In **Mortal Kombat**, when Sub-Zero rips out a spine, the round is over — but the real damage is that the audience just saw something nobody was supposed to see. The Fatality isn't just a finishing move; it's the moment data leaves the arena and ends up on every screen. Now imagine Shao Kahn's vault under Outworld — Soulnado spinning, soul gems racked in tiers, Shokan guards on the doors, Reptile cloaked in the rafters watching for thieves. The vault doesn't just *exist*. It's classified (relic, artifact, soul), zoned (which warrior gets which key), monitored (Kahn sees everything), and lethal on touch. That's data protection: not one wall, but layers — classification, access, encryption, monitoring, and a brutal response when something tries to walk out the door.

In plain English: data protection is the set of practices, controls, and policies that keep sensitive information from being read, modified, exfiltrated, or destroyed by anyone without authorization.

Technically (CS0-003 framing): data protection covers the **three states of data** (at rest, in transit, in use), the **classification schemes** that determine who touches what, the **regulatory categories** (PII, PHI, CHD, IP) that drive compliance obligations, and the **technical controls** ([[DLP]], encryption, [[CASB]], access management) that enforce the policy.

## Why it matters

Data is the prize. Every attacker in the [[Cyber Kill Chain]] is aiming at it. Every regulation — GDPR, HIPAA, PCI DSS, CIRCIA, state breach laws — is written about it. Every incident report, after the smoke clears, comes down to one question from the CISO: *what data was touched, and do we have to tell anyone?*

CySA+ Objective 1.1 lists this under security operations because the SOC analyst is the one who watches the vault. You're the one who sees the DLP alert at 2am, decides if 14,000 records leaving via Outlook is a sales engineer doing his job or an insider walking out with the customer list. Get it wrong in either direction and you either melt the on-call queue with false positives or you miss a real breach for 90 days.

## Key facts

### The three states of data

Every byte lives in one of three states, and each needs different controls.

| State | What it means | Primary control |
|---|---|---|
| **At rest** | Sitting on disk, in a database, in an S3 bucket, on a backup tape | Full-disk encryption (BitLocker, LUKS), TDE for databases, server-side encryption for cloud storage |
| **In transit** | Moving across a network — between client and server, between data centers, between cloud regions | [[TLS]] / [[SSL]] (TLS 1.2+ only — SSL is dead, deprecated, do not use), IPsec VPN, SSH |
| **In use** | Loaded into RAM, being processed by an application, sitting in a CPU register | Hardest to protect — confidential computing, secure enclaves (Intel SGX, AMD SEV), memory encryption, application-layer access controls |

> **CompTIA exam trap:** "SSL" and "TLS" are not interchangeable. SSL 2.0 and 3.0 are deprecated and broken (POODLE). TLS 1.0 and 1.1 are also deprecated. The correct answer for "secure data in transit" is **TLS 1.2 or 1.3**. If an answer choice says "SSL" without qualification, it's usually wrong.

### Data classification categories

CompTIA tests these by name. Memorize what each one covers and which regulation owns it.

| Category | What it is | Regulation |
|---|---|---|
| **PII** — Personally Identifiable Information | Anything that identifies a natural person, directly (SSN, passport, driver's license) or indirectly (DOB + ZIP + gender can re-identify 87% of US adults) | GDPR (EU), CCPA (California), state breach laws |
| **PHI** — Protected Health Information | Medical records, diagnoses, insurance info, anything covered by a healthcare provider | HIPAA / HITECH (US) |
| **CHD** — Cardholder Data | Primary Account Number (PAN), cardholder name, expiration date, service code. **SAD** (Sensitive Authentication Data) = full magnetic stripe, CVV/CVC, PIN — never stored post-authorization | PCI DSS |
| **IP** — Intellectual Property | Source code, trade secrets, M&A documents, R&D | Contract law, trade secret law, NDA enforcement |
| **Financial** | Bank accounts, tax records, SEC filings | SOX (US public companies), GLBA (US financial) |

> **CompTIA exam trap:** Under PCI DSS, the **PAN** (Primary Account Number) is the linchpin. Expiration date and cardholder name are CHD only when stored *with* the PAN. CVV/CVC is **SAD** — Sensitive Authentication Data — and must never be stored after the transaction authorizes, even encrypted. Storing CVV is an automatic PCI failure.

### DLP — Data Loss Prevention

[[DLP]] is the bouncer at the vault door. It inspects data and decides if it's allowed to leave.

**Three deployment modes:**

- **Network DLP** — sits on egress, inspects email, web uploads, FTP. Blocks or quarantines based on policy.
- **Endpoint DLP** — agent on the workstation, watches USB writes, clipboard, print jobs, screen captures.
- **Storage / Cloud DLP** — scans data at rest in file shares, SharePoint, OneDrive, S3. Tags and quarantines.

**How it identifies sensitive data:**

- **Pattern matching** — regex for SSN (`\d{3}-\d{2}-\d{4}`), credit card (Luhn-validated 16 digits), IBAN
- **Fingerprinting** — hash known sensitive documents; alert if any chunk matches
- **Classification labels** — Microsoft Purview / Azure Information Protection labels stick to the file; DLP reads the label
- **Machine learning / content analysis** — for unstructured data like contracts or source code

*The DLP false-positive rate is the single biggest reason DLP programs die. Tune aggressively, and accept that the first three months will be ugly.*

> **CompTIA exam trap:** DLP requires **content awareness** — it has to be able to read the data to classify it. End-to-end encrypted traffic (TLS without inspection, encrypted ZIP attachments, Signal) defeats DLP unless you break and inspect. This is why enterprises deploy **TLS inspection** at the perimeter and CASBs in the cloud. Encryption is data protection's best friend and DLP's worst enemy at the same time.

### Encryption — the universal control

Encryption shows up in every state of data and every regulation.

- **Symmetric** — AES-256 for data at rest, fast, single key
- **Asymmetric** — RSA-2048+, ECC for key exchange and signing, slow, two keys
- **Hashing** — SHA-256, SHA-3 for integrity (not encryption — one-way)
- **Hybrid** — TLS uses asymmetric to exchange a symmetric session key, then symmetric for bulk data

[[PKI]] — Public Key Infrastructure — is the trust hierarchy. CAs issue certs, certs bind public keys to identities, CRLs and OCSP revoke compromised certs. When the cert on your prod load balancer expires Saturday night, PKI is what just ruined your weekend.

**Key management is where encryption programs actually fail.** AES-256 with the key sitting in a config file checked into GitHub is worse than no encryption — it's encryption theater. Real programs use **HSMs** (Hardware Security Modules) or cloud KMS (AWS KMS, Azure Key Vault, GCP Cloud KMS) with rotation policies, separation of duties, and audit logs on every key access.

### CASB — Cloud Access Security Broker

[[CASB]] is DLP, IAM, and threat protection bolted onto the cloud edge. It sits between your users and SaaS apps (Salesforce, O365, Workday) and enforces policy on data going up and coming back down.

Four pillars:
- **Visibility** — what SaaS apps are users even using? (Shadow IT discovery)
- **Compliance** — is data going to apps that meet your regulatory requirements?
- **Data security** — DLP for cloud
- **Threat protection** — UEBA, anomaly detection, compromised account detection

Deployment modes: **API-based** (out-of-band, scans after the fact), **forward proxy** (inline, intercepts traffic), **reverse proxy** (inline, for unmanaged devices).

### Sensitive data protection in practice

The control stack, layered like Kahn's vault:

1. **Identify and classify** — you can't protect what you can't find. Data discovery scans first.
2. **Label** — tag the data so every downstream tool knows what it is
3. **Encrypt** — at rest and in transit, always; in use when you can
4. **Access control** — IAM + RBAC + MFA, least privilege, [[PAM]] for admin access
5. **Monitor** — DLP, CASB, SIEM correlation, [[UEBA]]
6. **Respond** — IR playbook for data exposure; legal hold; breach notification timers start ticking the moment you confirm

### Privacy regulations and notification clocks

| Regulation | Scope | Notification timeline |
|---|---|---|
| **GDPR** | EU residents' data | 72 hours to supervisory authority |
| **HIPAA** | US PHI | 60 days to affected individuals; HHS notified concurrently for 500+ |
| **PCI DSS** | Cardholder data | Immediately to acquiring bank and card brands |
| **CIRCIA** | US critical infrastructure | 72 hours for covered cyber incidents; 24 hours for ransom payments |
| **State laws (US)** | Varies — California, NY, Texas all different | Usually "without unreasonable delay," some specify 30–60 days |

> **CompTIA exam trap:** GDPR's 72-hour clock starts when you become **aware of the breach**, not when the breach occurred. If forensics shows the attacker was in for 90 days but you found out Tuesday, your clock started Tuesday. Don't conflate "when did it happen" with "when did notification become required."

## SOC reality

- **The DLP alert at 2am:** "User exported 4,300 customer records to personal Gmail." Your first move is *not* to call the user — it's to confirm the alert is real (DLP false positives are 60%+ on day one) and check the user's recent activity in SIEM. Then loop in HR and legal *before* anyone talks to the employee. Custody and process matter; tipping off an insider blows the investigation.
- **The CISO question after any incident:** "Was regulated data involved?" If yes — PII, PHI, CHD — the conversation shifts from technical to legal in under five minutes. Notification clocks start. Outside counsel gets called. You stop being the lead and start being the evidence-handler.
- **What you never promise:** "No data left the environment." You don't know that until forensics finishes. Say "no confirmed exfiltration at this time" and update as evidence develops.
- **The handoff:** L1 triages the DLP alert → L2 validates and pulls user context → IR scopes if confirmed → Legal/Privacy owns breach notification decisions → Executive comms owns external statements. You don't tweet.
- **The boring 80%:** most DLP hits are sales reps emailing themselves a deck, HR exporting their own reports, devs pasting fake test SSNs into Slack. Tune ruthlessly, but never auto-close — the one you ignore is the one that becomes a Wall Street Journal headline.

*Encryption everywhere, classify before you protect, and assume your DLP will lie to you for the first 90 days — that's the job.*

## Related concepts

[[DLP]] · [[CASB]] · [[PKI]] · [[TLS]] · [[Encryption]] · [[PAM]] · [[IAM]] · [[MFA]] · [[Zero Trust]] · [[Network Segmentation]] · [[GDPR]] · [[HIPAA]] · [[PCI DSS]] · [[CIRCIA]] · [[UEBA]] · [[SIEM]] · [[Cyber Kill Chain]]

*Source: VIRGIL knowledge base — 2026-05-11*