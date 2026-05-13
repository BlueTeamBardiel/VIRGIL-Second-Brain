# Display Types

## What it is

You're spec'ing a new gaming rig and you're staring at three monitors at Micro Center: a 240Hz TN panel, a 165Hz IPS, and a 120Hz OLED. They're all "1440p." They cost $200, $400, and $900. The TN looks washed out from the side. The IPS is rich but the blacks are gray. The OLED looks like someone cut a window into another dimension. Same resolution, three different technologies, three different answers depending on what you do at the desk.

In plain English: a display is the screen. *Display type* is the underlying panel technology that decides how it makes light and color. *Attributes* are the spec-sheet numbers — resolution, refresh rate, pixel density, color gamut — that tell you how good it is at doing that.

Technically: a display is the output organ of the machine — the GPU's muscle work made visible. The panel is glass, transistors, and either a backlight (LCD family: TN, IPS, VA, Mini-LED) or self-emissive pixels (OLED). The digitizer is a separate layer on top that turns finger touches into coordinates. On older CCFL-backlit LCDs, an inverter board converted DC to the high-voltage AC the backlight tube needed.

## Why it matters

Objective 220-1201 3.1 explicitly tests panel types, attributes, the digitizer, and the inverter. CompTIA wants you to know the trade-offs between TN, IPS, VA, OLED, and Mini-LED, plus what resolution, refresh rate, pixel density, and color gamut actually mean.

Real-world: this is one of the most concrete buying decisions in IT. Helpdesk users will ask you "which monitor should I get?" Designers need wide gamut. Traders need lots of pixels. Gamers need refresh rate. Call center users need cheap and reliable. Get the panel-to-workload match wrong and you've wasted budget or hurt productivity. Also: laptop screens fail. Knowing whether a dead screen is the panel, the backlight, the inverter (on legacy units), or the digitizer determines whether you swap one part or the whole assembly.

## In your build, in the enterprise

**Beat 1 — Technical depth.**

The LCD family all works the same way at the foundation: a backlight shines through liquid crystals that twist to block or pass light, with a color filter on top. The differences are in how the crystals are arranged.

- **TN (twisted nematic)** — oldest, cheapest, fastest. Pixel response in 1ms. Refresh rates up to 360Hz. Garbage viewing angles — colors shift the moment you tilt. Washed-out color, narrow gamut.
- **IPS (in-plane switching)** — crystals lie parallel to the panel. Excellent color accuracy, ~178° viewing angles, wide gamut. Slower response than TN historically; modern "Fast IPS" hits 1ms. "IPS glow" — gray haze in dark scenes from off-angle backlight bleed.
- **VA (vertical alignment)** — crystals stand perpendicular and tilt to let light through. Best contrast of any LCD, deep blacks (3000:1 vs 1000:1 on IPS). Slower response, smearing in dark transitions.
- **OLED** — no backlight. Each pixel is its own organic LED that emits light directly. Black pixels are *off*, so contrast is effectively infinite. Per-pixel response under 0.1ms. Risk: burn-in on static elements (taskbars, HUDs).
- **Mini-LED** — still LCD, but the backlight is thousands of tiny LEDs in independent dimming zones. Approaches OLED contrast without burn-in risk. Brighter than OLED. Blooming (halo around bright objects on dark backgrounds) is the trade-off.

**Attributes:**

- **Resolution** — pixel count. 1080p (1920×1080), 1440p (2560×1440), 4K (3840×2160), 5K, 8K.
- **Refresh rate** — how many times per second the panel redraws. 60Hz, 120Hz, 144Hz, 240Hz, 360Hz, 480Hz on flagship OLEDs.
- **Pixel density (PPI)** — pixels per inch. A 27" 1440p is ~109 PPI. A 27" 4K is ~163 PPI. Higher = sharper text, but Windows scaling has to compensate.
- **Color gamut** — the slice of visible color the panel can reproduce. sRGB (web standard), DCI-P3 (cinema, modern wide-gamut target), Adobe RGB (print).

