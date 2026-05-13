# Video Cables

## What it is

You finish the build, mount the GPU, plug the monitor in with whatever cable came in the box, and the screen stays black. Or it lights up but caps at 60Hz on a 240Hz panel. Or HDR won't enable. Nine times out of ten it's the cable — wrong standard, wrong version, or wrong port on the back of the GPU.

A video cable carries display signal from a source (GPU, iGPU, laptop, console) to a sink (monitor, TV, projector). The eyes of the machine talking to the eyes of the human. Modern video cables carry pixel data, audio, and often USB or power on the same wire — they're not just video anymore.

Technically: a video cable is a physical interface defined by a connector standard (HDMI, DisplayPort, DVI, VGA, USB-C/Thunderbolt) and a protocol version that dictates max resolution, refresh rate, color depth, and feature support (HDR, VRR, audio return).

## Why it matters

Display connector trivia is one of the most reliably tested topics on Core 1, and one of the most common helpdesk tickets you'll close in your first month. "My monitor isn't working" is rarely the monitor. It's the cable, the port, or the version mismatch. CompTIA Objective 220-1201 3.2 explicitly lists HDMI, DisplayPort, DVI, VGA, and USB-C as the named connectors — know the pinouts conceptually, the max resolutions, and the version differences.

In the field, you'll be the one explaining to a CAD engineer why their 4K 144Hz monitor is running at 60Hz (HDMI 1.4 cable in an HDMI 2.1 port — the cable is the bottleneck). You'll be the one stocking the parts cabinet with adapters because the new laptops are USB-C only and the conference rooms are still HDMI.

## In your build, in the enterprise

**Beat 1 — Technical depth.** Five connectors matter for the exam:

- **HDMI** (High-Definition Multimedia Interface) — 19-pin, carries video + audio + Ethernet + CEC. Versions matter: HDMI 1.4 caps at 4K@30Hz, HDMI 2.0 at 4K@60Hz, HDMI 2.1 at 4K@120Hz / 8K@60Hz with 48Gbps bandwidth. Mini and Micro HDMI exist for cameras and tablets.
- **DisplayPort (DP)** — 20-pin, latching connector, royalty-free, packet-based. DP 1.4 hits 4K@120Hz, DP 2.0/2.1 hits 8K@60Hz at 80Gbps. Supports daisy-chaining via MST (Multi-Stream Transport). Mini DisplayPort is the same protocol, smaller plug.
- **DVI** (Digital Visual Interface) — older, three flavors: DVI-D (digital only), DVI-A (analog only, rare), DVI-I (both). Single-link maxes at 1920×1200@60Hz, dual-link doubles the pin count and hits 2560×1600. No audio. White connector with screws.
- **VGA** (Video Graphics Array) — 15-pin DE-15, analog only, blue connector with thumbscrews. Tops out around 1920×1200 with quality degradation at distance. No audio. Dying but not dead.
- **USB-C / Thunderbolt** — same physical plug, different protocols. USB-C with **DisplayPort Alt Mode** carries native DP signal over the cable. **Thunderbolt 3/4** does the same plus 40Gbps PCIe data and 100W power delivery. Thunderbolt 5 pushes to 80Gbps (120Gbps in burst mode) for 8K and external GPUs.

**Beat 2 — Feynman example via gaming/personal build.** You build a new gaming rig with an RTX 5080 and a 4K 240Hz OLED panel. The monitor ships with one HDMI cable and one DP cable.

**The HDMI play:** HDMI 2.1 cable into the GPU's HDMI 2.1 port. 48Gbps. 4K@240Hz with DSC (Display Stream Compression) works. HDR enables. *Right cable, right port, right version — done.*

**The cheap-cable trap:** You grab a random HDMI cable from the parts drawer because the bundled one is too short. Screen flickers. Drops to 4K@60Hz. The cable is HDMI 1.4 from 2014 — physically identical connector, fraction of the bandwidth. *The plug shape lies. The version is what matters.*

**The DisplayPort play:** Switch to the bundled DP 2.1 cable. Locks in at 4K@240Hz no compression. G-Sync works. Daisy-chain a second monitor off the first via MST. *DisplayPort is the PC enthusiast's default for a reason — higher bandwidth headroom and a connector that doesn't fall out.*

**The kicker:** Your buddy's PS5 plugs into the same monitor via the second HDMI port. Console-land is HDMI-only. *DisplayPort is PC; HDMI is everything else.* You'll route both into your life.

**Beat 3 — Bridge to the enterprise.** Same question — "what cable connects the source to the display?" — different answer per build:

- **Gaming PC:** DisplayPort 2.1 to a high-refresh monitor. HDMI 2.1 to the living-room TV.
- **Developer workstation:** USB-C Thunderbolt dock → two DisplayPort monitors via MST. One cable to the laptop, full power delivery, two 4K panels.
- **Conference room PC:** HDMI 2.0 to the wall-mounted display, plus a VGA fallback because the projector from 2014 is still there.
- **Call-center desktop:** Single VGA or DVI-D cable to a 1080p monitor. Nobody's chasing 240Hz on a Citrix session.
- **Server in a rack:** A crash cart with VGA or sometimes DisplayPort, used for ten minutes a year when iLO/iDRAC isn't enough.

**Beat 4 — The point.** Same fundamental question: what bandwidth does this display need, and what's the cheapest cable that delivers it without bottlenecking? Gaming rigs chase headroom. Enterprises buy whatever the standardized monitor model accepts. Server rooms barely care because the head is a diagnostic tool, not a daily driver. *Get the question into your bones — you'll ask it for the rest of your career.*

## Key facts

### Connector quick reference

