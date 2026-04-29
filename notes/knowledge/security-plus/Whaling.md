---
domain: "social-engineering"
tags: [whaling, phishing, social-engineering, spear-phishing, business-email-compromise, executive-targeting]
---
# Whaling

**Whaling** is a highly targeted form of [[Spear Phishing]] that specifically aims at **high-value individuals** — executives, board members, CFOs, and other C-suite personnel — using carefully crafted, personalized deception to steal credentials, authorize fraudulent transactions, or deliver [[Malware]]. Because these targets have elevated access to sensitive systems and financial authority, a successful whaling attack can yield catastrophic organizational damage. Whaling is closely related to [[Business Email Compromise (BEC)]] and represents one of the most financially destructive forms of [[Social Engineering]].

---

## Overview

Whaling derives its name from the analogy of hunting "big fish" — the attack is distinguished from generic [[Phishing]] not just by its target selection, but by the extraordinary level of personalization and research invested in each campaign. Threat actors spend weeks or months performing open-source intelligence (OSINT) gathering, studying the target's communication style, professional relationships, ongoing projects, and organizational structure before crafting a single message. The result is an email or other communication that is nearly indistinguishable from legitimate correspondence.

The financial impact of whaling is severe. The FBI's Internet Crime Complaint Center (IC3) consistently ranks BEC and executive-targeted fraud among the costliest cybercrime categories. In 2020 alone, BEC schemes — of which whaling is a primary driver — accounted for over $1.8 billion in losses according to IC3 reporting. High-profile cases include the 2016 Ubiquiti Networks incident, where attackers impersonating executives convinced finance employees to transfer approximately $46.7 million to fraudulent overseas accounts.

Unlike opportunistic phishing that relies on volume and crude lures (e.g., generic "your account has been suspended" emails), whaling lures are contextually rich. They reference real internal projects, use the correct formatting and signature style of internal communications, correctly name colleagues and business partners, and often arrive at psychologically exploitable moments — quarterly close, merger negotiations, or during a known business trip when the impersonated executive is unreachable. The attacker may have surveilled LinkedIn, press releases, SEC filings, and conference speaker bios to populate the message with authentic-sounding context.

Whaling attacks are not limited to email. Attackers increasingly leverage SMS (referred to as **smishing**), phone calls (**vishing**), and even deepfake audio or video to impersonate executives. In 2019, a UK-based energy company CEO was deceived by an AI-generated deepfake voice that mimicked his parent company's CEO, resulting in a fraudulent $243,000 wire transfer — demonstrating that whaling has evolved beyond purely email-based tactics.

The attack surface for whaling has expanded with the proliferation of collaboration tools like Microsoft Teams, Slack, and Zoom. Threat actors have begun compromising or spoofing identities within these platforms to conduct whaling-style attacks outside of the traditional email vector, making detection and prevention significantly more complex for security operations teams.

---

## How It Works

Whaling follows a structured, multi-phase attack lifecycle that mirrors professional intelligence operations more than typical cybercrime.

### Phase 1: Target Selection and OSINT Reconnaissance

Attackers begin by identifying high-value targets using publicly available information:

- **LinkedIn** — Identifies executive names, titles, direct reports, organizational structure, and recent role changes
- **Company websites** — "About Us" and "Leadership" pages reveal full names, email formats, and sometimes direct phone numbers
- **SEC EDGAR filings (10-K, 8-K, DEF 14A)** — Reveals board composition, executive compensation, and strategic initiatives
- **Press releases and news articles** — Reveals ongoing M&A activity, partnerships, or financial status
- **Conference speaker lists and published schedules** — Reveals when executives may be traveling or unavailable

Tools commonly used in this phase:
```bash
# theHarvester — collect emails and names from public sources
theHarvester -d targetcompany.com -b linkedin,google,bing -l 200

# Maltego (GUI) — graph-based OSINT mapping of organizational relationships

# Hunter.io — discover email formats and executive addresses
curl "https://api.hunter.io/v2/domain-search?domain=targetcompany.com&api_key=YOUR_KEY"
```

### Phase 2: Email Infrastructure Setup

Attackers register lookalike domains designed to evade casual scrutiny:

| Legitimate Domain | Spoofed/Lookalike Domain |
|---|---|
| targetcorp.com | targetc0rp.com |
| targetcorp.com | target-corp.com |
| targetcorp.com | targetcorp-security.com |
| targetcorp.com | targetcorp.net |

If the target organization lacks strict [[DMARC]] enforcement, attackers may directly spoof the `From:` header without needing a lookalike domain:

```
From: CEO Name <ceo@targetcorp.com>          ← Display name
Reply-To: attacker@evil-domain.com           ← Hidden redirect
```

Email headers revealing this manipulation:
```
Received: from mail.evil-domain.com (evil-domain.com [203.0.113.55])
From: John Smith <ceo@targetcorp.com>
Reply-To: john.smith.ceo@gmail.com
```

