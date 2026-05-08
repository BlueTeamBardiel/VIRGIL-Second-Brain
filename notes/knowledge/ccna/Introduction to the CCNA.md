# Introduction to the CCNA

## What it is

In Battlefield, you don't spawn into Operation Metro on day one and lead a 64-player squad assault. You hit basic training first — learn to ADS, throw a grenade without killing your squad, drive a tank in a straight line. That's exactly what the CCNA does. It's the boot camp Cisco makes you clear before they trust you near the enterprise battlefield where [[CCNP]] and [[CCIE]] engineers are calling in airstrikes on production networks.

Officially, CCNA is Cisco's foundational networking certification, validated by passing exam **200-301**. The exam is a 120-minute gauntlet covering everything from how a cable carries bits to how Python scripts can yell at a router. Pass it, and you've got a 3-year shelf life before you need to recertify or move up the ladder.

## Why it matters

Treat the CCNA like the Helldivers 2 basic training mission — skipping it is technically possible, but you'll get melted the moment a real bug hive (a production network outage at 2 AM) shows up. Every concept stacks: VLANs depend on switching, routing depends on IP, security depends on all of it. CCNA forces you to build that stack in order.

Practically, it's also the price of admission for most network engineer job postings. Entry-level roles with a CCNA pay roughly **$50–65k USD**, and once you've got 2–3 years of hands-on time, that climbs to **$70–90k**. Not a fortune, but a real on-ramp into infrastructure work.

## Key facts

### Exam logistics
- **Exam code:** 200-301
- **Duration:** 120 minutes — pacing matters, especially because simulations eat clock time like a Tarkov raid eats your loadout
- **Cost:** ~$330 USD
- **Passing score:** ~825/1000, which works out to roughly **68–70% correct**
- **Validity:** 3 years from pass date — your cert has a respawn timer
- **Question types:** multiple choice, multiple select, drag-and-drop, and **simulations** (mini Cisco IOS environments where you actually type commands — no guessing your way through these)

### Six exam domains (the skill tree)
Think of these as the six branches of a Cyberpunk 2077 perk tree. You can't just dump points into one.

| Domain | Weight |
|---|---|
| Network Fundamentals | 20% |
| Network Access | 20% |
| IP Connectivity | 25% |
| IP Services | 10% |
| Security Fundamentals | 15% |
| Automation and Programmability | 10% |

IP Connectivity is the heaviest single domain — routing protocols pull the most weight on the scoreboard.

### Recommended study budget
Total time: **200–250 hours over 2–3 months**. Treat it like a raid prep schedule:
- **Videos:** ~40 hours — your overview pass, like watching a build guide before respeccing
- **Textbook:** **80+ hours** — the heaviest single bucket, because reading is where the deep mechanics actually stick
- **Labs:** **60+ hours** — Packet Tracer or CML, this is your training range
- **Practice exams:** **20+ hours** — scrim mode before the real match

Skip labs and you'll fail the simulations. Guaranteed.

### Core IOS commands you'll live and die by
The Cisco CLI has modes nested like menus in a fighting game — you start in user mode, drill into privileged, then deeper into config. The **prompt itself tells you where you are**, the same way the corner of your screen in Watch Dogs 2 tells you whether you're in hacking mode or just walking around.

- `Router>` — user EXEC (look but don't touch)
- `Router#` — privileged EXEC
- `Router(config)#` — global configuration
- `Router(config-if)#` — interface configuration

Key commands:
- `enable` — jumps from user EXEC into **privileged EXEC mode** (the `#` prompt)
- `configure terminal` — drops you into **global configuration mode**
- `interface <name>` — enters **interface configuration mode** for a specific port
- `ip address <addr> <mask>` — assigns an IPv4 address to that interface
- `no shutdown` — enables the interface (Cisco interfaces ship disabled by default, like a weapon you have to manually equip)
- `show version` — IOS version and device info, your character sheet
- `show running-config` — the live, in-RAM config currently running the box
- `show startup-config` — the config stored in NVRAM that loads on boot
- `copy running-config startup-config` — saves your work; forget this and a power cycle wipes your changes like quitting Dark Souls without resting at a bonfire

### Password commands (and why one is a trap)
- `enable password` — stores the password in **plaintext** inside the config file. Anyone with `show running-config` access reads it directly. Avoid.
- `enable secret` — stores the password as an **MD5 hash by default (type 5)**. Still not modern-strong, but vastly better than plaintext.

If both are configured, `enable secret` wins.

### Switching vs routing fundamentals
- **Ethernet operates at OSI Layer 2 (Data Link)** — the layer where MAC addresses live
- **Switches learn MAC addresses dynamically** by watching source MACs on incoming frames and building a CAM table — like Among Us players quietly noting who came out of which vent
- **Routers do not depend on MAC address learning** — they forward based on Layer 3 IP routing tables instead. MACs only matter for the next-hop handoff, not the routing decision itself.

## Related concepts
[[OSI Model]] · [[Cisco IOS CLI Modes]] · [[VLANs]] · [[OSPF]] · [[MAC Address Table]] · [[Subnetting]] · [[Packet Tracer and CML]] · [[CCNP Enterprise]] · [[Network Automation with Python]]