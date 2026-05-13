# Cooling

## What it is

Cooling is breathing. The CPU is the brain, and like any brain it generates heat when it thinks hard. Stop the airflow and the brain cooks itself — except silicon doesn't die dramatically, it just gets slower. The chip detects the heat, drops its clock speed to survive, and your "8 GHz gaming rig" suddenly performs like a laptop from 2014. That's thermal throttling, and it's the single most common reason a perfectly-specced PC feels sluggish under load.

In plain English: cooling is the system that moves heat from hot silicon into the air outside the case. Heat sinks pull it off the chip, fans push it through the case, and thermal paste fills the microscopic gaps so the heat actually transfers. No paste, no transfer. No airflow, no exit. The chip throttles.

Technically: every modern CPU and GPU has a thermal junction maximum (Tjmax), usually 95–105°C. Hit that ceiling and the chip throttles or shuts down. The cooling solution exists to keep the die under that ceiling under sustained load — not idle, not for ten seconds, but for the two-hour gaming session or the eight-hour rendering job. CompTIA tests this under Objective 220-1201 3.5 (motherboards, CPUs, cooling).

## Why it matters

Cooling failures are silent. The user says "my PC got slow" and they're right — the CPU is sitting at 99°C and clocking down to 1.2 GHz to avoid death. No BSOD, no error, no smoke. Just slow. A tech who doesn't check temps will replace RAM, reinstall Windows, run malware scans, and never find it.

The exam tests heat sinks, thermal paste/pads, fans, liquid cooling, and temperature monitoring as motherboard connector types and CPU install considerations. You need to know which fan plugs into which header, what thermal paste actually does, when liquid beats air, and how the BIOS reads temperature from the chip itself.

Career-wise: every desktop you'll ever touch has a cooling solution. Every server rack you'll ever walk past is cooled by something. Get this wrong on a CPU swap and you destroy an $800 chip in 30 seconds. Get it right and you're the tech who knows why the marketing director's machine has been slow for six months.

## In your build, in the enterprise

**Beat 1 — the technical layer.** Heat moves three ways: conduction (chip to heat sink through thermal paste), convection (heat sink to air via fans), and radiation (negligible at these temperatures). Thermal paste is not glue — it's a gap filler for microscopic surface imperfections between the CPU's integrated heat spreader (IHS) and the cold plate of the cooler. Apply too much and you insulate. Apply too little and you have air gaps. A pea-sized dot in the center, mounted with even pressure, spreads correctly.

Fans connect to the motherboard via 3-pin (voltage-controlled) or 4-pin PWM (pulse-width modulated) headers. PWM gives fine-grained RPM control; 3-pin is on/off-ish. The CPU_FAN header is mandatory — the BIOS will refuse to boot if it detects no fan there. Case fans go into CHA_FAN headers. AIO pumps go into AIO_PUMP or a CPU_FAN header configured for full-speed.

Liquid cooling — closed-loop AIO (all-in-one) or custom loop — uses a pump to circulate coolant from a cold plate on the CPU through tubes to a radiator with fans. More thermal mass, better sustained performance, more failure points.

**Beat 2 — the gaming build.**

**The stock cooler:** Ships in the box with the CPU. Adequate for an i5 at stock clocks doing email. Put a Ryzen 9 under it during a Cyberpunk session and it screams like a hairdryer while the chip throttles to 75% of its rated speed. *Stock coolers are floor, not ceiling.*

**The tower air cooler:** Noctua NH-D15, Be Quiet Dark Rock, Thermalright Peerless Assassin. Big aluminum fin stack, two fans, six heatpipes. Handles a 7800X3D under full load near silently. Costs $40–100. *For 90% of builds, a good tower cooler beats a mid-range AIO.*

**The 360mm AIO:** Three 120mm fans on a radiator, pump on the CPU, sealed loop. Better thermal headroom for Core Ultra 9 / Ryzen 9 chips that boost hard. Looks clean, costs $150+. Pump dies in year four and you find out at 2 AM mid-raid when temps spike to 100°C and the system locks. *AIOs have a shelf life. Air coolers don't.*

**The thermal paste mistake:** Reseating a cooler without cleaning off old paste with isopropyl alcohol. Or pumping a blob the size of a marble onto the IHS thinking more is better. *Less is more. Clean every time.*

**Beat 3 — same question, different builds.** "How much sustained heat do I need to dissipate?"

- **Gaming PC:** Ryzen 7 7800X3D at 120W package power. Tower air cooler handles it. Done.
- **Developer/streaming rig:** Ryzen 9 9950X compiling and encoding simultaneously, sustained 200W+. AIO 280mm or 360mm earns its price here.
- **Cybersecurity analyst workstation:** Threadripper running 20 VMs in parallel, 350W sustained. Custom loop or beefy air cooler designed for HEDT sockets. Stock anything is laughable.
- **1U rack server:** Xeon at 250W TDP. Cooled by six 40mm screamers running at 15,000 RPM, pulling air front-to-back through the entire chassis. The CPU has a passive heat sink — no fan attached. Cooling is a chassis-level design, not a component.

**Beat 4 — the point.** Same question — "how much heat, for how long?" — different right answer every time. Cooling isn't a component you pick once. It's a thermal budget you design around the workload. Get this question into your bones — you'll ask it for every build, every server spec, every "why is this thing slow" ticket for the rest of your career.

## Key facts

### Cooling solution types

