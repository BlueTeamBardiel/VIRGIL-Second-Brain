# Privacy vs. Security

## What it is

In **Smash Bros**, when you boot up a match the game asks two different questions. The **rules screen** asks *what's allowed* — items on or off, stock count, stage hazards, Final Smashes legal? That's security: the ruleset that governs what can happen in the arena. The **player tag screen** asks *who you are* — your name, your main, your tag, your online ID. That's privacy: what gets collected about you, who sees it, and whether your "xX_DadKiller_Xx" tag shows up on the global leaderboard. You can have a perfectly locked-down ruleset (no items, Final Destination, three stocks) and still leak every player's handle to anyone watching the replay. **Strong security does not mean private. Private data does not mean secure.**

Plain English: **Security** is about protecting data from unauthorized access, modification, or destruction. **Privacy** is about controlling how data — specifically data about people — is collected, used, shared, and retained. Security is the lock on the door. Privacy is the question of whether you should have collected the visitor's home address in the first place.

Technical CS0-003 framing: Security controls implement confidentiality, integrity, and availability for any data classification. Privacy controls govern the lawful, ethical, and consented handling of **personally identifiable information (PII)**, **cardholder data (CHD)**, **protected health information (PHI)**, and other regulated personal data categories. The two domains overlap but are not synonymous. Encryption is a security control that *supports* privacy; consent management is a privacy control that has no security analog.

## Why it matters

CySA+ Objective 1.1 covers sensitive data protection — **DLP**, **PII**, **CHD** — because the analyst sitting at the SIEM is the first person to notice when 800,000 records leave the network at 2am. But the analyst's job doesn't stop at "block the exfil." If those 800,000 records were collected without consent, retained past policy, or stored in a cloud bucket the data protection officer never knew existed, the security incident becomes a regulatory incident. Different reporting clock. Different lawyers. Different career trajectory for whoever owned the bucket.

The exam tests this distinction because real-world breaches collapse it. GDPR fines aren't levied because data got stolen — they're levied because data shouldn't have been collected, or shouldn't have been retained, or shouldn't have been sent to a US subprocessor without a transfer mechanism. Equifax wasn't just a security failure; it was a privacy failure compounded by a security failure. The analyst who understands both gets promoted. The one who only sees CIA gets blindsided.

## Key facts

### Security vs. privacy — the clean split

| Dimension | Security | Privacy |
|---|---|---|
| **Question** | Is the data protected? | Should we have this data at all? |
| **Triad** | Confidentiality, Integrity, Availability | Notice, Consent, Minimization, Purpose Limitation |
| **Controls** | [[Encryption]], [[MFA]], [[IAM]], [[Network Segmentation]], [[EDR]] | Consent management, data classification, retention schedules, DSAR fulfillment |
| **Owner** | CISO, SOC, IR | DPO (Data Protection Officer), Legal, Compliance |
| **Regulator** | Industry (PCI Council, NIST) | Government (GDPR, CCPA, HIPAA, CIRCIA) |
| **Failure mode** | Breach, ransomware, exfil | Unconsented collection, over-retention, unlawful disclosure |

Memorize the asymmetry: **you can be secure without being private** (a perfectly encrypted database of data you had no right to collect), and **you can be private without being secure** (a tiny, consented, minimized dataset sitting in a misconfigured S3 bucket). Both states are bad. The job is to do both.

### Personally Identifiable Information (PII)

PII is any data that identifies an individual alone or in combination with other data. CompTIA splits it two ways:

- **Direct identifiers** — SSN, driver's license, passport number, full name + DOB, biometric template, account number with credentials
- **Indirect identifiers** — ZIP code, gender, date of birth (the famous Sweeney study showed 87% of Americans are uniquely identifiable from just these three)

**Sensitive PII** = direct identifiers + categories like medical, financial, sexual orientation, religious affiliation, immigration status. Loss requires notification under most US state laws.

**Non-sensitive PII** = public-record stuff (name in a phone book, business email). Still PII, lower breach threshold.

[[Cardholder Data]] (CHD) under PCI DSS is its own beast: PAN (Primary Account Number), cardholder name, expiration date, service code. **Sensitive Authentication Data** (full track, CAV2/CVC2/CVV2, PIN) cannot be stored post-authorization, ever, even encrypted.

### Generally Accepted Privacy Principles (GAPP) — the ten

CompTIA leans on GAPP and the OECD principles as the framework for privacy program design. Memorize the ten — they map almost directly to GDPR articles:

1. **Management** — written policy, accountable owner (DPO)
2. **Notice** — tell the data subject what you're collecting and why
3. **Choice & Consent** — opt-in (GDPR) or opt-out (some US frameworks) before processing
4. **Collection** — only what's necessary (data minimization)
5. **Use, Retention & Disposal** — purpose limitation + retention schedules + secure destruction
6. **Access** — Data Subject Access Request (DSAR) — the subject can see and correct
7. **Disclosure** — third-party sharing only with agreement (DPA, BAA for HIPAA)
8. **Security** — this is where privacy borrows the entire CIA stack
9. **Quality** — accurate, current, complete
10. **Monitoring & Enforcement** — audits, incident response, regulator notification

Principle 8 is the bridge. Every privacy program assumes a working security program underneath it.

### Where security controls serve privacy

The CySA+ exam likes to ask which control protects which property. Cheat sheet:

| Control | Security property | Privacy property |
|---|---|---|
| [[Encryption]] (at rest, in transit) | Confidentiality | Supports minimization-of-exposure |
| [[Data Loss Prevention]] (DLP) | Prevents exfil | Enforces collection/disclosure limits |
| [[Identity and Access Management]] (IAM) | Authentication, authorization | Enforces purpose limitation (need-to-know) |
| [[Tokenization]] / Pseudonymization | Reduces breach scope | Required by GDPR Art. 32 |
| [[Cloud Access Security Broker]] (CASB) | Shadow IT discovery, policy enforcement | Detects unconsented data flows to SaaS |
| [[Zero Trust Architecture]] | "Never trust, always verify" | Enforces least-privilege access to PII stores |
| Retention/disposal automation | Reduces attack surface | Required by purpose limitation |

DLP is the analyst's most direct daily privacy tool. A DLP rule that flags "9 digits, dash, 2 digits, dash, 4 digits" leaving via email isn't catching a security threat in the abstract — it's catching an SSN going somewhere it shouldn't, which is privacy violation first and security incident second.

### Regulatory clocks (CompTIA loves these)

- **GDPR**: 72 hours from awareness to supervisory authority notification. Affected individuals "without undue delay" if high risk.
- **CCPA/CPRA**: notification "in the most expedient time possible and without unreasonable delay."
- **HIPAA Breach Notification Rule**: 60 days to individuals, HHS, and (if >500 records in a state) media.
- **PCI DSS**: immediate notification to card brands and acquirer; forensic investigator (PFI) typically engaged within days.
- **CIRCIA** (US, critical infrastructure): 72 hours for significant incidents, 24 hours for ransomware payment.

> **CompTIA exam trap:** GDPR's 72 hours starts from **awareness** of the breach, not from the breach itself. If your SIEM caught a data exfil on Monday but the SOC didn't escalate it as a confirmed personal-data breach until Thursday, the clock started Thursday — but be ready to defend that delay to the regulator. "We didn't know" only works if you can prove a reasonable detection capability.

> **CompTIA exam trap:** PII and CHD are not the same thing and have different controls. PCI DSS forbids storing CVV/CVV2 *at all* post-auth. PII rules generally allow storage with consent + security controls. Don't pick "encrypt and retain the CVV" as the right answer — it's never right.

> **CompTIA exam trap:** Anonymized data is not PII and is out of scope for most privacy laws. **Pseudonymized** data (replaced with a token, but reversible with a key) **is still PII** under GDPR. The exam will offer "we anonymized it" when the scenario describes pseudonymization — wrong answer.

### Privacy-impacting architecture decisions

Objective 1.1 also covers infrastructure choices. Each has a privacy dimension:

- **[[Cloud]] (IaaS/PaaS/SaaS)** — data residency. GDPR cares where the bytes physically sit. Transfer to a US-region S3 bucket without SCCs (Standard Contractual Clauses) is a violation regardless of how well-encrypted the bucket is.
- **[[Hybrid]] / [[On-Premises]]** — easier residency control, harder logging discipline.
- **[[Serverless]] / [[Containerization]]** — ephemeral compute makes log retention and audit harder. Privacy programs need to prove what data was processed; "the container is gone" is not an answer.
- **[[Federation]] / [[SSO]]** — identity data crosses trust boundaries. Each federation partner is a data processor under GDPR.
- **[[Network Segmentation]]** — segmenting PII stores isn't just security hygiene; it's evidence of purpose limitation when the regulator asks.

## SOC reality

- **The DLP alert at 11pm**: 47 records matching the SSN regex left via a personal Gmail attachment. The L1 doesn't just block and close — they preserve the email, identify the sender, flag for the privacy officer. The CISO will ask "is this notifiable?" within an hour. Wrong answer ends careers.
- **The discovery call**: someone in marketing spun up a SaaS analytics tool and pushed three years of customer email addresses into it. No DPA, no consent update, no security review. CASB caught it. Now it's a privacy incident with no malicious actor — and it still triggers the 72-hour clock if the SaaS vendor is offshore and the data subjects are EU residents.
- **The IR lead's first question after "what was taken?"**: "Was it PII? Was it CHD? Was it PHI?" The answer determines which lawyers join the bridge, which regulators get called, and which insurance policy applies. Get this wrong and the response plan executes against the wrong playbook.
- **Never tell leadership "it's just metadata"**: IP addresses, device IDs, and behavioral profiles are PII under GDPR. The "it's only logs" framing has cost organizations seven-figure fines.
- **The handoff**: SOC owns detection and containment. The **Data Protection Officer** owns regulator notification, DSAR response, and the public statement. If your org doesn't have a DPO, find out who's playing that role *before* the incident, not during.

## Related concepts

[[PII]] · [[Cardholder Data]] · [[PHI]] · [[Data Loss Prevention]] · [[GDPR]] · [[HIPAA]] · [[PCI DSS]] · [[CIRCIA]] · [[Encryption]] · [[Tokenization]] · [[CASB]] · [[Zero Trust Architecture]] · [[Identity and Access Management]] · [[Data Classification]] · [[Sensitive Data Protection]] · [[Incident Response Lifecycle]] · [[Chain of Custody]]

*Source: VIRGIL knowledge base — 2026-05-11*