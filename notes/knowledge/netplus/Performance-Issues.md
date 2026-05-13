# Performance Issues

## What it is

In **Tetris**, the board fills from the bottom up. You handle one piece per second at level 1, no problem. By level 15 the pieces are dropping faster than your fingers can place them, the stack creeps toward the ceiling, and a single misplaced S-piece leaves a hole you'll never clear. The game didn't break. It got *faster than your capacity to keep up*. That's exactly what a network performance issue is — the wire is intact, the routers are alive, packets are flowing, but the rate of demand has outpaced the rate of service, and something in the stack is about to top out.

In N10-009 terms, **performance issues** are degradations in throughput, latency, jitter, or packet delivery that occur *without a hard outage*. The link is up. Ping replies. Users complain anyway. Objective 5.4 makes you diagnose this exact class of problem — the network that's technically working and practically unusable.

## Why it matters

Hard outages are easy. The link light is off, the cable is cut, the switch is dead — you find it, you fix it, ticket closed. Performance issues are the long tail of helpdesk hell. The VoIP call sounds like a robot. The Zoom freezes for two seconds every minute. The warehouse scanner disassociates from the AP every time the forklift drives past. The user says *"the internet is slow"* and means fifteen different things.

Objective 5.4 covers congestion, bottlenecking, wireless interference, signal degradation, channel overlap, latency, jitter, packet loss, roaming, and disassociation — every soft failure mode CompTIA can think of. Get good at this domain and you stop being the tech who reboots the switch and hopes. You become the one who runs `iperf`, reads the spectrum analyzer, and points at the microwave in the breakroom.

## Key facts

### The four horsemen: bandwidth, throughput, latency, jitter

These get confused on the exam constantly. Memorize the distinction.

| Term | What it measures | Unit | Tetris analogy |
|---|---|---|---|
| **Bandwidth** | Theoretical max capacity of the link | bps, Mbps, Gbps | The level cap of the game |
| **Throughput** | Actual data delivered per second | bps, Mbps, Gbps | Your real lines-per-minute |
| **Latency** | One-way (or round-trip) delay | ms | The lag between key press and piece moving |
| **Jitter** | Variation in latency | ms | Sometimes the piece moves instantly, sometimes 200ms later |

A gigabit link has 1 Gbps of [[Bandwidth]]. If you `iperf` it and get 340 Mbps, your **throughput capacity** is 340 — the other 660 are lost to duplex mismatch, CRC errors, congestion, or a host that can't push faster. Bandwidth is the pipe. Throughput is what actually flows.

*Latency you can play around. Jitter destroys you.* A consistent 80ms ping in a shooter is survivable. A ping that swings 20→180→40→220 makes every shot a guess. Same principle for VoIP — codecs handle steady delay with a jitter buffer; they choke on variance.

### Packet loss

Packets the destination never sees. Causes:

- **Congestion** — the queue at an interface overflows and the router tail-drops
- **CRC errors** — bad cable, EMI, failing SFP
- **Duplex mismatch** — one side full, one side half, collisions on every transmission
- **MTU mismatch** — fragmentation dropped by a firewall, especially with DF bit set
- **Wireless** — collisions, interference, weak signal

Acceptable loss: **0% for TCP-sensitive apps, <1% for VoIP, <0.1% for real-time gaming.** [[TCP]] retransmits and recovers slowly because of congestion control — even 2% loss can collapse a TCP session's throughput. [[UDP]] just keeps going and the application has to cope.

### Congestion and bottlenecking

**Congestion** is too much traffic for the available capacity at a specific point. **Bottlenecking** is the same idea but framed as *the slowest link defines the path*. A 10 Gbps core uplink with a 100 Mbps access switch underneath is bottlenecked at 100 Mbps no matter how fat the core is.

Common bottleneck points:

- WAN uplink (the ISP handoff is almost always the narrowest pipe)
- Inter-VLAN routing on a router that's CPU-bound
- A single shared SSID with 60 clients on one AP
- A trunk port from access to distribution that someone forgot to LAG
- The firewall's deep-inspection throughput (the spec sheet's "firewall throughput" and "threat-prevention throughput" are different numbers)

Fix with [[QoS]] (prioritize voice/video), traffic shaping, link aggregation ([[LACP]]), capacity upgrades, or offloading inspection to dedicated hardware.

### Wireless — where most performance complaints live

Wireless has its own ecosystem of failures because it's a shared, half-duplex, RF-contested medium pretending to be Ethernet.

#### Interference

- **Co-channel interference** — two APs on the same channel within earshot back off for each other (CSMA/CA). Throughput halves.
- **Adjacent-channel interference** — APs on overlapping channels (2.4 GHz channel 3 and 6) collide and corrupt frames.
- **Non-Wi-Fi interference** — microwaves (2.4 GHz, classic), Bluetooth, cordless phones, baby monitors, fluorescent lights, the elevator motor next to the AP.

#### Channel overlap

> **CompTIA exam trap:** 2.4 GHz has only **three non-overlapping channels — 1, 6, and 11.** Every other channel overlaps. If a question shows a site survey with APs on channels 1, 4, 8, 11 — channels 4 and 8 are the problem. 5 GHz has many non-overlapping 20 MHz channels but bonding to 40/80/160 MHz reduces them; in dense deployments use 20 or 40 MHz, not 80+.

