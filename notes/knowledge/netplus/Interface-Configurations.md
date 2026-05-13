# Interface Configurations

## What it is

In **DayZ**, you find a working radio in Cherno but it won't transmit. You check the battery — full. You check the frequency — set. You check the antenna — wait, you never attached one. The radio shows "powered on" but it can't actually talk to anyone because layer 1 is broken. That's exactly what an interface problem is — the port shows green in software but the physical reality is wrong, and until you walk the cable like you'd walk a coastline checking for zombies, you're guessing.

A network interface is the port where copper or fiber meets the device. **Interface configuration** is the software state (speed, duplex, VLAN, admin status), and **physical interface issues** are everything between the NIC and the far-end transceiver: the cable, the connectors, the SFP, the patch panel, the wall jack, the keystone you crimped at 2am. CompTIA Objective 5.2 lives entirely in this space — the gap between what the switch reports and what's actually true at the physical layer.

## Why it matters

Most "the network is down" tickets are layer 1. Bent pin, kinked cable, unseated SFP, PoE budget exhausted, somebody plugged a Cat5 patch into a 10GBASE-T port and wonders why the link won't come up. If you can read interface counters and identify cable faults, you resolve 60% of network tickets without escalating. If you can't, you escalate everything and your senior tech learns to dread your name.

The exam tests this hard because in the real world, the techs who skip layer 1 waste hours theorizing about routing problems caused by a damaged RJ45 clip.

## Key facts

### Port status — what the switch tells you

| Status | Meaning | What to do |
|---|---|---|
| **Up / Connected** | Link established, traffic flowing | Nothing — it's working |
| **Down / Notconnect** | No link detected — physical issue | Check cable, far-end device, transceiver |
| **Administratively down** | Someone ran `shutdown` on the port | `no shutdown` if it should be up |
| **Error disabled (err-disabled)** | Switch killed the port due to a violation (port security, BPDU guard, loop) | Find the cause first, then `shutdown` / `no shutdown` to clear |
| **Suspended** | Port is part of an EtherChannel/LAG that failed negotiation | Check LACP config on both ends — usually a mismatch |

> **CompTIA exam trap:** *Administratively down* means a human disabled the port. *Error disabled* means the switch disabled it because of a policy violation. They look similar in output and the wrong one on a question costs you the point. Admin down = human. Err-disabled = automatic.

### Cable categories — copper twisted pair

| Category | Max Speed | Max Distance | Notes |
|---|---|---|---|
| **Cat 5** | 100 Mbps | 100m | Obsolete. If you find it in a wall, replace it. |
| **Cat 5e** | 1 Gbps | 100m | Minimum acceptable for new installs |
| **Cat 6** | 1 Gbps full / 10 Gbps to 55m | 100m / 55m | 10 Gbps only at reduced distance |
| **Cat 6a** | 10 Gbps | 100m | Thicker, shielded, fills conduit faster |
| **Cat 7** | 10 Gbps | 100m | Shielded, uses GG45 not RJ45 — niche |
| **Cat 8** | 25/40 Gbps | 30m | Data center top-of-rack only |

