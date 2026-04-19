---
domain: "social-engineering"
tags: [vishing, social-engineering, phishing, voice-fraud, pretexting, telecommunications]
---
# Vishing (Voice Phishing)

**Vishing** (a portmanteau of "voice" and "[[Phishing]]") is a form of [[Social Engineering]] in which attackers use telephone calls — real or synthesized — to manipulate victims into revealing sensitive information, transferring funds, or granting unauthorized access. Unlike email-based phishing, vishing exploits the inherent human trust placed in voice communication and the perceived urgency that a live phone call creates. It frequently leverages [[Pretexting]], [[Caller ID Spoofing]], and increasingly, **AI-generated deepfake audio** to convincingly impersonate trusted entities such as banks, government agencies, or IT help desks.

---

## Overview

Vishing occupies a critical niche in the attacker's social engineering toolkit because voice calls trigger psychological responses that text-based attacks often cannot. When a person hears a confident, authoritative voice claiming to be from the IRS, their bank's fraud department, or their company's IT support team, the fight-or-flight response narrows their critical thinking. The attacker exploits this narrow window to extract credentials, one-time passwords (OTPs), credit card numbers, or to direct the victim to install remote access software.

The attack vector predates the internet. "Phone phreaking" culture of the 1960s and 70s — practiced by figures like John Draper ("Captain Crunch") — demonstrated that telecommunication systems could be manipulated through acoustic and social means. Modern vishing evolved from these roots but is now industrialized. Criminal organizations operate offshore call centers staffed with trained "agents" following structured call scripts, targeting thousands of victims per day using automated dialing systems (autodialers) and VoIP infrastructure that costs pennies per call.

The proliferation of **Voice over IP (VoIP)** technology has dramatically lowered the barrier to entry for vishing attacks. Services such as Twilio, Google Voice, and countless SIP (Session Initiation Protocol) providers allow attackers to place calls from anywhere in the world while displaying any caller ID they choose — a technique known as [[Caller ID Spoofing]]. This anonymity, combined with the global reach of internet telephony, makes attribution and law enforcement response extremely difficult.

A newer and particularly dangerous evolution is **AI-assisted vishing**, sometimes called **"deepfake vishing"** or **"voice cloning attacks."** Tools such as ElevenLabs, Resemble AI, and open-source models like Tortoise-TTS can clone a specific person's voice from as little as three to five seconds of audio — obtainable from public videos, voicemails, or social media. In 2019, criminals used AI voice cloning to impersonate a German CEO's voice, directing a UK subsidiary executive to transfer €220,000 ($243,000) to a fraudulent account. This attack demonstrated that vishing has crossed from opportunistic crime into sophisticated, targeted corporate espionage.

Vishing is heavily intertwined with other attack categories. It is commonly used as a **follow-up vector** after a data breach, where attackers use leaked PII (personally identifiable information) to sound credible. It is also used as a **second stage** in hybrid attacks: a phishing email directs a victim to call a phone number, where a live or automated vishing agent then extracts payment card details or credentials. This hybrid form is known as a **telephone-oriented attack delivery (TOAD)** campaign.

---

## How It Works

### Phase 1: Reconnaissance

Before placing a call, sophisticated vishers conduct OSINT (Open Source Intelligence) gathering to build a convincing pretext. Information is sourced from:

- **LinkedIn**: Job titles, managers' names, internal project names, organizational structure
- **Data breach dumps**: Email addresses, phone numbers, partial SSNs from previous breaches (available on dark web markets)
- **Company websites**: Phone directory, "About Us" pages, press releases
- **Social media**: Personal details that make the attacker sound familiar and legitimate

Tools used during recon include `theHarvester`, `Maltego`, and manual searches of breach databases like HaveIBeenPwned.

```bash
# Example: theHarvester gathering public info on a target domain
theHarvester -d targetcompany.com -b linkedin,google,bing -l 200

# Example: Checking for breached accounts associated with a domain
# (using HaveIBeenPwned API v3)
curl -s -H "hibp-api-key: YOUR_API_KEY" \
  "https://haveibeenpwned.com/api/v3/breachedaccount/victim@targetcompany.com"
```

### Phase 2: Infrastructure Setup

Attackers establish anonymous calling infrastructure:

1. **Acquire a VoIP account**: Purchase via prepaid cryptocurrency using a provider that accepts anonymous registration (e.g., VoIP.ms, SipStation, or configure Asterisk with a SIP trunk)
2. **Configure caller ID spoofing**: Most SIP providers allow arbitrary Caller ID via the `From` or `P-Asserted-Identity` SIP header
3. **Set up a PBX if needed**: Asterisk or FreePBX on a VPS allows complex call routing, IVR menus mimicking bank automated systems, and call recording

```ini
; Asterisk extensions.conf snippet simulating a callback number
; (for educational red-team lab use only)
[from-internal]
exten => _1NXXNXXXXXX,1,Answer()
exten => _1NXXNXXXXXX,n,Playback(bank-welcome-message)
exten => _1NXXNXXXXXX,n,Record(/tmp/victim-response.wav)
exten => _1NXXNXXXXXX,n,Hangup()
```

