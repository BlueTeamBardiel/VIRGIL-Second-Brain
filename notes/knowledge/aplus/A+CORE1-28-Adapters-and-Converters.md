# Adapters and Converters

## What it is

Every tech has a drawer. In that drawer: a USB-C to HDMI dongle, three Mini DisplayPort to VGA adapters from the projector wars, a SATA-to-USB caddy that's saved twelve dying drives, a DVI-to-HDMI passive adapter, and a Lightning-to-3.5mm dongle from when Apple killed the headphone jack. That drawer is the job. You will live in that drawer.

In plain English: an **adapter** or **converter** is a device that changes one connector or signal type into another so two pieces of hardware that don't natively speak to each other can connect. Adapters mate physically compatible signals (DVI-D to HDMI — same digital video, different plug). Converters do active signal translation (VGA analog to HDMI digital — needs a chip and usually power).

Technically: passive adapters rewire pins. Active converters contain silicon that re-encodes the signal — they have a direction (source → display, not the other way), and they need power, either from the port or a wall wart.

## Why it matters

CompTIA objective **220-1201 3.2** wants you to identify cables, connectors, and their purposes — and adapters are the glue between them. On the job, the conference room HDMI cable is missing, the executive's laptop is USB-C only, the projector is VGA from 2009, and the meeting starts in four minutes. Knowing which dongle does what — and which combinations physically can't work without a powered converter — is the difference between a working presentation and a resume update.

This is also where new techs get burned. Passive adapters are cheap and forgiving. Active converters fail silently, get hot, and only work in one direction. The exam tests whether you know the difference. The job tests whether you carry the right one.

## In your build, in the enterprise

**Beat 1 — technical depth.** Adapters fall into three categories. **Passive** adapters do pin remapping only — DVI-D ↔ HDMI, USB-A ↔ USB-C (data only), DisplayPort ↔ Mini DisplayPort. They work because the underlying signals are electrically compatible. **Active** converters contain a chip that translates between protocol families: VGA (analog RGB) ↔ HDMI (digital TMDS), HDMI ↔ DisplayPort in certain directions, USB-C DisplayPort Alt Mode ↔ VGA. Active converters draw power, run warm, and are directional. **Bridges** are powered devices that translate storage or peripheral protocols: SATA-to-USB caddies, USB-to-serial (DB9) dongles, USB-to-RJ45 Ethernet adapters, Thunderbolt docks that fan out into HDMI, USB-A, SD, and Ethernet from one port.

Key signal compatibilities to memorize: DVI-D → HDMI is passive (same TMDS signal). DVI-A → VGA is passive (both analog). DVI-I carries both, so it adapts to either. VGA → anything digital requires an active converter. HDMI → DisplayPort requires active in most cases; DisplayPort → HDMI is often passive on dual-mode (DP++) sources. USB-C carries USB data, DisplayPort Alt Mode video, Thunderbolt, and up to 240W of power — but only if the cable and both ends support each protocol. A USB-C cable is not a USB-C cable. There are at least six tiers.

**Beat 2 — Feynman via the homelab dongle drawer.**

**The HDMI-to-VGA fight at 2am:** New 4K monitor on the gaming rig. Old VGA KVM you forgot you had. Passive HDMI-to-VGA adapter from the bin — ten bucks, no power. Plug it in. Black screen. *HDMI is digital, VGA is analog. Passive can't convert between signal families.* Order an active powered converter. It works. Image is mediocre because you're downconverting 4K digital to 1080p analog and the world is laughing.

**The DVI-to-HDMI win:** Old GTX 1070 in the secondary rig has DVI-D out. New monitor is HDMI-only. Five-dollar passive adapter. Works first try, full resolution, no power needed. *Same digital signal, different plug — passive is fine.*

**The USB-C dock that runs hot:** Single-cable docking station for the work laptop — one USB-C in, HDMI + Ethernet + three USB-A + SD card out. Works great. Gets uncomfortably warm. *Active conversion isn't free — every protocol translation is a chip doing work.* If the dock dies in two years, that's why.

**The SATA caddy that saved a wedding:** Friend's laptop won't boot. Pull the 2.5" SATA SSD, drop it in a USB-to-SATA caddy, plug into your machine, copy the wedding photos off in fifteen minutes. *A $12 bridge adapter is the single most useful tool in the drawer.* Buy two.

**Beat 3 — bridge from gaming to enterprise.** Same fundamental question across builds: **what signal am I starting with, what signal does the other end need, and is the conversion passive, active, or impossible?**

- **Gaming PC at home:** GPU has DisplayPort, monitor has HDMI. Passive DP→HDMI adapter, $8, done.
- **Developer rig:** Three monitors, mixed inputs (DP, HDMI, USB-C). Each adapter chosen per signal pair. Maybe one active converter in the chain.
- **Conference room:** Twelve laptops a week plug in — USB-C MacBooks, USB-C ThinkPads, the one Dell with HDMI, the executive's old machine with Mini DisplayPort. The room's display accepts HDMI only. You stock a tray of adapters: USB-C→HDMI active, Mini DP→HDMI passive, USB-C dock with HDMI out. Every one is labeled.
- **Server room / network closet:** Different game entirely. USB-to-DB9 serial adapters for console access to switches and firewalls. USB-to-RJ45 adapters for laptops without Ethernet. Fiber media converters (multimode LC ↔ copper RJ45) bridging legacy copper segments to the fiber backbone. KVM-over-IP appliances replacing the physical KVM cart. The "adapter" here might be a 1U rack-mounted box with its own power supply and management interface.

