# Email Security

## What it is

In **Metal Gear Solid**, the codec rings and a voice says *"Snake, this is Colonel Campbell."* Sometimes it's actually Campbell. Sometimes it's the Patriots' AI puppeting his voice through compromised comms to feed Snake bad orders. The whole back half of MGS2 is Raiden taking codec calls from "Colonel" that get progressively more unhinged — *"turn off the console right now"* — because the channel was never authenticated. Snake had no way to verify the sender. He just trusted the voice on the other end of the frequency.

That's email. SMTP was designed in 1982 to deliver mail between trusted academic hosts. The `From:` field is a suggestion. Anyone can spell it however they want. Email security is the bolt-on layer that asks: *did this codec call actually come from Campbell, or is the Colonel AI again?*

**Technical definition:** Email security is the set of controls — authentication (SPF, DKIM, DMARC), content filtering (secure email gateways, sandboxing), and user-facing indicators (banners, link rewriting) — that defend against malicious mail: phishing, spoofing, business email compromise, and malware delivery. CompTIA tests this under [[Objective 1.2]] because email-borne IoCs (obfuscated links, social engineering attacks, malicious attachments dropping unauthorized software) are the dominant initial-access vector in real incidents.

## Why it matters

Roughly 90% of breaches start with email. Not zero-days. Not exotic supply-chain attacks. A user clicking a link or opening an attachment from a sender they thought they recognized. Verizon DBIR has said this every year for a decade and the number doesn't budge.

For the CySA+ exam, email security shows up in three places: as a source of IoCs you have to recognize (1.2), as a control set you have to recommend (2.5), and as the initial-access entry on the IR timeline you have to reconstruct (3.2). For the job, it's the single highest-volume alert category an L1 analyst will touch. Tune email well, the SOC sleeps. Tune email badly, the queue fills with FPs and a real BEC slips through at 4pm Friday.

## Key facts

### The three authentication standards

These are tested together. CompTIA loves to ask which one does what, and which one *enforces* versus which one just *publishes*.

| Control | What it does | Where it lives | Enforces? |
|---|---|---|---|
| **SPF** (Sender Policy Framework) | Lists which IPs are allowed to send mail for a domain | DNS TXT record on the sending domain | No — just publishes the policy. Receiver decides. |
| **DKIM** (DomainKeys Identified Mail) | Cryptographically signs the message with a private key; receiver verifies with public key in DNS | DNS TXT record (`selector._domainkey.domain.com`) + header on the message | No — proves integrity and origin, doesn't tell receiver what to do on failure |
| **DMARC** (Domain-based Message Authentication, Reporting, and Conformance) | Tells receivers what to do when SPF/DKIM fail, and where to send aggregate reports | DNS TXT record (`_dmarc.domain.com`) | **Yes** — `p=none`, `p=quarantine`, `p=reject` |

### How they actually work together

SPF checks if the IP that delivered the mail is in the sender domain's authorized list. DKIM checks if the message body and key headers were signed by someone holding the domain's private key. DMARC sits on top and says: *if SPF or DKIM fails and the domain in the `From:` header doesn't align with the authenticated domain, do this.*

The alignment piece is what catches spoofing. An attacker can pass SPF by sending from their own domain (they own the IP, they publish their own SPF). What they can't do is make their domain align with the `From:` header showing your bank's domain. DMARC fails the message because the authenticated domain (`evil.com`) doesn't match the visible `From:` (`yourbank.com`).

### DMARC policy progression

> **CompTIA exam trap:** DMARC defaults to `p=none` for a reason. CompTIA will offer "deploy DMARC `p=reject` immediately" as the wrong answer to a remediation scenario. Right answer: start at `none`, ingest aggregate reports (RUA), identify legitimate senders you forgot about (marketing platforms, payroll vendors, the printer that emails scans), authorize them properly, *then* move to `quarantine`, *then* `reject`. Skipping the report phase will drop legitimate mail.

- **`p=none`** — monitor only. Receivers report failures but deliver the mail. Discovery phase.
- **`p=quarantine`** — failed mail goes to spam/junk. Soft enforcement.
- **`p=reject`** — failed mail is bounced at the SMTP transaction. Hard enforcement. Goal state.

### SPF gotchas worth knowing

- SPF records are limited to **10 DNS lookups** (the include count). Exceed it and SPF returns `permerror` — a failure DMARC will treat as a fail. Common when an org adds every SaaS vendor's `include:` mechanism without flattening.
- The SPF record itself is one TXT record, and DNS TXT records cap at **255 characters per string** (concatenated into longer values). Long SPF records get split across strings.
- SPF only checks the `MAIL FROM` (envelope sender), not the `From:` header the user sees. That's why DMARC alignment matters.

### The IoCs an analyst actually sees

CompTIA Objective 1.2 lists indicator categories. Email-delivered attacks hit most of them downstream. The mail itself shows:

- **Obfuscated links** — URL shorteners, IDN homograph attacks (`раypal.com` with a Cyrillic `а`), nested redirects, links pointing to legitimate file-sharing services (SharePoint, Google Drive) hosting the actual payload
- **Social engineering attacks** — urgency, authority, fear ("your account will be suspended in 24 hours"), CEO impersonation, invoice fraud
- **Unauthorized changes communication** — "I'm in a meeting, can you update my direct deposit?" — classic payroll diversion BEC
- **Attachments with macro-enabled documents, ISO/IMG containers, LNK files, HTML smuggling**

