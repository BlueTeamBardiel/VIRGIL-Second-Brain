# Mobile Device Forensics

## What it is

In **Tetris**, you don't get to pause the board to think. The pieces keep falling, and every line you leave unfilled raises the stack toward the kill line. The only way to survive is to commit early — slot the L-piece *now*, before the next tetromino spawns and forces a new geometry. Mobile device forensics is the same drill. The phone is the falling board. Battery drains. Remote wipe commands are queued by an attacker in another country. Cell tower updates rewrite location history. Apps phone home and overwrite caches. *You acquire on the clock or you acquire nothing.*

In plain English: mobile forensics is the discipline of pulling evidence off a phone or tablet in a way that holds up in court and survives technical scrutiny — without altering what's on the device.

Technical definition for CS0-003: the structured process of identifying, isolating, acquiring, preserving, analyzing, and reporting on data from mobile endpoints (iOS, Android, embedded) during incident response. It sits inside the **Detection and Analysis** and **Containment, Eradication, and Recovery** phases of the [[NIST SP 800-61]] lifecycle, governed by [[Chain of Custody]] and [[Legal Hold]] requirements.

## Why it matters

A laptop sits on a desk. A phone goes everywhere — into the rideshare, into the executive's bag during the M&A meeting. When the incident touches insider threat, BEC, executive account takeover, or stalkerware, the phone holds the answer: SMS, location data, app artifacts, push notification history, WhatsApp/Signal databases, biometric unlock events.

CompTIA tests this under **Objective 3.2 — Given a scenario, perform incident response activities**: evidence acquisition, preservation, chain of custody, validating data integrity, and isolation. Mobile is *different* from desktop — different acquisition types, different isolation requirements, different legal exposure.

Real-world stakes: a botched acquisition gets thrown out at trial. A phone left on the network gets remote-wiped mid-acquisition. A device unlocked with the suspect's biometric before counsel arrives challenges the whole case on Fifth Amendment grounds. The L1 analyst who powers a phone off "to be safe" just triggered secure boot and lost the unencrypted RAM keys forever.

## Key facts

### The acquisition hierarchy

| Type | What you get | Risk | When you use it |
|---|---|---|---|
| **Manual** | Photos of the screen, scrolling by hand | Highest evidentiary risk, alters state | Triage only, or when nothing else works |
| **Logical** | What the OS API exposes — contacts, SMS, call logs, some app data | Low risk, partial coverage | First-pass on a live, unlocked device |
| **Filesystem** | Allocated files at FS level — app sandboxes, SQLite DBs, plists, caches | Medium risk, needs elevated access | When logical isn't enough and you have legal authority |
| **Physical** | Bit-for-bit image of NAND flash, including deleted/unallocated | Highest depth, often blocked by full-disk encryption | High-stakes; modern iOS/Android often impossible without exploit |

*Modern phones are encrypted by default. Physical acquisition on a locked, post-2018 iPhone is the Tetris T-spin of forensics — possible if you have the right tool and the right exploit chain, otherwise the piece doesn't fit.*

### Isolation — the Faraday move

The moment you seize the device, it must come off every network: cellular, Wi-Fi, Bluetooth, NFC, UWB. If you don't isolate, the attacker — or the device's own MDM — can remote-wipe, push a config, or rotate keys.

**Options, ranked:**

1. **Faraday bag / Faraday box** — RF-shielded enclosure. Gold standard. Phone keeps running, keeps the screen unlocked if it was unlocked, but cannot transmit or receive.
2. **Airplane mode + disable Wi-Fi/Bluetooth manually** — only if already unlocked and you can trust the UI. Touching the screen alters state.
3. **SIM removal** — kills cellular but not Wi-Fi. Partial measure.
4. **Power off** — last resort. Triggers secure boot, encrypts memory, loses volatile artifacts, may activate BFU (Before First Unlock) state on iOS where even good tools can't extract.

> **CompTIA exam trap:** "Power off the device to preserve evidence" is the *wrong* answer for mobile. Powering off destroys RAM artifacts and transitions iOS devices to BFU state where most data is unreachable. The right answer is **isolate via Faraday bag while keeping the device powered and in current lock state.**

### Preservation and data integrity

Once acquired, the image must be hashed — typically **SHA-256** — and the hash recorded in the [[Chain of Custody]] log. Every analysis happens on a working copy, never the original. The hash gets re-verified at every transfer: examiner to examiner, lab to court.

**Validating data integrity** means the hash recorded at acquisition matches the hash on the copy the defense expert receives. If it doesn't match, the evidence is contaminated. Answer with the log, not from memory.

### Chain of custody — the line clear

Every person who touches the evidence signs. Every transfer, every storage location, every analysis session — logged with timestamp, name, purpose, hash verification.

Required fields: case number, item description (make, model, IMEI, serial, condition), date/time of seizure, seizing analyst, every subsequent transfer with both signatures, storage location, hash values at each verification.

*A single gap — one transfer with no signature — and opposing counsel walks the evidence out the door. I've watched a six-figure investigation collapse because someone "just grabbed the phone for a second" and didn't log it.*

### Legal hold

When litigation is reasonably anticipated, the org must issue a **legal hold** suspending normal data destruction. For mobile:

- Disable auto-wipe-on-failed-PIN policies
- Disable MDM auto-retire / device refresh
- Suspend iCloud/Google account deletion routines
- Preserve cloud backups — often more recoverable than the device itself
- Notify the custodian in writing

Legal hold is a **legal control**, not a technical one. Counsel issues it. The SOC executes without alerting the custodian if the investigation is covert.

### Scope and impact

**Scope:** which device(s), which custodian(s), which timeframe, which data categories. Defined by counsel and the IR lead, not the analyst. Going beyond scope is a Fourth Amendment problem in the US and a GDPR problem in the EU.

**Impact** for a compromised mobile device:
- What corporate data was on it? (mail, SSO tokens, VPN certs, MDM-pushed apps)
- What credentials does it cache? (push MFA, passkeys, authenticator seeds)
- What downstream systems trust it? (conditional access, device-bound tokens)
- Executive, privileged admin, or developer with prod access?

A phone with a cached production AWS console session is not the same impact as a phone with email only.

### Where the artifacts live

| Artifact | iOS | Android |
|---|---|---|
| SMS/iMessage | `sms.db` (SQLite) | `mmssms.db` |
| Call logs | `CallHistory.storedata` | `contacts2.db` |
| Location | `cache.sqlite`, significant locations | Google location history, `cache.cell` |
| App data | `/private/var/mobile/Containers/Data/Application/` | `/data/data/<package>/` |
| Keychain / credentials | iOS Keychain (encrypted) | Android Keystore (TEE-backed) |

Pair device artifacts with **cloud-side logs**: M365 sign-in logs, Google Workspace audit logs, MDM logs (Intune, Jamf, Workspace ONE). The device tells you what the user did locally; cloud logs tell you what the device did to the rest of the business.

### Remediation and compensating controls

After forensics complete, the device is either returned to service after factory reset and MDM re-enrollment, or retired and destroyed when chain-of-custody value exceeds operational value.

[[Re-imaging]] a phone means **factory reset + MDM re-enrollment + fresh credential issuance**. Old certificates, push tokens, and refresh tokens must be revoked server-side — resetting the device doesn't revoke them.

**Compensating controls** while the user waits for a clean device: loaner phone with restricted access, forced MFA re-enrollment from a known-good device, conditional access rules blocking the compromised device ID, token revocation across SSO/IdP.

> **CompTIA exam trap:** Re-imaging without **revoking cached credentials and tokens server-side** leaves the attacker with valid sessions. The exam will ask what's missing — the answer is usually "revoke refresh tokens" or "rotate device certificates," not "wipe again."

## Feynman: Tetris on a one-way clock

Mobile forensics plays like Tetris where you can't see the next-piece queue and gravity speed is set by the attacker. The board state is the device. Every piece you commit to:

- **Piece 1: Seize.** Grab the phone. State at this moment is your baseline. Photograph the screen.
- **Piece 2: Isolate.** Faraday bag, now. Every second on the network is another line stacking toward wipe.
- **Piece 3: Document.** Make, model, IMEI, visible damage, lock state. The bottom row — if it's not solid, everything above collapses.
- **Piece 4: Acquire.** Logical first, filesystem if you have the tool and legal cover. Hash immediately.
- **Piece 5: Verify.** Re-hash. The line clears when the hashes match.
- **Piece 6: Analyze on a copy.** Never on the original. The original sits in the evidence locker with a signed chain.

The kill line is **device wipe, BFU transition, or chain-of-custody break**. Hit any of those and the run ends.

*The hard lesson: in Tetris, the wrong piece in the wrong slot is recoverable if you stack carefully around it. In mobile forensics, the wrong move — powering off, unlocking with the suspect's finger before counsel signs off, leaving the device on Wi-Fi for "just five minutes" — is not recoverable. The piece doesn't come back out.*

## SOC reality

- **The 3am alert:** "MDM flagged jailbreak detection on a VP's iPhone." First action: pull the device ID from Intune, force a conditional access block, *do not* alert the user. Loop in legal before you touch the phone.
- **What the IR lead asks:** "Is it in a Faraday bag? What's the lock state? Have we revoked the refresh tokens? Who has the device right now and did they sign the log?"
- **Never promise leadership:** "We got everything off the phone." Modern encryption means physical acquisition often fails. Promise what you have: logical pull, cloud-side logs, MDM telemetry.
- **The handoff:** L1 isolates and documents. L2 or dedicated DFIR performs acquisition — mobile is specialist work. Outside counsel coordinates legal hold. External vendors often handle physical acquisition because the tools (Cellebrite, GrayKey, Magnet AXIOM) are licensed per-examiner.
- **The trap nobody mentions:** cloud sync. The phone you seized is one of three devices syncing to the same iCloud account. Acquiring just the phone misses two-thirds of the picture. Pull the cloud backup under legal process.

## Related concepts

[[Chain of Custody]] · [[Legal Hold]] · [[Evidence Acquisition]] · [[Forensic Imaging]] · [[Hashing and Data Integrity]] · [[NIST SP 800-61]] · [[Containment and Isolation]] · [[Re-imaging]] · [[Compensating Controls]] · [[MDM — Mobile Device Management]] · [[Conditional Access]] · [[Cloud Forensics]] · [[Faraday Bag]] · [[BFU vs AFU State]]

*Source: VIRGIL knowledge base — 2026-05-11*