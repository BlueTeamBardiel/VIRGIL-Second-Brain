# Wireless Network Technologies

## What it is

You've watched your Wi-Fi crawl when the microwave runs. Same band, same airspace, two devices yelling over each other. That's wireless networking in one sentence: every device in range is sharing the same finite chunk of radio spectrum, and the protocols are the rules they use to take turns without trampling each other.

Plain English: wireless tech sends data as radio waves through the air at specific frequencies. Different standards (Wi-Fi, Bluetooth, NFC, RFID) use different frequency bands and different rules for how devices find each other, authenticate, and exchange data. The band determines range and speed tradeoffs. The standard determines how the conversation works.

Technical: wireless networking is the **voice and ears** of any modern device — the network stack converted into modulated radio energy at FCC-allocated frequencies. The IEEE 802.11 family covers Wi-Fi (2.4 GHz, 5 GHz, 6 GHz). Bluetooth lives at 2.4 GHz with frequency hopping. NFC operates at 13.56 MHz at touch range. RFID spans multiple bands depending on use case. Each is regulated by the FCC in the US and equivalent bodies internationally — you cannot legally transmit on any frequency you want at any power you want.

## Why it matters

Wireless is the default now. Ethernet still wins on latency and reliability, but most users never plug in. Every helpdesk ticket about "internet is slow" starts with you deciding: is this a Wi-Fi problem, an ISP problem, or a user-too-far-from-the-AP problem? You can't troubleshoot what you don't understand.

CompTIA 220-1201 Objective 2.2 tests this directly. Expect questions about which 802.11 standard runs at which frequency, how channel selection prevents interference, the difference between Bluetooth class ranges, and what NFC can and cannot do. The exam loves the 2.4 vs 5 vs 6 GHz tradeoff and channel width questions.

Career relevance: Wi-Fi 6E and Wi-Fi 7 are rolling out across enterprise right now. The tech that put a 6 GHz radio in your phone in 2024 is hitting corporate APs in 2026. You will be the person explaining to a CFO why their conference room needs new access points.

## In your build, in the enterprise

**Beat 1 — Technical depth.** Wi-Fi runs on three bands: 2.4 GHz (long range, slow, crowded), 5 GHz (shorter range, fast, less crowded), and 6 GHz (Wi-Fi 6E and Wi-Fi 7 only, fastest, cleanest). Each band is divided into channels. 2.4 GHz has 11 usable channels in North America but only **3 non-overlapping** ones: 1, 6, and 11. 5 GHz has roughly 25 non-overlapping 20 MHz channels. 6 GHz adds another ~59 channels of clean spectrum. Channel width matters: wider channels (40, 80, 160, 320 MHz) push more data but eat more spectrum and are more vulnerable to interference. Modern 802.11 standards: Wi-Fi 4 (n, 2.4/5 GHz), Wi-Fi 5 (ac, 5 GHz only), Wi-Fi 6 (ax, 2.4/5), Wi-Fi 6E (ax extended to 6 GHz), Wi-Fi 7 (be, all three bands with 320 MHz channels and Multi-Link Operation).

**Beat 2 — Feynman example via gaming/personal build.**

**The 2.4 GHz problem:** You're playing Apex on Wi-Fi from the back bedroom. Your roommate microwaves leftovers. You start rubber-banding. *Microwaves leak at 2.4 GHz. So do baby monitors, old Bluetooth, cheap wireless cameras, and every neighbor's router from 2012. The band is a parking lot at noon.*

**Switch to 5 GHz:** Same router, different SSID, you connect to the 5 GHz radio. Latency drops, jitter drops. *Less range, but the apartment isn't that big and the signal punches through one wall fine.* Speed test goes from 80 Mbps to 600 Mbps.

**The 6 GHz upgrade:** You buy a Wi-Fi 6E router and a Wi-Fi 6E card for your PC. The 6 GHz band is brand-new spectrum — your neighbors' 2018 routers can't even see it. Empty highway. *160 MHz channels with no congestion equals gigabit-plus wireless to your desktop, which is genuinely shocking the first time you see it.*