**Beat 4 — the point.** Same fundamental question — *what's the source signal, what does the destination need, what kind of conversion is required* — different builds, different right answers. Get this question into your bones. You will ask it five times a week for the rest of your career.

## Key facts

### Passive vs. active vs. bridge

| Type | What it does | Needs power? | Examples |
|---|---|---|---|
| **Passive adapter** | Pin remap, same signal family | No | DVI-D↔HDMI, Mini DP↔DP, USB-A↔USB-C (data) |
| **Active converter** | Chip translates between signal families | Yes (port or wall) | VGA↔HDMI, HDMI↔DisplayPort (some directions), USB-C Alt Mode↔VGA |
| **Bridge / dock** | Translates storage or peripheral protocols | Yes | USB-to-SATA, USB-to-DB9 serial, USB-to-RJ45, Thunderbolt dock, fiber media converter |

### Common video adapter combinations

| From | To | Passive or active? | Notes |
|---|---|---|---|
| DVI-D | HDMI | Passive | Same TMDS signal, no audio on DVI side |
| DVI-A | VGA | Passive | Both analog |
| DVI-I | HDMI or VGA | Passive | DVI-I carries both signals |
| DisplayPort | HDMI | Passive (if DP++) | Most modern GPUs are dual-mode |
| HDMI | DisplayPort | Active | Always |
| VGA | HDMI/DVI/DP | Active | Analog→digital always needs a chip |
| USB-C (Alt Mode) | HDMI/DP/VGA | Depends — VGA always active | Source must support DP Alt Mode |
| Mini DisplayPort | DisplayPort | Passive | Pin remap |
| Lightning | HDMI/VGA | Active | Apple's Lightning Digital AV adapter has a chip inside |

### Storage and peripheral bridges

| Adapter | Purpose | Where you'll see it |
|---|---|---|
| **USB-to-SATA caddy** | Read/write 2.5" or 3.5" SATA drives over USB | Data recovery, drive cloning, the single most useful tool you own |
| **USB-to-eSATA** | External SATA drives over USB | Legacy, mostly replaced by USB 3.x and Thunderbolt |
| **USB-to-DB9 (serial)** | Console access to network gear | Every network closet, every firewall config session |
| **USB-to-RJ45** | Add Ethernet to a laptop without it | Ultrabooks, MacBooks, Surface devices |
| **M.2 NVMe-to-USB enclosure** | External NVMe over USB 3.2 / Thunderbolt | Cloning a system drive before an upgrade |
| **Lightning-to-USB / Lightning-to-3.5mm** | Apple peripheral compatibility | iPhone troubleshooting, audio dongles |
| **Fiber media converter (LC↔RJ45)** | Bridge copper segment to fiber run | Long cable runs, building-to-building |

### USB-C — the cable matters

A USB-C connector can carry: USB 2.0 data, USB 3.x data, USB4, Thunderbolt 3/4/5, DisplayPort Alt Mode, HDMI Alt Mode (rare), and Power Delivery up to 240W. **The connector tells you nothing about what the cable supports.** Charge-only cables exist. USB 2.0-only USB-C cables exist. Thunderbolt 4 cables look identical to $3 charging cables.

Buyer rules: cables rated for the protocol you need, certified where possible (USB-IF, Thunderbolt logo), and labeled in your homelab so you don't grab the wrong one at 2am.

### CompTIA exam traps

> **CompTIA exam trap:** *VGA-to-HDMI passive adapters don't exist that work.* If you see "$5 passive VGA-to-HDMI" on the exam — wrong answer. Analog-to-digital always requires an active converter with power. CompTIA tests this because techs buy the cheap passive ones and call the help desk.

> **CompTIA exam trap:** *DVI types matter.* DVI-D is digital only, DVI-A is analog only, DVI-I carries both. A DVI-D port cannot adapt to VGA passively because there's no analog signal there to remap. CompTIA loves this distinction.

> **CompTIA exam trap:** *USB-C ≠ Thunderbolt.* The connector is shared, the protocol is not. A laptop with a USB-C port may or may not support Thunderbolt, DisplayPort Alt Mode, or Power Delivery. Look for the lightning bolt (Thunderbolt) or DP icon next to the port.

> **CompTIA exam trap:** *Lightning is Apple-proprietary, not USB.* Lightning-to-HDMI adapters contain a chip and are active. They're not the same as USB-C-to-HDMI even though they look superficially similar.

## Helpdesk reality

- **"My monitor is black."** First question: what cable, what adapter, what's on each end? Half the time it's a passive adapter trying to do an active job, or a USB-C cable that's charge-only.
- **"I need to get files off this dead laptop."** USB-to-SATA caddy or M.2 enclosure. Pull the drive, mount it, copy the files. Twelve-dollar adapter is your $200/hour billable rescue.
- **"Can you get a picture on the projector?"** Conference room kit: stock USB-C→HDMI active, Mini DP→HDMI passive, VGA→HDMI active. Label them. Check them weekly. They walk off.
- **"It worked at home."** Home monitor was HDMI-native, office projector is VGA. Different conversion path, different adapter, possibly active. Not a laptop problem.
- **Never promise** an adapter will work without testing it. USB-C especially. The connector lies.

## Related concepts

[[Video Cables]] · [[Network Cables]] · [[USB Standards]] · [[Thunderbolt]] · [[SATA and Storage Interfaces]] · [[Display Standards — HDMI DisplayPort DVI VGA]] · [[Mobile Device Connectors]] · [[Peripheral Cables]]

*Source: VIRGIL knowledge base — 2026-05-10*