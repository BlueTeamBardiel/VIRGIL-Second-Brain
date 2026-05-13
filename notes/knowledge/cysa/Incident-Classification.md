# Incident Classification

## What it is

In **Tomb Raider** (2013), Lara doesn't fight every threat the same way. A Solarii cultist with a torch gets a different response than a wolf pack, which gets a different response than the storm-shrieking helicopter that nukes the radio tower out from under her. She reads the threat type — melee, animal, ranged, environmental — and her playbook changes: bow for stealth picks, shotgun for the rushers, climbing axe for the wolves, *get behind cover right now* for the helicopter. Same island, same Lara, completely different responses depending on how the threat showed up.

That's exactly what incident classification does — you sort the incident by **how it arrived** and **what it is**, so the right playbook fires.

Technically: **incident classification** is the early-triage step in the Detection & Analysis phase where the SOC tags an incident by attack vector, impact, and severity. That tag drives which playbook runs, which stakeholders get paged, which regulatory clock starts, and how the after-action report gets filed. NIST SP 800-61r2 codifies the attack vector taxonomy CompTIA tests on.

## Why it matters

Classification is the fork in the road. Misclassify an [[Insider Threat]] as a [[Phishing]] incident and you'll spend two hours hunting an external sender while the actual user is still exfiltrating to a personal Dropbox. Misclassify a [[DDoS]] as a web app exploit and the WAF team is digging through nginx logs while the upstream provider could have null-routed the source ASN in ten minutes.

Classification also drives the legal and compliance machine. Loss-of-equipment with PHI on it triggers HIPAA notification. A web-vector breach affecting EU residents starts the GDPR 72-hour clock. CIRCIA-covered critical infrastructure entities have their own US federal window. The wrong classification means the wrong clock — or no clock at all — and the org eats fines on top of the incident.

Exam relevance: **Objective CS0-003 3.3** (preparation and post-incident activity). CompTIA expects you to know the NIST attack vector categories cold and understand that classification flows from preparation (you defined the categories and playbooks beforehand) into detection (you apply the tag) into post-incident (you report against the tag).

## Key facts

### NIST SP 800-61 attack vector categories

CompTIA pulls these directly from NIST. Memorize them.

| Vector | What it means | Example |
|---|---|---|
| **External / Removable Media** | Attack delivered via removable media or peripheral | USB drop in the parking lot, malicious thumb drive, infected vendor laptop plugged into the LAN |
| **Attrition** | Brute force methods to compromise, degrade, or destroy systems, networks, or services | [[DDoS]], password spraying, credential stuffing, resource exhaustion |
| **Web** | Attack executed from a website or web-based application | [[SQL Injection]], [[XSS]], drive-by download, malicious ad, compromised SaaS app |
| **Email** | Attack delivered via email message or attachment | [[Phishing]], spear phishing, [[BEC — Business Email Compromise]], malicious attachment, malicious link |
| **Impersonation** | Attack involving replacement of something benign with something malicious | Spoofing, [[Man-in-the-Middle]], rogue access point, evil twin, DNS hijack, watering hole |
| **Improper Usage** | Incident from violation of acceptable use policy by an authorized user | Insider running torrents on the corp net, employee mailing customer DB home, sysadmin disabling logging |
| **Loss or Theft of Equipment** | Computing device or media used by the organization is lost or stolen | Stolen laptop, lost phone, unencrypted backup tape gone missing |
| **Other / Unknown** | Doesn't fit, or vector not yet determined | Where every alert starts before triage; where some alerts stay |

> **CompTIA exam trap:** "Attrition" sounds like a slow grind, but in NIST language it means **brute force** — DDoS, password spraying, anything that overwhelms by repetition or volume. CompTIA will plant "attrition" next to options that sound more naturally brute-forcey ("brute force attack" as a vector type) and the correct attack vector category answer is *attrition*.

> **CompTIA exam trap:** "Impersonation" is the **replacement** vector — something benign got swapped for something malicious. Phishing is *email*, not impersonation, even though phishing impersonates someone. The vector is the **delivery mechanism**, not the social-engineering technique on top of it.

### Classification by functional impact

Vector is "how it got in." Impact is "how bad is it now." NIST defines four functional impact tiers:

| Tier | Definition |
|---|---|
| **None** | No effect on the organization's ability to provide services to users |
| **Low** | Minimal effect; org can still provide critical services to all users but lost efficiency |
| **Medium** | Org lost ability to provide critical services to a subset of users |
| **High** | Org no longer able to provide some critical services to any users |

### Classification by information impact

Separate axis. What data is exposed?

| Tier | Definition |
|---|---|
| **None** | No information was exfiltrated, changed, deleted, or otherwise compromised |
| **Privacy Breach** | Sensitive PII of taxpayers, employees, beneficiaries, etc. was accessed or exfiltrated |
| **Proprietary Breach** | Unclassified proprietary information (e.g., trade secrets, CUI) was accessed or exfiltrated |
| **Integrity Loss** | Sensitive or proprietary information was changed or deleted |

