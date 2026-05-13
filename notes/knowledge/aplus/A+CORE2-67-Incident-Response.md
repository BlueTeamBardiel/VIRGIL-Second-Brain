# Incident Response

## What it is

You're rebuilding a user's laptop because it "feels slow." Halfway through, you notice a folder full of customer SSNs on the desktop, named `customer_dump_FINAL.xlsx`. The user is not in finance. The user should not have that file. You just became the first responder to an incident.

**Plain English:** Incident response is the structured process for handling an event that violates security, policy, or law — malware infection, data breach, prohibited content discovery, theft, insider misuse. The minute you suspect one, your job changes from "fix the computer" to "preserve evidence and notify the right people."

**Technical definition:** Incident response (IR) is the documented procedure an organization follows to identify, contain, eradicate, recover from, and document security incidents — while preserving chain of custody for evidence that may end up in court, in an audit, or in front of a regulator.

## Why it matters

A+ technicians are almost always the first humans to touch the evidence. Not the SOC. Not legal. You. What you do in the first ten minutes determines whether the company can prosecute, defend itself in a lawsuit, or pass an audit. Touch the wrong thing — reboot the box, log in as the user, copy a file with drag-and-drop — and you've contaminated evidence. The case dies. The auditor writes you up. Sometimes you get fired.

Tested directly on 220-1202 Objective 4.6 (prohibited content, regulated data, chain of custody, incident documentation).

## At home, at work

**Beat 1 — What "incident" actually covers.** Not just hackers. Malware infections, ransomware, prohibited content (CSAM, pirated software, illegal material), data breaches, lost/stolen devices, insider data exfiltration, AUP violations, license violations discovered during audit. Any of these can land on your ticket queue worded as something mundane: "computer running slow," "weird popup," "I can't find a file."

**Beat 2 — The Reddit-mod version of this you already know.** You've seen a Discord server handle a doxxing incident. Mods freeze the channel, screenshot everything before the user can delete, ping admin, escalate to Discord ToS team. *Don't engage the offender. Don't let them clean up. Preserve, then escalate.* That instinct is exactly right. Enterprise IR is the same instinct with paperwork.

**Beat 3 — At work, with stakes.** Same situation, the user is your coworker, the data is regulated, and "preserve and escalate" means a specific documented sequence. You do not investigate. You do not confront. You do not delete the file to "help." You stop, you document what you saw, you notify your manager and security, and you wait for instructions. *Curiosity is the enemy. Every click you make goes in the log.*

**Beat 4 — The point.** Same instinct, different consequences. Get the sequence — *observe, preserve, document, escalate* — into your bones before you see your first real incident. You won't have time to think it through when it happens.

## Key facts

### The first responder sequence

1. **Identify** — recognize that what you're looking at is an incident, not just a slow PC
2. **Report through proper channels** — your manager and security; not a public Slack channel
3. **Preserve** — leave the machine alone. Don't reboot, don't log out, don't copy files
4. **Document** — what you saw, when, where, who was logged in, what was on screen. Photograph the screen with your phone if instructed
5. **Maintain chain of custody** — every person who touches the evidence signs for it, timestamped

### Order of volatility

Evidence disappears in this order, fastest to slowest. Capture top-down:

| Tier | Data | Lifespan |
|---|---|---|
| 1 | CPU registers, cache | Microseconds |
| 2 | RAM, running processes, network connections | Until power off |
| 3 | Temp files, swap/pagefile | Until reboot or cleanup |
| 4 | Disk contents | Persistent |
| 5 | Remote logs, backups | Persistent, off-system |
| 6 | Physical media, printouts | Indefinite |

*Pulling the plug "to be safe" destroys tiers 1–3. Don't do it unless instructed.*

### Chain of custody

A documented log of who handled the evidence, when, why, and what they did with it. Every transfer signed. Break the chain and the evidence is inadmissible. Forensic copies are made bit-for-bit (using `dd` or hardware imagers), the original is sealed and write-blocked, and the copy is what gets analyzed.

> **CompTIA exam trap:** "Copy of the drive" on the exam means a **forensic bit-for-bit image**, not a file copy or robocopy. CompTIA will offer "copy the user's files to a USB" as a wrong answer — it destroys metadata and breaks chain of custody.

### Regulated data types you must recognize

| Data type | Regulation | Examples |
|---|---|---|
| PII | State laws, GDPR | Name + SSN, address, DOB |
| PHI | HIPAA | Diagnoses, prescriptions, medical records |
| PCI | PCI-DSS | Credit card numbers, CVV, magstripe data |
| Government-issued | Various | SSN, passport, driver's license, military ID |
| Financial | GLBA, SOX | Bank account numbers, financial statements |

If you find any of this where it doesn't belong, *that is an incident.* Stop and escalate.

### NDAs, law enforcement, licensing

- **NDA** — you agree not to disclose what you see. Standard for IT, signed on day one. **MNDA** is mutual, common when outside forensics vendors are involved.
- **Law enforcement** — you don't make the call; your manager and legal do. Triggers: CSAM (mandatory reporting in most jurisdictions), credible threats of violence, crimes against the company, regulated data breaches above reporting thresholds. *Escalate, don't dial 911 yourself unless there's an immediate safety threat.*
- **Licensing incidents** — pirated software, personal licenses used for business, expired perpetual licenses still deployed, GPL violations in commercial products, DRM circumvention tools. Splash screens ("Licensed to Acme Corp, seat 47/100") are evidence — screenshot them during inventory.

## AI tools as tickets and triage helpers

**Listening notes → incident report.** Take rough notes during discovery — what was on screen, what the user said, timestamps, file paths. After you've secured the scene, paste those notes into your company-approved AI (Microsoft Copilot, ServiceNow Now Assist) and ask for a structured incident report. Faster than typing longhand, structure is consistent.

**Screenshot triage.** User sends a ransomware splash you don't recognize. Drop it into the approved AI and ask "what ransomware family is this?" The AI does the visual ID; you do the response decision.

**Hard rule:** never paste the actual regulated data, credentials, or screenshots containing PII/PHI/PCI into any AI tool — even an approved one — unless security has explicitly cleared that workflow. Redact first. The AI helps you write *about* the incident; it never sees the incident's contents. Violating this turns *you* into the next incident.

## Helpdesk reality

- User says: *"Can you just delete it? I don't want to get in trouble."* Right answer: "I can't modify anything on this system right now. I need to step away and make a call." Then call your manager. Do not delete. Do not promise anything.
- User says: *"It's not mine, someone else must have put it there."* Note the statement verbatim. Don't argue. Don't investigate. Not your role.
- Coworker says: *"What did you find on so-and-so's machine?"* Right answer: "I can't discuss active incidents." Not even hints. Not even to your work-best-friend.
- Manager says: *"Just wipe it and reimage, we don't need the drama."* Right answer: "I need that in writing, and I need to confirm with security first." Get the cover. Some managers will throw you under the bus the second an auditor shows up.

## Related concepts

[[Chain of Custody]] · [[PII PHI PCI]] · [[Acceptable Use Policy]] · [[Software Licensing]] · [[Data Destruction]] · [[Documentation and Ticketing]] · [[Change Management]] · [[Malware Removal Process]]

*Source: VIRGIL knowledge base — 2026-05-11*