# Interface Issues

## What it is

In **League of Legends**, you queue up for ranked, lock in Jinx, and the game loads — but your champion is stuck at fountain. The client says you're connected. The minimap shows your team pushing mid. But your inputs aren't registering. Your packets are going out; nothing's coming back. The interface between you and the game is broken even though every status indicator says "fine."

That's exactly what a broken interface does on a switch — the port shows a link light, the cable looks plugged in, but traffic isn't passing, or it's passing badly. The interface is the boundary between a host and the network. When that boundary degrades, everything downstream of it suffers, and the failure is rarely obvious from the green LED alone.

Technically: an **interface issue** is any condition where a physical port on a switch, router, or NIC fails to pass frames cleanly. This includes Layer 1 problems (cable, transceiver, signal), Layer 2 problems (duplex mismatch, speed mismatch, error counters), and administrative problems (port shut down by an admin or by a protection mechanism). Objective N10-009 5.2 makes you diagnose these from symptoms and counter output.

## Why it matters

Interfaces are where 80% of network tickets start and end. A user can't reach the file server — first question: is the link up on their port? A wireless AP isn't powering on — first question: is the PoE budget exhausted on that switch? A fiber uplink between buildings throws errors all afternoon — first question: dirty connector or bent cable?

CompTIA tests this hard because it's the daily work. You will see questions that hand you a `show interface` output with CRC errors, runts, giants, and ask you to pick the cause. You will see questions where two switches won't pass traffic and the answer is TX/RX transposed on a fiber pair. Memorize the counters. Memorize the port states. The exam rewards pattern recognition, not theory.

## Key facts

### Port status — what the interface says about itself

When you run `show interface` on a Cisco or equivalent on any managed switch, the port reports two states: the **administrative state** and the **operational state** (also called line protocol).

| State | Meaning | Cause |
|---|---|---|
| **Up / Up** | Working | Normal |
| **Down / Down** | Link not detected | Cable unplugged, far-end down, dead NIC |
| **Administratively down** | Admin issued `shutdown` | Someone disabled it on purpose |
| **Up / Down** | Physical link, no L2 | Speed/duplex mismatch, encapsulation mismatch |
| **Error disabled (err-disabled)** | Switch protection feature shut it down | Port security violation, BPDU guard, flapping |
| **Suspended** | EtherChannel member rejected | LACP/PAgP mismatch with peer |

> **CompTIA exam trap:** *Administratively down* and *err-disabled* look similar but mean different things. Administratively down = a human typed `shutdown`. Err-disabled = the switch shut it down to protect itself (BPDU guard caught a rogue switch, port security saw too many MACs, storm control tripped). Fix: find the cause, then `shutdown` / `no shutdown` to bring it back. Just bouncing the port without fixing the cause means it goes err-disabled again in 30 seconds.

### Interface counters — what the port snitches on

Every managed interface keeps counters. Increasing counters mean active problems. The ones [[CompTIA]] tests:

- **CRC errors** — [[Cyclic Redundancy Check]] failed. The frame arrived corrupted. Cause: bad cable, EMI, failing transceiver, dirty fiber connector, duplex mismatch.
- **Runts** — frames smaller than 64 bytes. Cause: collisions (half-duplex), bad NIC, cable too long.
- **Giants** — frames larger than 1518 bytes (or larger than the configured MTU). Cause: jumbo frame mismatch, faulty NIC.
- **Drops** — frames discarded because the buffer was full or a policy dropped them.
- **Input/output errors** — generic catch-all. Drill into the specific counter.

*If CRC and runts are both climbing, your first suspect is duplex mismatch. If only CRC is climbing, suspect the physical layer — cable, connector, transceiver, interference.*

### Cable issues — the Layer 1 graveyard

| Problem | Symptom | Fix |
|---|---|---|
| **Incorrect cable** | No link, or link at wrong speed | Use the right category for the speed (see below) |
| **Improper termination** | Intermittent link, high error rate | Re-terminate the connector; verify with cable tester |
| **Signal degradation / [[Attenuation]]** | Works close, fails at distance | Within distance spec? Copper = 100m, MMF = varies, SMF = km+ |
| **Crosstalk** | CRC errors, especially on unshielded runs near power | Use [[STP]] shielded twisted pair, or reroute away from EMI |
| **[[Interference]] (EMI/RFI)** | Errors near motors, fluorescents, microwaves | Shielding, fiber, or relocation |
| **TX/RX transposed** | No link on fiber between two switches | Swap the TX and RX fibers at one end, or use a crossover patch |

**Category ratings** — memorize these for the exam:

| Category | Speed | Frequency | Notes |
|---|---|---|---|
| **Cat 5** | 100 Mbps | 100 MHz | Legacy, don't deploy |
| **Cat 5e** | 1 Gbps | 100 MHz | Minimum modern install |
| **Cat 6** | 1 Gbps (10 Gbps to 55m) | 250 MHz | Standard office today |
| **Cat 6a** | 10 Gbps to 100m | 500 MHz | Augmented, thicker, often shielded |
| **Cat 7** | 10 Gbps | 600 MHz | Always shielded (S/FTP), GG45/TERA connector — not common in US |
| **Cat 8** | 25/40 Gbps to 30m | 2000 MHz | Data center top-of-rack only |

