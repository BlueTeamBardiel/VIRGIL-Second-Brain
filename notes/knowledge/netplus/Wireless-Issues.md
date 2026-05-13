# Wireless Issues

## What it is

In **Escape from Tarkov**, you're holding an angle on Customs near Big Red. Your teammate is calling contacts on comms, but his voice cuts in and out — half his words drop, then a full second of silence, then "...behind you" arrives two seconds late. You die. He swears it was clear on his end. The radio worked fine in the dorms. But in this exact spot, between two concrete buildings with another squad's radios stomping on the same frequency, the signal is garbage.

That's exactly what a misbehaving wireless network does — the medium is shared, invisible, and unforgiving, and the symptoms upstairs (lag, drops, disconnects) almost never tell you what's actually broken downstairs.

Technically: wireless troubleshooting is the process of identifying performance and connectivity faults in 802.11 networks by isolating RF-layer problems (interference, signal strength, channel contention) from L2 problems (association, roaming, authentication) from L3+ problems ([[Latency]], [[Packet Loss]], [[Jitter]], DHCP, DNS). The exam wants you to know which symptom points to which layer, and which fix applies where.

## Why it matters

Wi-Fi is where 80% of your help desk tickets live. Users don't say "I'm experiencing a 5 GHz coverage shadow in conference room B" — they say "the internet is slow." Your job is to translate. Objective N10-009 5.4 explicitly lists wireless-adjacent failures (interference, channel overlap, signal degradation, insufficient coverage, client disassociation, roaming misconfiguration) because CompTIA knows this is the domain where new techs get destroyed. RF is invisible. You can't trace a bad signal with a cable tester. You need a mental model, a site survey tool, and the discipline to check L1 before blaming the ISP.

**Wireless is the network's nervous system extending into open air.** Same packets as copper and fiber, but the medium is shared with every microwave, every neighbor's AP, every Bluetooth headset, and every Wi-Fi camera in the building. Treat RF as hostile by default.

## Key facts

### The big six wireless symptoms

| Symptom | RF cause | Config cause | Where to check |
|---|---|---|---|
| Slow throughput | Interference, low SNR | Old standard (802.11g), wide channel on 2.4 GHz | Client signal/noise, AP channel width |
| Dropped connection | Coverage hole, signal loss | Roaming misconfig, auth timeout | Heatmap, AP logs, client logs |
| High latency/jitter | Contention, retries | QoS missing, overloaded AP | Client retry rate, AP client count |
| Can't connect at all | Out of range | Wrong PSK, MAC filter, DHCP exhausted | Association logs, DHCP scope |
| Connects then drops | Sticky client, weak signal | Roaming thresholds, band steering | Client RSSI history |
| Intermittent everything | Co-channel/adjacent interference | Channel overlap | Spectrum analyzer |

### Channel overlap — the 2.4 GHz tax

**2.4 GHz has only three non-overlapping channels: 1, 6, and 11.** This is the most-tested wireless fact on N10-009. Every other channel overlaps with its neighbors and causes adjacent-channel interference, which is worse than co-channel because the AP and client can't even back off politely — they just stomp on each other.

- **2.4 GHz**: 1, 6, 11 only. 20 MHz channels. Long range, terrible throughput, crowded.
- **5 GHz**: ~24 non-overlapping 20 MHz channels (region-dependent). 40/80 MHz widths possible. Shorter range, much higher throughput, less crowded.
- **6 GHz (Wi-Fi 6E/7)**: 59 new 20 MHz channels. Pristine, but only newer clients can see it.

> **CompTIA exam trap:** If the question asks how many non-overlapping channels exist on 2.4 GHz, the answer is **3** (1, 6, 11). CompTIA will list channel 4 or 9 in the answer choices to bait you.

### Interference sources

Two flavors, and the fix is different for each:

