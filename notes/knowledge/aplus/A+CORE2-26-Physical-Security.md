# Physical Security

## What it is

Your gaming rig sits behind a locked apartment door. The door has a deadbolt, the building has a key fob entry, the lobby has a camera, and the package room has a code. Five layers between the street and your 4090. None of them stop a determined intruder alone. Together they make your apartment a worse target than the unlocked one next door.

Physical security is the same logic applied to the things that hold data: server rooms, network closets, workstations, laptops, badges, the front door of the office. In plain English: keep unauthorized humans away from hardware they shouldn't touch.

Technically: physical security is the layered control set — barriers, access systems, surveillance, detection, and human response — that protects facilities, equipment, and the people inside from physical compromise. It pairs with logical security (passwords, encryption, ACLs) because either one alone is a half-built wall. A server with full-disk encryption is still a problem if someone walks out with it. A locked server room with `admin/admin` on every box is also a problem. You need both.

The motherboard is the nervous system of the machine; the building is the nervous system of the org. Physical security guards the wiring.

## Why it matters

Covered directly in **Objective 220-1202 2.1** — security measures and their purposes. CompTIA tests this heavily because every breach investigation eventually asks: how did they get in? Sometimes the answer is phishing. Sometimes the answer is "they walked in wearing a hi-vis vest and a clipboard." The exam wants you to know the controls by name and what each one actually stops.

Career relevance: your first IT job will involve physical security work whether the job description mentions it or not. You'll image laptops in a locked room, escort vendors to the server cage, issue badges, configure the door reader after someone gets terminated, and explain to a CFO why his unencrypted laptop being stolen from his car is a reportable incident. The helpdesk ticket queue includes "I forgot my badge" every Monday morning.

## In your build, in the enterprise

**Beat 1 — the controls, layered.** Physical security stacks in concentric rings: perimeter (fences, bollards, lighting, guards), building entry (badge readers, access control vestibules, magnetometers), interior zones (door locks, video surveillance, motion sensors, alarms), and equipment-level (equipment locks, cable locks, locking racks). Each ring is independent. Bollards stop a vehicle ram. Fences slow a pedestrian. Lighting removes shadows for cameras. A vestibule (mantrap) defeats tailgating by only opening the inner door after the outer one closes and one person is verified. Badge readers log who entered when. Video surveillance is forensic after the fact, deterrent before it. Motion sensors and alarms close the loop when nobody's watching the feeds live. Door locks come in mechanical (key), electronic (keypad), and electromechanical (badge/fob-triggered strike). Equipment locks are the Kensington slot on every business laptop and the locking bezel on rack-mounted servers.

**Beat 2 — Feynman via the gaming PC.**

**Your apartment door:** Deadbolt, peephole, the camera doorbell. *That's a vestibule, surveillance, and a lock — same controls, smaller scale.*

**The PC itself:** The Kensington slot you've never used. The case has thumb screws because nobody steals your side panel. *Consumer hardware assumes the building is the perimeter.*

**The GPU:** $1,800 of resellable hardware sitting in a glass-side case. You leave the apartment for a weekend LAN. *Your physical security is "I trust my roommate and my landlord's tenant screening."* That's a fine threat model for an apartment. It's a catastrophic threat model for a data center.

**The Steam Deck on the train:** You set it down to grab your bag and it's gone in three seconds. *Mobility breaks every physical control that assumes the asset stays put.* This is the same reason laptops get stolen from cars and conference rooms.

**Beat 3 — bridge from apartment to enterprise.** Same fundamental question: what's between an unauthorized person and the hardware? In your apartment: one locked door and a building lobby. In a small business office: a glass front door, a receptionist, and an unlocked server closet under someone's desk — frankly, worse than your apartment. In a real enterprise: fenced perimeter, guard at the gate, vestibule at the lobby, badge reader on every interior door, separately keyed server room, biometric reader on the cage holding the financial systems, locking rack inside the cage, and a tamper sensor on the rack door. Five-plus rings instead of one. The cost of the asset and the regulatory blast radius of its loss decide how many rings you build.

**Beat 4 — the point.** Same question, different stakes, different right answers. An apartment door is enough for a gaming PC. A vestibule, biometrics, and 24/7 surveillance are the minimum for a room full of customer PII. Get the question into your bones: *what's between an unauthorized human and this hardware, and is that enough given what the hardware holds?* You'll ask it for the rest of your career — every site survey, every new office buildout, every audit.

## Key facts

### Perimeter and exterior controls

| Control | What it does | What it stops |
|---|---|---|
| **Fences** | Defines boundary, slows pedestrian access | Casual trespass |
| **Bollards** | Short posts blocking vehicle approach | Vehicle ramming, accidental impact |
| **Lighting** | Eliminates shadows, supports cameras | Concealment, deters opportunists |
| **Security guards** | Human judgment, response, deterrence | Social engineering, active threats |
| **Video surveillance** | Records activity, deters, investigates | Mostly forensic; deterrent secondary |

### Building entry controls

- **Access control vestibule (mantrap):** Two interlocking doors. Outer closes before inner opens. Defeats **tailgating** — the #1 way unauthorized people enter buildings.
- **Badge reader:** Proximity card (RFID) or smart card. Logs every entry. Cheap to deploy, easy to revoke when someone is terminated.
- **Magnetometers:** Metal detectors at entry. Common in courthouses, schools, sensitive government sites. Not common in private offices.
- **Biometrics:** Fingerprint, retina, palm print, facial recognition (FRT), voice recognition. Authenticates a person, not a card. Pairs with badges for MFA at the door.

