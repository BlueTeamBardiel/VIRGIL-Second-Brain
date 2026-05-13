# Cable Issues

## What it is

In **Forza Horizon**, you tune a car for a road race and forget to check tire compound. The drivetrain is perfect, the engine is dialed, the aero is set — but you've got rally tires on tarmac. The car still moves. It just oversteers into every corner and your lap times look like garbage you can't explain. The car isn't broken. The connection between the car and the road is wrong.

That's exactly what cable issues do — every component on the network is working, but the physical medium connecting them is degraded, miscategorized, mis-terminated, or just plain wrong for the job.

**Technical definition (N10-009 Objective 5.2):** Cable issues are Layer 1 faults — physical-medium problems that cause link failure, intermittent connectivity, throughput loss, or interface errors. They manifest at the switchport as counter increments, port-status flags, or hard link-down events, and they are the first thing you rule out before touching anything above Layer 1.

## Why it matters

Roughly half of all network tickets that escalate past tier-1 turn out to be Layer 1. A bent pin, a kinked Cat6 run, a transceiver seated 90% of the way, a 120-meter cable run that should have been 90 — these are the silent killers. Every senior network engineer has a war story about chasing a routing bug for six hours that turned out to be a cracked RJ45 boot.

CompTIA tests cable issues hard on N10-009 because the exam wants techs who check the wire before they blame the config. *If you can't troubleshoot Layer 1, you cannot troubleshoot.*

## Key facts

### Cable categories — speed, distance, shielding

| Category | Speed | Bandwidth | Notes |
|---|---|---|---|
| **Cat 5e** | 1 Gbps | 100 MHz | Bare minimum. Found everywhere. |
| **Cat 6** | 1 Gbps @ 100m, 10 Gbps @ 55m | 250 MHz | The current normal. |
| **Cat 6a** | 10 Gbps @ 100m | 500 MHz | Often shielded. Thicker, stiffer. |
| **Cat 7** | 10 Gbps | 600 MHz | Shielded, GG45/TERA connectors. Rare in US. |
| **Cat 8** | 25/40 Gbps @ 30m | 2000 MHz | Data-center top-of-rack only. |

> **CompTIA exam trap:** Cat 6 does 10 Gbps **only up to 55 meters**. After that, it drops to 1 Gbps. If a question says "10 Gbps across a 90-meter run," the answer is Cat 6a, not Cat 6.

**STP vs UTP** — Shielded Twisted Pair has a foil or braid shield around the pairs to reject [[EMI]]. Use STP near fluorescent ballasts, motors, elevators, MRI machines. UTP (Unshielded) is cheaper and fine for offices. *Shielded cable that isn't grounded properly is worse than unshielded — it becomes an antenna.*

### Copper distance limit

**100 meters total for any Cat 5e/6/6a copper run.** That's 90m horizontal cable + 5m patch on each end. Go past 100m and you get [[attenuation]] — the signal weakens until the receiver can't distinguish it from noise. Symptoms: link flapping, slow speeds, [[CRC]] errors climbing.

### Fiber — single-mode vs multimode

| Type | Color | Distance | Light source | Use case |
|---|---|---|---|---|
| **Multimode (MMF)** | Orange (OM1/2), Aqua (OM3/4), Lime (OM5) | Up to 400m at 10G | LED or VCSEL | Inside the building, between IDFs |
| **Single-mode (SMF)** | Yellow | Up to 40+ km | Laser | Between buildings, WAN, long-haul |

> **CompTIA exam trap:** Single-mode is yellow, multimode is some shade of orange/aqua. If they ask for cross-campus or carrier handoff, it's single-mode. If they ask for in-building 10G, it's multimode.

### Transceivers and mismatches

**SFP / SFP+ / QSFP** modules plug into switches to convert electrical to optical (or copper to fiber). Two ways they go wrong:

- **Incorrect transceiver / mismatch** — SFP on one end, SFP+ on the other, or an SR (short-range) module trying to talk to an LR (long-range) module. *No link. Or link at the wrong speed.*
- **TX/RX transposed** — fiber has two strands, one for transmit, one for receive. If a tech makes a custom patch and crosses them, the switch transmits into its own receiver and hears nothing. Fix: swap the strands at one end. LC connectors have a clip you can pop and reverse.

### Port status — what the switch tells you

| Status | Meaning |
|---|---|
| **Up / Connected** | Link established, traffic flowing |
| **Down / Notconnect** | No link detected — check the cable, the far end, the transceiver |
| **Administratively down** | A human typed `shutdown` on the port. Not a fault — a policy state. |
| **Error disabled (err-disabled)** | Switch shut the port itself because of port-security violation, BPDU guard, flapping, or duplex mismatch |
| **Suspended** | EtherChannel/LACP member port that can't negotiate into the bundle |

