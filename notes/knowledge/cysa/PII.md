# PII — Personally Identifiable Information

## What it is

In **Death Stranding**, every cargo case Sam Porter Bridges hauls has a manifest: contents, weight, fragility, recipient, destination. Some cases are labeled with skull icons — handle with care, do not drop, do not get wet, do not let BTs touch them. You can lose a regular package and Fragile will yell at you. You lose a Q-Pid or a cremation cargo and the network downgrades you, the recipient never trusts you again, and the route gets flagged. Same cargo system, wildly different blast radius depending on what's inside the case.

That's exactly what **PII** is — the data inside the case that turns an ordinary breach into a regulator-grade incident.

Technical definition: **Personally Identifiable Information** is any data that, alone or combined with other data, can identify a specific natural person. NIST SP 800-122 splits it into **direct identifiers** (SSN, passport number, driver's license, biometrics, full name + DOB) and **indirect identifiers** that become PII when correlated (ZIP code + DOB + gender re-identifies ~87% of US residents — the Sweeney study). CySA+ tests PII as a category of **sensitive data** that drives logging, segmentation, encryption, DLP, and breach-notification obligations. It is one of several regulated data classes — alongside **PHI** (health), **CHD** (cardholder data, governed by PCI DSS), and **IP** (intellectual property) — but PII is the one that touches almost every business system you'll defend.

## Why it matters

PII is the data class that triggers the lawyers. A breach of marketing copy gets a Slack message. A breach of 50,000 customer records with names, emails, and dates of birth gets a 72-hour GDPR notification clock, a state AG inquiry, a class action, and a board-level conversation about whether the CISO keeps their job. CySA+ Objective 1.1 lists **sensitive data protection** as a core architectural concern because where PII lives dictates how you segment the network, what you log, what you encrypt, who gets privileged access, and what your DLP rules look like.

For the analyst at the keyboard: knowing which systems hold PII is the difference between "alert acknowledged, monitoring" and "wake the IR lead, start the legal hold, preserve volatile memory." Same alert, different asset, different night.

## Key facts

### What counts as PII

| Type | Examples | Sensitivity |
|---|---|---|
| **Direct identifiers** | SSN, passport #, driver's license, taxpayer ID, biometrics (fingerprint, iris, face template), full name + DOB | High — single-field re-identification |
| **Quasi-identifiers** | ZIP, DOB, gender, employer, job title | Low alone, high in combination |
| **Contact data** | Email, phone, home address | Medium — phishing fuel, doxxing fuel |
| **Account data** | Username, IP address, device ID, cookie ID | Medium — under GDPR these *are* PII; under older US frameworks, debated |
| **Financial PII** | Bank account, routing, partial card (full card = CHD under PCI DSS) | High |
| **Sensitive categories (GDPR Art. 9)** | Health, genetics, biometrics, race, religion, sexual orientation, union membership, political opinion | Highest — special-category data, stricter handling |

### The PII / PHI / CHD distinction (exam-relevant)

- **PII** — any identifying data. Governed by GDPR, CCPA/CPRA, state breach laws, sectoral laws.
- **PHI** — Protected Health Information. PII *plus* health context. Governed by **HIPAA** in the US. Requires BAAs, minimum-necessary rule, 60-day breach notification to HHS.
- **CHD** — Cardholder Data. PAN, cardholder name, expiry, service code. Governed by **PCI DSS**. CVV is **SAD** (Sensitive Authentication Data) and must never be stored post-authorization.
- Overlap is the rule, not the exception. A hospital billing record is PII + PHI + CHD simultaneously and inherits the strictest control from each regime.

### How PII shapes the architecture (Objective 1.1)

**Network segmentation.** PII repositories sit in their own VLAN or security zone with east-west firewalls. The CRM database is not on the same flat network as the print server. Microsegmentation under [[Zero Trust]] takes this further — every connection to the PII store is authenticated and authorized per-session.

**Identity and access management.** PII access requires named accounts, MFA, and [[Privileged Access Management]] for admins. [[Single Sign-On]] reduces password sprawl but concentrates blast radius — compromise the IdP and the attacker walks into every PII store at once. [[Federation]] (SAML, OIDC) extends this trust to partners, which is also how PII leaks when a federated partner gets popped.

**Encryption.** PII encrypted **at rest** (TDE, file-level, full-disk depending on threat model) and **in transit** ([[TLS]] 1.2+, deprecate [[SSL]] entirely). Key management via HSM or cloud KMS. [[PKI]] underpins the certificates and the integrity of the whole chain.

**Logging.** PII access logged at a higher verbosity than non-sensitive systems. Logging levels (DEBUG, INFO, WARN, ERROR, CRITICAL) tuned so that read operations on PII tables generate auditable events without drowning the [[SIEM]]. **Time synchronization** (NTP) is non-negotiable — a PII access log with the wrong timestamp is forensically worthless and legally fragile.

**Data Loss Prevention.** [[DLP]] inspects endpoint, network, and cloud egress for PII patterns — SSN regex, credit-card Luhn checks, named-entity recognition for full names + DOB combinations. [[CASB]] enforces the same on SaaS (Salesforce, Workday, M365). [[SASE]] bundles it into the edge.

**Cloud and hybrid considerations.** PII in [[IaaS]] inherits provider physical controls but customer logical controls — the **shared responsibility model**. Serverless and containerized workloads handling PII need ephemeral secrets management (not baked into images), runtime [[SDN]] inspection, and policy-as-code controls. Hybrid environments multiply the audit surface — same record may exist in on-prem Oracle, AWS RDS, and a SaaS analytics tool, and the breach scope is the union of all three.

**System hardening.** Hosts processing PII: minimal services, disabled unnecessary system processes, hardened [[Windows Registry]] hives or `/etc` configurations, restricted file structure permissions on the database directory, EDR with behavioral detection, immutable audit logging shipped off-host. **Passwordless** (FIDO2, platform authenticators) reduces credential-theft risk to PII admin accounts.

### Discovery — you can't protect what you can't find

PII discovery tools (Microsoft Purview, BigID, Varonis, AWS Macie) crawl file shares, databases, S3 buckets, and email archives looking for PII patterns. A discovery scan on a 10-year-old fileshare will find PII in places nobody remembered putting it — `HR_archive_2014/terminations.xlsx` with 800 SSNs in plaintext. This is the boring work that prevents the loud incident.

*Every breach post-mortem includes the sentence "we didn't know that system stored PII."*

### Breach notification clocks (CySA+ trap zone)

| Regime | Clock | To whom |
|---|---|---|
| **GDPR Art. 33** | 72 hours from awareness | Supervisory authority; data subjects "without undue delay" if high risk |
| **HIPAA Breach Notification Rule** | 60 days | Individuals; HHS (immediately if >500 affected) |
| **PCI DSS** | Immediate | Card brands, acquirer |
| **CCPA/CPRA** | "Most expedient time possible" | Affected California residents |
| **US state laws** | Varies — 30 to 90 days typical | State AG, residents |
| **CIRCIA** (US critical infrastructure) | 72 hours for incidents, 24 hours for ransom payments | CISA |

### CompTIA exam traps

> **CompTIA exam trap:** PII is not a synonym for "private data." An IP address is PII under **GDPR** but historically not under US sectoral law. The right answer on CySA+ depends on the regulatory regime named in the scenario. Read the question for jurisdiction.

> **CompTIA exam trap:** **PHI ⊂ PII** but **CHD ⊄ PII** strictly. Cardholder data without a name is still CHD under PCI DSS but may not be PII under GDPR. Don't collapse the categories.

> **CompTIA exam trap:** Tokenization vs encryption. Tokenization replaces PII with a non-reversible token mapped in a separate vault — out of scope for many compliance regimes if implemented correctly. Encryption is reversible with the key. CompTIA loves to ask which one reduces compliance scope; tokenization is usually the right answer for **PCI scope reduction**.

> **CompTIA exam trap:** "PII at rest is encrypted" does not mean the database is safe. If the application service account decrypts on every query and the attacker has the service account, the encryption is theater. Encryption protects against disk theft and backup theft, not against compromised application credentials.

## SOC reality

- **The 3am alert** looks like: DLP fires on a 47MB outbound POST to a Pastebin-adjacent domain from a finance workstation. First thing you check: was it PII? DLP tells you it matched 1,200 SSN patterns. Now it's an incident, not a ticket.

- **L1's first move** is preservation, not eradication. Don't kill the process before someone captures the network session and the endpoint memory — the question "what got out" matters more than "make it stop" once data is already gone. Isolate via EDR (network containment), don't power off.

- **The IR lead's first questions**: *"How many records? What categories — names only, or names + SSN + DOB? Confirmed exfil or attempted? When did access begin? Who's the data owner?"* If you can't answer record count and data category within an hour, the 72-hour GDPR clock is already eating into your timeline.

- **Never promise leadership** "no PII was exfiltrated" until the netflow, proxy logs, and DLP captures are reconciled. *"We have no evidence of exfiltration"* is the most you say in the first 24 hours. The CFO will want a number; give them a range with a confidence level.

- **Handoff path**: L1 confirms PII match → L2 scopes affected records and accounts → IR lead opens incident → **legal and privacy office** engaged immediately (they own the notification clock) → comms and executive briefing → if regulated sector, regulator notification within mandated window. Legal owning the clock is a hard rule — analysts do not decide when to notify.

## Related concepts

[[Data Loss Prevention]] · [[CASB]] · [[SASE]] · [[Zero Trust]] · [[Network Segmentation]] · [[Privileged Access Management]] · [[Identity and Access Management]] · [[Single Sign-On]] · [[Federation]] · [[Multifactor Authentication]] · [[Encryption]] · [[PKI]] · [[TLS]] · [[GDPR]] · [[HIPAA]] · [[PCI DSS]] · [[CHD]] · [[PHI]] · [[Incident Response Lifecycle]] · [[Chain of Custody]] · [[SIEM]] · [[Time Synchronization]] · [[System Hardening]]

*Source: VIRGIL knowledge base — 2026-05-11*