**Beat 2 — Feynman example via gaming/personal build.**

You've got $500 for a 27" 1440p monitor and you play a mix of Valorant and single-player RPGs.

**The TN trap:** $250 buys you a 240Hz TN panel. Valorant feels like cheating. Then you fire up Cyberpunk and the colors look like a faded poster. You tilt your head and the top of the screen goes purple. *TN wins on response time and refresh, loses on everything else.*

**The IPS sweet spot:** $400 buys a 165Hz Fast IPS. Valorant is still buttery — 165Hz is past the point of diminishing returns for most humans. RPGs look great. Blacks are slightly gray in a dark room. *IPS is the default right answer for mixed workloads.*

**The OLED splurge:** $900 buys a 240Hz QD-OLED. Every game looks like a different medium. Then you leave Discord open on the second monitor for eight hours and six months later you can faintly see the channel list burned into the panel. *OLED is the best image you can buy and the most fragile.*

**The kicker:** Resolution and refresh rate live on the same budget. You cannot have 4K 240Hz OLED for $400. *Pick the two attributes that matter most for your workload and accept the third is going to be mid.*

**Beat 3 — Bridge from gaming to enterprise.**

Same fundamental question: *what does this screen need to do?*

- **Gaming PC:** refresh rate and response time win. IPS or OLED at 1440p 144Hz+.
- **Developer workstation:** pixel density wins. 4K at 27" so 80 lines of code are sharp. 60Hz is fine. IPS.
- **Designer / video editor:** color gamut and accuracy win. IPS or Mini-LED with factory calibration covering 99% DCI-P3. Refresh rate doesn't matter.
- **Trading floor / SOC analyst:** resolution and screen real estate win. Three or four 27" 1440p IPS panels. Refresh rate, gamut, response time — all irrelevant. They're reading dashboards.
- **Call center:** cost wins. 1080p 24" IPS. $120. Buy 400 of them.
- **Hospital / shared workstation:** durability and viewing angles win. IPS, anti-glare matte, no OLED (burn-in from static EHR interface in 18 months).

**Beat 4 — The point.**

Same fundamental question, different workloads, different right answers. The panel-and-attribute decision is one of the cleanest examples of "there is no best, only best-for-this." Get this question into your bones — when a user asks "which monitor should I get?" your first response is "what are you doing on it?" — *not* a recommendation. You'll ask this question for the rest of your career.

## Key facts

### Panel comparison

| Panel | Response time | Contrast | Color | Viewing angles | Best for |
|---|---|---|---|---|---|
| **TN** | <1ms | ~1000:1 | Narrow, washed | Poor (~160°) | Competitive esports on a budget |
| **IPS** | 1–4ms | ~1000:1 | Wide, accurate | Excellent (178°) | Mixed-use, default pick |
| **VA** | 4–8ms | ~3000:1 | Wide, deep blacks | Good (~178°) | Movies, dark-room single-player |
| **OLED** | <0.1ms | Infinite | Wide (DCI-P3 95%+) | Excellent | Premium gaming, content creation |
| **Mini-LED** | 1–4ms | ~10,000:1+ | Very wide, very bright | Excellent | HDR work, OLED-class without burn-in |

### Resolution standards

| Name | Pixels | Common sizes |
|---|---|---|
| 1080p / FHD | 1920×1080 | 22"–24" |
| 1440p / QHD | 2560×1440 | 27"–32" |
| 4K / UHD | 3840×2160 | 27"–43" |
| 5K | 5120×2880 | 27" (creator) |
| 8K | 7680×4320 | 65"+ TVs, niche |

### Pixel density (PPI) sweet spots

- **27" 1440p** — ~109 PPI — the gaming default
- **27" 4K** — ~163 PPI — sharp text, requires Windows 150% scaling
- **24" 1080p** — ~92 PPI — office standard, cheap and fine
- **15.6" laptop 1080p** — ~141 PPI — looks fine
- **15.6" laptop 4K** — ~282 PPI — overkill at arm's length, kills battery

