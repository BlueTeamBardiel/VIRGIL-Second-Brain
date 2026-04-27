---
domain: "social-engineering"
tags: [smishing, phishing, social-engineering, mobile-security, sms, attack]
---
# Smishing

**Smishing** (SMS phishing) is a form of [[Social Engineering]] attack that uses **Short Message Service (SMS)** text messages — or messaging platforms such as iMessage and WhatsApp — to deceive victims into revealing sensitive information, clicking malicious links, or installing [[Malware]]. Like its cousin [[Phishing]], smishing exploits human psychology rather than technical vulnerabilities, leveraging urgency, authority, and fear to bypass critical thinking. It is classified under the broader [[Vishing and Smishing]] category of mobile-targeted [[Social Engineering]] attacks and is explicitly tested on the [[CompTIA Security+ SY0-701]] exam.

---

## Overview

Smishing emerged as a distinct threat vector in the mid-2000s as mobile phone penetration became near-universal. Attackers recognized that SMS messages carry an implicit trust many users do not extend to email — people rarely expect spam or fraud via text, and SMS messages typically enjoy near-100% open rates compared to email's ~20%. This psychological edge makes smishing disproportionately effective despite its technical simplicity. Unlike email phishing, SMS lacks robust filtering infrastructure, sender authentication protocols equivalent to [[DMARC]], [[DKIM]], and [[SPF]], or standardized spam mitigation at the carrier level, meaning malicious messages frequently reach their targets unimpeded.

