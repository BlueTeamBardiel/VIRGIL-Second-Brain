# Phishing

## What it is

In Elden Ring, there's a creature called the **Mimic Tear** — and even more devilishly, the **Mimic Chest**. You walk into a dungeon, exhausted, low on Flasks, and there sits a beautiful chest at the end of a corridor. Loot! Except when you reach for it, the lid snaps open into rows of teeth and a Mimic devours you. The trap worked because it wore the costume of something you *wanted* and *trusted*. The shape was familiar. The context was right. Your guard was down because the dungeon had conditioned you to expect a reward in exactly that spot.

That is phishing.

In plain English: **phishing is when an attacker disguises a malicious message as something legitimate to trick you into handing over credentials, money, or access.** The attacker doesn't break your locks — they convince you to open the door. The "chest" might be an email from "IT Support," a text from "your bank," a LinkedIn message from a "recruiter," or a voice call from "the IRS." The shape is familiar. The context feels right. And the moment you click, type, or speak, the lid snaps shut.

**Technical definition:** Phishing is a social engineering attack vector in which an adversary impersonates a trusted entity through electronic communication to induce a victim to disclose sensitive information (credentials, PII, financial data), execute malicious code (via attachment or link), or perform an unauthorized action (wire transfer, MFA approval, credential reset). Phishing exploits human cognitive shortcuts — [[authority]], [[urgency]], [[scarcity]], [[familiarity]], and [[trust]] — rather than technical vulnerabilities, although it frequently delivers technical payloads as a second stage.

Phishing is explicitly enumerated under **SY0-701 Objective 2.2 — Common Threat Vectors and Attack Surfaces**, and it appears as the most heavily-tested social engineering concept on the exam.

---

## Why it matters

Phishing is the **#1 initial access vector** in real-world breaches. Industry incident reports consistently attribute 70–90% of breaches to a human element, and phishing dominates that category. Ransomware crews, nation-state APTs, and lone-wolf credential thieves all start the same way: a message in an inbox.

**Attack scenario.** An attacker registers `micros0ft-support[.]com`, copies Microsoft's HTML/CSS, and sends an email to 3,000 employees of a target company: *"Your password expires in 24 hours. Click here to renew."* Even a 1% click rate yields 30 sets of credentials. With one valid set, the attacker logs into the [[VPN]], finds the credentials don't have [[MFA]] on a legacy app, pivots to the file server, and exfiltrates 80GB of customer data. Total time from email send to exfil: 11 hours. Cost to the company: $4M average per IBM's annual breach study.

**Defense scenario.** A SOC analyst sees an [[email gateway]] alert: 47 messages from the same external sender, all containing a URL that resolves to a 6-hour-old domain. The analyst pulls the message via the [[SIEM]], detonates the link in a sandbox, confirms it serves a credential-harvesting page mimicking Office 365, blocks the domain at the [[DNS]] resolver and the [[secure email gateway]], purges the messages from all 47 inboxes via [[Microsoft Defender for Office 365]] zero-hour auto-purge, and forces password reset on the three users who clicked. Damage: contained.

**Exam relevance.** CompTIA tests phishing in three flavors: (1) recognizing the *type* of phishing from a scenario, (2) identifying the *social engineering principle* being exploited, and (3) selecting the correct *technical or administrative control* to mitigate it. You will see at least 3–5 phishing-related questions on the SY0-701.

> **Why CompTIA tests this:** Phishing is the only attack vector where end-user training is a primary control. CompTIA wants to confirm that a Security+ holder can both *detect* phishing artifacts (sender spoofing, URL mismatch, urgency cues) and *recommend* layered defenses (DMARC, SPF, DKIM, awareness training, email gateways).

---

## Key facts

### Phishing variants — know every one of these

