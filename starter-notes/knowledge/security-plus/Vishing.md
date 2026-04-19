---
domain: "social-engineering"
tags: [vishing, social-engineering, phone-fraud, pretexting, voice-phishing, identity-theft]
---
# Vishing

**Vishing** (voice phishing) is a [[Social Engineering]] attack in which an adversary uses telephone calls or voice-over-IP communication to manipulate victims into divulging sensitive information, transferring funds, or granting unauthorized system access. Like its email-based cousin [[Phishing]], vishing exploits human psychology rather than technical vulnerabilities, leveraging urgency, authority, and fear to bypass rational decision-making. Modern vishing campaigns frequently combine [[Caller ID Spoofing]], AI-generated synthetic voices, and detailed [[Open Source Intelligence (OSINT)]] reconnaissance to make attacks nearly indistinguishable from legitimate calls.

---

## Overview

Vishing emerged as a natural evolution of telephone fraud, predating the internet, but exploded in sophistication with the widespread adoption of Voice over IP (VoIP) technology in the early 2000s. VoIP dramatically reduced the cost of placing large volumes of calls and, crucially, decoupled caller identity from physical telephone infrastructure, making [[Caller ID Spoofing]] trivial and inexpensive. Attackers can now rent virtual numbers in any country, route calls through dozens of jurisdictions, and present any caller ID they choose — all for pennies per minute.