### Interior and equipment controls

- **Door locks:** Mechanical (pin tumbler), electronic (keypad/PIN), electromechanical (badge-triggered strike), smart (mobile digital key via Bluetooth/NFC).
- **Motion sensors / alarm systems:** Detect after-hours intrusion. Tied to monitoring service for response.
- **Equipment locks:** Kensington cable locks on laptops, locking server rack doors, USB port blockers on kiosks, locking bezels on disk bays.
- **Keys / key fobs:** Mechanical keys still exist for server rooms and IDF closets. Fobs are RFID tokens for door access, often combined with PIN.

### Authentication factors (where physical meets logical)

The exam loves the **three factors of authentication** — know them cold:

| Factor | Examples |
|---|---|
| **Something you know** | Password, PIN, security question |
| **Something you have** | Smart card, key fob, hardware token, mobile digital key, TOTP app |
| **Something you are** | Biometric — fingerprint, retina, palm, face, voice |

Sometimes a fourth factor: **somewhere you are** (geolocation/IP-based).

**MFA** combines two or more *different* factors. A password + a PIN is not MFA — both are "something you know."

### Logical security controls (pair with physical)

- **Principle of least privilege (PoLP):** Give every user the minimum access required to do their job. Nothing more.
- **Just-in-time (JIT) access:** Privileges granted only when needed, revoked after. Standing admin rights are the enemy.
- **Privileged Access Management (PAM):** Vaults admin credentials, brokers sessions, records what privileged users did.
- **Zero Trust:** Never trust, always verify. No implicit trust based on network location. Every request authenticated, authorized, encrypted.
- **ACLs:** Lists of who can access what — on files, folders, network resources, firewall rules.
- **Identity and Access Management (IAM):** The umbrella system tying users to entitlements across the org.
- **Directory services:** Active Directory, Entra ID, LDAP — the source of truth for identity.
- **SSO (Single Sign-On):** One authentication grants access to multiple systems. Reduces password fatigue and reuse.
- **SAML:** The protocol that makes SSO work between identity providers and service providers.
- **MDM:** Mobile Device Management. Enforces policy on phones, tablets, laptops — encryption, screen lock, remote wipe.
- **DLP:** Data Loss Prevention. Monitors and blocks sensitive data from leaving via email, USB, cloud upload.

### MFA delivery methods (220-1202 explicitly tests these)

- **SMS / voice call:** OTP delivered by text or phone. Weakest MFA — SIM swapping defeats it. Better than nothing.
- **Authenticator app (TOTP):** Time-based one-time password, 6 digits, refreshes every 30 seconds. Google Authenticator, Microsoft Authenticator, Authy. Strong, free, offline-capable.
- **Hardware token:** YubiKey, RSA SecurID. Physical device generates or signs codes. Strongest common MFA. Phishing-resistant when FIDO2.
- **Email OTP:** One-time code sent to email. Weak if the email account itself isn't MFA-protected.
- **Push notification:** App prompts "approve/deny." Convenient, vulnerable to MFA fatigue attacks (spam the user until they approve).

### CompTIA exam traps

> **CompTIA exam trap:** Vestibule vs. badge reader. A badge reader alone does not stop tailgating — someone can follow you in. A **vestibule** is the control that specifically defeats tailgating because only one person can be verified at a time.

> **CompTIA exam trap:** MFA factor counting. Password + security question = single-factor (both "know"). Password + fingerprint = MFA. Password + smart card = MFA. Smart card + PIN = MFA (have + know — this is how CAC/PIV cards work).

> **CompTIA exam trap:** Bollards stop vehicles, not people. Fences slow people. Don't swap them on the test.

> **CompTIA exam trap:** Biometrics authenticate *who you are*, not *what you have*. CompTIA will offer "biometric token" as a distractor — there's no such category.

> **CompTIA exam trap:** Least privilege ≠ Zero Trust. Least privilege limits *what* a verified user can do. Zero Trust questions *whether* a request should be trusted at all, every time.

## Helpdesk reality

- **"I forgot my badge."** Standard Monday ticket. Verify identity (photo ID + supervisor confirmation if needed), issue a temporary badge with same-day expiration, log it. Never just buzz someone in because they look familiar.
- **"My laptop was stolen from my car."** Don't lecture. Open an incident ticket immediately, trigger remote wipe via MDM, rotate any cached credentials, notify security/compliance. If the disk was encrypted (BitLocker, FileVault) and the device was locked, the data is probably safe — say *probably*, never *definitely*.
- **"Can you let this contractor into the server room real quick?"** No. Contractors need a sponsored badge, a logged visit, and escort per policy. The shortcut is how breaches happen. Point them at the proper request workflow even if the requester is your manager.
- **"The fingerprint reader won't recognize me."** Wet hands, cuts, dry skin, sensor dust. Re-enroll the print. If it keeps failing, that user needs a fallback factor — never leave someone locked out of MFA with no recovery path.
- **"I propped the server room door open while I worked."** Common, dangerous, and against every policy. Close the door. Explain why once, calmly. If it keeps happening, it's a security incident, not a conversation.

## Related concepts

[[Authentication Methods]] · [[MFA and TOTP]] · [[Active Directory and Entra ID]] · [[Mobile Device Management]] · [[Data Loss Prevention]] · [[Zero Trust]] · [[Principle of Least Privilege]] · [[Incident Response]] · [[BitLocker and Full Disk Encryption]] · [[Social Engineering]]

*Source: VIRGIL knowledge base — 2026-05-10*