> **CompTIA exam trap:** **Administratively down ≠ err-disabled.** Admin down is a person. Err-disabled is the switch protecting itself. The fix for admin down is `no shutdown`. The fix for err-disabled is to find what triggered it, then `shutdown` / `no shutdown` to clear.

### Interface counters — the smoking gun

Run `show interface` on a Cisco switch and you see counters. When they climb, you have a Layer 1 problem:

- **CRC errors** — Cyclic Redundancy Check failed. The frame's checksum doesn't match. Causes: bad cable, EMI, duplex mismatch, failing transceiver. *CRC climbing in real time = replace the cable first, then the SFP.*
- **Runts** — frames smaller than 64 bytes. Usually collisions on a half-duplex link or a damaged NIC.
- **Giants** — frames larger than 1518 bytes (or the configured MTU). Usually MTU mismatch or jumbo frames not configured end-to-end.
- **Input errors / drops** — frames the interface couldn't process. Could be buffer exhaustion, but often physical.
- **Increasing counters** — the key word is *increasing*. A counter with 12 CRCs from a year ago is noise. A counter adding CRCs every time you re-check is a live fault.

### Cable faults — what actually breaks

- **Improper termination** — RJ45 crimped with pairs untwisted too far back, or the wrong T568 standard (A vs B). One end A, other end B = crossover cable, which modern auto-MDIX switches handle, but older gear won't.
- **Incorrect standard** — straight-through used where crossover is needed, or vice versa. Rare now but tested.
- **Crosstalk** — signal from one pair bleeds into adjacent pair. NEXT (Near-End) and FEXT (Far-End). Caused by untwisting pairs too far at the jack, sharp bends, or stapling cable too tight.
- **Interference / EMI** — running Cat6 parallel to a fluorescent ballast or power conduit. Symptoms: intermittent drops, CRCs.
- **Signal degradation / attenuation** — distance, age, water damage, or cable kinked so hard the conductors are deformed.
- **Drops** — link drops, momentary loss of connection. Often a marginal cable that works until a vibration or temperature change.

### Power over Ethernet (PoE)

PoE delivers DC power over the same cable as data. Used for APs, IP phones, cameras, door readers.

| Standard | Power at PSE | Power at PD |
|---|---|---|
| **802.3af (PoE)** | 15.4W | 12.95W |
| **802.3at (PoE+)** | 30W | 25.5W |
| **802.3bt Type 3 (PoE++)** | 60W | 51W |
| **802.3bt Type 4** | 100W | 71W |

**Power budget exceeded** — every PoE switch has a total wattage budget (say, 370W). Plug in 30 APs at 30W each and you've asked for 900W. The switch will refuse to power some ports. Symptoms: APs randomly fail to boot, last-plugged-in device gets no power.

> **CompTIA exam trap:** A PoE device that won't boot when plugged into a specific switch but works on a different one — check the power budget, not the device.

### CompTIA exam traps roundup

> **Trap:** Duplex mismatch causes CRC errors and runts, but link stays UP. Auto-negotiate on one side, hard-coded full-duplex on the other → one side runs half-duplex, sees collisions, generates errors. The link doesn't drop. Counters climb. This is the classic "link is up but the connection is terrible" symptom.

> **Trap:** If a fiber link is dark, swap TX and RX at one end before replacing the transceiver. TX/RX transposition is free to fix; transceivers cost money and a maintenance window.

> **Trap:** Cat 7 is not a TIA/EIA-recognized standard in North America. If CompTIA gives you Cat 7 as an option for a US deployment scenario, lean toward Cat 6a unless the question specifically calls for shielded high-frequency.

## Helpdesk reality

- User says: *"The internet is slow."* You check `show interface` on their switchport and CRC errors are at 4 million and climbing. The internet isn't slow. Their patch cable is crushed under a desk caster.
- User says: *"My computer won't connect."* First check: is the link light on at the NIC and at the switch? No light = Layer 1. Light = move up the stack. *90% of "won't connect" tickets are resolved by reseating the patch cable.*
- User says: *"It worked yesterday."* Ask what changed. Did facilities move furniture? Did someone vacuum? Did the cleaning crew unplug something? Cables don't degrade overnight — humans degrade them.
- Never promise: *"I'll have you back online in five minutes."* If it's a cable run inside a wall, that's a cable-puller's job and a maintenance window.
- Escalation point: if you've replaced the patch cable on both ends, confirmed the link light, and the port still shows err-disabled or climbing CRCs on a known-good cable, escalate to the network team with the `show interface` output. That output is your evidence.

## Related concepts

[[OSI Model]] · [[Ethernet Standards]] · [[Fiber Optics]] · [[Transceivers]] · [[PoE]] · [[Duplex and Speed Mismatch]] · [[Cable Testers]] · [[Structured Cabling]] · [[Attenuation and EMI]] · [[Port Security]] · [[Spanning Tree Protocol]] · [[Network Troubleshooting Methodology]]

*Source: VIRGIL knowledge base — 2026-05-11*