| Type | How it works | Best for | Trade-off |
|---|---|---|---|
| **Passive heat sink** | Aluminum/copper fins, no fan, relies on chassis airflow | Low-TDP CPUs, servers with chassis fans, Raspberry Pi-class | Needs external airflow; useless without it |
| **Stock air cooler** | Small heatsink + fan, ships with CPU | Stock-clocked mainstream CPUs, office builds | Loud under load, no overclocking headroom |
| **Tower air cooler** | Large fin stack, heatpipes, 1–2 fans | Most enthusiast and gaming builds | Big — check case clearance and RAM height |
| **AIO liquid (120/240/280/360mm)** | Sealed pump-radiator loop | High-TDP gaming/workstation CPUs | Pump can fail, finite lifespan (~5–7 years) |
| **Custom liquid loop** | User-built reservoir, pump, radiator, blocks | Extreme builds, GPU+CPU loops | Expensive, requires maintenance, leaks possible |
| **Server fan walls** | Front-to-back high-RPM small fans through chassis | 1U/2U rack servers | Loud as a jet engine — never deploy in a quiet room |

### Thermal interface materials

- **Thermal paste** — viscous compound, applied between CPU IHS and cooler cold plate. Standard for desktops. Reapply every 5–7 years or whenever the cooler is removed.
- **Thermal pads** — pre-cut solid pads, common on VRMs, M.2 NVMe drives, GPU memory chips. Easier install, slightly worse performance than quality paste.
- **Liquid metal** — gallium-based, best thermal conductivity, electrically conductive. One drop on the motherboard and you've shorted the board. Reserved for delidding and laptop repastes by people who know what they're doing.

> **CompTIA exam trap:** Thermal paste is not optional and not reusable. The exam will ask "what should you do before reseating a heat sink?" Answer: clean off old paste with isopropyl alcohol (90%+) and apply fresh paste. Reusing dried-out paste is the wrong answer.

### Fan headers and connectors

| Header | Pins | Purpose |
|---|---|---|
| **CPU_FAN** | 4-pin PWM | Mandatory — BIOS halts boot if empty |
| **CPU_OPT** | 4-pin PWM | Secondary CPU fan (push-pull) or AIO second fan |
| **CHA_FAN / SYS_FAN** | 4-pin PWM | Case fans |
| **AIO_PUMP / W_PUMP** | 4-pin, full-speed | AIO/custom loop pump — needs constant max RPM |

3-pin fans plug into 4-pin headers fine — they just lose PWM control and run via voltage modulation instead.

### Temperature monitoring

The CPU has on-die thermal sensors read by the BIOS/UEFI and the OS. Tools to know:
- **BIOS/UEFI hardware monitor** — shows CPU temp, fan RPM, system temp at the firmware level
- **HWiNFO64, Core Temp, HWMonitor** — Windows tools for live temp/clock/voltage
- **`sensors` (Linux)** — same thing, command-line, after installing `lm-sensors`
- **iDRAC / iLO / IPMI** — out-of-band management for servers, monitors temps even when the OS is dead

Idle temps under 50°C, load temps under 85°C is the rough healthy band for desktop CPUs. Servers run hotter by design and have wider tolerance.

### CompTIA exam traps

> **Trap 1:** "Liquid cooling is always better than air." False. A $90 Peerless Assassin matches or beats a $130 240mm AIO on most CPUs and never has a pump to fail. CompTIA may frame liquid as the "premium" answer — read the scenario. If sustained extreme TDP is mentioned, liquid wins. Otherwise air is often correct.

> **Trap 2:** Confusing thermal paste with thermal pads. Pads are pre-cut solid, used on VRMs/NVMe/GPU memory. Paste is liquid-ish, used on CPU IHS. They are not interchangeable in an exam scenario.

> **Trap 3:** "The fan is spinning, so cooling is fine." Fan spinning ≠ heat moving. Dead thermal paste, clogged fins, blocked intake — fan spins, chip cooks. Always verify with actual temperature readings.

> **Trap 4:** Plugging the AIO pump into a CPU_FAN header configured for PWM ramping. The pump needs full-speed constant power. Use AIO_PUMP or set the header to 100% in BIOS.

## Helpdesk reality

- **"My PC got slow over the past few months."** First check: open task manager, watch CPU clock speed under load. If it's clocking down to 1–2 GHz under stress, you're looking at thermal throttling. Pop the case, check for dust caked in the heat sink fins. Compressed air, not a vacuum (static discharge risk).
- **"It shuts off when I play games."** Almost always thermal. Either the cooler came loose, the paste is dead, or the case airflow is choked. Check temps with HWiNFO during a load test before you start replacing parts.
- **"It's so loud."** Fans at 100% means the BIOS is trying to save the chip from cooking. Loud fans are a symptom, not a problem to silence by lowering the fan curve. Find the heat source first.
- **Never promise a CPU swap will go cleanly without thermal paste on hand.** You pull the cooler, the paste is dried, you cannot reseat without fresh paste. If you don't have a tube in your kit, you don't have a complete kit.
- **Server rooms are cold for a reason.** If a user complains the server room is freezing, the answer is "yes, it has to be." Don't adjust HVAC to make people comfortable in there.

## Related concepts

[[CPU Architecture]] · [[Motherboard Form Factors]] · [[BIOS UEFI]] · [[Power Supplies]] · [[Cases and Airflow]] · [[Thermal Throttling]] · [[Server Hardware]] · [[Hardware Troubleshooting]]

*Source: VIRGIL knowledge base — 2026-05-10*