### Phase 3: Crafting the Lure

The whaling email is meticulously constructed:

- **Subject line** references real current events: `RE: Q3 Earnings Call Prep - Wire Transfer Needed`
- **Tone and vocabulary** matches the impersonated executive's known communication style (harvested from public speeches, investor calls, or previous email leaks)
- **Urgency and authority** create psychological pressure: "I'm in meetings all day, please handle this immediately and don't discuss with anyone else per our NDAs"
- **Plausible context**: references a real acquisition, vendor relationship, or internal initiative uncovered during OSINT

### Phase 4: Execution and Follow-Up

The attack is delivered and the attacker actively manages the interaction:

```
Attack vector selection:
├── Email spoofing / lookalike domain
├── Compromised email account (if initial access already achieved)
├── SMS/Vishing as follow-up to add pressure
└── Collaboration platform message (Teams/Slack impersonation)
```

After the initial message, attackers often follow up with phone calls using VoIP spoofing to display the executive's real number:

```bash
# VoIP spoofing concept (educational — SIP INVITE manipulation)
# Attackers use services that allow arbitrary CallerID setting
# Legitimate SIP field:
# From: "John Smith CEO" <sip:jsmith@company.com>
```

### Phase 5: Payload Execution

The attack culminates in one or more of:
- **Wire transfer fraud** — Finance employee transfers funds to attacker-controlled account
- **Credential harvesting** — Target clicks link to a convincing portal login page
- **Malware delivery** — Malicious attachment (macro-enabled DOCX, ISO, PDF with embedded JavaScript)
- **Data exfiltration authorization** — Target is social-engineered into approving data access or sharing sensitive files

---

## Key Concepts

- **Whaling**: A subcategory of [[Spear Phishing]] that targets specifically high-level executives and board members, characterized by extensive pre-attack OSINT and exceptionally personalized lure content.
- **Business Email Compromise (BEC)**: A related attack category in which attackers use either compromised or spoofed email accounts to conduct fraud; whaling is often the mechanism used to initiate BEC scenarios.
- **Lookalike Domain**: A malicious domain name crafted to visually resemble a legitimate domain, using techniques like homoglyph substitution (rn → m), hyphen insertion, or TLD swapping to deceive recipients performing only casual inspection.
- **DMARC (Domain-based Message Authentication, Reporting & Conformance)**: An email authentication protocol that instructs receiving mail servers how to handle emails that fail [[SPF]] and [[DKIM]] checks; a properly enforced DMARC policy of `p=reject` is the single most effective technical control against domain spoofing in whaling.
- **OSINT (Open-Source Intelligence)**: The systematic collection and analysis of information available from public sources; in whaling, attackers use OSINT to build a detailed profile of the target executive and organizational context to construct believable lures.
- **Deepfake Social Engineering**: The use of AI-generated synthetic audio or video to impersonate trusted individuals; increasingly used as a whaling vector to supplement or replace email-based deception.
- **Vishing**: Voice phishing conducted over telephone; in whaling campaigns, vishing is used to add urgency or verify fraudulent wire transfer requests, exploiting the authority of an impersonated executive.

---

## Exam Relevance

**SY0-701 Domain Mapping**: Whaling appears under **Domain 2.0 – Threats, Vulnerabilities, and Mitigations**, specifically within social engineering attack types.

**Key Exam Facts**:
- Whaling = phishing + **executive/high-value target** — this distinction is the most commonly tested point
- The exam differentiates: **Phishing** (broad), **Spear Phishing** (targeted individual), **Whaling** (specifically executives/C-suite)
- Whaling is classified as a **social engineering** attack, not purely a technical attack
- Associated defenses tested include: [[DMARC]], [[SPF]], [[DKIM]], user awareness training, and multi-person authorization for financial transfers

**Common Question Patterns**:
1. *"A CFO receives an email appearing to be from the CEO requesting an urgent wire transfer. The email passes spam filters and uses the CEO's real name and title. What type of attack is this?"* → **Whaling**
2. *"Which control would BEST prevent domain spoofing used in a whaling attack?"* → **DMARC with p=reject policy**
3. *"An attacker spent three weeks researching a company's leadership before crafting a single fraudulent email. What characteristic of this attack is being demonstrated?"* → **High level of personalization / targeted research**

**Common Gotchas**:
- Don't confuse whaling with BEC — BEC is the *broader fraud category*, whaling is the *specific attack technique*
- Whaling doesn't require malware — many successful whaling attacks are purely social and involve no technical exploit
- The exam may present whaling in a voice or SMS context — it is not exclusively email-based

---

## Security Implications

### Vulnerabilities Exploited

Whaling exploits **human cognitive vulnerabilities** rather than software bugs:
- **Authority bias** — Employees are conditioned to comply with executive requests quickly
- **Urgency/scarcity** — Time pressure bypasses deliberate rational evaluation
- **Fear of consequences** — Targets avoid questioning the "CEO" out of professional anxiety
- **Lack of out-of-band verification habits** — Finance personnel rarely call back to verify wire requests through a known-good phone number

