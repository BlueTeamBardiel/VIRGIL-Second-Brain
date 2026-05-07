# Cables, Connectors, and Ports

## What it is

The physical loadout of networking. Just like a Tarkov raid where your armor, ammo type, and weapon attachments determine whether you survive contact, the cables and connectors you pick determine whether your packets actually arrive — and how fast. A Cat 5 cable trying to push 10 Gbps is the networking equivalent of bringing a Makarov to a Labs run.

At the physical layer, you have three main weapon classes:

- **Copper UTP/STP** — twisted pairs of copper wire carrying electrical signals. Cheap, flexible, distance-limited.
- **Fiber-optic** — glass strands carrying pulses of light. Expensive, fast, immune to interference, goes the distance.
- **Connectors and ports** — the mating interfaces (RJ45, LC, SC, etc.) that physically click cables into switches, NICs, and patch panels.

## Why it matters

Pick the wrong cable and the link either doesn't come up, comes up at a humiliating speed, or works fine until someone fires up a microwave nearby and your link starts flapping. A datacenter run over fiber doesn't care about the EMI from the chiller next door; a copper run through the same path might drop frames every time the compressor kicks on.

Cables are also where troubleshooting almost always starts. Layer 1 problems wear costumes — they look like DNS issues, app slowness, mystery latency spikes. Knowing the physical media saves hours of staring at Wireshark.

## Key facts

### Twisted-pair copper (UTP / STP)

- **UTP = Unshielded Twisted Pair.** Four pairs of copper wire twisted together inside plastic. The twist itself is the magic — opposite twisting cancels electromagnetic noise and crosstalk between pairs, the same way noise-cancelling headphones use an inverted waveform to kill outside sound.
- **STP = Shielded Twisted Pair.** Same idea but wrapped in metal foil/braid. Bulkier, pricier, harder to bend, but survives in noisy environments (factory floors, near heavy electrical gear).
- **100 meters max** for any copper Ethernet run. Past that, signal attenuation turns your packets into mush.

### Cat ratings — the cable's "gear score"

| Category | Speed | Frequency |
|----------|-------|-----------|
| Cat 3 | 10 Mbps | 16 MHz |
| Cat 4 | 16 Mbps | 20 MHz |
| Cat 5 | 100 Mbps | 100 MHz |
| Cat 5e | 1 Gbps | 100 MHz |
| Cat 6 | 1 Gbps | 250 MHz |
| Cat 6A | 10 Gbps | 500 MHz |
| Cat 7 | 10 Gbps | 600 MHz |

Higher Cat = tighter twists, better insulation, higher signaling frequency. Cat 6A only does 10 Gbps for **55 meters** of the 100m budget unless it's properly shielded — the one exception to the 100m rule.

### IEEE 802.3 standards (which cable does what)

- **802.3** — 10 Mbps / 100m / Cat 3 or 4
- **802.3u** — 100 Mbps / 100m / Cat 5 (Fast Ethernet)
- **802.3ab** — 1 Gbps / 100m / Cat 5e or 6 (Gigabit Ethernet)
- **802.3an** — 10 Gbps / 55m / Cat 6A (10GBASE-T)

### Pinouts: straight-through vs crossover

- **TIA/EIA-568B pin order:** orange-white, orange, green-white, blue, blue-white, green, brown-white, brown. Memorize this one — it's the de facto standard.
- **Straight-through:** 568B on both ends. Same color order on each connector. Used between *different* device types (PC ↔ switch, switch ↔ router).
- **Crossover:** 568A on one end, 568B on the other. Used between *same* device types (switch ↔ switch, PC ↔ PC). Like a 1v1 mirror match — both sides need their TX and RX swapped or they'll both shout into the void at the same time.
- **MDI-X auto-sensing:** modern switches just figure it out. The port silently swaps pairs internally if it detects you used the wrong cable. Crossover cables are basically museum pieces now.

### Fiber-optic

Fiber is the "endgame loadout." Instead of pushing electrons down copper, it pulses LED or laser light down a glass strand. Light doesn't care about your fluorescent ballast or the radio tower across the street.

- **Immune to EMI and RFI** — no electrical signal to interfere with.
- **Core diameter:** 8–50 microns (a human hair is ~70 microns for reference).
- **Cladding** — outer glass layer with a *lower refractive index* than the core. This is what makes fiber work: light hitting the boundary at a shallow angle gets totally internally reflected, bouncing down the cable instead of leaking out. Same principle as a glow stick trapping light along its length.
- **Buffer coating** — plastic jacket protecting the glass from scratches and bending damage.
- **Strength members** — aramid fibers (Kevlar family) running alongside the glass so the cable doesn't snap when someone yanks it.

**Single-mode (SMF):**
- Core: 8–10 microns
- Distance: **100+ km**
- Uses laser, one path of light
- More expensive
- Long-haul, between buildings, ISP backbones

**Multimode (MMF):**
- Core: 50–62.5 microns
- Distance: up to **2 km**
- Uses LED, multiple light paths
- Cheaper
- Datacenter, within-building runs

### Fiber connectors

- **LC** — small, latches like an RJ45. The default for modern high-speed gear. If you're plugging in an SFP today, it's almost certainly LC.
- **SC** — square, push-pull. Bigger, older, still common.
- **ST** — round, twist-lock bayonet (think old-school camera lens mount). Legacy.
- **MPO** — multi-fiber in a single connector, often 12 or 24 strands. Used for 40G/100G breakouts where you need a bundle of parallel lanes, like running multiple Discord voice channels through one ribbon cable.

### Cisco port naming

The port label tells you the speed ceiling:

- **Fa0/0, Fa0/1** — Fast Ethernet (100 Mbps)
- **Gi0/0, Gi0/1** — Gigabit Ethernet (1 Gbps)
- **Te0/0, Te0/1** — Ten Gigabit Ethernet (10 Gbps)

Format is `Type Slot/Port`. `Gi0/24` = the 24th gigabit port on slot 0.

### Duplex

- **Full-duplex** — send and receive simultaneously, no collisions. Like a Discord voice call where everyone can talk at once without cutting each other off.
- **Half-duplex** — take turns. If both sides talk at once, that's a collision and both have to back off and retry. Walkie-talkie behavior. Hub territory, basically extinct.
- **Autonegotiation** — both sides advertise their capabilities and pick the highest common denominator for speed and duplex. Modern best practice: leave it on both ends. Hard-coding one side and not the other is a classic way to create a duplex mismatch — the link "works" but throughput tanks under load.

### Standards bodies

- **TIA/EIA-568** — defines copper cabling categories and pinouts.
- **IEEE** — defines Ethernet itself under the 802.3 family.

## Related concepts

[[Ethernet Frame Structure]]
[[OSI Physical Layer]]
[[SFP and SFP+ Transceivers]]
[[Collision Domains and Broadcast Domains]]
[[Auto-MDIX]]
[[Structured Cabling and Patch Panels]]
[[PoE (Power over Ethernet)]]
[[Attenuation and Crosstalk]]
[[Duplex Mismatch Troubleshooting]]