**The catch:** 6 GHz range is shorter. Walk to the kitchen, your phone drops to 5 GHz automatically. *Higher frequency = more bandwidth, less penetration. Physics doesn't negotiate.*

**Beat 3 — Bridge from gaming to enterprise.** Same fundamental question — *which band serves which workload?* — different right answers across builds:

- **Gaming PC:** wired Ethernet if at all possible. If wireless, 5 GHz or 6 GHz, never 2.4. Latency over throughput.
- **Smart home / IoT devices:** 2.4 GHz on purpose. Range and wall penetration matter more than speed for a doorbell camera. Most cheap IoT can't even do 5 GHz.
- **Enterprise office:** dual-band or tri-band APs ceiling-mounted on a planned channel reuse pattern. 5 GHz primary for laptops, 2.4 GHz available for legacy devices, 6 GHz where the budget allows. A site survey decided every AP placement.
- **Warehouse / industrial:** 2.4 GHz for range. Forklift scanners need to roam half a football field; 5 GHz dies at that distance.

**Beat 4 — The point.** Same question — which band, which channel width, which standard — different workloads, different right answers. Get this question into your bones. You will ask it every time you spec, troubleshoot, or design a wireless deployment for the rest of your career.

## Key facts

### 802.11 standards

| Marketing name | IEEE | Band(s) | Max theoretical | Real-world note |
|---|---|---|---|---|
| Wi-Fi 4 | 802.11n | 2.4 / 5 GHz | 600 Mbps | First with MIMO. Still everywhere. |
| Wi-Fi 5 | 802.11ac | 5 GHz only | 6.9 Gbps | Workhorse of the 2015–2020 era. |
| Wi-Fi 6 | 802.11ax | 2.4 / 5 GHz | 9.6 Gbps | OFDMA, better in crowded environments. |
| Wi-Fi 6E | 802.11ax | + 6 GHz | 9.6 Gbps | Same standard, new spectrum. |
| Wi-Fi 7 | 802.11be | 2.4 / 5 / 6 GHz | 46 Gbps | 320 MHz channels, MLO, current enterprise rollout. |

Wi-Fi 5 (ac) is **5 GHz only**. CompTIA loves this question.

### Frequency bands and channel widths

| Band | Channel widths | Non-overlapping channels (NA) | Range | Speed |
|---|---|---|---|---|
| 2.4 GHz | 20, 40 MHz | 3 (1, 6, 11) | Long, penetrates walls | Slow |
| 5 GHz | 20, 40, 80, 160 MHz | ~25 | Medium | Fast |
| 6 GHz | 20, 40, 80, 160, 320 MHz | ~59 | Short | Fastest |

Wider channel = more data, but more chance of stepping on a neighbor's signal. In dense apartment buildings you sometimes deliberately *shrink* channel width to escape congestion.

### Channel selection

On 2.4 GHz, only 1, 6, and 11 don't overlap. Anything else creates partial collision with adjacent channels. Auto-channel works most of the time; in dense environments, manually pick the cleanest one with a Wi-Fi analyzer app. On 5 GHz and 6 GHz, channels are wider but there are so many that auto-channel usually does fine.

> **CompTIA exam trap:** "Channels 1, 6, and 11" is the answer for 2.4 GHz non-overlapping channels in North America. Memorize it. Other regions have different counts (Japan has channel 14 for 11b only, Europe goes to 13). The exam defaults to North America unless it says otherwise.

### Bluetooth

Operates at **2.4 GHz** in the same ISM band as Wi-Fi, but uses **adaptive frequency hopping** — it skips between 79 narrow channels 1,600 times per second to avoid colliding with Wi-Fi and microwaves. Range classes:

| Class | Power | Range |
|---|---|---|
| Class 1 | 100 mW | ~100 m |
| Class 2 | 2.5 mW | ~10 m (most phones, headphones) |
| Class 3 | 1 mW | ~1 m |

