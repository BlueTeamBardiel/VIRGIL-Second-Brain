# Peripheral Cables

## What it is

Open the drawer next to your desk. Count the cables. USB-A to USB-B that came with a printer in 2014. A Lightning cable with the rubber peeling off. Two USB-Cs, one of which only charges and won't carry data because it's a $3 dollar-store cable. A Thunderbolt cable you paid $40 for and treat like jewelry. An eSATA cable you forgot you owned.

That drawer is the topic.

In plain English: peripheral cables are the wires that connect *things* to your computer — keyboards, mice, printers, external drives, phones, cameras, docks. Not video (different objective), not network (different objective), not internal hard drive cables (different objective). The stuff that plugs into the *outside* of the box.

Technically: peripheral cables carry data and often power between a host controller (almost always USB or Thunderbolt these days) and an external device. The connector defines the physical interface; the protocol running over it defines the speed and feature set. **Connector ≠ protocol.** A USB-C cable might run USB 2.0 at 480 Mbps or Thunderbolt 4 at 40 Gbps. The plug looks identical. The cable is not.

The motherboard is the nervous system. Peripheral cables are the limbs reaching out to grab the world — the keyboard you type on, the drive you back up to, the phone you charge while it syncs. Some limbs are fast and modern. Some are vestigial and still attached because the lab printer from 2009 won't die.

## Why it matters

Objective 220-1201 3.2 asks you to identify peripheral cables and connectors on sight and know what they're used for. CompTIA loves this objective because the field tech version of this skill is non-negotiable. A user calls: "the thing won't connect to the thing." You walk to the desk. You need to look at both ends of the cable, look at both ports, and know within three seconds whether the cable is wrong, the port is dead, or the cable is right but the wrong *generation* of right.

The career stakes: every helpdesk tech gets handed a bag of mystery cables on day one. Knowing USB-A from USB-B from USB-C from Mini-USB from Micro-USB from Lightning from Thunderbolt is the baseline. Knowing that a USB-C cable can be charge-only, USB 2.0, USB 3.2, or Thunderbolt 4 — and that they're visually identical — is what separates a tech who solves the problem from one who swaps three cables and gives up.

## In your build, in the enterprise

**Beat 1 — technical depth.** USB is the dominant peripheral standard. The generations matter:

| Standard | Max speed | Typical connector |
|---|---|---|
| USB 2.0 | 480 Mbps | USB-A, USB-B, Mini-B, Micro-B, USB-C |
| USB 3.0 / 3.1 Gen 1 / 3.2 Gen 1 | 5 Gbps | USB-A (blue tongue), USB-B SuperSpeed, USB-C |
| USB 3.1 Gen 2 / 3.2 Gen 2 | 10 Gbps | USB-A, USB-C |
| USB 3.2 Gen 2x2 | 20 Gbps | USB-C only |
| USB4 | 20 or 40 Gbps | USB-C only |
| Thunderbolt 3 | 40 Gbps | USB-C |
| Thunderbolt 4 | 40 Gbps | USB-C |
| Thunderbolt 5 | 80 Gbps (120 burst) | USB-C |

USB 3.x ports are conventionally **blue** on the inside; USB 2.0 is black; USB-C is reversible and color-tells nothing. Thunderbolt ports carry a small lightning-bolt icon next to the USB-C jack. Lightning is Apple's pre-USB-C iPhone connector, deprecated as of iPhone 15 (2023) per EU mandate. eSATA is external SATA — a SATA bus extended outside the case for external drives, mostly dead, killed by USB 3.0. Serial (DB9 / RS-232) is a 9-pin legacy port still used for console access on switches, routers, UPSes, and industrial equipment. RJ11 is the small 4- or 6-pin plug for telephone lines and fax — looks like a skinny Ethernet jack, isn't.

**Beat 2 — Feynman example via gaming/personal build.**

**The new build:** You finish the gaming PC. Front panel: two USB-A 3.2 Gen 1, one USB-C 3.2 Gen 2. Back panel: a wall of USB-A in three colors, two USB-C, one with a lightning bolt. *Color and icon tell you the speed before you read the manual.*

**The keyboard and mouse:** USB-A 2.0. They send a few hundred bytes a second. Plugging a keyboard into the front USB-C port works but wastes the port. *Slow devices go on slow ports. Save the fast ports for fast devices.*

**The external NVMe enclosure:** USB-C 10 Gbps. You plug it into the front panel USB-C and it copies a 50 GB game in 90 seconds. You plug the same enclosure into a USB-A 2.0 port using a USB-C-to-A adapter and the same copy takes 18 minutes. *The cable and the port both have to support the speed. The slowest link sets the speed.*

**The phone charger that won't transfer files:** Your buddy hands you a USB-C cable to move a video off your phone. Nothing happens. The cable is charge-only — two power wires, no data wires. It cost $2 at a gas station. *USB-C cables are not interchangeable. Buy from a brand that lists the spec on the packaging.*

**Beat 3 — bridge from gaming to enterprise.** Same fundamental question — *what speed does this cable actually carry?* — different answers in different contexts:

- **Gaming PC:** USB-C 10 Gbps for the external NVMe, USB-A 2.0 for the keyboard. Mismatched cables waste money or bottleneck the drive.
- **Developer rig with a Thunderbolt dock:** the dock daisy-chains a 4K monitor, a 10 GbE adapter, two external SSDs, and charges the laptop, all over one Thunderbolt 4 cable. A USB-C cable that *looks* identical but is only USB 3.2 will fail to drive the monitor and fail to deliver 100W charging. The user calls the helpdesk: "my dock is broken." The dock is fine. The cable is wrong.
- **Security analyst workstation:** YubiKey on USB-A, smart card reader on USB-A, encrypted external drive on USB-C 10 Gbps. The analyst needs more USB-A ports than a 2026 laptop ships with — a powered USB hub becomes part of the standard issue.
- **Enterprise server room:** the cables on the back of the rack are mostly *not* USB. They're SAS, fiber, and Ethernet. But the front of every server has a USB-A port for a keyboard and a serial console (DB9 or RJ45-to-DB9 rollover) for out-of-band management. Every senior network engineer has a USB-to-serial adapter on their keyring. *Serial isn't dead in the data center — it's the cable you reach for when the network is down.*

**Beat 4 — the point.** Same fundamental question, different workloads, different right answers. *What does this cable actually carry, and what does each end actually support?* Get this question into your bones — you'll ask it for the rest of your career, and the user who hands you a "broken" cable usually just handed you a charge-only cable, a USB 2.0 cable on a USB 3 device, or a USB-C cable that doesn't do Thunderbolt.

## Key facts

### USB connector shapes

| Connector | Where you see it | Notes |
|---|---|---|
| **USB-A** | Host side: PCs, hubs, chargers | The classic flat rectangle. Not reversible. |
| **USB-B** | Printers, older audio interfaces | Square-ish with chamfered top corners. |
| **Mini-USB** | Old cameras, PS3 controllers | Mostly dead. Trapezoid shape. |
| **Micro-USB** | Pre-2018 Android phones, cheap electronics | Still common on cheap accessories. |
| **USB-C** | Modern phones, laptops, peripherals | Reversible. Carries USB 2.0 through Thunderbolt 5 depending on the cable. |
| **Lightning** | iPhones 5–14, older iPads | Apple proprietary. Reversible. EU mandated USB-C on iPhone 15+. |

### USB-C is a connector, not a protocol

This is the single most-tested concept in this objective. A USB-C cable can be:

- **USB 2.0 only** (charging cables, cheap accessories — 480 Mbps, no video)
- **USB 3.2 Gen 1** (5 Gbps)
- **USB 3.2 Gen 2** (10 Gbps)
- **USB4** (20 or 40 Gbps)
- **Thunderbolt 3, 4, or 5** (40–80 Gbps, video, PCIe tunneling, daisy-chaining)
- **Charge-only** (no data wires at all)

> **CompTIA exam trap:** "Which cable supports 40 Gbps?" The answer is *Thunderbolt 3/4 or USB4*, not "USB-C." USB-C is the connector. The question is testing whether you know connector ≠ protocol.

### Power delivery

USB Power Delivery (USB-PD) lets USB-C cables carry up to 240W (USB-PD 3.1, EPR) for laptop charging and high-power peripherals. Older USB-A maxes around 7.5W. *This is why your laptop charges over USB-C and not USB-A.*

### Legacy peripheral cables you still meet

| Cable | Use case | Status |
|---|---|---|
| **eSATA** | External hard drives, pre-2012 | Dead. USB 3.0 killed it. |
| **DB9 / Serial / RS-232** | Console access on switches, routers, UPSes, industrial gear | Alive in the data center. Buy a USB-to-serial adapter. |
| **RJ11** | Telephone lines, fax, DSL modems | Alive in branch offices that still use POTS lines. |
| **Lightning** | Pre-2023 iPhones | Sunsetting. Still in countless drawers. |
| **PS/2** | Pre-2000s keyboards and mice | Effectively dead. Some servers still ship the port. |

### CompTIA exam traps

> **Trap:** USB 3.0 ports are blue *inside the connector*. USB 2.0 is black. Test questions describe the port color and ask the speed.

> **Trap:** A Thunderbolt port and a USB-C port look identical. The differentiator is the **lightning bolt icon** next to the port. No icon = USB-C only.

> **Trap:** Mini-USB and Micro-USB are different connectors. Mini is older, larger, trapezoid. Micro is newer, smaller, has a flatter profile. CompTIA shows pictures.

> **Trap:** RJ11 (phone, 4-6 pin) vs RJ45 (Ethernet, 8 pin). They look similar at a glance. Count the pins.

> **Trap:** "External SATA" is **eSATA**, not USB. The connector is shaped differently from internal SATA — it's reinforced for repeated insertion and has no L-shape.

## Helpdesk reality

- **"My phone won't charge fast on this cable."** It's a USB 2.0 cable. They need a USB-PD-rated cable, ideally the one that came with the phone. Cheap cables won't negotiate fast charging.
- **"My external drive is so slow."** Check both ends. They plugged a USB 3.0 drive into a USB 2.0 port (black plastic, back of an old desktop). Move it to a blue port.
- **"My dock stopped working."** They swapped the Thunderbolt cable for a USB-C cable that "looked the same." Issue them the *correct* cable and label it. *Half of all dock tickets are this exact problem.*
- **"I need to console into the switch and my laptop has no serial port."** Hand them a USB-to-serial adapter. Every network closet should have a spare in the toolbox. Install the driver — Prolific and FTDI chipsets are the common ones.
- **Never promise** a USB-C cable from the supply closet supports Thunderbolt unless the cable is explicitly labeled. Buy labeled cables. Throw the unlabeled ones away.

## Related concepts

[[Video Cables and Connectors]] · [[Network Cables and Connectors]] · [[USB Standards and Speeds]] · [[Thunderbolt]] · [[Hard Drive Cables (SATA, SAS, NVMe)]] · [[Mobile Device Connections and Sync]] · [[Docking Stations]] · [[Cable Tools and Testers]]

*Source: VIRGIL knowledge base — 2026-05-10*