The operational model for smishing campaigns is straightforward but devastating in practice. Threat actors obtain bulk phone numbers through data broker purchases, compromised databases, automated number enumeration (generating sequential numbers in a target country's format), or by scraping numbers from social media and business directories. They then send mass SMS messages impersonating trusted entities — banks, government agencies (IRS, HMRC, Medicare), parcel delivery companies (FedEx, UPS, Royal Mail), or technology providers (Apple, Google, Microsoft) — directing victims to spoofed websites or instructing them to call fraudulent phone numbers.

Smishing attacks escalate in sophistication at the targeted end of the spectrum. Spear smishing (targeted smishing) uses OSINT-gathered personal information to craft highly convincing messages referencing the victim's name, employer, recent purchases, or geographic location. In 2022, the Scattered Spider (UNC3944) threat group conducted highly targeted smishing campaigns against employees of major technology companies and telecommunications providers, successfully tricking employees into providing credentials and MFA codes, ultimately leading to breaches at companies including MGM Resorts and Caesars Entertainment.

The technical delivery infrastructure behind smishing campaigns typically involves **SMS aggregator abuse**, **SIM farms**, **GSM modems** loaded with prepaid SIMs, or **SMS spoofing services** (some legitimate services repurposed maliciously) that allow sender ID manipulation. In some jurisdictions, criminals exploit **SS7 (Signaling System No. 7)** protocol weaknesses to deliver messages while masking origin. The low cost — bulk SMS can cost fractions of a cent per message — makes smishing economically attractive at scale.

Regulatory and law enforcement responses have been limited in effectiveness. The CTIA and major US carriers implemented the **STIR/SHAKEN** framework (primarily for voice calls) and the **10DLC (10-Digit Long Code)** registration system, which requires businesses to register their messaging campaigns. However, threat actors operating internationally or using unregistered SIM cards largely circumvent these controls. The UK's National Cyber Security Centre (NCSC) reported over 6.4 million suspicious SMS messages reported to its 7726 reporting service in 2021 alone.

---

## How It Works

### Phase 1: Reconnaissance and Target Acquisition

Attackers compile target phone number lists through several mechanisms:

- **Data breach databases**: Purchasing dumps from dark web markets (e.g., numbers from breached e-commerce, healthcare, or financial records)
- **Number harvesting tools**: Automated scrapers targeting LinkedIn, public business directories, or social media profiles
- **Sequential enumeration**: Generating all valid numbers within a carrier's number block
- **Previous campaign responses**: Confirming "live" numbers from those who replied to or clicked earlier messages

### Phase 2: Infrastructure Setup

Attackers build their smishing infrastructure:

```
Attack Infrastructure Components:
├── SMS Delivery
│   ├── SIM Farm (multiple physical SIM cards + GSM modems)
│   ├── Bulk SMS API (abused legitimate aggregator)
│   ├── SMS Spoofing Service (alphanumeric sender ID)
│   └── VoIP-to-SMS gateway
│
├── Malicious Landing Pages
│   ├── Typosquat domain (e.g., app1e-secure-verify[.]com)
│   ├── Cloned bank/service login page
│   ├── URL shortener to obscure destination
│   └── Hosting on bulletproof provider or compromised legitimate site
│
└── Credential Harvesting Backend
    ├── Reverse proxy (Evilginx2, Modlishka) for real-time MFA bypass
    ├── Custom phishing kit
    └── Exfil channel (Telegram bot, email, C2 server)
```

### Phase 3: Message Crafting

Effective smishing messages share psychological trigger characteristics:

```
EXAMPLE SMISHING TEMPLATES (for awareness/education):

[URGENCY + AUTHORITY]
"USPS: Your package #9400111899223947 cannot be delivered. 
Update your address within 24hrs: usps-delivery-update[.]info"

[FINANCIAL THREAT]
"Wells Fargo ALERT: Suspicious charge $847.00 detected. 
If not you, verify immediately: wf-secure-login[.]net/verify"

[PRIZE/REWARD]
"Congratulations! You've been selected for a $500 Amazon 
gift card. Claim before midnight: amzn-rewards[.]xyz"
```

Key message attributes:
- **Short and scannable**: Designed to be read in <5 seconds
- **Shortened or lookalike URLs**: Using bit.ly, t.ly, or registered typosquat domains
- **Sender ID spoofing**: Alphanumeric sender names mimicking "FedEx," "Chase," or "Apple"
- **Personalization**: Including victim name or last 4 digits of account number (obtained from breaches)

### Phase 4: Credential Harvesting / Malware Delivery

Upon clicking the link, victims encounter one of several payloads:

**Credential Harvesting via Reverse Proxy:**
Tools like **Evilginx2** act as a man-in-the-middle between victim and legitimate service, capturing session tokens in real time — bypassing SMS-based MFA:

```bash
# Evilginx2 conceptual operation (defensive awareness only)
# Attacker configures phishlet for target service
# Victim → attacker proxy → real service
# Proxy captures: username, password, session cookie
# Attacker replays cookie → authenticated session (MFA bypassed)
```

**Android Malware Delivery:**
Smishing messages targeting Android users may link to APK files hosted outside the Play Store:

```
Message: "Your bank app needs a security update. Download here: 
bankname-security[.]com/update.apk"

Result: Victim installs banking trojan (e.g., FluBot, Cerberus, 
SharkBot) that overlays legitimate banking apps and steals credentials
```

**iOS Exploitation:**
iOS restricts sideloading, so iOS-targeted smishing typically:
- Directs to credential phishing pages
- Attempts WebKit exploit delivery (rare, nation-state level)
- Uses MDM enrollment trick to gain device control

### Phase 5: Exfiltration

Stolen credentials are immediately exfiltrated via:
- Telegram bot API calls (`https://api.telegram.org/bot<TOKEN>/sendMessage`)
- Direct POST to attacker-controlled database
- Email relay to attacker inbox
- Real-time operator console if using commercial phishing kit

---

## Key Concepts

- **Smishing**: A portmanteau of "SMS" and "phishing"; the use of text messages to conduct social engineering attacks targeting credentials, financial information, or malware installation.
- **SIM Farm**: A physical array of GSM modems each loaded with prepaid SIM cards, used to send mass SMS messages while making attribution difficult; a primary infrastructure component for large-scale smishing operations.
- **Sender ID Spoofing**: The manipulation of the alphanumeric "From" field in an SMS message to display a trusted brand name (e.g., "FedEx," "IRS," "Apple") instead of the actual originating number; enabled by SMS gateways that allow custom sender IDs with minimal verification.
- **Evilginx2 / Reverse Proxy Phishing**: An attack technique using a transparent reverse proxy that sits between the victim and a legitimate service, capturing authentication cookies in real time and defeating time-based OTP (TOTP) and SMS-based MFA; particularly relevant to modern smishing campaigns.
- **FluBot / Cabassous**: A sophisticated Android banking malware family (disrupted by Europol in 2022) distributed heavily via smishing; once installed, it harvested banking credentials, accessed contact lists to self-propagate smishing messages, and intercepted SMS-based OTP codes.
- **SS7 Vulnerability**: Weaknesses in the Signaling System No. 7 telecom protocol that can be exploited to intercept SMS messages, enabling attackers to capture MFA codes or assist in smishing delivery operations; demonstrates why SMS-based MFA is considered a weak second factor.
- **Spear Smishing**: A highly targeted variant using OSINT-gathered personal data to craft individualized messages; used in advanced threat actor campaigns (e.g., Scattered Spider) against corporate employees to steal credentials with high success rates.
- **10DLC Registration**: A US carrier-level system requiring businesses to register their messaging campaigns and brand identities before sending application-to-person (A2P) SMS at scale; intended to reduce spam but largely circumvented by criminal operators using unregistered international routes.

---

## Exam Relevance

**SY0-701 Domain Mapping:** Smishing falls under **Domain 2.0 – Threats, Vulnerabilities, and Mitigations**, specifically objective **2.2 (Threat Vectors and Attack Surfaces)** and **2.4 (Social Engineering)**.

**High-Probability Question Patterns:**

1. **Identification questions**: Given a scenario describing a text message asking a user to click a link and verify bank account details, candidates must identify this as *smishing* (not phishing, vishing, or pharming). The distinguishing factor is always the **SMS/text message delivery channel**.

2. **Comparison questions**: Know the full social engineering family:
   - **Phishing** → Email
   - **Smishing** → SMS/Text
   - **Vishing** → Voice call
   - **Spear Phishing** → Targeted email
   - **Whaling** → Targeted phishing against executives

3. **Mitigation questions**: The exam may ask which control best mitigates smishing. Correct answers include **security awareness training**, **mobile device management (MDM)**, and **filtering solutions**. Do NOT select technical email controls (SPF/DKIM/DMARC) — those apply to email phishing, not SMS.

4. **MFA weakness questions**: Smishing is used to steal SMS-based OTP codes. The exam expects you to know that **SMS-based MFA is weaker** than authenticator apps or hardware tokens and that smishing is a specific threat enabling its bypass.

**Common Gotchas:**
- Don't confuse smishing with **vishing** — if a user receives a *call*, it's vishing; if they receive a *text*, it's smishing.
- The exam may present smishing scenarios involving QR codes in text messages — this is still smishing (the delivery vector is SMS).
- "Pretexting" may appear in smishing scenarios — pretexting refers to the fabricated backstory used, not the delivery channel itself.

---

## Security Implications

### Attack Surface

SMS as a protocol was designed in an era where security was not a priority. The **GSM (Global System for Mobile Communications)** standard and its SMS subsystem lack:
- End-to-end encryption by default
- Sender authentication mechanisms
- Equivalent infrastructure to email's anti-spoofing standards

This creates a fundamentally weak baseline compared to email, where decades of anti-phishing tooling exists.

### Real-World Incidents

**Scattered Spider / UNC3944 (2022–2023):**
This financially motivated threat group conducted large-scale spear smishing campaigns against IT helpdesk employees at MGM Resorts, Caesars Entertainment, and multiple telecommunications companies. They sent targeted SMS messages impersonating IT department alerts, directing employees to phishing pages harvesting credentials and MFA codes. The MGM breach alone resulted in estimated losses exceeding $100 million. This group demonstrated that highly skilled smishing, combined with [[Vishing]], can defeat MFA and compromise enterprise environments.

**FluBot Android Malware Campaign (2020–2022):**
FluBot was distributed almost exclusively via smishing, with messages purporting to be parcel delivery notifications. Victims who installed the APK had their banking credentials stolen, their contact lists exfiltrated (enabling further smishing propagation), and their SMS messages intercepted. Europol disrupted the FluBot infrastructure in May 2022 after it had infected hundreds of thousands of devices across Europe and Australia.

**IRS Impersonation Campaigns (Recurring):**
Annual tax season smishing campaigns impersonating the IRS, claiming victims owe taxes or are due a refund, directing to credential harvesting pages or requesting gift card payments. The IRS explicitly does not initiate taxpayer contact via SMS, making these clearly fraudulent — yet they succeed due to fear and authority bias.

**CVE Relevance:**
While smishing itself is a social engineering attack without a CVE designation, malware delivered via smishing has associated CVEs:
- **CVE-2021-30983**: iOS WebKit vulnerability targeted via smishing-delivered URLs in nation-state operations
- **CVE-2023-20963**: Android Framework privilege escalation exploited post-smishing malware installation

---

## Defensive Measures

### For Organizations

**1. Security Awareness Training:**
Train employees specifically on SMS-based threats. Tabletop exercises should include smishing scenarios. Reinforce that legitimate IT departments and financial institutions will never request credentials or MFA codes via text message.

```
Policy Statement Example:
"[Organization] IT will never request your password, 
verification code, or account information via SMS. 
If you receive such a message, report it to security@company.com 
and delete it without clicking any links."
```

**2. Mobile Device Management (MDM):**
Deploy MDM solutions (Microsoft Intune, Jamf, VMware Workspace ONE) to:
- Enforce app whitelisting, preventing installation of sideloaded APKs
- Enable mobile threat defense (MTD) integrations (Lookout, Zimperium, CrowdStrike Falcon for Mobile)
- Restrict unknown source installation on managed Android devices

```bash
# Android MDM policy (Intune example concept)
# Block installation from unknown sources
# Require Google Play Protect
# Enforce minimum OS version (patches WebKit/system vulns)
```

**3. Replace SMS MFA with Phishing-Resistant Authentication:**
Migrate from SMS-based OTP to:
- **FIDO2/WebAuthn hardware keys** (YubiKey, Google Titan)
- **Authenticator apps** (Microsoft Authenticator, Duo) — still vulnerable to real-time phishing proxy but harder than SMS
- **Certificate-based authentication**

**4. DNS Filtering and Secure Web Gateway:**
Deploy DNS filtering (Cisco Umbrella, Cloudflare Gateway, Pi-hole with threat feeds) that blocks known smishing domains. When mobile users click links, DNS filtering can prevent resolution of malicious hostnames:

```
# Pi-hole blocklist addition for phishing domains
# /etc/pihole/adlists.conf
# Add: https://phishing.army/download/phishing_army_blocklist_extended.txt
# Update gravity: pihole -g
```

**5. Carrier-Level Reporting:**
In the US, forward suspicious SMS messages to **7726 (SPAM)** — the cross-carrier spam reporting shortcode. Carriers use this data to block identified smishing campaigns. In the UK, forward to **7726** as well (NCSC/Ofcom program).

**6. Incident Response Procedure for Smishing:**
Define a clear procedure:

```
Smishing Incident Response Checklist:
1. Do NOT click link or call number in message
2. Screenshot message for evidence
3. Report to security team / IT helpdesk
4. Forward to