Bluetooth versions 5.0+ added BLE (Bluetooth Low Energy) for IoT devices and longer range modes. Pairing requires both devices in discoverable mode, then a PIN or numeric confirmation. Regulations: same FCC Part 15 unlicensed rules as Wi-Fi 2.4 GHz — anyone can transmit, no license required, but you must accept interference and not cause harmful interference.

### NFC (Near Field Communication)

13.56 MHz, range of about **4 cm**. That short range is the security feature, not a bug. Used for tap-to-pay (Apple Pay, Google Pay), pairing shortcuts, employee badge readers, transit cards. Data rates are tiny (424 kbps max) — NFC isn't for transferring files, it's for authenticating an intent. Tap your badge, the door reads it, the AC system grants access.

> **CompTIA exam trap:** NFC's defining trait is short range (~4 cm). If a question asks which wireless tech is best for tap-to-pay or proximity authentication and limits the answer by range, it's NFC. Bluetooth has more range, more bandwidth, but is the wrong answer here.

### RFID (Radio Frequency Identification)

| Band | Frequency | Range | Use case |
|---|---|---|---|
| LF | 125–134 kHz | <10 cm | Animal tags, old building access |
| HF | 13.56 MHz | <1 m | Smart cards, library books, NFC is HF RFID |
| UHF | 860–960 MHz | up to 12 m | Inventory, retail anti-theft, supply chain |

NFC is technically a subset of HF RFID with two-way communication. Passive RFID tags have no battery — they're powered by the reader's RF field. Active tags have batteries and broadcast. UHF RFID is what scans every pallet entering an Amazon warehouse.

### Consumer vs enterprise

**At home:** one router, one or two SSIDs, auto-channel, WPA3 if you're lucky and the firmware supports it. You set it up once and forget it until something breaks.

**In an enterprise environment, this changes:** a wireless deployment starts with a **site survey** — a tech walks the floor with a heatmapping tool measuring signal strength, noise, and existing networks before a single AP is installed. APs are ceiling-mounted on a planned grid with overlapping coverage and **non-overlapping channel assignments** so adjacent APs don't fight each other. A wireless LAN controller (WLC) or cloud controller manages dozens to thousands of APs, pushes config centrally, handles client roaming, and steers devices toward the best band (band steering). Authentication is **WPA3-Enterprise with 802.1X / RADIUS** — users authenticate with domain credentials or certificates, not a shared password. Guest networks are isolated VLANs. Rogue AP detection runs constantly. When a user complains about Wi-Fi at home, you reboot the router. When a user complains about Wi-Fi at work, you check the controller dashboard, look at their client history, and find out which AP they're connected to and why their roaming failed.

## Helpdesk reality

- **"My Wi-Fi is slow."** First question: 2.4 or 5 GHz? Most users have no idea. Check the SSID they're connected to, check signal strength, check how far they are from the AP. Half the time the answer is "you're three walls away from the access point."
- **"Bluetooth keeps disconnecting."** Microwaves, dense Wi-Fi, USB 3.0 ports (yes, USB 3 leaks 2.4 GHz interference — Intel published a whitepaper on it). Move the dongle to a USB 2.0 port or use an extension cable.
- **"Tap-to-pay isn't working."** NFC needs the phone unlocked, the right app open or set as default, and the phone within ~4 cm of the reader. Cases with metal or magnets can block it.
- **"Why can't my old laptop see the new Wi-Fi?"** It's probably a 6 GHz-only SSID and the laptop's radio is 5 GHz max. Connect it to the 5 GHz SSID. Never promise a hardware-incapable device will reach a band it doesn't have a radio for.
- **Never promise** a specific speed over wireless. Wireless is shared, contended, and weather-dependent (literally — humidity affects 5 GHz). Promise wired speeds, estimate wireless.

## Related concepts

[[SOHO Networking]] · [[Network Cables and Connectors]] · [[TCP-IP Fundamentals]] · [[Network Security WPA WPA2 WPA3]] · [[Mobile Device Connectivity]] · [[Wireless Troubleshooting]]

*Source: VIRGIL knowledge base — 2026-05-10*