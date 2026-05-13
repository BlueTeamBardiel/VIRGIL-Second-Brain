# Physical Access Security

## What it is

The server room door has a badge reader, a PIN pad, and a camera pointed at the keypad. To get in: tap the badge, type the PIN, and the camera records your face doing it. Three factors, one door. That's physical access security in one sentence.

Plain English: every layer that decides whether a human body — not a user account, a body — gets near hardware it shouldn't touch. Fences, locks, badges, vestibules, guards, cameras, sensors, and the policies that govern them.

Technical: physical access security is the set of administrative, physical, and technical controls that restrict, monitor, and audit physical entry to facilities, equipment, and media. It enforces the same principles as logical access control — identification, authentication, authorization, accounting — applied to atoms instead of bits. If your nervous system (the network) is hardened but someone can walk up to the switch and plug in a Raspberry Pi, the whole stack is compromised at the heart.

## Why it matters

The cheapest, fastest, most reliable attack on any system is physically touching it. Encryption stops a remote attacker. It doesn't stop someone who walks the server out of the building on a hand truck. CompTIA tests this hard on **220-1202 Objective 2.1** because techs in the field are the ones installing badge readers, escorting visitors, locking workstations, and noticing the propped-open back door.

There's also the helpdesk reality: most physical security failures aren't movie heists. They're forgotten badges, tailgaters, an unlocked screen at lunch, a sticky note with a password under the keyboard. You'll handle these constantly.

## In your build, in the enterprise

**Beat 1 — the control categories.** Physical access security splits into four functional groups. *Deterrents* discourage attempts: fences, lighting, signage, visible cameras. *Preventive controls* block entry: locks, bollards, vestibules, badge readers, biometric scanners. *Detective controls* catch attempts in progress or after: motion sensors, alarms, video surveillance, magnetometers. *Compensating controls* fill gaps: security guards, escort policies, log review. Real facilities layer all four — defense in depth.

**Beat 2 — your gaming rig and homelab.** You already do physical security, you just don't call it that. Your apartment door is a **door lock** — single-factor, something-you-have. Smart lock with a code? Two-factor. The Kensington slot on your laptop you never use is an **equipment lock** mount point — same control class hospitals put on every workstation. *Same control, different stakes.*

Your homelab's threat model is small: roommate, cat, gravity. A desk against a wall is fine. *Your data is replaceable, your hardware is insured.*

But if you run a Plex server with family photos, or a Proxmox box with VMs holding tax documents and password vault backups, you've crossed into needing real physical thinking. *Where is the box? Who has access to that room? If someone grabbed it tomorrow, what walks out with it?* If the answer is "everything I care about, unencrypted," the fix isn't a better firewall — it's full-disk encryption (BitLocker, LUKS) so the drive is useless when it leaves the building.

**Beat 3 — the bridge to enterprise.** Same question, bigger building. *Who is allowed near which hardware, and how do we prove it after the fact?*

The parking lot has **bollards** to stop vehicle ramming. **Fences** and **lighting** mark perimeter. **Guards** patrol and check badges. The front door is a **badge reader** plus PIN pad. High-security zones use an **access control vestibule** (mantrap) — two interlocked doors, one person at a time, defeating tailgating. **Magnetometers** screen for weapons at sensitive sites. **Biometric scanners** add something-you-are on top of the badge. **Motion sensors** and **alarms** trigger after hours. **Video surveillance** records for the inevitable investigation. **Equipment locks** chain workstations to desks.

**Beat 4 — the point.** Physical security is logical security's foundation. Every authentication mechanism on the network assumes the attacker can't physically touch the device. Break that assumption, the whole stack is theater. *Get this question into your bones: where is the hardware, who can reach it, and what proves they were the ones who did?*

## Key facts

### Physical security controls — the named devices

| Control | Category | What it does | CompTIA gotcha |
|---|---|---|---|
| **Bollards** | Preventive (perimeter) | Concrete/steel posts that stop vehicles | Anti-vehicle, not anti-pedestrian |
| **Fences** | Deterrent/preventive | Mark perimeter, slow intrusion | Height and material matter |
| **Lighting** | Deterrent/detective | Eliminate shadows | Often motion-activated |
| **Security guards** | Compensating/preventive | Human judgment, response, escort | Only control that adapts real-time |
| **Access control vestibule (mantrap)** | Preventive | Two interlocked doors, one person at a time | Defeats **tailgating/piggybacking** |
| **Badge reader** | Preventive (authentication) | RFID/NFC card validates identity | Pairs with PIN for two-factor |
| **Magnetometer** | Detective | Metal detector for weapons/devices | Gov, courts, secure facilities |
| **Motion sensors** | Detective | Detect movement in restricted zones | After-hours alarm trigger |
| **Alarm systems** | Detective | Signal intrusion, notify response | Useless without monitored response |
| **Video surveillance (CCTV)** | Detective | Record activity for forensics | Evidence, not prevention |
| **Door locks** | Preventive | Mechanical or electronic entry | Cipher locks, smart locks, deadbolts |
| **Equipment locks** | Preventive | Cable locks (Kensington), rack locks | Stops walk-off theft |