### Technical Weaknesses Leveraged

- **Absent or unenforced DMARC** — Without `p=reject`, spoofed `From:` headers reach inboxes unmodified
- **No multi-person authorization (MPA) for wire transfers** — Single-approval financial processes create a single point of failure
- **Email client display name trust** — Most email clients prominently show display names and hide actual sending addresses by default, trivially exploited via `From: CEO Name <attacker@evil.com>`

### Notable Real-World Incidents

| Year | Victim | Loss | Method |
|---|---|---|---|
| 2016 | Ubiquiti Networks | $46.7 million | Executive email impersonation, wire fraud |
| 2016 | FACC AG (Austria) | €50 million | CEO fraud / whaling |
| 2019 | UK Energy Firm | $243,000 | AI deepfake voice impersonation |
| 2015 | Mattel | $3 million | Fake CEO wire request (recovered) |

### CVEs and Technical Context

While whaling itself doesn't have assigned CVEs (it exploits human behavior, not software), it frequently leverages:
- **CVE-2017-11882** — Microsoft Office memory corruption used to deliver payload via malicious attachments in targeted phishing
- **CVE-2021-40444** — MSHTML remote code execution via malicious Office documents, used in targeted campaigns
- Email infrastructure misconfigurations that allow header spoofing (not CVE-tracked but cataloged in MITRE ATT&CK as **T1566.002 – Spearphishing Link** and **T1566.001 – Spearphishing Attachment**)

**MITRE ATT&CK Mapping**: Technique **T1566** (Phishing), Sub-technique **T1566.002** (Spearphishing Link), with whaling represented as a high-privilege-target variant.

---

## Defensive Measures

### Email Authentication Stack (Highest Priority)

Deploy the complete email authentication triad on all organizational domains:

```dns
; SPF Record
targetcorp.com. IN TXT "v=spf1 include:mail.provider.com ~all"

; DKIM — configure in mail server (Postfix example)
opendkim-genkey -t -s mail -d targetcorp.com
; Add public key to DNS:
mail._domainkey.targetcorp.com. IN TXT "v=DKIM1; k=rsa; p=MIGfMA0GCSqGSIb3..."

; DMARC — start with p=none to monitor, progress to p=reject
_dmarc.targetcorp.com. IN TXT "v=DMARC1; p=reject; rua=mailto:dmarc-reports@targetcorp.com; ruf=mailto:dmarc-forensics@targetcorp.com; pct=100"
```

Progress the DMARC policy from `p=none` → `p=quarantine` → `p=reject` over 4-8 weeks while monitoring aggregate reports.

### Organizational and Process Controls

- **Multi-Person Authorization (MPA)**: Require two independent approvals for any wire transfer above a defined threshold (e.g., $5,000). Verify via a pre-registered callback number, never the number provided in the request.
- **Out-of-Band Verification Protocol**: Establish a documented procedure requiring voice confirmation of any unusual financial or access requests through a phone number stored in the company directory — not sourced from the email itself.
- **Executive Email Banners**: Configure mail gateways to prepend a visible banner to all externally-originated email even if the display name matches an internal executive:

```
[EXTERNAL EMAIL] This email originated outside the organization.
Verify before clicking links or transferring funds.
```

### Technical Controls

- **Email Gateway Configuration** (Proofpoint, Mimecast, Microsoft Defender for Office 365):
  - Enable **anti-spoofing policies** with strict impersonation detection
  - Enable **executive impersonation protection** — flag any external email where the display name matches a VIP list
  - Deploy **URL sandboxing** and **attachment sandboxing** to detonate suspicious content
  - Configure **VIP/executive impersonation alerts** in SIEM

- **Microsoft 365 Anti-Phishing Policy** (PowerShell):
```powershell
# Enable impersonation protection for executives
Set-AntiPhishPolicy -Identity "Default" `
  -EnableTargetedUserProtection $true `
  -TargetedUsersToProtect @("ceo@targetcorp.com","cfo@targetcorp.com") `
  -TargetedUserProtectionAction Quarantine `
  -EnableMailboxIntelligence $true `
  -EnableSimilarUsersSafetyTips $true
```

### Training and Awareness

- Conduct regular **whaling simulations** targeting specifically C-suite and finance staff — not just general employees
- Train executives to be **skeptical of urgency** in financial requests, regardless of apparent sender
- Publish an internal **"call to verify" culture** — normalize questioning unusual executive requests without professional repercussions
- Brief finance teams on **wire fraud red flags**: new banking details, urgency, secrecy requests, and unusual transfer destinations

---

## Lab / Hands-On

### Lab 1: OSINT Profiling Simulation

Practice OSINT reconnaissance against a **test organization** (your own lab domain or a designated practice target):

```bash
# Install theHarvester
pip3 install theHarvester

# Run against your own lab