SIP operates over **UDP/TCP port 5060** (unencrypted) and **port 5061** (TLS-encrypted, SIPS). RTP (Real-time Transport Protocol) carries the actual voice data over **UDP ports 10000–20000** (range varies by configuration). Attackers running their own Asterisk server control the full signaling and media path.

### Phase 3: The Call — Execution of the Pretext

The attacker places the call with a spoofed caller ID matching the impersonated organization (e.g., 1-800-XXX-XXXX matching a bank's real number as displayed in CNAM lookups). The call follows a structured script:

**Common pretexts include:**

| Pretext | Claimed Identity | Goal |
|---|---|---|
| Fraud alert | Bank fraud department | OTP / card number |
| IT support | Company help desk | Credentials / RAS install |
| IRS audit | Government agent | Payment / SSN |
| Prize notification | Contest organizer | Payment info / PII |
| CEO fraud | Executive | Wire transfer |

**Psychological manipulation techniques applied during the call:**

- **Authority**: "This is the IRS Criminal Investigation Division."
- **Urgency / Scarcity**: "Your account will be locked in 15 minutes unless we verify."
- **Fear**: "We've detected fraudulent charges totaling $3,400."
- **Reciprocity**: "I'm calling to help you secure your account."
- **Social proof**: "We've already spoken with your manager, John Smith."

### Phase 4: Credential/Data Harvesting

Once rapport and urgency are established, the attacker requests specific information:

- **OTP interception**: Attacker has already triggered an MFA SMS to the victim's phone; they ask the victim to "read back the code we just sent to confirm your identity" — the victim hands over their own MFA token
- **Remote access**: "Download AnyDesk/TeamViewer so I can fix the problem" — attacker gains full GUI control of victim's machine
- **Direct transfer**: "Verify your routing and account number so we can reverse the fraudulent charge"

### Phase 5: Post-Exploitation / Covering Tracks

- Call is placed via VoIP with no traceable physical location
- VPS hosting Asterisk is paid via cryptocurrency and terminated after the campaign
- SIP providers in permissive jurisdictions retain minimal logs
- Proceeds are laundered via cryptocurrency mixing services or gift card purchases (a common vishing cash-out method — "buy $500 in Google Play cards and read me the codes")

---

## Key Concepts

- **Pretexting**: The fabrication of a believable fictional scenario (the "pretext") that gives the attacker a plausible reason to request sensitive information. In vishing, pretexts are reinforced by prior OSINT and use of the victim's actual personal data to build trust. Pretexting is explicitly illegal under the Gramm-Leach-Bliley Act (GLBA) in the United States when used against financial institutions.

- **Caller ID Spoofing**: The technical manipulation of SIP `From` headers or CNAM (Caller Name) data to display an arbitrary phone number to the recipient. Legally regulated in the US by the Truth in Caller ID Act of 2009, which prohibits spoofing with intent to defraud — but enforcement against offshore attackers is effectively impossible.

- **OTP Interception**: A critical vishing technique where the attacker has already begun an authentication attempt (using stolen credentials) and tricks the victim into reading back the one-time password sent via SMS or authenticator app, bypassing MFA protections that would otherwise stop them.

- **Vishing Kits / TOAD (Telephone-Oriented Attack Delivery)**: Structured attack packages sold or shared on criminal forums that include call scripts, spoofed audio of hold music or IVR prompts, and target lists. TOAD campaigns combine email phishing (to deliver a phone number) with live or AI-agent vishing calls that harvest data from victims who call the attacker's number.

- **Voice Cloning / Deepfake Audio**: The use of AI text-to-speech models trained on a target's real voice to generate synthetic audio that is indistinguishable from the genuine speaker. Applied in Business Email Compromise (BEC)-style attacks against executives. Detection requires dedicated audio forensic tools or behavioral anomaly analysis.

- **Vishing via Automated IVR**: Attackers deploy Interactive Voice Response (IVR) systems that mimic bank telephone systems, prompting victims who call back "suspicious charge" numbers to enter their full card number, PIN, and expiry date via DTMF tones — all captured and logged automatically with no human attacker on the line.

- **Smishing-to-Vishing Pivot**: A hybrid attack where an SMS message (smishing) instructs the recipient to call a phone number. The victim, believing they initiated the contact, has lower psychological defenses than they would for an unsolicited call.

---

## Exam Relevance

**CompTIA Security+ SY0-701 Domain**: 5.0 — Security Program Management and Oversight (specifically 5.4 — Summarize elements of effective security compliance; and 2.2 — Explain common threat vectors and attack surfaces)

**Key exam points:**

- Vishing is categorized under **social engineering** attacks alongside phishing, smishing, spear phishing, whaling, and pharming. Know the distinctions: vishing = **voice**, smishing = **SMS**, phishing = **email**.
- The SY0-701 exam expects you to recognize **pretexting** as the foundation of vishing and understand it as a distinct concept (not just a synonym for lying — it's specifically the creation of a fabricated scenario/identity).
- **Impersonation** is the specific social engineering technique being applied during a vishing call — expect questions that ask you to identify the technique when given a scenario description.
- Know that **vishing commonly bypasses MFA** by tricking users into surrendering OTPs — this is a key point about the limitations of SMS-based MFA.
- The exam may present **scenario questions** describing a call from "the IT department" asking for credentials — the correct answer will always be to **verify through an out-of-band channel** (call back using a known-good number from the company directory, not the number the caller provided).
- **Deepfake/AI vishing** may appear in newer question sets as an emerging threat — understand it as a form of **identity fraud** enabled by AI.

**Common gotchas:**
- Don't confuse **vishing** with **war dialing** — war dialing is scanning phone number ranges for modems (a network enumeration technique), not social engineering
- **Pretexting ≠ vishing**: Pretexting is a technique *used within* vishing calls; it's also used in person (physical impersonation) and in written communication
- **Whaling** targets high-value executives; a vishing call targeting a CEO would be both whaling *and* vishing simultaneously

---

## Security Implications

### Attack Surface

Every employee with a phone number is a potential vishing target. This attack surface cannot be firewalled, patched, or filtered at the network layer. Published company directories, LinkedIn profiles, and leaked data breach records continuously refresh the attacker's target list.

### Known Incidents and Case Studies

**2019 — AI CEO Voice Fraud (UK/Germany):** Criminals used AI voice synthesis to impersonate the CEO of a German parent company, calling the UK subsidiary's CFO and directing a €220,000 wire transfer to a Hungarian bank account. First publicly documented case of AI-assisted vishing at the corporate level. (Reported by Wall Street Journal, September 2019.)

**2020 — Twitter Bitcoin Hack (Social Engineering / Vishing Component):** Attackers called Twitter employees impersonating internal IT staff, convincing them to provide credentials to internal admin tools. This granted access used to compromise high-profile accounts (Obama, Musk, Biden, Apple). The attack demonstrated vishing as a **privileged access escalation** vector inside major tech companies. (US DOJ indictment, July 2020.)

**2022 — Uber Breach:** A threat actor (attributed to Lapsus$ group affiliate) conducted vishing against an Uber contractor, repeatedly sending MFA push notifications while calling the contractor and impersonating Uber IT security. The contractor eventually approved the push, granting the attacker access to internal systems. This is a textbook **MFA fatigue + vishing** combined attack.

**IRS Phone Scam Epidemic (2016–present):** The US Treasury Inspector General reported over $80 million stolen from more than 70,000 victims via IRS impersonation vishing calls between 2013 and 2020, with offshore call centers operating primarily from India.

### Vulnerability Factors

- **Lack of caller authentication**: PSTN (Public Switched Telephone Network) was designed with no authentication for caller identity — the calling party asserts its own number
- **STIR/SHAKEN gaps**: While STIR/SHAKEN (Secure Telephone Identity Revisited / Signature-based Handling of Asserted information using toKENs) was mandated for US carriers in 2021, it only signs calls originating from participating carriers — international and VoIP-to-PSTN calls frequently lack attestation
- **SMS MFA vulnerability**: Any MFA scheme that delivers codes to phone numbers can be circumvented via vishing OTP interception
- **Human psychology**: No technical patch exists for authority bias, fear response, or social pressure

---

## Defensive Measures

### Organizational Controls

**1. Security Awareness Training**
Deploy regular, role-specific vishing simulation exercises. Vendors such as KnowBe4, Proofpoint Security Awareness, and Cofense offer vishing simulation modules in addition to phishing simulations. Train employees to:
- Never provide credentials, OTPs, or financial information over an inbound call
- Always verify caller identity by hanging up and calling back using a number from an official directory — not the number provided by the caller
- Recognize urgency and fear as manipulation tactics

**2. Call Verification Procedures (Callback Policy)**
Implement a formal policy: any inbound call requesting sensitive action (password reset, wire transfer, access grant) requires:
- Employee hangs up
- Looks up the caller's number independently
- Calls back on the verified number
- Documents the interaction

**3. Out-of-Band Authentication for Privileged Actions**
Wire transfers, credential resets, and access changes should require **multi-person authorization** confirmed through separate, verified communication channels — not over the same phone call.

**4. DMARC/STIR-SHAKEN Awareness**
Work with your telephony provider to ensure **STIR/SHAKEN attestation** is enabled for outbound calls (protects your organization from being impersonated). Educate employees that "Verified Caller" indicators on modern smartphones are helpful but not foolproof.

### Technical Controls

**5. Network-Level Call Filtering**
Deploy enterprise telephony platforms (Cisco Unified Communications, Microsoft Teams Direct Routing, Zoom Phone) with:
- Call analytics identifying abnormal call patterns
- Integration with reputation-based carrier services (e.g., First