| Connector | Audio | Max (common version) | Typical use |
|---|---|---|---|
| **HDMI 2.1** | Yes | 4K@120Hz, 8K@60Hz | TVs, consoles, modern monitors |
| **HDMI 2.0** | Yes | 4K@60Hz | Most monitors 2015–2020 |
| **HDMI 1.4** | Yes | 4K@30Hz, 1080p@120Hz | Legacy, cheap cables |
| **DisplayPort 2.1** | Yes | 8K@60Hz, 4K@240Hz | Enthusiast PC monitors |
| **DisplayPort 1.4** | Yes | 4K@120Hz, 8K@30Hz w/ DSC | Mainstream PC monitors |
| **DVI-D Dual-Link** | No | 2560×1600@60Hz | Legacy PC monitors |
| **DVI-D Single-Link** | No | 1920×1200@60Hz | Older PC monitors |
| **VGA** | No | ~1920×1200 (analog) | Legacy, projectors, KVMs |
| **USB-C (DP Alt Mode)** | Yes | Up to DP 2.1 specs | Laptops, tablets, phones |
| **Thunderbolt 4** | Yes | Dual 4K@60Hz or 8K@60Hz | Pro laptops, docks |
| **Thunderbolt 5** | Yes | 8K@60Hz, multi-monitor | Workstations, eGPU |

### DVI variants — the trap CompTIA loves

- **DVI-A** — analog only (rare, basically dead)
- **DVI-D** — digital only — single-link OR dual-link (dual has more pins in the middle)
- **DVI-I** — integrated, carries both digital and analog (extra flat pins around the long blade)

A DVI-I to VGA passive adapter only works because DVI-I carries the analog signal. A DVI-D to VGA adapter requires an active converter with a chip in it — it has to redraw the signal from digital to analog.

### Adapters and what's actually possible

Passive adapter (just rewires pins):
- DVI-D ↔ HDMI (both digital, same TMDS signaling)
- DisplayPort → HDMI 1.4 (DP++ source required)
- DVI-I → VGA

Active adapter (contains a signal converter chip):
- HDMI → VGA (digital to analog conversion)
- DisplayPort → VGA
- USB-C → HDMI 2.1 (often)
- DisplayPort → DVI dual-link (single-link is passive, dual-link needs active)

> **CompTIA exam trap:** A DVI-D to VGA "adapter" cannot be passive — DVI-D has no analog signal to pass through. If you see a question about converting digital DVI-D output to a VGA monitor, the answer involves an **active converter**, not a simple adapter.

> **CompTIA exam trap:** USB-C with DisplayPort Alt Mode is **not** the same as Thunderbolt. Thunderbolt requires the controller and certification; DP Alt Mode is just video tunneled through the USB-C plug. Both look identical from the outside. The lightning-bolt logo on the port indicates Thunderbolt.

> **CompTIA exam trap:** HDMI carries audio by default; DVI and VGA carry **no audio at all**. Users who switch from HDMI to DVI and lose sound are not broken — that's the standard. Run a separate 3.5mm cable.

### Cable length practical limits

| Cable | Reliable passive length |
|---|---|
| HDMI (high-speed certified) | ~7.5m / 25ft |
| DisplayPort | ~3m / 10ft (longer drops bandwidth) |
| DVI | ~5m / 15ft single-link |
| VGA | ~5m / 15ft before noticeable degradation |
| USB-C / Thunderbolt 4 | 2m passive, longer requires active/optical |

Beyond these distances you need active cables, fiber-optic HDMI/DP, or a signal extender. Conference rooms and digital signage live in this world.

### Consumer vs. enterprise framing

**At home:** One HDMI or DP cable from GPU to monitor. Maybe a USB-C cable from a laptop to a monitor with built-in dock. Total cable count: under five. You buy whatever's on Amazon for $12.

**In the enterprise:** Standardized cable kits per desk, often pre-bundled by the asset management team. USB-C/Thunderbolt docks at every desk so the laptop fleet plugs in with one cable and gets dual monitors plus power plus Ethernet plus peripherals. Conference rooms have HDMI wall plates wired through structured cabling to the AV cabinet. Crash carts in the data center carry VGA, DP, and a USB keyboard because the rack hardware is generationally mixed. Cables are inventoried, labeled, and tested. When a CEO's monitor goes black during a board meeting, the spare cable is in a drawer ten feet away — that's the standard you're building toward.

## Helpdesk reality

- **"My second monitor isn't working."** Check the cable first, then the port, then the display settings. Nine out of ten times the cable wiggled loose or someone plugged into the motherboard's iGPU port instead of the dedicated GPU.
- **"My monitor is stuck at 60Hz but it's a 144Hz display."** Cable version. HDMI 1.4 or a cheap DP cable can't carry the bandwidth. Swap for a certified HDMI 2.1 or DP 1.4+ cable.
- **"I plugged in HDMI but there's no sound."** Set the HDMI device as the default audio output in Windows sound settings. Or the user is on DVI/VGA and there is no audio — explain the limitation, run a separate audio cable.
- **"The conference room projector won't show my laptop."** New laptop is USB-C only, projector is HDMI or VGA. Keep a USB-C → HDMI active adapter in every conference room and in your bag. CompTIA tests this scenario directly.
- **Never promise a passive adapter will work between digital and analog standards.** DVI-D to VGA, HDMI to VGA — these need active converters with power. Saying "just grab any adapter" is how tickets reopen.

## Related concepts

[[GPU Basics]] · [[USB Standards and USB-C]] · [[Thunderbolt]] · [[Display Settings and Resolutions]] · [[Network Cables]] · [[Adapters and Converters]] · [[Mobile Device Connectors]]

*Source: VIRGIL knowledge base — 2026-05-10*