[[Twisted Pair Cable]] uses two flavors: **UTP** (unshielded) and **STP** (shielded twisted pair). STP wraps the pairs in foil or braid to resist electromagnetic interference. Use STP near elevator motors, fluorescent ballasts, industrial gear. Use UTP everywhere else — it's cheaper, easier to terminate, and you don't have to ground the shield (and if you don't ground shielded cable properly, it acts as an antenna and makes things *worse*).

> **CompTIA exam trap:** Cat 6 at 10 Gbps only works to **55 meters**, not 100. If the question gives you a 70m run requiring 10GBASE-T, the answer is Cat 6a or better. CompTIA will absolutely put 6 in the answers to see if you remember the distance derate.

### Fiber — single mode vs multimode

| Type | Core | Light Source | Distance | Color |
|---|---|---|---|---|
| **Single-mode (SMF)** | 8–10 μm | Laser | Up to 40+ km | Yellow jacket |
| **Multimode (MMF)** | 50 or 62.5 μm | LED or VCSEL | Up to ~400m at 10G | Orange (OM1/2), aqua (OM3/4), green (OM5) |

Single-mode is one path of light down a narrow core — long distance, expensive optics. Multimode is many paths bouncing down a wide core — short distance, cheap optics, but **modal dispersion** limits how far you can push it before pulses smear into each other.

*If you mix single-mode fiber with a multimode transceiver, the link won't work — and even if it does briefly, you've burned out the receiver because SMF lasers are too hot for MMF optics.*

### Transceivers — SFP, SFP+, QSFP

[[Transceivers]] are the hot-swappable optics that plug into a switch port. The transceiver must match: the **speed** of the port, the **fiber type** (SMF vs MMF), and the **standard** at the far end. A 10GBASE-SR (multimode short range) on one side and 10GBASE-LR (single-mode long range) on the other = no link, ever.

> **CompTIA exam trap:** *Incorrect standard* on the exam usually means a transceiver mismatch — same speed, wrong fiber type, wrong wavelength. Both ends must agree.

### Cable issues you'll actually see

- **Improper termination** — RJ45 crimped to the wrong pinout. T568A vs T568B doesn't matter as long as **both ends match**. Mix them on one cable and you've made a crossover by accident.
- **TX/RX transposed** — the transmit pair on one side lines up with transmit on the other instead of receive. Modern gear with **Auto-MDIX** fixes this automatically. Old gear or fiber without auto-negotiation will not — you swap the strands or use a crossover.
- **Crosstalk** — signal from one pair bleeding into another. **NEXT** (Near-End Crosstalk) and **FEXT** (Far-End Crosstalk) are the named flavors. Caused by untwisting too much wire at termination or cheap cable.
- **Attenuation** — signal loss over distance. Every cable type has a max run length for a reason.
- **Interference / EMI** — outside electromagnetic noise. Fluorescent lights, motors, microwaves, parallel power runs. Fix with STP, conduit, or rerouting.
- **Signal degradation** — generic catch-all: attenuation + crosstalk + interference + bad terminations all together.
- **Incorrect cable** — using a Cat5 patch on a 10G link, using a rollover cable for data, using crossover where straight-through is needed (rare on modern auto-MDIX gear but still appears on the exam).

### PoE — Power over Ethernet

[[Power over Ethernet]] delivers DC power over the same twisted pairs as data. Standards:

| Standard | Power at PSE | Common Use |
|---|---|---|
| 802.3af (PoE) | 15.4W | VoIP phones, basic APs |
| 802.3at (PoE+) | 30W | PTZ cameras, better APs |
| 802.3bt Type 3 (PoE++) | 60W | Wi-Fi 6 APs, video phones |
| 802.3bt Type 4 | 100W | Pan-tilt-zoom cams, small displays |

**Power budget exceeded** is when you've plugged in more PoE devices than the switch's total power supply can feed. A 24-port PoE+ switch advertised at 370W total means you cannot run 24 × 30W cameras — do the math. When the budget caps out, new devices refuse to power up and the port logs a budget error. *The fix is a bigger PSU, a second PoE switch, or non-PoE devices on the overflow ports.*

> **CompTIA exam trap:** A PoE device that won't power up but the port shows link is almost always a **power budget** issue, not a cable issue. Check the switch's PoE allocation table before you start swapping cables.

### Interface counters — what the switch is screaming about

Run `show interface` and read the counters. Increasing counters mean an active problem:

- **CRC errors** — [[Cyclic Redundancy Check]] failed. The frame arrived corrupted. Cause: bad cable, EMI, duplex mismatch, failing transceiver. *CRCs on one port only = that port's cable. CRCs everywhere = a broader EMI or grounding problem.*
- **Runts** — frames smaller than 64 bytes. Usually collisions on a half-duplex link, or a NIC truncating frames.
- **Giants** — frames larger than 1518 bytes (or 1522 with VLAN tag). Usually a misconfigured MTU or jumbo frame setting on one end but not the other.
- **Drops** — frames the switch threw away because the queue was full or the policy said no. Could be congestion, could be QoS, could be an ACL.
- **Mismatch (duplex)** — one end is full-duplex, the other half. Causes CRCs, runts, slow throughput. Hardcoding speed/duplex on one end and leaving the other on auto is the classic cause.

*Late collisions specifically are the smoking gun for a duplex mismatch — collisions should never happen on a properly negotiated full-duplex link.*

### Wireless signal — adjacent to interface issues

For [[Wireless]] interfaces, "signal strength" replaces cable issues. **RSSI** measured in negative dBm: -50 is excellent, -70 is workable, -80 is "why is my Zoom dropping." Interference on 2.4 GHz from microwaves and Bluetooth is the wireless equivalent of EMI on copper.

### CompTIA troubleshooting methodology applied

When the user calls and says "my port is down":

1. **Identify** — what changed? Was it working yesterday? New equipment?
2. **Theory** — start at layer 1. Cable, link light, port status.
3. **Test** — `show interface`, cable tester, swap the patch cable.
4. **Plan** — replace cable, reseat transceiver, clear err-disable.
5. **Implement** — make the change.
6. **Verify** — link light green, counters not climbing, user confirms.
7. **Document** — port, cable run, what you found, what you replaced.

## Helpdesk reality

- User says: *"The internet doesn't work."* What they mean: one application is slow, or one device has no link. Always ask what specifically failed.
- First check: link light on the NIC and on the switch port. No link light = it's a layer 1 problem, period. Don't run `ipconfig` until the cable is confirmed.
- Second check: try a known-good patch cable. Cable testers are great but a spare cable is faster.
- Never promise: *"I'll have it fixed before your meeting."* Cable runs through walls take hours. Patch cables take 30 seconds. You don't know which one it is yet.
- Escalation point: if the port is err-disabled and you don't know why, or if multiple ports on the same switch are CRCing, that's a network team ticket — there's a configuration or hardware issue beyond a single cable.

## Related concepts

[[Cable Types]] · [[Twisted Pair Cable]] · [[Fiber Cable]] · [[Transceivers]] · [[Power over Ethernet]] · [[Duplex and Speed]] · [[OSI Model]] · [[Cyclic Redundancy Check]] · [[Auto-MDIX]] · [[Network Troubleshooting Methodology]] · [[Wireless]] · [[Cable Testers]]

*Source: VIRGIL knowledge base — 2026-05-11*