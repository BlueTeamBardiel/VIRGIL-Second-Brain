# Impersonation

## What it is

In Bioshock, you find a corpse on the ocean floor and pull on his Big Daddy suit, mimicking his lumbering walk and grunts to fool the Little Sisters into thinking you're their protector. That's exactly what impersonation does — an attacker pretends to be someone the victim already trusts so the victim hands over access, data, or money without thinking.

**Impersonation** is a social engineering attack where the threat actor assumes the identity of a trusted person, role, or entity to manipulate a target into performing an action or disclosing information.

## Why it matters

Impersonation is the delivery mechanism behind most successful breaches that start with humans: wire fraud, credential theft, MFA fatigue, and ransomware footholds all begin with someone believing the attacker is the IT helpdesk, the CEO, a vendor, or a courier. For SY0-701 Objective **2.2**, candidates must distinguish impersonation from related techniques like [[pretexting]], [[phishing]], and [[business email compromise]] — CompTIA's favorite trap is offering "pretexting" and "impersonation" as two answers to the same question, where pretexting is the *fabricated story* and impersonation is the *assumed identity*. They overlap; the question hinges on which is emphasized in the scenario.

## Key facts

### Common impersonation vectors

| Vector | How it works | Example |
|---|---|---|
| **Voice ([[vishing]])** | Caller claims to be IT, bank, IRS | "This is Microsoft Support, your PC is infected" |
| **Email ([[phishing]] / [[BEC]])** | Spoofed sender or lookalike domain | CEO emails CFO requesting urgent wire |
| **SMS ([[smishing]])** | Texts impersonating banks, couriers | "UPS: package held, click to verify" |
| **In-person ([[tailgating]])** | Wears uniform, carries clipboard | "Fire inspector," "HVAC tech" |
| **Deepfake** | AI-generated voice or video | Cloned CEO voice authorizing transfer |

### Enabling techniques

- **[[Pretexting]]** — the fabricated backstory that makes the impersonation plausible
- **[[Spoofing]]** — technical forgery of caller ID, email headers, or MAC addresses
- **[[Typosquatting]]** — registering lookalike domains (rnicrosoft.com)
- **[[OSINT]]** — LinkedIn, org charts, social media to learn who reports to whom
- **Authority and urgency** — the two psychological levers that disable verification

### High-value impersonation targets

- **Executives** — [[whaling]] / [[CEO fraud]] for wire transfers
- **IT helpdesk** — to reset passwords or push MFA prompts ([[MFA fatigue]])
- **Vendors / suppliers** — invoice redirection fraud
- **New hires** — least likely to recognize internal anomalies

### Defenses

| Control | Type | What it stops |
|---|---|---|
| **[[Security awareness training]]** | Administrative | Recognition of pretexts |
| **Callback verification** to known number | Procedural | Wire fraud, helpdesk impersonation |
| **[[DMARC]] / [[DKIM]] / [[SPF]]** | Technical | Email sender spoofing |
| **[[Out-of-band verification]]** | Procedural | Deepfake voice / BEC |
| **Visitor badges + escort policy** | Physical | In-person impersonation, [[tailgating]] |
| **Code words / challenge phrases** | Procedural | Executive voice cloning |
| **Number matching MFA** | Technical | MFA fatigue from helpdesk impersonators |

### Exam-ready distinctions

- **Impersonation** = assuming an identity ("I am John from IT")
- **Pretexting** = the story justifying the contact ("There's a problem with your account")
- **Phishing** = the medium (email) — often *contains* impersonation
- **[[Identity fraud]]** = using stolen identity for financial gain, broader and often post-breach

## Related concepts

[[Pretexting]] · [[Phishing]] · [[Vishing]] · [[Whaling]] · [[Business Email Compromise]] · [[Spoofing]] · [[Social Engineering]] · [[MFA Fatigue]] · [[Tailgating]] · [[Deepfake]] · [[OSINT]]

---
*Source: VIRGIL knowledge base — 2026-05-08*