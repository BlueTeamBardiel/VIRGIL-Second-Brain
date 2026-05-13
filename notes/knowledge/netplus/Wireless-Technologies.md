# Wireless Technologies

## What it is

In **Destiny**, the Tower is the social hub. Every Guardian who fast-travels in lands in the same instance — up to sixteen of you, milling around Zavala, Banshee, the Postmaster. But the Tower isn't one server. It's a *shard*. The matchmaking layer drops you into whichever instance has room, broadcasting the same name ("The Tower") across dozens of parallel copies. You and your fireteam can be standing in "the Tower" and not see each other because you're in different instances. The name is shared. The actual cell isn't.

That's exactly what an SSID is — a shared name broadcast by multiple access points, where the client picks the strongest cell to land in and roams between them without noticing.

Technically: **wireless networking** uses radio frequencies in the 2.4 GHz, 5 GHz, and 6 GHz bands to provide network access without cabling, governed by the IEEE 802.11 family of standards. Clients associate with access points (APs), authenticate, and exchange frames over a shared medium using CSMA/CA. Net+ 2.3 wants you fluent in the frequencies, the channel layout, the AP architectures, the security modes, and the deployment patterns.

## Why it matters

Wireless is where the helpdesk lives. Cabled drops rarely fail in mysterious ways — they're either link-up or they're not. Wireless fails in a hundred ways: interference, channel overlap, weak signal, roaming issues, captive portals that won't load, PSK typos, band steering pushing a client onto a band it can't reach. Every IT job above tier-1 expects you to read a wireless survey, pick non-overlapping channels, and know when to upgrade from a SOHO mesh to a controller-based deployment. CompTIA tests this hard under Objective **2.3**.

## Key facts

### Frequencies and channels

| Band | Range | Penetration | Channels | Speed ceiling | Notes |
|---|---|---|---|---|---|
| **2.4 GHz** | Long | Good through walls | 1, 6, 11 (non-overlapping, US) | Lowest | Crowded. Microwaves, Bluetooth, cordless phones, baby monitors all live here. |
| **5 GHz** | Medium | Poor through walls | ~25 non-overlapping (with DFS) | High | Cleaner. Some channels require DFS. |
| **6 GHz** | Short | Worst | 59 channels (20 MHz) | Highest | Wi-Fi 6E and Wi-Fi 7 only. Pristine — no legacy devices. |

The 2.4 GHz non-overlapping channels are **1, 6, and 11**. That's it. Every other channel in 2.4 GHz overlaps with its neighbors and creates co-channel interference. Memorize this — CompTIA will offer you channel 3 or channel 8 as bait.

5 GHz has many more usable channels, but some sit in **DFS (Dynamic Frequency Selection)** territory shared with weather radar. **802.11h** is the standard that lets APs detect radar pulses on those DFS channels and vacate automatically. Without 802.11h, you're not legally allowed to use the DFS range in most regulatory domains.

### Channel width

Wider channel = more throughput, but also more interference and fewer non-overlapping channels.

- **20 MHz** — default, most compatible, always use on 2.4 GHz
- **40 MHz** — bonds two adjacent channels
- **80 MHz** — Wi-Fi 5 sweet spot for 5 GHz
- **160 MHz** — Wi-Fi 6/6E, high throughput, eats spectrum
- **320 MHz** — Wi-Fi 7 on 6 GHz only

*The wider the channel, the more crowded your neighbors make it. In a dense apartment building, 20 or 40 MHz on 5 GHz beats 160 MHz every time.*

### Regulatory impacts

Wi-Fi is licensed radio. The **regulatory domain** (FCC in the US, ETSI in Europe) controls which channels you can use, at what transmit power, and whether DFS is required. Set the wrong country code on an AP and you'll either lose channels you should have or transmit illegally on channels you shouldn't. The 6 GHz band especially has different rules per region.

### Band steering and band use cases

**Band steering** nudges dual-band-capable clients onto 5 GHz (or 6 GHz) instead of letting them camp on the crowded 2.4 GHz band. Sounds great. In practice it sometimes pushes a client onto a band with worse signal in their location. *I learned the hard way that band steering on a router with one weak 5 GHz radio makes laptops worse, not better.*

- **2.4 GHz** — IoT, smart bulbs, garage door openers, devices in the basement
- **5 GHz** — laptops and phones in the same room as the AP
- **6 GHz** — new gear in line-of-sight to a Wi-Fi 6E/7 AP, with the best wireless latency you'll see

### SSID, BSSID, ESSID

- **SSID** — the network name. Human-readable. "Tower-Guest." Up to 32 characters.
- **BSSID** — the MAC address of the AP's radio. Each AP has at least one BSSID per band. This is how clients identify a *specific* AP, not just the network.
- **ESSID** — the SSID when it's shared across multiple APs to form an **Extended Service Set (ESS)**. Same string as the SSID, but the term implies multiple APs broadcasting it for roaming.

The Destiny Tower analogy: SSID is "The Tower." BSSID is the specific instance ID you're in. ESSID is the fact that all those instances share the name.

### Network topology types