Post-click, the IoCs cascade:

- **Malicious processes** spawned from Office (`winword.exe → powershell.exe` is the classic parent-child chain)
- **Unexpected outbound** traffic from a workstation to a never-before-seen IP
- **Beaconing** on a fixed interval to C2
- **Introduction of new accounts** if the attacker escalates
- **Unauthorized scheduled tasks** or **registry changes** for persistence
- **Data exfiltration** to file-sharing services or DNS tunneling

### Secure email gateways and what they actually catch

A secure email gateway (SEG) — Proofpoint, Mimecast, Microsoft Defender for O365, Google Workspace's built-in — sits inline and does:

- **Reputation filtering** — kill mail from known-bad IPs/domains before content scan
- **Authentication checks** — SPF/DKIM/DMARC evaluation
- **Content scanning** — signature-based AV on attachments, heuristic analysis
- **Sandbox detonation** — open the attachment in a VM, watch what it does, block if it misbehaves
- **URL rewriting / time-of-click protection** — rewrite every link to go through the gateway's proxy, so when the user clicks three days later, the gateway re-checks the URL against current threat intel (the payload site often goes live *after* delivery to evade scan-on-receipt)
- **Banner injection** — `[EXTERNAL]` tags, `[CAUTION: First time sender]` warnings

> **CompTIA exam trap:** Banners are not a technical control. They're a human control. CompTIA may present a scenario asking how to "prevent" phishing — banners *reduce risk* by training the user's eye, but they don't prevent delivery. The prevent answer is SEG + DMARC enforcement. The detect answer is user reporting + SIEM correlation.

### BEC — the attack that ignores all of this

Business Email Compromise often involves no malware, no malicious link, and no spoofing that DMARC would catch. The attacker either:

1. Compromises a real mailbox (credential phishing → MFA bypass → real account sends real mail from a real domain — passes SPF, DKIM, DMARC clean), or
2. Registers a lookalike domain (`accounting@yourc0mpany.com` vs `yourcompany.com`) — passes its own SPF/DKIM, and DMARC only protects domains you own

Defense is conditional access (impossible-travel detection), DLP on outbound (catch wire-transfer instructions), and out-of-band verification policy (call the CFO on a known number before moving money). *No DNS record stops a human being from approving a fraudulent invoice.*

### Headers — where the forensic work happens

When a user reports a phish, you pull the full headers. The chain of `Received:` lines reads bottom-up, showing every hop from sender to recipient. You look for:

- The actual originating IP (often a residential or hosting-provider IP, not the claimed sender's infrastructure)
- `Authentication-Results:` header showing the SPF/DKIM/DMARC verdict the receiver computed
- `Return-Path:` vs `From:` mismatch
- `Reply-To:` pointing somewhere weird — common in BEC, where the visible `From:` looks legit but replies route to an attacker-controlled address
- Timestamps that don't make sense (mail "sent" from US business hours but `Received:` chain shows it transited an Eastern European relay)

## SOC reality

- The phishing report inbox is the highest-signal threat feed in the building. User-reported phish is closer to ground truth than most commercial threat intel. Tune the reporting button to one-click, route to a dedicated mailbox, auto-create a triage ticket. *The user who reported it is the sensor that worked — don't make them fill out a form.*
- L1 workflow on a reported phish: pull headers, check sender reputation, detonate attachment in sandbox, expand URLs through a safe resolver, search SIEM for other recipients of the same campaign, search proxy/DNS logs for users who *clicked* before reporting. The click search is what tells you whether this is a notification or an incident.
- CISO question after a successful phish: "How many users got the mail, how many clicked, how many entered credentials, are those accounts contained, is there mailbox forwarding configured, is there data exfil?" Have the answer ready in that order. Mailbox forwarding rules are the persistence mechanism nobody checks — attackers love them because they survive password resets.
- Never tell leadership "DMARC will fix this." DMARC fixes *exact-domain spoofing*. It does not fix lookalike domains, compromised legitimate accounts, or any link/attachment delivered through a domain the attacker controls. Roughly 60% of BEC bypasses DMARC entirely because the attacker uses a different domain.
- Escalation point: any phish where credentials were entered → identity team for forced reset + session revocation + MFA re-enrollment. Any phish where an attachment executed → IR/EDR team for endpoint isolation. Any wire-transfer or invoice manipulation → legal and fraud, not just IT.

## Related concepts

[[Phishing]] · [[Business Email Compromise]] · [[SPF]] · [[DKIM]] · [[DMARC]] · [[Secure Email Gateway]] · [[Social Engineering]] · [[Indicators of Compromise]] · [[Obfuscated Links]] · [[Email Header Analysis]] · [[DLP]] · [[Sandboxing]] · [[Threat Intelligence]] · [[MITRE ATT&CK Initial Access]] · [[Spear Phishing]] · [[Credential Harvesting]]

*Source: VIRGIL knowledge base — 2026-05-11*