The psychological engine of a vishing attack is the same engine that powers all social engineering: the exploitation of cognitive biases. Attackers invoke **authority** (impersonating the IRS, Microsoft, a bank fraud department, or a company's IT help desk), **urgency** (a frozen account, an active arrest warrant, an ongoing breach), **scarcity** (a narrow window to act), and **reciprocity** (offering "help" in exchange for credentials). Humans are conditioned from childhood to trust voices, particularly authoritative ones, making telephone communication an especially powerful attack surface.

Corporate environments face a particularly acute vishing risk through attacks targeting IT help desks and VPN access portals. The 2020 Twitter Bitcoin scam — in which attackers vished Twitter employees into handing over internal admin credentials, ultimately compromising accounts belonging to Barack Obama, Elon Musk, and Apple — demonstrated that no organization is immune. Attackers researched employee rosters using LinkedIn, posed as Twitter IT staff, and convinced legitimate employees to enter credentials into a fake internal VPN portal. The entire breach was accomplished without a single line of exploit code.

In recent years, **AI-powered voice cloning** has elevated vishing from a crude numbers game into a precision weapon. Tools like ElevenLabs, Resemble AI, and open-source projects such as Coqui TTS can generate a convincing replica of a target's voice from as little as three seconds of audio harvested from social media, YouTube videos, or voicemail greetings. In 2019, the CEO of a UK energy firm was defrauded of €220,000 after receiving a call from what he believed was his parent company's German CEO — the voice was entirely AI-synthesized. These "deep voice" attacks represent a frontier challenge for both technical and human defenses.

Vishing is also commonly combined with other attack types in multi-vector campaigns. A typical chain might begin with a [[Smishing]] (SMS phishing) message directing a victim to call a number, followed by a vishing call that collects credentials, followed by an [[Account Takeover]] using those credentials. This hybrid approach exploits multiple trust channels simultaneously, overwhelming the victim's skepticism and making attribution harder for incident responders.

---

## How It Works

### Phase 1: Reconnaissance

Before any call is placed, skilled vishers invest heavily in research. Using OSINT tools and techniques, attackers profile the target organization and individuals:

- **LinkedIn / company websites**: Employee names, titles, reporting structures, internal tool names (e.g., "We use ServiceNow for tickets")
- **Social media**: Voice samples, personal details that build rapport ("How's the team in Austin?")
- **WHOIS / DNS records**: To identify hosting providers, email systems, and domain registrars
- **Data broker sites**: Spokeo, Intelius, BeenVerified yield home addresses, relatives' names, and partial SSNs
- **Previous data breaches**: Credential dumps from [[HaveIBeenPwned]] or dark web forums provide account numbers, password patterns, and security question answers

```bash
# OSINT recon example using theHarvester
theHarvester -d targetcorp.com -b google,linkedin,bing -l 500

# Maltego CE can map employee relationships
# Shodan can identify VoIP infrastructure exposed externally
shodan search "Asterisk PBX" org:"TargetCorp"
```

### Phase 2: Infrastructure Setup

Attackers establish calling infrastructure designed for anonymity and spoofing:

- **VoIP providers**: Services like Google Voice, Twilio, Vonage, or less regulated offshore alternatives (SpoofCard, SpoofTel) allow arbitrary caller ID presentation
- **SIP trunks**: Attackers stand up their own Asterisk or FreeSWITCH PBX instances to control call routing completely
- **Burner numbers**: Temporary DIDs (Direct Inward Dial numbers) purchased with prepaid cards or cryptocurrency

```
; Asterisk dialplan snippet showing caller ID manipulation
; /etc/asterisk/extensions.conf

[outbound-spoofed]
exten => _1NXXNXXXXXX,1,Set(CALLERID(num)=18005551234)
 same => n,Set(CALLERID(name)=IRS Tax Authority)
 same => n,Dial(SIP/trunk1/${EXTEN})
 same => n,Hangup()
```

SIP (Session Initiation Protocol) operates on **UDP/TCP port 5060** (unencrypted) and **port 5061** (TLS-encrypted SIPS). RTP (Real-time Transport Protocol), which carries the actual audio, uses **UDP ports 16384–32767** (range varies by implementation). Because SIP `INVITE` messages carry caller ID in the `From:` header with minimal authentication in many deployments, spoofing is technically straightforward.

### Phase 3: Pretext Development

The attacker crafts a believable story — the **pretext** — tailored to the target:

| Pretext Type | Target | Goal |
|---|---|---|
| Bank fraud department | Consumer | Card numbers, OTP codes |
| IRS / Tax Authority | Consumer | SSN, payment |
| IT Help Desk | Corporate employee | VPN credentials, MFA bypass |
| Vendor/Supplier | Accounts Payable | Wire transfer authorization |
| CEO/Executive impersonation | CFO/Finance | Urgent funds transfer |

### Phase 4: The Call

During the call itself, the attacker uses specific manipulation techniques:

1. **Opening with known information**: Reciting the last four digits of an account number (often obtainable from breaches) to establish false legitimacy
2. **Creating urgency**: "There's an active fraud attempt on your account right now — we need to verify you immediately"
3. **Authority signaling**: Formal language, department names, ticket/case numbers, hold music
4. **Eliciting credentials incrementally**: Not asking for everything at once; building trust before escalating requests
5. **Handling resistance**: "I completely understand your concern about security — let me transfer you to our verification team" (transfers to an accomplice)
6. **OTP harvesting**: Asking the victim to read back the one-time code "we just sent" — intercepting MFA in real time

### Phase 5: Exploitation

With harvested credentials, attackers move laterally:

```
# Timeline of a typical corporate vishing attack

T+0:00  Vishing call to help desk employee
T+0:08  Employee provides AD credentials + MFA code
T+0:09  Attacker logs into VPN with captured credentials
T+0:12  Attacker accesses internal ticketing system
T+0:15  Attacker resets executive email password
T+0:25  Attacker exfiltrates email via IMAP over port 993
T+0:40  Attacker plants persistence (OAuth token grant)
```

---

## Key Concepts

- **Pretexting**: The fabrication of a fictional scenario (pretext) used to manipulate a victim. In vishing, the pretext is the cover story — IRS agent, bank fraud investigator, IT support technician — that provides context and authority for the attacker's requests. Pretexting became explicitly illegal under the Telephone Records and Privacy Protection Act of 2006 in the United States.

- **Caller ID Spoofing**: The technical manipulation of the calling number and name displayed to the recipient. Achieved via VoIP `From:` header manipulation or services like SpoofCard. Legitimate use exists (e.g., hospitals displaying a central callback number), but it is the primary technical enabler of vishing. The STIR/SHAKEN framework was developed to authenticate caller identity at the carrier level.

- **STIR/SHAKEN**: Secure Telephone Identity Revisited / Signature-based Handling of Asserted information using toKENs. A framework mandated by the FCC in 2021 requiring US carriers to cryptographically sign and verify caller identity. Calls receive an "A," "B," or "C" attestation level. STIR/SHAKEN significantly reduces but does not eliminate spoofing, particularly for international calls.

- **Vishing-as-a-Service (VaaS)**: The commoditization of vishing attacks in which criminal groups offer automated IVR (Interactive Voice Response) phishing systems on dark web forums. Victims receive automated calls mimicking bank fraud departments and are prompted to enter card numbers, PINs, and SSNs via their keypad, with data collected in a backend dashboard.

- **Voice Cloning / Deepfake Audio**: The use of AI-based text-to-speech or voice conversion models to synthesize a convincing replica of a specific individual's voice. Modern tools (ElevenLabs, RVC, Coqui XTTS) require minimal sample audio. Attackers target executives, family members, or trusted colleagues to bypass social trust completely.

- **OTP Interception (Real-Time Phishing)**: A vishing technique in which the attacker calls the victim at the precise moment they trigger an MFA SMS or authenticator push, convincing them to read back the code. This defeats SMS-based 2FA, TOTP, and even some push notification systems. Only FIDO2/WebAuthn hardware keys are resistant because authentication is bound cryptographically to the legitimate domain.

- **Smishing-to-Vishing Chain**: A multi-stage attack beginning with an SMS message (smishing) that creates urgency (e.g., "Suspicious login detected — call immediately: 1-800-XXX-XXXX"), then routes the victim to the attacker's call center. The SMS legitimizes the call, and the call legitimizes credential theft.

---

## Exam Relevance

**CompTIA Security+ SY0-701** tests vishing within the broader domain of **Social Engineering** (Domain 2.0 — Threats, Vulnerabilities, and Mitigations).

**Key exam facts to memorize:**

- Vishing = **voice** phishing. Always telephone/VoIP. If the question mentions a phone call and manipulation, the answer is vishing.
- **Pretexting** is the fabricated scenario used in vishing — it is a separate, related concept and may appear as a distractor or a correct answer depending on question framing. Know the distinction: pretexting is the story; vishing is the channel.
- **Smishing** = SMS phishing. Questions may present a scenario chain; identify each stage correctly.
- The primary defense against vishing is **security awareness training** — not technical controls. For exam purposes, when asked about *mitigating* social engineering, training and policy rank above technical solutions.
- **STIR/SHAKEN** may appear as a technology control for vishing/caller ID spoofing. Know it as a carrier-level framework, not an end-user tool.

**Common question patterns:**

> "A user receives a phone call from someone claiming to be from the IT department, asking for their VPN password to fix an urgent outage. What type of attack is this?"
> → **Vishing** (and also involves pretexting)

> "Which attack combines SMS and voice communication to harvest credentials?"
> → **Smishing followed by vishing** (multi-vector social engineering)

> "An employee receives a call from someone claiming to be the CEO, requesting an urgent wire transfer. What should the policy require?"
> → **Out-of-band verification** / **callback procedure to a known number**

**Gotchas:**
- Don't confuse vishing with **whaling** (which targets executives via email). Whaling is email-based; a phone call targeting an executive is still vishing.
- **Impersonation** is the act; vishing is the method. Exam may test either term.
- Vishing exploits **human vulnerabilities**, not software CVEs — don't select technical patch management as a mitigation.

---

## Security Implications

### Attack Vectors

Vishing attacks target several distinct access paths:

1. **Help desk credential reset**: Attackers impersonate employees to reset passwords and MFA tokens, gaining initial access without any malware
2. **Financial wire fraud**: Business Email Compromise (BEC) often includes a vishing component where attackers call Accounts Payable to verbally confirm fraudulent wire instructions
3. **MFA bypass**: Real-time OTP interception defeats most forms of multifactor authentication except hardware FIDO2 tokens
4. **Supply chain impersonation**: Attackers pose as vendors/partners to extract network architecture details, credentials, or initiate fraudulent transactions

### Notable Incidents

| Year | Incident | Impact |
|---|---|---|
| 2019 | UK Energy CEO AI Voice Fraud | €220,000 wired to attacker |
| 2020 | Twitter Bitcoin Scam | 130 accounts compromised; $120,000 BTC stolen |
| 2022 | Uber (Lapsus$ group) | Contractor vishable into MFA fatigue acceptance; full network access |
| 2023 | MGM Resorts | Help desk vishing led to ransomware; $100M+ estimated loss |
| 2023 | Caesars Entertainment | Similar Lapsus$/Scattered Spider vishing TTPs; $15M ransom paid |

The MGM and Caesars incidents are particularly instructive: the Scattered Spider threat group performed 10-minute LinkedIn research sessions on employees, called MGM's help desk, and successfully impersonated an employee to reset credentials. **No technical vulnerability was exploited.**

### Threat Intelligence

MITRE ATT&CK Framework maps vishing under:
- **T1566.004** — Phishing: Vishing (Initial Access)
- **T1598.004** — Gather Victim Identity Information: Phone Call (Reconnaissance)

FBI IC3 reports vishing/BEC losses exceeding **$2.9 billion annually** in the United States alone, making it one of the highest-impact cybercrime categories by financial loss.

---

## Defensive Measures

### Organizational Policy Controls

1. **Callback verification policy**: Any request received by phone that involves credentials, wire transfers, or system access changes MUST be verified by hanging up and calling back on a number sourced independently (from the company directory, not from the caller). This single control defeats the vast majority of vishing attacks.

2. **Out-of-band verification for financial transactions**: Wire transfers above a defined threshold require email + phone + a secondary approval from a different employee — never approve based on a single phone call alone.

3. **Help desk verification procedures**: Require callers to authenticate via employee ID + manager name + secondary factor before any account action. Implement ticket-based audit trails for all password resets and MFA changes.

4. **Code words / duress signals**: High-risk employees (executives, finance, IT admin) should have pre-arranged verbal authentication codes for sensitive requests.

### Technical Controls

```yaml
# Example: Microsoft Entra ID (Azure AD) Conditional Access Policy
# Require phishing-resistant MFA for help desk admin operations

Policy Name: Require FIDO2 for Privileged Actions
Assignments:
  Users: Help Desk Admins, IT Admins
  Cloud Apps: All Cloud Apps
  Conditions:
    Sign-in Risk: Low, Medium, High
Access Controls:
  Grant:
    - Require authentication strength: Phishing-resistant MFA
    - (FIDO2 security key or Windows Hello for Business only)
```

- **FIDO2/WebAuthn hardware keys** (YubiKey, Google Titan): The only MFA method that cannot be intercepted by real-time vishing because authentication is cryptographically bound to the origin domain
- **STIR/SHAKEN awareness**: Ensure telephony providers support attestation;