| Variant | Channel | Targeting | Distinguishing feature |
|---|---|---|---|
| **[[Phishing]]** | Email | Mass / untargeted | Generic lure, "Dear Customer" |
| **[[Spear phishing]]** | Email | Specific individual or small group | Researched, personalized |
| **[[Whaling]]** | Email | C-suite / executives | High-value target, often legal/financial pretext |
| **[[Vishing]]** (voice phishing) | Phone / VoIP | Varies | Caller ID spoofing, real-time pressure |
| **[[Smishing]]** (SMS phishing) | Text / SMS | Mass or targeted | Shortened URLs, package delivery / 2FA lures |
| **[[Pharming]]** | DNS / hosts file | Mass | Redirects victim from legitimate URL to malicious site, no click required |
| **[[Business Email Compromise]] (BEC)** | Email | Finance / HR / vendor staff | Impersonates executive or vendor, requests wire transfer or W-2 data |
| **[[Angler phishing]]** | Social media | Customers of a brand | Attacker poses as customer support on Twitter/X, Facebook |
| **[[Quishing]]** (QR phishing) | QR code | Varies | Malicious QR in email, poster, or restaurant table tent |
| **[[Watering hole attack]]** | Compromised website | Specific community | Not phishing per se, but adjacent — attacker poisons a site the target group visits |

> **CompTIA exam trap:** Whaling vs. Spear phishing. Both are targeted. The differentiator is **rank/value of the target**. If the scenario says "CFO," "CEO," or "executive" — pick **whaling**. If it says "an engineer in the finance department" — pick **spear phishing**.

> **CompTIA exam trap #2:** **Pharming** is *not* a click-based attack. It's DNS poisoning or hosts-file modification that redirects a user typing the *correct* URL to a malicious site. If the scenario says the user "typed the address themselves" but still landed on a fake page — it's pharming, not phishing.

### Social engineering principles exploited

CompTIA expects you to map a phishing message to the underlying psychological lever:

- **[[Authority]]** — "This is the CEO. Send the wire."
- **[[Urgency]]** — "Your account will be locked in 2 hours."
- **[[Scarcity]]** — "Only 3 spots left in the mandatory training."
- **[[Intimidation]]** — "Failure to comply will result in legal action."
- **[[Consensus]] / Social proof** — "All your colleagues have already updated their password."
- **[[Familiarity]] / Liking** — "Hey, it's Mike from accounting, remember me from the offsite?"
- **[[Trust]]** — Spoofed branding, legitimate-looking domains.

### Indicators of a phishing message

Drill these into muscle memory — the exam loves "which of the following is most indicative of a phishing email":

1. **Sender domain mismatch** — display name says "PayPal" but the address is `service@paypa1-secure[.]ru`
2. **Mismatched URL on hover** — link text reads `bankofamerica.com` but resolves to `bofa-login.tk`
3. **Spelling, grammar, awkward translation** — though AI-generated phishing has largely eliminated this tell
4. **Generic greeting** — "Dear Valued Customer"
5. **Urgency / threat / reward** — emotional manipulation
6. **Unexpected attachment** — `.zip`, `.iso`, `.html`, `.lnk`, `.docm`, macro-enabled Office documents
7. **Request for credentials, MFA codes, gift cards, or wire transfers**
8. **Reply-to differs from From** — common BEC indicator
9. **Newly registered domain** — domains under 30 days old are highly suspect

### Technical controls — email authentication trifecta

| Control | What it does | Record type |
|---|---|---|
| **[[SPF]]** (Sender Policy Framework) | Lists which IPs are authorized to send mail for a domain | DNS TXT |
| **[[DKIM]]** (DomainKeys Identified Mail) | Cryptographically signs outbound mail; recipient verifies signature against sender's public key in DNS | DNS TXT (selector record) |
| **[[DMARC]]** (Domain-based Message Authentication, Reporting & Conformance) | Tells receivers what to do when SPF/DKIM fail (none / quarantine / reject) and where to send reports | DNS TXT |