### Color gamut targets

- **sRGB** — the web. 100% sRGB is the floor for any non-trash monitor.
- **DCI-P3** — cinema standard, what HDR content is mastered in. 90%+ for content creation.
- **Adobe RGB** — wider greens than sRGB, used in print prepress. Niche.

### Touch screen / digitizer

The digitizer is a separate layer over the LCD/OLED that detects touch. Two technologies:

- **Capacitive** — what every modern smartphone, Surface, and iPad uses. Detects the electrical disturbance from a finger or active stylus. Multi-touch. Won't work with gloves or non-conductive styluses.
- **Resistive** — old PDAs, ATMs, industrial kiosks. Two flexible layers that touch when pressed. Works with anything (gloves, fingernails, plastic stylus). Single-touch, less accurate.

Repair note: on a phone or tablet, when the screen cracks but display still works, the digitizer is what's broken. On modern devices the digitizer, LCD/OLED, and front glass are bonded into one assembly — you replace the whole thing.

### Inverter (legacy)

On older laptops with **CCFL (cold cathode fluorescent lamp) backlights**, an inverter board converted DC battery power into the high-voltage AC the fluorescent tube needed. Symptom of a bad inverter: image is faintly visible if you shine a flashlight at the screen, but no backlight. *Modern LED-backlit laptops have no inverter.* CompTIA still tests this because the objectives haven't dropped legacy hardware.

### CompTIA exam traps

> **CompTIA exam trap: "image is faint, can see it with a flashlight."** On a CCFL laptop = bad inverter. On a modern LED laptop = bad backlight LED strip or the LED driver circuit. CompTIA's textbook answer is *inverter* because the objective lists inverter explicitly. Read the question carefully.

> **CompTIA exam trap: OLED vs LED.** OLED is self-emissive, each pixel makes its own light. "LED monitor" almost always means *LED-backlit LCD* — it's still an LCD panel, just with LED instead of CCFL backlight. They are not the same thing.

> **CompTIA exam trap: refresh rate vs response time.** Refresh rate (Hz) is how often the panel redraws per second. Response time (ms) is how fast a single pixel changes color. A 240Hz panel with 8ms response time will smear. Both matter, they measure different things.

> **CompTIA exam trap: resolution vs pixel density.** A 4K 65" TV and a 4K 27" monitor have the *same* resolution and *very different* pixel density. Resolution is total pixel count; PPI accounts for screen size.

## Helpdesk reality

- **"My screen is dim, I can barely see anything."** — On a laptop, suspect the backlight first. Shine a flashlight at the screen — if you see a faint image, the panel is fine and the backlight is dead. On legacy CCFL units, that's the inverter. On modern LED units, that's the LED strip or driver, and you're usually replacing the whole lid assembly.
- **"My monitor has a weird shadow of my taskbar."** — That's OLED burn-in, and it's permanent. Built-in pixel-shift and panel-refresh routines slow it but don't reverse it. Warranty may cover it; check.
- **"Why does my new 4K monitor have tiny text?"** — Pixel density. Open Settings → System → Display and set scaling to 150% or 175%. Don't drop the resolution to "fix" it; you'll get blurry text instead of small text.
- **"My touchscreen stopped responding but the screen still works."** — Digitizer failure. On a phone or tablet, the digitizer is bonded to the display — replace the whole assembly. Reboot first; sometimes the touch driver hangs.
- **"Which monitor should I buy?"** — Always ask what they do on it before answering. Gaming, coding, design, spreadsheets — the right answer is different for each. Never recommend a monitor without knowing the workload.

## Related concepts

[[Video Cables and Connectors]] · [[GPU Basics]] · [[Laptop Display Components]] · [[Mobile Device Displays]] · [[HDR and Color Calibration]] · [[Display Scaling and DPI]] · [[Multi-Monitor Setup]]

*Source: VIRGIL knowledge base — 2026-05-10*