### Biometric scanners (something-you-are)

| Type | How it works | Strength | Weakness |
|---|---|---|---|
| **Fingerprint** | Capacitive/optical ridge pattern | Cheap, fast, ubiquitous | Spoofable; wet/dirty fingers fail |
| **Palm print** | Vein/print pattern of whole palm | Harder to spoof | Larger reader, slower |
| **Retina** | Blood vessel pattern in back of eye | Extremely unique | Invasive, slow, expensive |
| **Facial recognition** | Geometry of face | Contactless, fast | Lighting/angle sensitive; fooled by photos on cheap systems |
| **Voice recognition** | Vocal pattern | Contactless, works over phone | Noise, illness, recordings |

> **CompTIA exam trap:** biometrics is **something-you-are**, not something-you-have. A fingerprint reader on a phone is one factor. The phone (something-you-have) plus the fingerprint (something-you-are) is two-factor. Don't double-count the biometric.

### Physical access tokens — what people carry

- **Keys** — oldest control. Easy to copy, easy to lose, no audit trail.
- **Key fobs** — RFID/NFC dongle, no battery, taps a reader. Cheap and revocable.
- **Smart cards** — chip with cryptographic credentials (PIV, CAC in government). Often dual-use: physical entry + logical login.
- **Hardware tokens** — YubiKey, RSA SecurID, FIDO2 keys. Primarily logical, increasingly tied to physical access.
- **Mobile digital key** — phone with NFC/Bluetooth credential. Provisioned through MDM, revocable instantly. Replacing plastic badges at modern facilities.

### Logical controls that ride alongside physical

Physical access integrates with the same identity stack as logical access: **IAM** knows who you are across all systems; **directory services** (AD, LDAP, Entra ID) back it; **MFA** applies at the door (badge + PIN, badge + biometric) and the workstation; **least privilege** means HR doesn't get the data center badge; **just-in-time access** auto-revokes the contractor's data center badge after their 2-hour work order; **Zero Trust** applies to bodies in buildings, not just packets on wires; each door has an **ACL** of which badge IDs are allowed at which times.

### Consumer vs. enterprise

**At home:** front door lock, maybe a smart lock, maybe a Ring camera. Laptop fingerprint reader. Face ID. Audit log is your memory and 30-day cloud retention. *Threat model: opportunist burglary, roommate snooping.*

**In the enterprise:** layered perimeter (fence → bollards → guards → vestibule → badge + biometric → cameras → motion sensors → alarms), every entry logged to IAM, tied to AD/Entra, reviewed by SOC analysts. Visitor sign-in, escort, badge issuance. Annual access reviews to revoke stale permissions. *Threat model: insider threat, corporate espionage, ransomware crews, physical pen testing.*

The jump isn't just more locks — it's **auditability**. Enterprise physical security exists so that after the incident, you can prove who was where, when, and what they touched.

### CompTIA exam traps

> **Tailgating vs. piggybacking:** *Tailgating* is following someone in without their knowledge. *Piggybacking* is with their consent (they hold the door). Both defeated by **access control vestibules**.

> **Mantrap = access control vestibule.** CompTIA prefers "access control vestibule" on the new exam. Know both terms.

> **Bollards stop vehicles, not people.** Pedestrian intrusion answers are fences, locks, or guards.

> **Video surveillance is detective, not preventive.** Cameras record what happened — they don't stop it. If the question asks what *prevents* unauthorized access, the answer is locks, vestibules, or guards.

> **Biometrics ≠ MFA by itself.** A fingerprint alone is one factor. MFA requires two of {something-you-know, something-you-have, something-you-are}.

## Helpdesk reality

- **"I forgot my badge, can you let me in?"** — Never. Even if you know the person. Direct them to reception or security for a temporary badge. Tailgating someone in because you recognize them is the exact behavior pen testers exploit.
- **"The badge reader at the side door is broken, we've been propping it open."** — Critical ticket, not low-priority. A propped door defeats every control behind it. Escalate to facilities and security same-day.
- **"I need access to the server room to grab a cable."** — Not without a ticket, escort, or pre-authorized access. Even for techs. Especially for techs.
- **"Why do I need to lock my screen when I go to the bathroom?"** — Because an unlocked workstation is a logged-in workstation, and a logged-in workstation is one passerby away from exfiltration. Win+L. Make it a reflex.
- **"Someone's following me into the building, should I hold the door?"** — No. Politely ask them to badge in themselves. If they can't, direct them to reception. You will feel rude. Do it anyway.

## Related concepts

[[Logical Security]] · [[Multifactor Authentication]] · [[Identity Access Management]] · [[Zero Trust]] · [[Principle of Least Privilege]] · [[Mobile Device Management]] · [[Social Engineering]] · [[Workstation Security Best Practices]] · [[Authentication Factors]] · [[Access Control Lists]]

*Source: VIRGIL knowledge base — 2026-05-10*