> **Exam tip:** If a question asks how to prevent attackers from spoofing *your* domain in outbound phishing against your customers — the answer is **DMARC with a `p=reject` policy**, supported by SPF and DKIM. SPF or DKIM alone is insufficient.

### Additional technical controls

- **[[Secure Email Gateway]] (SEG)** — Proofpoint, Mimecast, Microsoft Defender for Office 365 — performs URL rewriting, attachment sandboxing, impersonation detection
- **[[URL filtering]] / [[DNS filtering]]** — blocks known phishing domains at the perimeter (Cisco Umbrella, Cloudflare Gateway)
- **[[Sandboxing]] / detonation chambers** — opens attachments and links in an isolated VM before delivery
- **[[Browser isolation]]** — renders untrusted web content in a remote container
- **[[MFA]]** — even if credentials are phished, attacker still needs the second factor. Prefer **[[FIDO2]] / WebAuthn / phishing-resistant MFA** over SMS or push, because SMS and push are vulnerable to **[[MFA fatigue]]** and SIM swap attacks
- **[[Conditional Access]] policies** — block sign-ins from anomalous geographies or unmanaged devices
- **[[Email banners]]** — `[EXTERNAL]` tags on inbound mail
- **[[Anti-spoofing]]** rules at the gateway

### Administrative controls

- **[[Security Awareness Training]]** — periodic, not annual; topic-rotated
- **[[Phishing simulations]]** — KnowBe4, Cofense, Microsoft Attack Simulator — measure click rates and report rates over time
- **Reporting button** — one-click "Report Phish" in Outlook / Gmail; the *report rate* is a better metric than the click rate alone
- **Acceptable Use Policy** referencing email handling
- **Incident response runbook** for confirmed phishing — credential reset, mailbox forwarding rule audit, sign-in log review, MFA re-registration

### Attack chain — what happens after a click

```
1. User clicks link in phishing email
2. Lands on credential-harvesting page (often hosted on hijacked WordPress site or
   newly registered domain behind Cloudflare)
3. Page POSTs credentials to attacker's collection server
4. Attacker logs into M365 / Okta / VPN (often within minutes — automated)
5. Attacker creates inbox forwarding rule (covers tracks)
6. Attacker enumerates contacts, OneDrive, SharePoint
7. Attacker pivots: lateral phishing to colleagues, OAuth app consent, or
   straight to data exfiltration / ransomware deployment
```

A modern variant — **adversary-in-the-middle (AiTM) phishing** — uses tools like **Evilginx2** to proxy the legitimate login page in real time, capturing both the password AND the session cookie. This bypasses MFA entirely because the attacker rides the authenticated session rather than re-authenticating. AiTM is the #1 reason phishing-resistant MFA (FIDO2/WebAuthn) matters in 2024+.

### Phishing variants to know cold

| Variant | Channel | Tactic |
|---|---|---|
| **Spear phishing** | Email | Targeted at specific individual with personalized lure |
| **Whaling** | Email | Spear phishing aimed at executives (CEO, CFO) |
| **Vishing** | Voice / phone | Caller pretends to be IT, bank, IRS — often combined with caller ID spoofing |
| **Smishing** | SMS / text | Fake delivery notifications, fake bank alerts, MFA prompt baits |
| **Quishing** | QR codes | Malicious QR in email or printed flyer leads to credential page |
| **Pharming** | DNS / hosts file | Redirects legitimate URL to attacker's lookalike site |
| **Watering hole** | Web | Compromises a site the target visits regularly |
| **Business Email Compromise (BEC)** | Email | Impersonates executive to authorize wire transfers; FBI tracks billions in BEC losses annually |

### CompTIA exam traps

