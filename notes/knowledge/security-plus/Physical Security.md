# Physical Security

## What it is

In League of Legends, your Nexus can have full health, your team can be ahead 30 kills, but if the enemy walks past your towers and inhibitors uncontested, the game ends. The Nexus doesn't care about your KDA — it cares whether minions can reach it. That's exactly what physical security does — it keeps the wrong bodies out of the rooms where the actual machines live, because every logical control collapses the moment someone with a screwdriver reaches the rack.

**Physical security** is the layered set of tangible controls — barriers, sensors, locks, lighting, surveillance, and personnel — that prevent unauthorized physical access to facilities, equipment, and personnel.

## Why it matters

If an attacker reaches the hardware, encryption keys, BIOS, USB ports, and console cables become trivially exploitable; full-disk encryption does not save you from someone unscrewing the drive at 2 a.m. Objective 1.2 explicitly enumerates the physical control catalog (fencing, bollards, badges, lighting, sensors, etc.), and CompTIA's favorite trap is mislabeling a control's **category** (physical/technical/managerial) versus its **type** (preventive/detective/deterrent/compensating). A bollard is *physical* and *preventive*; a CCTV camera is *physical* and *detective*; a "Beware of Dog" sign is *deterrent*. Memorize that the same control can wear two hats but never three at once on this exam.

## Key facts

### Perimeter controls

| Control | Purpose | Category / Type |
|---|---|---|
| [[Fencing]] | Defines boundary, slows intruders | Physical / Preventive + Deterrent |
| [[Bollards]] | Stops vehicle ramming attacks | Physical / Preventive |
| [[Lighting]] | Eliminates shadows, aids cameras | Physical / Deterrent + Detective |
| [[Gates]] | Controlled entry/exit point | Physical / Preventive |
| [[Barricades]] | Channel foot/vehicle traffic | Physical / Preventive |

### Access control points

- **[[Access control vestibule]]** (formerly "mantrap") — two interlocking doors; only one opens at a time. Defeats **[[tailgating]]** and **[[piggybacking]]**.
- **[[Badges]]** — proximity cards, smart cards ([[PIV]]/[[CAC]]), or magstripe; tied to [[RFID]] or [[NFC]] readers.
- **[[Locks]]** — categories: **conventional** (key), **deadbolt**, **electronic** (PIN pad), **biometric**, **cipher**, and **smart locks** (Bluetooth/network-aware).
- **[[Security guards]]** — the only control that can exercise judgment. Expensive, fallible, unionizable.
- **[[Reception/visitor logs]]** — accountability trail; pair with **visitor badges** that visibly differ from employee badges.

### Detection and surveillance

- **[[Video surveillance]] / CCTV** — detective control. Modern systems include **motion detection**, **object recognition**, and **license plate readers**.
- **[[Sensors]]**:
  - **Infrared** — detects body heat / movement
  - **Pressure** — detects weight on floor mats or fence wires
  - **Microwave** — detects motion via reflected RF
  - **Ultrasonic** — detects motion via sound wave displacement
- **[[Alarms]]** — circuit (door/window contact), motion, duress (panic button).
- **[[Infrared cameras]]** — see in darkness; useful where lighting is impractical.

### Deterrents

**[[Signage]]**, visible cameras, lighting, and guard presence. Cheap, sometimes effective, never sufficient alone.

### Specialized physical concerns

- **[[Faraday cage]]** — blocks electromagnetic emissions; defeats [[RF eavesdropping]] and protects against [[EMP]]. Also blocks legitimate signals (cell, Wi-Fi) — that's the point.
- **[[Protected cable distribution]]** — shielded conduits for sensitive cabling, prevents tapping.
- **[[Air gap]]** — physical network isolation; the ultimate segmentation.
- **[[Secure areas]]** — vaults, secure rooms, **[[SCIF]]**s (Sensitive Compartmented Information Facilities) for classified work.

### Common physical attacks to know

| Attack | Description | Defense |
|---|---|---|
| [[Tailgating]] | Following authorized person through door | Vestibule, guards, training |
| [[Piggybacking]] | Same as tailgating but *with consent* of the authorized person | Awareness training, policy |
| [[Lock picking]] | Manipulating pin tumblers | High-security locks, electronic locks |
| [[Lock bumping]] | Specially cut "bump key" defeats pin tumbler locks | Bump-resistant locks |
| [[Dumpster diving]] | Recovering discarded sensitive material | [[Shredding]], locked dumpsters, pickup services |
| [[Shoulder surfing]] | Observing credentials being entered | Privacy screens, positioning awareness |
| [[RFID cloning]] | Skimming and duplicating prox cards | Shielded sleeves, smart cards with crypto |
| [[USB drop attack]] | Malicious USB left for curious finder | Disabled USB ports, endpoint controls, training |

### Control category cheat-sheet (Sec+ exam pattern)

CompTIA wants you to classify any given control along **two axes**:

- **Category**: Managerial, Operational, Technical, **Physical**
- **Type**: Preventive, Deterrent, Detective, Corrective, Compensating, Directive

Example: a security guard checking badges is **Physical / Preventive**. A guard reviewing CCTV after the fact is **Physical / Detective**. Same guard, different function, different classification. The exam will exploit this.

## Related concepts

[[Access control vestibule]] · [[Tailgating]] · [[Faraday cage]] · [[Defense in depth]] · [[Security control categories]] · [[Bollards]] · [[SCIF]] · [[Air gap]] · [[Badges]] · [[Surveillance]]

---
*Source: VIRGIL knowledge base — 2026-05-08*