# DSL Digital Subscriber Line

## What it is

In DOTA, your courier hauls items from the fountain to your hero on the lane — same dirt road, but it carries gold-bought goods alongside the ordinary fountain traffic without anyone tripping over each other. That's exactly what DSL does — it shoves internet data over the same copper phone line your grandmother uses for voice calls, by running on frequencies the voice signal never touches.

**DSL** is a family of technologies that delivers broadband internet over the existing twisted-pair copper telephone loop by using frequencies above the 4 kHz voice band.

## Why it matters

DSL exists because telcos already had copper running into nearly every building on Earth — re-using it was cheaper than trenching fiber. The catch: signal attenuation on copper is brutal, so the further you sit from the **DSLAM** in the central office, the slower (or deader) your link. On the CCNA, DSL shows up as a WAN access technology paired with **PPPoE** encapsulation — expect questions on why you'd configure a dialer interface and where authentication happens.

## Key facts

### DSL flavors

| Variant | Down / Up | Typical reach | Use case |
|---|---|---|---|
| **[[ADSL]]** (Asymmetric) | ~24 Mbps / ~3 Mbps | ~5.5 km | Home users — more download than upload |
| **[[SDSL]]** (Symmetric) | ~2 Mbps / ~2 Mbps | ~3 km | Small business — equal up/down |
| **[[VDSL]]** / VDSL2 | ~100 Mbps / ~40 Mbps | ~1.2 km | Fiber-to-the-cabinet last-mile copper |

Asymmetric exists because residential users download far more than they upload (Netflix, web pages). Symmetric exists because businesses host things.

### Physical pieces

- **[[DSL modem]]** — also called a CPE or DSL transceiver. Modulates the digital signal onto high-frequency carriers on the copper pair. Connects to the **[[DSLAM]]** (DSL Access Multiplexer) at the telco central office.
- **[[DSL filter]]** (microfilter / splitter) — a low-pass filter on every phone jack that strips DSL frequencies (>25 kHz) so your analog phone doesn't hear screeching modem noise. Forget one filter and the entire line gets flaky.
- **[[DSLAM]]** — aggregates many subscriber lines, hands traffic off to the ISP's IP core.

### PPPoE encapsulation

DSL links typically run **[[PPPoE]]** (PPP over Ethernet, RFC 2516) so the ISP can authenticate, assign IPs, and bill per-session — the same mechanics as old dial-up, just over Ethernet framing.

Cisco config skeleton (router as PPPoE client):

```
interface dialer1
 encapsulation ppp
 ip address negotiated
 ppp authentication chap callin
 ppp chap hostname VIRGIL@isp
 ppp chap password 0 secret
 dialer pool 1
 mtu 1492
!
interface gigabitEthernet0/0
 no ip address
 pppoe enable
 pppoe-client dial-pool-number 1
```

Note the **MTU 1492** — PPPoE eats 8 bytes of overhead from the standard 1500. Forget this and you get black-hole fragmentation: pings work, large transfers hang.

### Distance limitations

DSL throughput decays with copper length. Rough rules:
- ADSL effective beyond ~5.5 km: not happening
- VDSL2 past ~1.2 km: collapses toward ADSL speeds
- Line quality (gauge, splices, bridge taps) matters as much as raw distance

### DSL vs cable vs fiber

| Trait | **DSL** | **Cable ([[DOCSIS]])** | **Fiber ([[GPON]] / [[FTTH]])** |
|---|---|---|---|
| Medium | Twisted-pair copper | Coaxial copper | Glass |
| Bandwidth | Per subscriber, dedicated to DSLAM | Shared with neighborhood node | Effectively unlimited |
| Typical down | 10–100 Mbps | 100 Mbps – 1 Gbps | 1–10 Gbps |
| Distance sensitivity | Severe | Moderate | Negligible |
| Contention | Low (point-to-point copper) | High (shared coax segment) | Low |
| Latency | 10–40 ms | 10–30 ms | 1–5 ms |

DSL's selling point was ubiquity, not speed. Cable beat it on raw throughput. Fiber beats both on everything except deployment cost — which is why DSL still exists in 2026 wherever the trenching never happened.

## Related concepts

[[PPPoE]] · [[PPPoA]] · [[DSLAM]] · [[DOCSIS]] · [[Metro Ethernet]] · [[MTU]] · [[CHAP]] · [[Dialer interface]] · [[Last mile]]

---
*Source: VIRGIL knowledge base — 2026-05-07*