# Laptop Hardware

## What it is

Your laptop is a desktop PC that someone shrank, sealed, and told to survive on a battery. Every component you'd find in a tower is in there — CPU, RAM, storage, GPU, PSU equivalent, cooling, network — except smaller, soldered more often than not, and packed so tight that replacing one part means removing four others to get to it.

A laptop is a portable computer where every component decision is a tradeoff against three constraints: **size, heat, and battery life**. The motherboard is the nervous system, the battery is the heart that lets the body walk around, and the keyboard, trackpad, webcam, and microphone are the senses. When something fails, you're not swapping a card — you're doing surgery on a sealed patient.

## Why it matters

This is one of the first things you'll do as a helpdesk tech: someone's keyboard has a dead `E` key, their battery swelled and popped the trackpad off, their Wi-Fi card died, or the webcam stopped working two days before a board meeting. Laptops are the dominant business endpoint in 2026 — desktops are a minority deployment outside of call centers, labs, and engineering workstations.

CompTIA tests this on **220-1201 Objective 1.1** — mobile device hardware and replacement techniques. Expect scenario questions where a user describes a symptom and you pick which component to replace.

## In your daily life, in the enterprise

**Beat 1 — what's actually inside.** A modern business laptop has: a lithium-polymer battery (40–90 Wh), one or two SO-DIMM slots OR soldered LPDDR5 RAM, an M.2 NVMe SSD, an M.2 Wi-Fi card with two or three U.FL antenna leads routed up through the display hinge, a membrane or scissor-switch keyboard, a webcam + microphone array above the screen, a fingerprint reader, and sometimes an NFC scanner. Thin-and-lights solder more; business-class ThinkPads, Latitudes, and EliteBooks keep more user-serviceable. Apple solders everything.

**Beat 2 — the home scenario.** Your personal laptop, three years in:

**The battery:** Lasts 90 minutes instead of 7 hours. You run `powercfg /batteryreport` and see design capacity 56Wh, full charge capacity 31Wh. *Lithium batteries die by ~20% per year of heavy use. This is normal, not a defect.*

**The keyboard:** Coffee. The `K` key stopped working. You pry the keycap off, see corrosion on the scissor mechanism, and realize the whole keyboard is one part — you replace the entire top case assembly. *Laptops are repaired at the assembly level, not the component level.*

**The Wi-Fi:** Connection drops when you tilt the screen. After 4 years of opening and closing the lid, one of the U.FL pigtails has fatigued in the hinge. The card itself is fine. *The antennas live in the display bezel — the card lives in the base. The hinge is where they meet and where they fail.*

**The SSD:** SMART warnings. You clone to a new NVMe before it dies, swap, done. *Storage is the easiest laptop swap. If you only learn one repair, learn this one.*

**Beat 3 — same questions, enterprise scale.** You're working helpdesk at a 2,000-person company. Same symptoms, different process:

- **Battery swelled** on a Dell Latitude → ship to depot under warranty, or swap yourself and **dispose of the swollen battery as hazmat** (lithium fire risk — never throw in regular trash, never puncture).
- **Keyboard failed** on a ThinkPad → Lenovo sells it as a CRU (customer-replaceable unit). 15-minute swap, ship the old one back.
- **Wi-Fi card died** on an EliteBook → replace the M.2 2230 card. Note: some enterprise BIOSes have a **wireless card allowlist** — only OEM-approved cards POST. Generic Intel AX210 won't work; you need the HP-branded SKU.
- **Fingerprint reader stopped working** → reseat the ribbon cable first. If still dead, replace the module and re-enroll Windows Hello.

**Beat 4 — the point.** Same hardware questions you've answered for your own laptop, scaled to a fleet with warranty contracts, asset tags, and a return-merchandise pipeline. *The diagnostic instinct is identical. The procurement and disposal process is what changes.*

## Key facts

### Battery

| Spec | Detail |
|---|---|
| Chemistry | Lithium-polymer (Li-Po), sometimes lithium-ion |
| Capacity | 40–90 Wh typical for business laptops |
| Lifespan | 300–800 full charge cycles, 2–5 years real-world |
| Failure modes | Reduced capacity, swelling, won't charge, sudden shutdown at >10% |
| Health check | `powercfg /batteryreport` (Windows), System Information → Power (macOS) |

**Swollen battery = immediate replacement.** You'll see the trackpad bulge upward or the bottom panel bowing. Power off, isolate, replace. Never puncture. Dispose as hazmat through your e-waste process.

### RAM and storage