- **RF interference (non-Wi-Fi)** — microwaves, Bluetooth, cordless phones, wireless cameras, fluorescent ballasts. Hits 2.4 GHz hardest. Find with a **spectrum analyzer** (Wi-Fi analyzers only see beacons — they can't see non-802.11 noise).
- **Co-channel/adjacent-channel interference (Wi-Fi-on-Wi-Fi)** — your AP and the neighbor's AP on the same or overlapping channel. Find with a Wi-Fi analyzer app. Fix by changing channel or reducing transmit power.

*I learned this the hard way: a client complained about Wi-Fi dropping every weekday at 12:15pm. It was the microwave in the breakroom on the other side of the wall. Spectrum analyzer found it in 30 seconds. A Wi-Fi analyzer would have shown nothing wrong.*

### Signal degradation and coverage

**RSSI** (Received Signal Strength Indicator) is measured in negative dBm. Closer to zero = stronger.

| RSSI | Quality | What works |
|---|---|---|
| -30 to -50 dBm | Excellent | Everything |
| -50 to -65 dBm | Good | HD video, VoIP |
| -65 to -75 dBm | Fair | Web, email, degraded video |
| -75 to -85 dBm | Poor | Barely associates, constant retries |
| < -85 dBm | Useless | Will not stay connected |

**SNR** (signal-to-noise ratio) matters more than raw signal. -65 dBm with a -90 dBm noise floor (25 dB SNR) works fine. -65 dBm with a -70 dBm noise floor (5 dB SNR) is unusable.

**Insufficient coverage** = dead zones. The fix is not "boost the AP power." Cranking transmit power makes the AP shout louder but the *client* (a phone with a tiny antenna) can't shout back. You get asymmetric coverage — the client hears the AP but the AP can't hear the client. **Add more APs, don't crank power.**

### Bandwidth, throughput, and the contention tax

**Bandwidth** = theoretical max the standard supports (Wi-Fi 6 ≈ 9.6 Gbps aggregate). **Throughput** = what you actually get. The ratio is brutal on wireless because:

- Wireless is **half-duplex** and shared — only one device transmits at a time per channel (CSMA/CA).
- Every client transmitting subtracts from every other client's airtime.
- A single slow legacy client (802.11g at 54 Mbps) hogs airtime that fast clients (Wi-Fi 6 at 600+ Mbps) could have used. This is the **slow-client penalty**.
- Retries from weak-signal clients eat airtime that successful transmissions could have used.

**Bottlenecking on wireless usually isn't the AP's uplink** — it's the air. A gigabit backhaul does nothing if 40 clients are fighting for 2.4 GHz airtime.

### Latency, jitter, and packet loss on wireless

Same definitions as wired, but wireless makes all of them worse:

- **Latency** spikes during retries. A bad packet gets retransmitted at L2 before TCP even notices.
- **Jitter** is brutal for VoIP and game traffic. A client with 5% retry rate will have wildly inconsistent ping.
- **Packet loss** at the RF layer triggers L2 retries (good — TCP doesn't see it) until retries are exhausted, at which point the packet is dropped and TCP backs off (bad).

If a user reports Teams calls cutting out, check the client's retry rate and RSSI before blaming the WAN.

### Client disassociation and roaming misconfiguration

**Disassociation** = the AP and client lose the L2 relationship. Causes: weak signal, 802.1X timeout, AP reboot or load-balance kick, DHCP renewal failure, or a **sticky client** glued to the original AP at -82 dBm instead of roaming to the AP it's standing next to at -45 dBm.

**Roaming misconfiguration** is the silent killer in any multi-AP deployment:

- **SSID mismatch** across APs — "CorpWiFi" vs "Corp-WiFi" = client treats them as different networks and won't roam.
- **Inconsistent security settings** — same SSID, different PSK or 802.1X config = roaming fails.
- **No 802.11r/k/v** — without fast roaming extensions, the client does a full re-auth at every roam, causing 1–3 second gaps that destroy VoIP.
- **Wrong roaming threshold** — clients decide when to roam, not APs. Fix is on the client OS or, in enterprise, via **band steering** and **minimum RSSI** kicks (AP boots the client below -75 dBm so it's forced to find a better AP).

> **CompTIA exam trap:** Roaming is a *client-side decision* in standard 802.11. The AP can suggest (802.11v) and assist (802.11k neighbor reports), but cannot force most clients to roam. The exam answer for "client stays on weak AP" is rarely "reboot the AP" — it's usually "configure minimum RSSI" or "verify consistent SSID/security across APs."

### Congestion and contention

**Congestion** = too much traffic for available bandwidth. **Contention** = too many devices fighting for airtime. Wireless suffers from both simultaneously. A 50-user conference room on one AP isn't a bandwidth problem — it's a contention problem. The fix is more APs with lower power, not a fatter pipe.

### CompTIA exam traps

> **CompTIA exam trap:** "Slow Wi-Fi" with a strong signal almost always points to **channel overlap or interference**, not coverage. Strong RSSI + low throughput = something else is on your channel. Weak RSSI + low throughput = coverage problem. The exam will give you the RSSI value — read it.

> **CompTIA exam trap:** If a user can connect at their desk but drops in the conference room, the answer is **insufficient coverage**. If they can connect in both places but the connection drops *while walking between them*, the answer is **roaming misconfiguration**.

> **CompTIA exam trap:** 5 GHz has more channels and less interference but **shorter range** than 2.4 GHz. CompTIA will offer "switch all clients to 5 GHz" as a fix for coverage problems — it's wrong. 5 GHz fixes congestion, not coverage.

## Helpdesk reality

- User says: *"The Wi-Fi is down."* What they mean: their laptop won't load one specific website, or the printer is offline, or they're in a known dead zone. Confirm the scope before touching anything — *one user, one floor, or the whole building?*
- First check is always **the link** — are they associated to an AP? What's the RSSI? On Windows: `netsh wlan show interfaces`. On macOS: option-click the Wi-Fi icon. If RSSI is worse than -75 dBm, you have a physical-world problem, not a config problem.
- Never promise "I'll fix the Wi-Fi by 2pm." RF problems require site surveys, channel planning, sometimes new AP placement. *The cable doesn't care about your SLA, and neither does a microwave oven.*
- If three users on the same AP all complain at once, it's the AP. If three users on three different APs complain at once, it's upstream (DHCP, DNS, controller, WAN). Pattern-match before you escalate.
- Escalation point: once you've confirmed RSSI is acceptable, channel is clean, and the client is associated with a good IP — and it's still broken — open a ticket with the network team. Include client MAC, AP MAC, RSSI, retry rate, and timestamps. *Don't show up with "Wi-Fi is slow." Show up with evidence.*

## Related concepts

[[Wireless Standards]] · [[Wireless Security]] · [[2.4 GHz vs 5 GHz vs 6 GHz]] · [[RSSI and SNR]] · [[Site Survey]] · [[Latency]] · [[Jitter]] · [[Packet Loss]] · [[QoS]] · [[802.1X]] · [[DHCP]] · [[Troubleshooting Methodology]]

*Source: VIRGIL knowledge base — 2026-05-11*