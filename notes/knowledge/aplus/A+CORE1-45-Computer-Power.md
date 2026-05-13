# Computer Power

## What it is

The PSU is the heart. It pumps clean DC power to every organ in the case — CPU, GPU, drives, fans, motherboard. Stop the heart, the body dies instantly. Give it a bad heart, the body dies slowly and takes other organs with it.

In plain English: the power supply unit (PSU) takes the messy AC voltage from the wall, converts it to the clean low-voltage DC the components actually need, and distributes it through a fan-out of cables and connectors. It's the single most under-respected component in a build — and the one most likely to take the rest of the rig out when it fails badly.

Technically: a switching-mode power supply that accepts 100–240 VAC input, rectifies and steps it down through a high-frequency transformer, and outputs regulated DC rails at +3.3V, +5V, +12V (and -12V, +5VSB for standby). Modern PSUs deliver nearly all their power on the +12V rail; everything else is generated downstream.

## Why it matters

A bad PSU doesn't just fail to power your build — it kills your build. Cheap units skip protection circuits (OVP, OCP, SCP) and when they finally pop, they send a voltage spike straight into the motherboard, GPU, and drives. You replace a $40 PSU with a $400 GPU corpse.

CompTIA tests this on **Objective 220-1201 3.6**: input voltage selection, wattage sizing, modular vs non-modular, the 20+4 pin connector, redundant PSUs, and efficiency ratings (80 PLUS). Expect questions where someone "upgraded their GPU and now the system reboots under load" — that's a wattage/quality problem, not a software one.

Career-wise: every server, every workstation, every desktop you'll ever touch has a PSU. The enterprise versions are different beasts — redundant, hot-swappable, fed from two separate power circuits — but the fundamentals are identical. Learn this once, apply it everywhere.

## In your build, in the enterprise

**Beat 1 — Technical depth.** PSU shopping has five real specs:

- **Wattage** — total continuous output. A modern gaming rig pulls 400–700W under load; size the PSU 30–40% above peak draw for headroom and efficiency.
- **Efficiency rating (80 PLUS)** — Bronze, Silver, Gold, Platinum, Titanium. Higher tier = less wasted heat, lower electric bill, longer lifespan. 80 PLUS Gold is the sweet spot for most builds.
- **Modular / semi-modular / non-modular** — modular lets you detach unused cables. Better airflow, cleaner build, no rat's nest of unused Molex stuffed behind the drive cage.
- **Rail layout** — single +12V rail (most modern units) vs multi-rail. Single rail is simpler and fine for consumer use.
- **Connectors** — 24-pin ATX motherboard (20+4 split for backwards compat), 4+4 EPS for CPU, 6+2 PCIe for GPU, SATA, Molex, and the new 12V-2x6 (formerly 12VHPWR) for high-end GPUs.

Input voltage matters too. **110–120 VAC** in North America, **220–240 VAC** in most of the rest of the world. Older PSUs had a red switch on the back — flip it wrong and you fry the unit on first power-on. Modern PSUs are auto-switching (active PFC) and handle the full 100–240V range automatically. *Still check before plugging into a foreign outlet.*

**Beat 2 — Feynman example via gaming build.** You're spec'ing a 7800X3D + RTX 5080 gaming rig. The GPU pulls 360W peak transient, the CPU pulls 120W, drives and fans add 50W. Peak system draw: ~530W.

**The wattage chase:** Cheap forum advice says "1000W to be safe!" That's wrong-headed. PSUs are most efficient at 50–80% load. A 750W Gold unit running at 530W (70%) outperforms a 1000W unit running at 530W (53%) on heat, noise, and electric bill. *Buy headroom, not vanity.*

**The efficiency tier:** 80 PLUS Gold 750W from a tier-1 brand (Corsair RM, Seasonic Focus, be quiet! Straight Power) — $130. The "1000W" no-name on Amazon for $70 lies about its rating, skips protection circuits, and is the one that takes your GPU with it when the capacitors swell. *The PSU is not where you save money.*

**The modular call:** Fully modular. Plug in 24-pin, EPS, two PCIe cables for the GPU, two SATA. Done. The other six cables stay in the box. Airflow is clean, the back of the case isn't a graveyard, and when you upgrade the GPU in two years you swap one cable instead of rewiring the whole rig. *Modular pays for itself the first time you upgrade.*

**The 12V-2x6 reality:** Plug it in fully. All the way. Listen for the click. The original 12VHPWR melted on RTX 4090s because users seated it 90% and ran 600W through a partial connection. *Half-seated power connectors are a fire, not a fault.*

**Beat 3 — Bridge from gaming to enterprise.** Same fundamental question — "how much clean power does this machine need, and what happens when the PSU dies?" — different right answer at every scale.