- **Soldered LPDDR5/LPDDR5X** in ultrabooks, MacBooks, most thin-and-light — not user-replaceable, spec correctly at purchase
- **SO-DIMM DDR4/DDR5** in business laptops, gaming laptops, mobile workstations — match speed and capacity for dual-channel
- **M.2 NVMe 2280** is primary storage on modern laptops (2230 in compact models); PCIe 4.0 or 5.0
- **2.5" SATA SSD** still appears in older business laptops; HDDs are virtually extinct
- **Clone before swap** with Macrium Reflect, Clonezilla, or vendor tools — saves a reinstall

### Wireless cards and antennas

- **M.2 2230 form factor** is standard (Intel AX210, AX211, BE200 for Wi-Fi 7)
- **Two or three U.FL/MHF4 antenna leads** — main, auxiliary, sometimes Bluetooth — route through the hinge to antennas in the display bezel
- **Signal drops when lid is at a certain angle** → broken antenna lead in the hinge, not the card
- **Bluetooth dead but Wi-Fi fine** → one specific U.FL lead disconnected; they're tiny and they pop off

### Keyboard and input

- Scissor-switch or low-profile membrane in most laptops; mechanical in some gaming models
- Thin laptops: keyboard is riveted into the top case assembly — replace the whole assembly
- Business laptops (ThinkPad, Latitude): keyboard is often a standalone CRU with one ribbon cable
- **Liquid spill:** power off immediately, remove battery if possible, invert to drain, let dry 48+ hours. Sugary liquids almost always require replacement.

### Camera, microphone, and privacy

- Webcam and mic are usually on the same module above the display but different cables — check Device Manager before swapping hardware when only one is dead
- **Privacy shutter** (physical slider) on most modern business laptops
- **Hardware mic mute key** (F4 on ThinkPads) cuts the mic at firmware level, not OS

### Physical security components

| Component | Function |
|---|---|
| **Fingerprint reader** | Biometric auth via Windows Hello; capacitive sensor in palm rest or power button |
| **IR camera** | Windows Hello face unlock; separate IR sensor next to the webcam |
| **Smart card reader** | CAC/PIV authentication on government/enterprise laptops |
| **NFC scanner** | Tap-to-pair, badge authentication |
| **TPM 2.0 chip** | Hardware root of trust; stores BitLocker keys, Windows Hello credentials |
| **Kensington lock slot** | Physical anti-theft tether point |

### CompTIA exam traps

> **CompTIA exam trap:** Symptom is "Wi-Fi drops when the lid moves." The answer is **damaged antenna lead**, not the wireless card. The card works fine — the connection fails at the hinge.

> **CompTIA exam trap:** Swollen battery — the answer is always **replace and dispose as hazmat**, never "continue using until it fails." This is a safety question disguised as a hardware question.

> **CompTIA exam trap:** Biometric authentication is **something you are**. Smart card and NFC badge tap are **something you have**. CompTIA tests MFA factor categorization constantly.

> **CompTIA exam trap:** Soldered RAM cannot be upgraded. If a question says "user needs more RAM" on an ultrabook, the answer is often **replace the laptop** or **spec correctly next refresh**, not "upgrade the RAM."

## Helpdesk reality

- **"My laptop only lasts an hour now."** Run a battery report first. If full charge capacity is under 50% of design, order a replacement. Don't promise it'll be like new — explain that lithium batteries degrade and 2–4 years is typical.
- **"My Wi-Fi is slow in conference room B."** Could be antenna damage, the access point, or 2.4GHz interference. Does it happen on other laptops in the same room? Does this laptop work fine elsewhere? Isolate the variable.
- **"The camera doesn't work in Teams."** Check the privacy shutter first. Half these tickets are a closed shutter or a hardware mic-mute key the user hit by accident. Always check the physical switch before touching software.
- **"My fingerprint reader stopped recognizing me."** Re-enroll in Windows Hello. Clean the sensor with a microfiber cloth. If still dead, check Device Manager — if it's missing entirely, the ribbon cable likely came loose. Reseat before replacing.
- **Never promise data survives a repair.** Confirm the user has backups (OneDrive, network share) before you take the laptop apart. The user will remember whose hands the laptop was in when their files vanished.

## Related concepts

[[Mobile Device Types]] · [[Laptop Display Components]] · [[Mobile Device Connectors and Ports]] · [[Mobile Device Accessories]] · [[Wireless Networking Standards]] · [[Authentication Factors]] · [[ESD Safety and Repair Procedures]]

*Source: VIRGIL knowledge base — 2026-05-11*