> **CompTIA exam trap:** Plugging a Cat 5 cable into a 10G port gives you a link — at 1 Gbps or worse, with CRC errors at load. The port negotiates down. The user says "it's working" and your monitoring says "it's bleeding." *Incorrect cable category is silent failure. The link light lies.*

### Fiber — single mode vs multimode

| Type | Color (typical jacket) | Source | Distance | Use case |
|---|---|---|---|---|
| **Multimode (MMF)** | Orange (OM1/2), Aqua (OM3/4), Pink/Magenta (OM5) | LED or VCSEL | 100m–550m typical | Within a building, data center |
| **Single mode (SMF)** | Yellow | Laser | 10–80+ km | Between buildings, ISP backhaul |

You cannot mix single mode and multimode. Same connector (LC, SC), different core diameter, different optics. Plug an SMF cable into MMF transceivers and you get nothing, or you get a fragile link with massive insertion loss.

### Transceivers — the small parts that fail loud

[[Transceivers]] (SFP, SFP+, QSFP, QSFP28) plug into switch cages and convert electrical signals to optical. They fail in interesting ways:

- **Wrong transceiver type** — 10G SFP+ in a 1G SFP cage might not seat or might not negotiate
- **Wavelength mismatch** — both ends must use the same wavelength (850nm MMF, 1310nm or 1550nm SMF)
- **Vendor lock** — Cisco transceivers in Cisco switches; third-party may need `service unsupported-transceiver` to run
- **Dirty optics** — a single fingerprint on the fiber tip causes CRC errors. Always cap unused fibers. Clean before mating.

*The cleanest desk in the data center belongs to the fiber tech. Fingerprints are the enemy.*

### PoE — when power is the problem

[[Power over Ethernet]] delivers electricity over the same twisted pair that carries data. Standards:

| Standard | Power at PSE | Power at PD | Use case |
|---|---|---|---|
| **PoE (802.3af)** | 15.4W | 12.95W | VoIP phones, basic APs |
| **PoE+ (802.3at)** | 30W | 25.5W | Modern APs, PTZ cameras |
| **PoE++ Type 3 (802.3bt)** | 60W | 51W | Heavy APs, video conf |
| **PoE++ Type 4 (802.3bt)** | 100W | 71.3W | Small displays, LED arrays |

Every PoE switch has a **power budget** — total watts available across all ports. A 24-port switch advertising "PoE+" might have a 370W budget, not 24 × 30W = 720W.

> **CompTIA exam trap:** **Power budget exceeded.** You install 24 new Wi-Fi 6 APs that draw 25W each (600W total) on a switch with a 370W PoE budget. The first 14 power up. The rest stay dark, or boot and brown out under load. The port shows "power denied" in the counters. Fix: bigger PSU on the switch, a second PoE switch, or PoE injectors for the overflow.

### Speed and duplex mismatch

Two devices on a link must agree on **speed** (10/100/1000/10000) and **duplex** (half/full). Auto-negotiation handles this 99% of the time. The 1% that bites:

- One end hardcoded to 1000/full, other end on auto → other end falls back to half-duplex → mismatch
- **Symptom:** link is up, traffic passes at low load, performance collapses under load, CRC and runt counters climb on the half-duplex side, late collisions on the full-duplex side

*Never hardcode one end without hardcoding both. Either both auto, or both manual to the same values.*

### Incorrect standard

Two switches connected with a fiber pair using **LR optics on one side and SR on the other** — different wavelengths, won't link. Or a media converter set for 100Base-FX talking to a 1000Base-SX port. The connectors fit. The standards don't. Always match optics end-to-end.

## Helpdesk reality

- User says: *"The internet is down."* What they mean: one website didn't load, or their laptop's NIC is disabled. First check: link light on the wall jack and on the laptop. No light = Layer 1.
- User says: *"My phone won't turn on."* If it's a VoIP phone, check PoE on the switch port before you blame the phone. `show power inline` is your friend.
- User says: *"It worked yesterday."* Something changed. Was the cable moved? Did facilities run new fluorescent lights in the ceiling above the run? Is there a new microwave in the breakroom 6 feet from the AP?
- Never promise *"it'll be fixed in five minutes"* on an interface issue. The fix might be a cable swap (2 minutes) or a new transceiver shipped overnight (24 hours).
- Escalation point: if you've verified link, swapped the cable, swapped the port, and the counters still climb, it's a network team ticket. Hand off with the counter output and a timestamp. *Don't make the senior engineer re-run the commands you already ran.*

## Related concepts

[[Cable Types]] · [[Power over Ethernet]] · [[Transceivers]] · [[OSI Model]] · [[Duplex and Speed]] · [[Cable Testing Tools]] · [[STP Shielded Twisted Pair]] · [[Single Mode vs Multimode Fiber]] · [[CompTIA Troubleshooting Methodology]] · [[Port Security]] · [[Spanning Tree Protocol]]

*Source: VIRGIL knowledge base — 2026-05-11*