- **Gaming PC**: one 750W 80 PLUS Gold, single PSU, plugged into a UPS. PSU dies → rig is down for a day until the replacement arrives. Acceptable.
- **Developer workstation / homelab**: same single PSU, maybe 850W for the extra drives and the GPU doing local Llama inference. Same UPS. Same acceptable downtime.
- **Cybersecurity analyst rig**: same answer. The workstation isn't special — the SIEM and the SOC tooling live on servers somewhere else.
- **1U production server**: **redundant power supply**. Two PSUs, often labeled 1+1, each capable of running the full server load alone. One PSU dies, the other carries the load with zero downtime. The dead unit is hot-swappable — pull it out the front of the chassis, slide a new one in, the server never noticed. Each PSU is fed from a **separate power circuit** (A feed and B feed) so a tripped breaker on one circuit doesn't take the box down. Both feeds upstream are on UPS, then on generator transfer. The whole power chain is redundant, end to end.

**Beat 4 — The point.** Same question — "what does this machine need to keep running?" — different answer based on what "keep running" means. Gaming PC: "I'm not gaming until tomorrow." Production server: "every minute of downtime costs the business money or lives." Get the question into your bones. You'll ask it about every system you ever touch — power, storage, network, cooling, backups. *Redundancy is the price of "this cannot go down."*

## Key facts

### Voltage rails and what uses them

| Rail | Powers |
|---|---|
| **+12V** | CPU (via EPS), GPU (via PCIe), drive motors, fans. The big rail — 90%+ of total wattage. |
| **+5V** | USB ports, some logic chips, older drive electronics |
| **+3.3V** | Motherboard chipset, RAM, modern drive logic |
| **-12V** | Legacy serial ports. Vestigial. Still in spec. |
| **+5VSB** | Standby power — keeps Wake-on-LAN, USB charging, and the power button alive when the system is "off" |

### The 20+4 pin ATX connector

Original ATX spec was 20-pin. When PCIe and higher-power CPUs arrived, ATX12V v2.0 added 4 extra pins for more +12V capacity. Modern PSUs ship with a **20+4 pin** connector — a 20-pin block with a detachable 4-pin extension that clips onto the side. Plugs into any motherboard from the last 20 years.

> **CompTIA exam trap:** Don't confuse the **20+4 pin ATX** (motherboard main power) with the **4+4 pin EPS** (CPU power, near the top of the board) or the **6+2 pin PCIe** (GPU power). Three different connectors, three different jobs. The exam will show you a photo and ask which it is.

### 80 PLUS efficiency tiers (at 50% load, 115V)

| Tier | Efficiency |
|---|---|
| 80 PLUS | 80% |
| Bronze | 85% |
| Silver | 88% |
| Gold | 90% |
| Platinum | 92% |
| Titanium | 94% |

Higher efficiency = less heat dumped into the case = quieter fans = longer component life. *Gold is the floor for any build you care about.*

### Consumer vs enterprise

| Aspect | Home / gaming | Enterprise server |
|---|---|---|
| **PSU count** | 1 | 2 (1+1 redundant), sometimes 3 (2+1) |
| **Hot-swap** | No — power down to replace | Yes — pull and replace live |
| **Power feeds** | Single circuit + UPS | Dual circuits (A/B), both on UPS, both backed by generator |
| **Form factor** | ATX, SFX | Proprietary 1U/2U slide-in modules |
| **Failure tolerance** | PSU dies = system down | PSU dies = alert fires, no downtime |
| **Replacement cost** | $80–$300 | $200–$800 per module, but kept on the shelf as a spare |

### CompTIA exam traps

> **Trap:** "More watts is always better." Wrong. Oversized PSUs run inefficiently at low load. Size to ~1.4× peak draw.

> **Trap:** Confusing input voltage (110–120 VAC wall) with output voltage (3.3/5/12 VDC to components). The exam will mix them deliberately.

> **Trap:** A redundant PSU is **two physical units**, not one PSU with two cables. Two cables from one PSU is just dual input — useful for A/B feeds, but if the PSU itself dies, the server is down.

## Helpdesk reality

- **"My PC randomly reboots when I play games."** Classic underpowered or dying PSU. Check wattage vs GPU+CPU TDP, check the 80 PLUS rating, check the age. PSUs degrade — a 7-year-old Bronze unit isn't delivering rated wattage anymore.
- **"It won't turn on at all, no lights, no fans."** Test the PSU first. Paperclip test (jump green to black on the 24-pin) or a $15 PSU tester. Also: is the rocker switch on the back of the unit on? *You will ask this question more than you'd believe.*
- **"I smell something burning from the tower."** Power off at the wall immediately. Don't restart to "see if it does it again." A failing PSU venting capacitor smoke is minutes from taking the motherboard with it.
- **"The server pulled an alert about PSU 1."** Good — that's redundancy doing its job. Schedule the hot-swap, don't panic. The box is running fine on PSU 2. Just don't leave it that way for a month.
- **Never promise** a specific PSU will "definitely be enough" without checking the GPU's transient spikes and the CPU's PL2 boost draw. Modern parts spike well above their rated TDP for milliseconds. That's what trips OCP and reboots the system.

## Related concepts

[[Motherboards]] · [[CPU]] · [[GPU]] · [[Cooling]] · [[UPS and Surge Protection]] · [[Server Form Factors]] · [[Cable Management]] · [[ESD Safety]]

*Source: VIRGIL knowledge base — 2026-05-10*