# Physical Attacks

## What it is

In World of Warcraft, you can have the best gear, the perfect raid build, max enchants on every slot — and none of it matters if someone walks up to your computer in real life and pulls the power cable mid-Mythic boss pull. That's exactly what physical attacks do — they bypass every digital control by going after the hardware, the people, or the building itself.

Physical attacks are threats that exploit physical access to systems, facilities, or media to compromise confidentiality, integrity, or availability without needing to defeat logical security controls.

## Why it matters

Every encryption algorithm, firewall rule, and IAM policy assumes the attacker doesn't have the device in their hands. Once they do, the threat model collapses — drives get cloned, RFID badges get duplicated, servers get unplugged. SY0-701 Objective 2.4 explicitly lists **brute force**, **RFID cloning**, and **environmental** as the three physical attack types you must recognize. The exam trap: CompTIA loves to disguise a physical attack as a network attack. If the question describes someone *physically present* — in a parking lot, near a door, holding a device — the answer is in this category, not in malware or social engineering.

## Key facts

### The three SY0-701 physical attack types

| Attack | What it targets | Example |
|---|---|---|
| **Brute force (physical)** | Locks, doors, hardware enclosures | Kicking in a server room door, prying open a kiosk, smashing a laptop case to extract the drive |
| **[[RFID cloning]]** | Proximity badges, contactless cards | Skimming a 125 kHz prox badge with a Proxmark or Flipper Zero, replaying it at the door reader |
| **[[Environmental attacks]]** | HVAC, power, fire suppression | Cutting power to a data center, tampering with cooling, triggering fire suppression to force evacuation |

### Brute force — physical variant

- Not to be confused with **[[password brute force]]** (a logical attack).
- Targets **[[mantraps]]**, server cages, **[[cable locks]]**, **[[Kensington locks]]**, tamper-evident enclosures.
- Defenses: **[[reinforced doors]]**, **[[security guards]]**, **[[surveillance]]**, **[[bollards]]**, **[[tamper-evident seals]]**, **[[locking cabinets]]**.

### RFID cloning mechanics

- **Low-frequency (125 kHz)** badges (HID Prox, EM4100) — trivially cloneable, no encryption, no challenge-response.
- **High-frequency (13.56 MHz)** badges (MIFARE Classic) — older versions cracked; newer **[[MIFARE DESFire]]** uses AES.
- Tools: **Proxmark3**, **Flipper Zero**, **NFC-enabled phones**.
- Attack flow: attacker stands within ~10 cm of a victim's badge (elevator, coffee shop), reads the UID, writes it to a blank card, walks through the door.
- Defenses: **[[smart cards]]** with mutual authentication, **[[badge sleeves]]** (RFID-blocking), **[[multi-factor]]** at sensitive doors (badge + PIN + biometric), **[[anti-passback]]** to prevent the same credential entering twice without leaving.

### Environmental attacks

- **Power**: cutting mains, overloading circuits, sabotaging **[[UPS]]** units, attacking **[[generator]]** fuel supply.
- **HVAC**: sabotaging cooling causes **[[thermal shutdown]]** of servers — silent, deniable, devastating.
- **Fire suppression**: triggering **[[FM-200]]** or pre-action sprinklers to force evacuation and damage equipment.
- **Water**: pipe sabotage above a server room.
- Defenses: **[[redundant power]]** (A/B feeds), **[[N+1 cooling]]**, **[[hot/cold aisle containment]]**, **[[environmental monitoring]]** (temperature, humidity, water sensors), physical access control on utility rooms — which administrators routinely forget about.

### Adjacent physical threats CompTIA may bundle in

- **[[Tailgating]]** / **[[piggybacking]]** — following someone through a secured door.
- **[[Shoulder surfing]]** — observing credentials physically.
- **[[Dumpster diving]]** — recovering discarded media or documents.
- **[[Skimming]]** — physical card skimmers on ATMs and POS terminals.
- **[[Evil maid attack]]** — brief unattended access to a powered-off device to install bootkit or keylogger.

### The exam trap

CompTIA tests whether you can distinguish:
- **Brute force (physical)** vs. **brute force (password)** — read the scenario for "door," "lock," "enclosure."
- **RFID cloning** vs. **[[card skimming]]** — cloning copies a credential; skimming captures track/chip data on payment cards.
- **Environmental attack** vs. **environmental control failure** — was it deliberate or accidental? The verb matters.

## Related concepts

[[RFID cloning]] · [[Tailgating]] · [[Evil maid attack]] · [[Mantraps]] · [[Bollards]] · [[Surveillance]] · [[Tamper-evident seals]] · [[UPS]] · [[Generator]] · [[Skimming]] · [[Smart cards]] · [[Multi-factor authentication]]

---
*Source: VIRGIL knowledge base — 2026-05-08*