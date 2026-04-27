---
domain: "social-engineering"
tags: [pretexting, social-engineering, attack, human-factors, identity-fraud, manipulation]
---
# Pretexting

**Pretexting** is a form of [[Social Engineering]] in which an attacker fabricates a convincing fictional scenario — a *pretext* — to manipulate a target into divulging sensitive information, granting access, or performing an action they would not otherwise take. Unlike [[Phishing]], which relies on urgency and volume, pretexting is typically targeted, narrative-driven, and often delivered via telephone, email, or in-person interaction. It exploits fundamental human tendencies such as trust, authority bias, and the desire to be helpful, making it one of the most psychologically sophisticated attack categories in the [[Social Engineering]] arsenal.

---

## Overview

Pretexting has existed long before the digital age — con artists and spies have fabricated identities for centuries — but in the modern threat landscape it has evolved into a precise, research-backed attack technique. A pretexter does not simply lie; they construct an entire believable persona supported by verifiable details, industry-specific jargon, and contextual knowledge gathered through [[OSINT (Open Source Intelligence Gathering)]]. The attack begins well before any contact with the victim, often involving days or weeks of reconnaissance to build a credible cover story.

The power of pretexting lies in its exploitation of cognitive shortcuts known as *heuristics*. When someone presents themselves as an authority figure — an IT administrator, a bank auditor, a law enforcement officer, or even a fellow employee — targets instinctively lower their guard. This is rooted in [[Authority Bias]] and [[Social Proof]], psychological phenomena documented extensively in Robert Cialdini's influence research. Attackers weaponize these tendencies deliberately, scripting conversations to trigger compliance before the victim has time to consciously evaluate the request.

Pretexting is not limited to external threat actors. Insider threats may use fabricated pretexts to obtain elevated access, extract data, or manipulate colleagues. Nation-state actors use it for intelligence gathering, corporate espionage, and sabotage. Criminal organizations use it to commit financial fraud — one of the most costly examples being [[Business Email Compromise (BEC)]], where executives are impersonated to authorize fraudulent wire transfers. The 2006 Hewlett-Packard pretexting scandal, in which investigators hired by HP used false identities to obtain phone records of board members and journalists, remains a landmark real-world case that led to the strengthening of U.S. pretexting laws under the Telephone Records and Privacy Protection Act of 2006.

The sophistication of pretexting attacks has grown dramatically with the availability of AI tools. Voice synthesis (deepfake audio) can impersonate executives in real time, and large language models can generate contextually accurate scripts tailored to a specific target organization. Combined with data harvested from [[LinkedIn]], corporate websites, and data broker aggregators, a skilled attacker can construct a pretext indistinguishable from a legitimate interaction. This convergence of technical and human-factors exploitation defines the modern threat.

---

## How It Works

Pretexting attacks follow a structured kill chain that mirrors the broader [[Cyber Kill Chain]] framework but is entirely social in nature. Each phase builds upon the last, and the attack often succeeds long before any technical vulnerability is ever touched.

### Phase 1: Reconnaissance

The attacker collects information about the target organization and individual(s). Sources include:

- **LinkedIn** — job titles, reporting structures, project names, technologies used
- **Corporate websites** — executive names, department structures, press releases
- **WHOIS / DNS records** — domain registrar data, mail servers
- **Job postings** — reveal internal tooling (e.g., "Must know ServiceNow and Okta")
- **Pastebin / data breach dumps** — previously leaked credentials and internal terminology
- **Social media** — personal details that build rapport (mutual connections, hobbies, recent events)

Tools commonly used in this phase:

```bash
# theHarvester - passive OSINT for email and domain data
theHarvester -d targetcorp.com -b google,linkedin,bing -l 500

# Maltego CE - graphical relationship mapping
# (GUI tool; import domain and enumerate relationships)

# Recon-ng framework
recon-ng
> marketplace install all
> modules load recon/domains-contacts/whois_pocs
> options set SOURCE targetcorp.com
> run
```

### Phase 2: Persona Construction

The attacker builds a fictional identity — or hijacks a real one — that fits naturally within the target's environment. Common personas include:

| Persona | Why It Works |
|---|---|
| IT Help Desk technician | Has a legitimate reason to ask for credentials |
| Vendor / third-party contractor | Outsider with partial insider knowledge |
| New employee | Ignorance is expected; asking questions is normal |
| Senior executive | Authority triggers immediate compliance |
| Bank / IRS auditor | Fear and legal obligation override skepticism |
| Recruiter | Targets share professional history willingly |

Supporting artifacts are fabricated to reinforce the persona:
- Spoofed caller ID (using VoIP services like Google Voice or SIP trunks with manipulated `From:` headers)
- Lookalike email domains (e.g., `targetcorp-support.com` vs `targetcorp.com`)
- Fake LinkedIn profiles with connections seeded over weeks
- Cloned corporate email signatures with correct fonts, logos, and disclaimer text