| Type | What it is | Use case |
|---|---|---|
| **Infrastructure** | Clients associate to an AP, AP connects to wired network | Every normal Wi-Fi network |
| **Ad hoc** | Peer-to-peer, no AP | Legacy laptop-to-laptop transfers. Rare now. |
| **Mesh** | Multiple APs interconnect wirelessly, self-healing | Home mesh kits, large coverage without cabling every AP |
| **Point-to-point** | Two directional antennas linking two buildings | Warehouse to main office across a parking lot |
| **Point-to-multipoint** | One hub antenna serving multiple remote endpoints | WISP serving a neighborhood from a tower |

### Antennas

- **Omnidirectional** — radiates in all horizontal directions (donut pattern). Standard for indoor APs.
- **Directional** — focuses RF energy in one direction. Higher gain, longer range, narrower beam.
  - **Yagi** — moderate gain, medium-range directional links
  - **Parabolic / dish** — high gain, long-range point-to-point bridges
  - **Patch / panel** — flat, wall-mounted, good for hallway or stadium coverage

*If your point-to-point link across the parking lot keeps dropping, the answer is almost never "more power" — it's "better-aimed directional antennas with clear line of sight."*

### AP architectures

- **Autonomous AP** ("fat AP") — self-contained, configured individually. Fine for one or two APs in a small office.
- **Lightweight AP** ("thin AP") — does only radio work. Configuration, authentication, and forwarding decisions come from a **wireless LAN controller (WLC)**. This is how enterprises run dozens to thousands of APs with one config and seamless roaming.

Set the SSID, security mode, and VLAN once on the controller and every AP picks it up. Autonomous APs require touching each one — fine for three APs, agony for three hundred.

### Encryption and authentication

| Mode | Status | Notes |
|---|---|---|
| WEP | Dead | Broken since 2001. Never use. |
| WPA | Dead | TKIP-based. Broken. |
| **WPA2** | Legacy but everywhere | AES/CCMP. PSK or Enterprise modes. Vulnerable to KRACK and offline PSK cracking. |
| **WPA3** | Current standard | SAE replaces PSK handshake. Forward secrecy. Resistant to offline cracking. Mandatory for Wi-Fi 6E and 7. |

**PSK vs. Enterprise:**

- **PSK** — one password for the whole network. Easy to set up, terrible for rotation.
- **Enterprise** — 802.1X with a RADIUS server. Each user authenticates with their own credentials (often AD-tied). Revoke one user without touching everyone else. Required for any environment over ~20 users.

### Guest networks and captive portals

- **Guest network** — separate SSID, isolated from the corporate VLAN, internet-only. Always put guests on their own VLAN. Never let guest traffic see the printer or the file server.
- **Captive portal** — the web page that intercepts the first HTTP request and forces the user to accept terms or authenticate. Coffee shops, hotels, airports. Implemented by redirecting DNS or HTTP at the gateway until the client authenticates.

### CompTIA exam traps

> **CompTIA exam trap:** The 2.4 GHz non-overlapping channels are **1, 6, and 11** — not 1, 5, 10, not 2, 7, 11. If the question shows a channel plan with channels 3 and 8, it's wrong by design.

> **CompTIA exam trap:** SSID, BSSID, ESSID are different. BSSID is always a MAC address. SSID is the name. ESSID is the name when it's shared across an Extended Service Set. If the question asks "what uniquely identifies a single AP's radio," the answer is BSSID.

> **CompTIA exam trap:** WPA3 uses **SAE**, not PSK. The exam will offer "WPA3-PSK" as a distractor. WPA3-Personal uses SAE; the marketing sometimes still says "PSK" but the cryptographic mechanism is SAE.

> **CompTIA exam trap:** **802.11h** is the radar-avoidance standard for DFS channels in 5 GHz. Don't confuse it with 802.11i (security), 802.11n (Wi-Fi 4), or 802.11ac (Wi-Fi 5).

> **CompTIA exam trap:** Autonomous APs configure individually; lightweight APs require a WLC. If the scenario describes managing 200 APs from a single console, the answer is lightweight + controller.

## Helpdesk reality

- **"The Wi-Fi is slow."** Check what band the device is on. Half the time it's parked on 2.4 GHz next to a microwave. Move to 5 GHz, problem solved.
- **"I can see the network but can't connect."** Eight times out of ten it's a PSK typo. The remaining two: MAC filtering, expired RADIUS cert, or the client is on a band the AP doesn't broadcast on.
- **"Wi-Fi works in the office but drops in the conference room."** Roaming failure or a coverage hole. Lightweight APs with a controller handle this; autonomous APs in separate broadcast domains don't.
- **Never promise a user that "moving closer to the router" will fix it.** Sometimes it does. Sometimes the AP is fine and the problem is a saturated 2.4 GHz channel from the neighbor's network. Run a site survey, don't guess.
- **Escalation:** if you've confirmed signal, correct PSK, right band, and the issue persists across multiple clients — it's an AP, controller, or RADIUS issue. Network team ticket.

## Related concepts

[[Wireless Standards 802.11]] · [[WPA3 and SAE]] · [[802.1X and RADIUS]] · [[Wireless Site Survey]] · [[Wireless LAN Controller]] · [[VLAN]] · [[SSID Security]] · [[Captive Portal]] · [[DFS and 802.11h]] · [[Wireless Troubleshooting]]

*Source: VIRGIL knowledge base — 2026-05-11*