### Classification by recoverability

How long and how hard is the eradication and recovery effort?

| Tier | Definition |
|---|---|
| **Regular** | Time to recovery is predictable with existing resources |
| **Supplemented** | Predictable with additional resources |
| **Extended** | Unpredictable; additional resources and outside help needed |
| **Not Recoverable** | Recovery from incident is not possible (e.g., destructive ransomware on no-backup data); launch investigation |

The three axes — functional impact, information impact, recoverability — combine into your **severity** score. That severity drives stakeholder notification and the IR escalation ladder.

### How classification connects to the lifecycle

Classification doesn't live in one phase. It threads through all four NIST phases:

- **Preparation** — Define the categories. Build the [[Playbooks]] for each vector. Run [[Tabletop Exercise]]s where the scenarios are tagged with vectors so the team practices the right playbook against the right tag. Define severity thresholds before you're under pressure to lower them.
- **Detection and Analysis** — Apply the tag during triage. The [[SIEM]] rule fired; the L1 analyst's first job after acknowledging is to classify. "Email vector, phishing, low functional impact, no information impact yet, regular recoverability." That tag drives everything downstream.
- **Containment, Eradication, and Recovery** — The classification picks the playbook. Email vector → mailbox search, sender block, URL detonation, user awareness pop. Web vector → WAF rule, app team page, code review. Loss/theft → remote wipe, encryption verification, legal hold.
- **Post-incident Activity** — [[Lessons Learned]] is filed against the classification. Metrics roll up by vector. If 70% of your incidents are email vector and your awareness training budget is $0, the [[Root Cause Analysis]] writes itself.

### Severity matrix — the practical version

Most orgs collapse the NIST three-axis model into a simple matrix the on-call analyst can apply at 3am:

| Severity | Trigger | Notification |
|---|---|---|
| **SEV-1 / Critical** | High functional impact OR confirmed data exfil OR ransomware encrypting prod | CISO + IR lead + legal + executive bridge, immediate |
| **SEV-2 / High** | Medium functional impact OR contained exfil attempt OR known APT TTPs observed | IR lead + CISO within 1 hour |
| **SEV-3 / Medium** | Low functional impact, single-host malware, contained phish click | IR team queue, business hours |
| **SEV-4 / Low** | Policy violation, single-user awareness failure, no compromise confirmed | L1 disposition, ticket close |

> **CompTIA exam trap:** Severity is **not** a vector. Vector is *how it arrived*, severity is *how much it hurts*. CompTIA will offer "high severity" as a multiple-choice option for an attack vector question. Wrong. The vectors are the eight NIST categories, full stop.

### Classification feeds the regulatory clock

The tag determines the clock:

- **Privacy breach** with EU data subjects → GDPR 72-hour notification to supervisory authority
- **Privacy breach** with US health data → HIPAA Breach Notification Rule (60 days, with carve-outs)
- **Privacy breach** with PCI cardholder data → PCI DSS incident response requirements + card brand notification
- **Attrition (DDoS)** on critical infrastructure → CIRCIA reporting for covered entities (72h for substantial incidents, 24h for ransom payments)
- **Loss/theft** with encrypted data and verified key separation → often *not* a reportable breach under safe-harbor provisions

Misclassify the information impact and you miss a clock. Miss a clock and the regulator's fine line-item is bigger than the incident itself.

## SOC reality

- The L1's first action after acknowledging a SIEM alert is to drop the initial classification tag into the ticket. "Suspected email vector, phishing, scope TBD." That tag is provisional and gets updated as analysis progresses — but it gets dropped *fast*, because the playbook depends on it.
- Classification changes mid-incident. What starts as "email vector, low impact" turns into "email vector → web vector → privilege escalation → confirmed exfil, high functional, privacy breach, extended recoverability" over six hours. Update the ticket every time the tag shifts. The post-incident timeline depends on it.
- The CISO's first three questions on any SEV-1 bridge: **"What's the vector? What's the impact? Is the regulatory clock running?"** All three are classification questions. If you can't answer them, the bridge stops while you find out.
- Never promise leadership a final classification on the first call. *"Initial classification is email vector, suspected phishing, scope under investigation"* is the right phrasing. "It was just a phish" is the phrasing that gets quoted back at you in the board deck three weeks later when it turns out to have been BEC with wire fraud.
- "Other / Unknown" is a valid classification, not a failure. Some incidents stay there for hours while forensics catches up. Forcing a premature tag to look decisive is how playbooks fire on the wrong incident.

## Related concepts

[[Incident Response Lifecycle]] · [[NIST SP 800-61]] · [[Playbooks]] · [[Tabletop Exercise]] · [[Lessons Learned]] · [[Root Cause Analysis]] · [[Chain of Custody]] · [[Forensic Acquisition]] · [[Phishing]] · [[BEC — Business Email Compromise]] · [[DDoS]] · [[Insider Threat]] · [[SIEM]] · [[GDPR]] · [[CIRCIA]] · [[HIPAA]]

*Source: VIRGIL knowledge base — 2026-05-11*