```bash
# SIP caller ID spoofing example (for authorized red team use only)
# Using Asterisk PBX - /etc/asterisk/sip.conf
[general]
fromdomain=targetcorp.com
fromuser=IT-Support

# Dialplan in extensions.conf
exten => _X.,1,Set(CALLERID(num)=+18005551234)
exten => _X.,2,Set(CALLERID(name)=IT Help Desk)
exten => _X.,3,Dial(SIP/${EXTEN}@provider)
```

### Phase 3: Pretext Delivery

Contact is made via the chosen channel. The attacker follows a script designed to:

1. **Establish credibility** — drop insider knowledge, reference real projects, name real colleagues
2. **Create urgency or fear** — "Your account has been flagged," "We're experiencing an active incident"
3. **Request a small initial action** — compliance with minor requests primes the target for larger ones ([[Foot-in-the-Door Technique]])
4. **Extract the payload** — credentials, MFA codes, wire transfer authorization, physical access

### Phase 4: Execution and Pivot

Obtained credentials are used immediately before the victim can second-guess the interaction. In technical attacks, this may involve:

```bash
# Using harvested credentials against corporate VPN
openconnect vpn.targetcorp.com --user=jsmith@targetcorp.com
# Password: obtained via pretext call

# OAuth token theft via harvested session cookies
# Attacker uses obtained MFA code within 30-second TOTP window
```

### Phase 5: Cover-Up

The attacker closes the interaction naturally, leaving no suspicion. Victims of pretexting often do not realize they have been attacked — sometimes for months.

---

## Key Concepts

- **Pretext**: The fabricated scenario, backstory, or justification an attacker creates to make a deceptive request appear legitimate. A good pretext is *verifiable enough* to seem real but *vague enough* to avoid easy disproof.

- **[[Impersonation]]**: The act of claiming to be another person or entity — real or fictional. In pretexting, impersonation of authority figures (IT, management, auditors) is the most common vector because authority bias suppresses critical thinking in targets.

- **[[Vishing]] (Voice Phishing)**: Telephone-based pretexting in which attackers call targets directly. Vishing attacks against financial institutions and crypto exchanges have caused hundreds of millions in losses; the 2022 Uber breach began with a vishing call to an employee.

- **[[Spear Phishing]]**: A highly targeted email-based attack that frequently incorporates pretexting elements — referencing real projects, colleagues, and events to make the malicious request appear routine.

- **[[OSINT (Open Source Intelligence Gathering)]]**: Open-source intelligence collection that forms the foundation of all effective pretexting. Without accurate reconnaissance data, the pretext lacks the specificity needed to overcome a target's skepticism.

- **[[Tailgating]] / Piggybacking**: Physical pretexting in which an attacker uses a fabricated reason (e.g., carrying boxes, claiming to be a contractor) to gain unauthorized physical access to a facility by following authorized personnel through secured doors.

- **Deepfake Audio/Video**: AI-generated synthetic media used to impersonate known individuals in real time or in recorded form. In 2019, a UK energy company CEO was defrauded of €220,000 after attackers used AI voice synthesis to impersonate his parent company's CEO on a phone call.

- **[[Quid Pro Quo Attack]]**: A pretexting variant in which the attacker offers something of value (e.g., "free IT support") in exchange for information or access, creating a sense of reciprocal obligation.

---

## Exam Relevance

**SY0-701 Domain Mapping**: Pretexting falls under **Domain 2.0 — Threats, Vulnerabilities, and Mitigations**, specifically under Social Engineering techniques (2.2).

### Key Exam Tips

- **Pretexting vs. Phishing**: The exam frequently distinguishes these. Phishing is broad, volume-based, and relies on urgency via email/SMS. Pretexting is *narrative-based* and involves constructing a believable identity/scenario — it can be delivered via any channel (phone, email, in-person). If a question describes a fabricated *scenario or role*, the answer is pretexting.

- **Pretexting vs. Impersonation**: These are related but distinct on the exam. Impersonation is *claiming to be someone else*. Pretexting is the *larger constructed scenario* that may include impersonation. A question describing someone who "claimed to be from the IT department and said there was an emergency" combines both — but if forced to choose one, select pretexting when the *scenario construction* is emphasized.

- **Pretexting is always targeted**: Unlike generic phishing, pretexting involves a customized scenario. If a scenario describes personalized details about the target being used, consider pretexting or spear phishing.

- **Authority and Urgency**: The exam recognizes these as the two primary psychological triggers in pretexting attacks. Questions may ask you to identify which principle is being exploited.

- **Legal note**: The exam may reference that pretexting to obtain phone records is illegal in the U.S. (TRPPA 2006) — this came up in the HP scandal context.

### Common Question Pattern

> *An attacker calls an employee, claims to be from the company's external auditing firm, and requests the employee's login credentials to "verify account access during a compliance review." What type of attack is this?*
> **Answer: Pretexting** (fabricated scenario + impersonation of authority)

---

## Security Implications

### Attack Vectors

Pretexting enables a wide range of downstream attacks once initial access or information is obtained:

- **Credential harvesting** → [[Credential Stuffing]], [[Pass the Hash]], [[Account Takeover]]
- **MFA bypass** → Real-time social engineering of OTP codes during active login attempts
- **Wire fraud** → [[Business Email Compromise (BEC)]] scenarios resulting in fraudulent transfers
- **Physical access** → Facility entry enabling hardware implants ([[LAN Turtle]], [[USB Drop Attack]])
- **Data exfiltration** → Convincing employees to email sensitive documents or share screen

### Notable Real-World Incidents

| Incident | Year | Pretexting Vector | Impact |
|---|---|---|---|
| **Hewlett-Packard Board Scandal** | 2006 | False identity to obtain phone records from telcos | Congressional investigation; TRPPA legislation |
| **Uber Data Breach** | 2022 | Vishing call impersonating IT support; MFA fatigue combined with voice pretext | Full network access; 57,000 employee records exposed |
| **MGM Resorts Breach** | 2023 | Vishing LinkedIn research + impersonation of IT help desk | $100M+ operational disruption; ransomware deployment |
| **Deepfake CEO Fraud** | 2019 | AI voice synthesis impersonating parent company CEO | €220,000 fraudulent wire transfer |
| **Twitter VIP Account Takeover** | 2020 | Vishing of Twitter employees for internal tool access | Cryptocurrency scam using accounts of Obama, Musk, Gates |

### Vulnerabilities Exploited (Non-CVE)

Pretexting exploits *process vulnerabilities* rather than software CVEs:

- Lack of callback verification procedures for identity claims
- Help desk policies that allow password resets via phone without secondary verification
- Absence of out-of-band verification for wire transfer requests
- Over-sharing on corporate directories and social media (attack surface for persona construction)
- Insufficient security awareness training leaving employees unable to recognize manipulation tactics

---

## Defensive Measures

### Policy Controls

1. **Strict Identity Verification Procedures**: Any request for credentials, sensitive data, or financial transactions must be verified via a *separate, pre-established communication channel* — not the one initiated by the caller/emailer. If someone calls claiming to be from IT, hang up and call the IT desk's published number independently.

2. **Callback Verification Policy**: Codify in policy that all inbound requests claiming to require urgent access or credential sharing must be validated via callback to a directory-listed number.

3. **Wire Transfer Authorization Policy**: Require dual authorization for transfers above threshold amounts, with mandatory out-of-band (phone) confirmation to known numbers. Never authorize based solely on email.

4. **Zero Trust Data Sharing Policy**: Employees should never share credentials, MFA codes, or sensitive data over the phone regardless of how authoritative the caller sounds.

5. **Least Privilege Access**: Limit the blast radius of successful pretexting by ensuring employees only have access to what they need. A help desk employee cannot hand over what they cannot access.

### Technical Controls

```yaml
# Example: Conditional Access Policy in Azure AD / Entra ID
# Require MFA + device compliance for ALL help desk password resets
# Prevents attacker from leveraging a social-engineered reset

Conditional Access Policy:
  Name: "Block-Unmanaged-Device-Password-Reset"
  Assignments:
    Users: All
    Cloud Apps: Microsoft Graph (Self-Service Password Reset)
  Conditions:
    Device Platforms: All
    Device State: Exclude Hybrid Azure AD Joined
  Grant Controls:
    Require: Multi-Factor Authentication
    Require: Compliant Device
```

```bash
# Configure email header inspection to flag external senders
# impersonating internal domains (Exchange Online Protection)
# Anti-impersonation policy via PowerShell

New-AntiPhishPolicy -Name "Anti-Pretexting-Policy" `
  -EnableOrganizationDomainsProtection $true `
  -EnableMailboxIntelligence $true `
  -EnableMailboxIntelligenceProtection $true `
  -MailboxIntelligenceProtectionAction Quarantine `
  -EnableSpoofIntelligence $true
```

### Human Controls

- **Security Awareness Training**: Conduct regular training using platforms like **KnowBe4**, **Proofpoint Security Awareness**, or **Cofense** that include simulated vishing and pretexting scenarios — not just phishing emails.
- **Red Team Exercises**: Commission periodic social engineering assessments (vishing, physical pretexting, email-based pretexting) against your own organization to measure human control effectiveness.
- **Reporting Culture**: Create a no-blame environment where employees can report suspicious calls/emails without fear of punishment for being targeted.
- **Challenge Phrases**: For high-privilege or high-sensitivity roles, implement shared internal challenge/response phrases to verify identity during sensitive requests.
- **Caller ID Skepticism Training**: Train employees explicitly that caller ID is trivially spoofed and should never be used as proof of identity.

---

## Lab / Hands-On

> ⚠️ **Ethics Notice**: All exercises below are for authorized, controlled environments only. Never conduct social engineering against individuals or organizations without explicit written consent. Use isolated homelab infrastructure.

### Lab 1: OSINT Persona Profiling (Passive Reconnaissance Simulation)

Build a simulated employee profile using only public data from a fictional test company you create:

```bash
# Step 1: Set up a fake LinkedIn-style profile (use a controlled test account)
# Document: name, title, department, technologies, coworkers, recent activity

# Step 2: Use the