#### Signal degradation and insufficient coverage

Signal weakens with distance (free-space path loss) and obstacles. Concrete walls eat 2.4 GHz; metal eats everything; water (including humans) eats 2.4 GHz especially. **Insufficient wireless coverage** shows up as users in the far corner reporting slow Wi-Fi while the AP itself reports fine throughput.

Measure with **RSSI** (received signal strength) and **SNR** (signal-to-noise ratio). Rough targets:

- RSSI better than **-65 dBm** for voice, **-70 dBm** for data
- SNR **>25 dB** for voice, **>20 dB** for data

Below those, modulation rates drop (the radio falls back from 256-QAM to 64-QAM to 16-QAM to BPSK), and throughput collapses even though "the bars look fine."

#### Client disassociation and roaming misconfiguration

A client **disassociates** when it loses the AP — signal too weak, AP rebooted, idle timeout, or the client decided another AP looked better. **Sticky clients** hold onto a distant AP at -80 dBm even when a closer AP is at -50 dBm, because most clients don't roam until the current connection is genuinely failing.

**Roaming misconfiguration** issues:

- APs configured with **different SSIDs per AP** — clients see them as separate networks and don't roam
- **Mismatched security** (one AP on WPA2, one on WPA3) — client re-auths from scratch
- **No 802.11k/v/r** — k advertises neighbor APs, v steers clients, r enables fast BSS transition. Without them, every roam is a full re-auth (~300-500ms, enough to drop a VoIP call)
- **Min RSSI / band steering** not tuned — APs either kick clients too aggressively or let them stick forever

*The right roam is invisible. The wrong roam ends your call.*

### Latency budgets by application

| Application | Latency tolerance | Jitter tolerance | Loss tolerance |
|---|---|---|---|
| Web browsing | <300ms | High | <1% |
| VoIP | <150ms one-way | <30ms | <1% |
| Video conferencing | <200ms | <50ms | <1% |
| Real-time gaming | <50ms | <10ms | <0.1% |
| Bulk file transfer | Doesn't care | Doesn't care | <0.01% (TCP) |

If a user says "Zoom is bad" and ping to the gateway is 4ms, the problem isn't local — it's upstream. Run `traceroute` and find where latency spikes.

### CompTIA exam traps

> **CompTIA exam trap:** **Bandwidth ≠ throughput.** A "1 Gbps link running at 400 Mbps" doesn't mean the bandwidth is 400 Mbps. Bandwidth is the spec; throughput is the measurement. If the question asks what tool measures actual throughput, the answer is `iperf` (or `iperf3`), not a speed test website.

> **CompTIA exam trap:** **Jitter and latency are not the same thing.** A VoIP call with high latency but low jitter is annoying but understandable. A VoIP call with low average latency but high jitter is unintelligible. The fix for jitter is a jitter buffer at the receiver and [[QoS]] marking in transit, not "more bandwidth."

> **CompTIA exam trap:** When a wireless question lists "channels 1, 6, 11" in a 2.4 GHz deployment, that's the *correct* design, not the problem. The problem is the AP on channel 4 next door, or the microwave, or the rogue AP someone plugged in under their desk.

> **CompTIA exam trap:** Roaming problems usually look like "client drops connection when walking through the building." The cause is almost never AP failure — it's the client being sticky, mismatched SSID configs across APs, or the absence of 802.11r fast transition.

## Helpdesk reality

- **"The internet is slow"** means absolutely nothing. Ask: slow how? Loading web pages? Just one site? Video calls? Downloads? File shares on the LAN? You're triaging *where* the bottleneck is before you touch anything.
- **First check is always local.** Ping the default gateway. If that's slow or lossy, the problem is between the user and the first hop — cable, NIC, Wi-Fi signal, local switch. If the gateway is fine, ping 8.8.8.8. If that's fine but `nslookup` is slow, it's DNS, not "the internet."
- **Wi-Fi complaints get a signal check before anything else.** Ask the user to look at their bars. Better, have them run a Wi-Fi analyzer app and report RSSI. -50 dBm is great. -75 dBm is the problem. You don't need to "boost the signal" — you need another AP or the user closer to the existing one.
- **Never promise a fix window for performance issues.** Hard outages have clear fixes. Performance issues can take hours of `iperf`, `traceroute`, packet captures, and vendor support calls. Tell the user you'll investigate, document findings, and update them — don't tell them it'll be 15 minutes.
- **Escalate when the path leaves your control.** If `traceroute` shows the latency spike three hops into the ISP, that's a carrier ticket, not yours. Document what you found, hand it off, and stop spinning your wheels trying to fix a router you don't own.

## Related concepts

[[Latency]] · [[Jitter]] · [[Packet Loss]] · [[Bandwidth]] · [[Throughput]] · [[QoS]] · [[Wireless Standards]] · [[Wireless Site Survey]] · [[RSSI and SNR]] · [[Channel Overlap]] · [[802.11k-v-r Roaming]] · [[CSMA-CA]] · [[Network Congestion]] · [[Duplex Mismatch]] · [[iperf]] · [[Traceroute]] · [[Troubleshooting Methodology]]

*Source: VIRGIL knowledge base — 2026-05-11*