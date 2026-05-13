# Privacy Licensing and Policies

## What it is

You finish a ticket. The user's machine had tax documents, a scanned passport, and a saved credit card autofill. You closed the ticket. Did you screenshot anything for "documentation"? Did you copy the error log to your personal Dropbox so you could look at it later? Did you mention the user's name in the team Slack?

That's the entire domain. Every machine you touch is also somebody's nervous system — their identity, their money, their medical records, their employer's intellectual property. Privacy, licensing, and policy is the rulebook for how a tech handles other people's data and other people's software without getting the company sued, fined, or breached.

**Technical definition:** the set of legal, regulatory, contractual, and internal-policy constraints that govern (1) what data you can access, copy, store, or disclose; (2) what software the organization is licensed to run and under what terms; (3) how incidents involving regulated data must be documented and escalated.

## Why it matters

This is a domain where "I didn't know" is not a defense. HIPAA fines start at $100 per record and climb to $50,000. PCI-DSS violations get a company's card-processing privileges revoked. GDPR fines top out at 4% of global annual revenue. An NDA breach can end your career and trigger personal liability.

CompTIA tests this hard on 220-1202 Objective 4.6 because helpdesk and field techs are the people with hands on the data. The breach doesn't usually come from the hacker in the hoodie — it comes from the tech who copied a drive to a personal USB stick to "work on it at home."

## In your daily work, in the enterprise