- **Phishing vs. spam.** Spam is unsolicited bulk; phishing is deceptive intent to steal/compromise. Not every spam is phishing.
- **MFA does not stop AiTM phishing** unless it's phishing-resistant (FIDO2/WebAuthn). SMS, TOTP, and push notifications can all be relayed in real time.
- **Best single defense** is layered: technical (DMARC + SEG + phishing-resistant MFA) plus human (training + reporting button). The exam loves "best" answers — defense in depth wins.
- **DMARC `p=none`** is monitor-only and does NOT prevent spoofing; only `p=quarantine` or `p=reject` actually block.

## Related concepts

[[Social Engineering]] · [[Spear Phishing]] · [[Whaling]] · [[Vishing]] · [[Smishing]] · [[Business Email Compromise]] · [[SPF]] · [[DKIM]] · [[DMARC]] · [[MFA]] · [[FIDO2]] · [[WebAuthn]] · [[MFA Fatigue]] · [[Adversary-in-the-Middle]] · [[Evilginx]] · [[Secure Email Gateway]] · [[URL Filtering]] · [[Sandboxing]] · [[Browser Isolation]] · [[Conditional Access]] · [[Security Awareness Training]] · [[Phishing Simulations]] · [[Watering Hole]] · [[Pharming]] · [[Pretexting]] · [[OAuth Consent Phishing]]

---
*Source: VIRGIL knowledge base — 2026-05-08*
 — **adversary-in-the-middle (AiTM) phishing** — uses tools like **Evilginx2** to proxy the legitimate login page in real time, capturing both the password AND the session cookie. This bypasses MFA entirely because the attacker rides the authenticated session rather than re-authenticating. AiTM is the #1 reason phishing-resistant MFA (FIDO2/WebAuthn) matters in 2024+.

### Phishing variants to know cold

| Variant | Channel | Tactic |
|---|---|---|
| **Spear phishing** | Email | Targeted at specific individual with personalized lure |
| **Whaling** | Email | Spear phishing aimed at executives (CEO, CFO) |
| **Vishing** | Voice / phone | Caller pretends to be IT, bank, IRS — often combined with caller ID spoofing |
| **Smishing** | SMS / text | Fake delivery notifications, fake bank alerts, MFA prompt baits |
| **Quishing** | QR codes | Malicious QR in email or printed flyer leads to credential page |
| **Pharming** | DNS / hosts file | Redirects legitimate URL to attacker's lookalike site |
| **Watering hole** | Web | Compromises a site the target visits regularly |
| **Business Email Compromise (BEC)** | Email | Impersonates executive to authorize wire transfers; FBI tracks billions in BEC losses annually |

### CompTIA exam traps

- **Phishing vs. spam.** Spam is unsolicited bulk; phishing is deceptive intent to steal/compromise. Not every spam is phishing.
- **MFA does not stop AiTM phishing** unless it's phishing-resistant (FIDO2/WebAuthn). SMS, TOTP, and push notifications can all be relayed in real time.
- **Best single defense** is layered: technical (DMARC + SEG + phishing-resistant MFA) plus human (training + reporting button). The exam loves "best" answers — defense in depth wins.
- **DMARC `p=none`** is monitor-only and does NOT prevent spoofing; only `p=quarantine` or `p=reject` actually block.

## Related concepts

[[Social Engineering]] · [[Spear Phishing]] · [[Whaling]] · [[Vishing]] · [[Smishing]] · [[Business Email Compromise]] · [[SPF]] · [[DKIM]] · [[DMARC]] · [[MFA]] · [[FIDO2]] · [[WebAuthn]] · [[MFA Fatigue]] · [[Adversary-in-the-Middle]] · [[Evilginx]] · [[Secure Email Gateway]] · [[URL Filtering]] · [[Sandboxing]] · [[Browser Isolation]] · [[Conditional Access]] · [[Security Awareness Training]] · [[Phishing Simulations]] · [[Watering Hole]] · [[Pharming]] · [[Pretexting]] · [[OAuth Consent Phishing]]

---
*Source: VIRGIL knowledge base — 2026-05-08*