**Beat 1 — Technical depth.** Four categories of constraint stack on every ticket: **regulated data** (PII, PHI, PCI, government IDs — each with its own framework: HIPAA, PCI-DSS, GDPR, state breach laws), **contractual constraints** (NDAs, MNDAs, vendor agreements, customer data-handling clauses), **licensing** (per-seat, per-device, concurrent, subscription, perpetual, OEM, volume, open-source with its own license families — GPL, MIT, Apache, BSD, AGPL), and **internal policy** (AUP, data retention schedule, incident response plan). Incident handling adds two procedural concepts: **order of volatility** (capture RAM before disk before archived logs, because volatile evidence dies first) and **chain of custody** (every hand the evidence passes through, signed and timestamped, or it's inadmissible).

**Beat 2 — Feynman example via your home setup.**

**The Plex server:** You rip your Blu-ray collection to a NAS. Legal in some jurisdictions for personal backup, gray in others. *DRM exists specifically to make this annoying — that's its job.*

**The Windows license:** You build a new gaming rig, pull the SSD from the old one, drop it in the new build. Windows phones home, sees new motherboard, deactivates. You call Microsoft, prove you're the same human, they reactivate. *That's a license check enforcing a EULA you clicked through in 2019.*

**The "free" software:** You install a video editor labeled "free for personal use." Two years later you start a YouTube channel that makes $400/month. You are now in violation of the personal-use license. *Personal-use and corporate-use are different SKUs of the same binary.*

**The open-source trap:** You grab a GPL-licensed library, bake it into a tool you sell. GPL says derivative works must also be GPL — meaning open-sourced. You just gave away your product's code. *Open-source is not "free to do whatever." Read the license.*

**Beat 3 — Bridge to the enterprise.** Same four traps, scaled up and lawyered. The Plex situation becomes **data retention requirements** — the company is legally required to keep certain records (financial: 7 years; medical: often lifetime + 6; tax: 7) and legally required to *destroy* other records on schedule (GDPR right-to-be-forgotten, state PII laws). Retention is both a floor and a ceiling. The Windows reactivation becomes **volume licensing** — KMS servers, Microsoft 365 tenant seat counts, audits where Microsoft's compliance team shows up and counts every running install against purchased entitlements. Get caught short, you pay the difference plus penalties. The personal-vs-corporate license becomes the reason your company can't let an employee install their home copy of Adobe on a work laptop, even if they own it. The open-source GPL trap becomes a full **software bill of materials (SBOM)** and a legal review of every dependency before it ships.

**Beat 4 — The point.** Same fundamental question across every scale: *who owns this data or this software, what are the terms, and what happens when those terms are broken?* At home the consequences are deactivation and a strongly-worded email. In the enterprise the consequences are fines, lawsuits, regulatory action, and breach disclosure. Get this question into your bones — you'll ask it on every ticket for the rest of your career.

## Key facts

### Regulated data categories

| Category | What it is | Framework | Tech's job |
|---|---|---|---|
| **PII** (Personally Identifiable Information) | Name + SSN, name + DOB, name + address, etc. | State breach laws, GDPR | Don't copy, don't email, don't screenshot |
| **PHI** (Protected Health Information) | Anything tying a person to a medical condition or treatment | HIPAA (US) | No discussion outside the care team. No screenshots. Ever. |
| **PCI** (Payment Card Industry data) | Card number (PAN), CVV, expiration, cardholder name | PCI-DSS | Cards in scope must be in PCI-compliant systems only. Never write down a CVV |
| **Government-issued IDs** | Passport, driver's license, SSN, national ID numbers | State + federal law | Treat as PII + extra. Never photograph or copy |
| **Healthcare data** | Beyond PHI — research data, genetic info, mental health records | HIPAA + state laws (often stricter) | Same as PHI, often higher penalty |

### Incident response — the order that matters

When an incident happens (suspected breach, malware, illegal content discovered, regulated-data exposure):

1. **Stop and think before you touch anything.** Don't reboot. Don't "just check something."
2. **Inform management immediately.** Not the user. Not the team Slack. Your manager and the security team.
3. **Preserve evidence** following **order of volatility** — CPU registers and cache, RAM, network state, running processes, then disk (forensic image — a **copy of drive** made with a write-blocker, bit-for-bit, hashed before and after), then archived logs.
4. **Document everything** — timestamps, what you saw, what you did, who you told. **Incident documentation** is the legal record. If it isn't written down, it didn't happen.
5. **Chain of custody** — every transfer of evidence (drive, USB, log file) gets signed and timestamped. Breaks in the chain make evidence inadmissible.
6. **Law enforcement involvement** is a management/legal decision, not yours. CSAM is the one exception — most jurisdictions require immediate reporting, and your company's policy will spell out who calls.

### NDA, MNDA, and confidentiality

- **NDA (Non-Disclosure Agreement)** — one-way. Usually you signing one promising not to disclose the company's information.
- **MNDA (Mutual NDA)** — both parties promise not to disclose each other's information. Standard for vendor relationships, contract work, anything where information flows both directions.
- **Chain of custody NDA** — confidentiality binding everyone who touches evidence during an investigation. Common in forensics work.

The NDA doesn't expire when you leave the job. Tech who blabs about a former employer's incident on Twitter gets sued.

### Licensing models you will see

| Model | What it means | Where you see it |
|---|---|---|
| **Perpetual** | One-time purchase, use forever (within EULA terms) | Older Office suites, many enterprise apps |
| **Subscription** | Recurring fee, stop paying → stop working | Microsoft 365, Adobe Creative Cloud |
| **Per-seat** | One license per named user | Most SaaS |
| **Per-device** | One license per machine, any user | Windows OEM |
| **Concurrent** | N licenses, anyone can use as long as total active ≤ N | CAD software, specialty tools |
| **Volume** | Bulk purchase, managed via KMS or activation server | Windows/Office enterprise deployments |
| **OEM** | Tied to original hardware, dies with the motherboard | Pre-installed Windows |
| **Personal-use** | Free or cheap for non-commercial individual use | Many "free" tools |
| **Corporate-use** | Paid tier for business use of the same software | Same tools, different SKU |
| **Open-source** | Source available, terms vary by license family | GPL, MIT, Apache, BSD, AGPL |

**Splash screens** at login that say "this system is for authorized use only, activity is monitored, by logging in you consent to..." — that's not decoration. That's the legal notice that makes monitoring lawful and prosecutions possible. Removing or skipping splash screens is a serious policy violation.

### DRM and data retention

**DRM (Digital Rights Management)** enforces license terms technically — activation servers, hardware dongles, online check-ins, encrypted media. Enterprise context: DRM also protects internal documents (Microsoft Purview, Adobe DRM) so a leaked file is unreadable outside the corporate tenant.

**Data retention requirements** are dual: legal minimums (keep X for Y years) and legal maximums (delete after Z). Your company's retention schedule is a real document. Read it. Deleting a record before its retention window ends is destruction of evidence. Keeping a record past its window is a liability.

### AUP (Acceptable Use Policy)

Defines what users can and can't do on company systems: no personal email on work laptop, no installing unapproved software, no using corporate VPN for torrents, no plugging in personal USB drives. AUP is what you point at when terminating a user's access after they did something dumb. Every new hire signs one. Every tech enforces one.

### CompTIA exam traps

> **CompTIA exam trap:** order of volatility. RAM is captured **before** disk because RAM disappears at power-off. Candidates often answer "image the drive first" — wrong. Volatile first, persistent last.

> **CompTIA exam trap:** law enforcement notification is rarely the tech's call. Inform management; let them and legal decide. The exception is mandatory-reporting content (CSAM) — know your jurisdiction's rule.

> **CompTIA exam trap:** open-source ≠ free to use however. GPL imposes copyleft obligations. MIT/BSD are permissive. CompTIA likes to test that "open-source has license terms" full stop.

> **CompTIA exam trap:** PII vs PHI vs PCI — different frameworks, different penalties. A credit card number is PCI, not PII. A medical record is PHI under HIPAA, not generic PII.

> **CompTIA exam trap:** chain of custody is broken by *any* undocumented transfer. Leaving a drive on a desk unattended for 20 minutes can void the evidence.

## Helpdesk reality

- **"Can you just copy my files to a USB so I can work from home?"** — No. Data leaves on company-approved channels only (OneDrive, sanctioned VPN). Cite the AUP, escalate if they push back.
- **"I found something weird on this user's machine."** — Stop. Don't open it further. Don't show coworkers. Lock the screen, walk away, tell your manager. If it's CSAM or evidence of a crime, the procedure is non-negotiable.
- **"I have a personal license for Photoshop, can I install it on my work laptop?"** — No. Personal-use licenses don't cover corporate use, and IT has no record of it for audit. Same answer for "I have Office at home."
- **"Why does the login screen have that giant legal warning?"** — That splash screen is what makes monitoring and disciplinary action enforceable. It's not optional.
- **"Just take a screenshot of the error and send it to me."** — If the error window shows account numbers, names, or medical info, no. Crop, redact, or describe in text. Screenshots of regulated data sitting in your ticket system are themselves a compliance problem.
- **AI tool reminder:** never paste user data, error screenshots containing PII/PHI/PCI, or internal documents into an AI tool that hasn't been approved by your security team. Approved tools (Microsoft Copilot under your tenant, ServiceNow Now Assist) keep data inside the compliance boundary. Consumer ChatGPT does not.

## Related concepts

[[Incident Response]] · [[Chain of Custody]] · [[PII and PHI]] · [[PCI-DSS Basics]] · [[HIPAA Basics]] · [[Acceptable Use Policy]] · [[Software Licensing Models]] · [[Open-Source Licensing]] · [[Data Retention and Destruction]] · [[Splash Screens and Legal Banners]] · [[NDA and MNDA]] · [[Order of Volatility]] · [[Forensic Drive Imaging]]

*Source: VIRGIL knowledge base — 2026-05-11*