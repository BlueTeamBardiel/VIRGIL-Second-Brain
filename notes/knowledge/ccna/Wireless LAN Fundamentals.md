# Wireless LAN Fundamentals

## What it is

In Madden, the offense breaks the huddle and only one quarterback can call the audible at the line — if two players try to bark out signals at once, the whole play falls apart in confused noise. That's exactly what a Wi-Fi network deals with: every device in range hears every transmission, and only one can speak cleanly at a time.

IEEE 802.11 is the standard that defines Wi-Fi. It operates at Layers 1 (the actual radio waves bouncing through the air) and 2 (the framing rules that decide who gets to talk and when). Instead of pushing electrons down a copper wire or photons down fiber, 802.11 modulates electromagnetic waves traveling through open air, which means every device in range receives every transmission whether it was meant for them or not — like every defender on the field hearing the QB's cadence, even though only the offense is supposed to act on it.

Because radios can't transmit and receive on the same frequency at once without deafening themselves, Wi-Fi is **half-duplex** — like the play clock in Madden, where one side runs their snap count and the other side reacts, never both calling plays simultaneously. To keep devices from talking over each other, 802.11 uses **CSMA/CA** (Carrier Sense Multiple Access with Collision Avoidance): listen first, wait a random backoff, then transmit. It's the pre-snap rhythm — you wait for the noise to die down before barking the count. CSMA/CA *reduces* collisions; it doesn't eliminate them. Two receivers running crossing routes at full speed can still collide at the same spot, and two devices that both think the channel is clear can still key up at the same instant.

## Why it matters

Wired Ethernet is a hallway with assigned doors. Wi-Fi is an open courtyard where anyone with the right radio can shout into the conversation. That changes everything: capacity is shared, range is fuzzy, security is harder, and physics — walls, microwaves, fish tanks — actually matters for your throughput.

Understanding the fundamentals is what separates "the Wi-Fi is slow, reboot the router" from "channel 6 is saturated because three neighbors are also on it, and the 2.4 GHz signal from my AP is getting absorbed by the brick wall." Same problem, two completely different repair playbooks.

## Key facts

### Regulation and physics
- **FCC** regulates RF in the US, **ETSI** in Europe, **ITU** coordinates internationally. Think of them as the league commissioners deciding which frequencies are legal to play on.
- **ISM bands** are unlicensed — the public parks of the spectrum. Anyone can transmit there if they follow power and channel rules.
- **Wavelength = 300,000,000 m/s ÷ frequency (Hz)**. Higher frequency = shorter wavelength = more directional, less penetration. Lower frequency = longer waves that bend around obstacles better.
- 2.4 GHz wavelength ≈ 12 cm; 5 GHz ≈ 6 cm. That's why 2.4 punches through drywall like a sniper round in *Tarkov* and 5 GHz gets stopped by a closed door.
- US AP transmit power cap is typically **30 dBm** (1 watt); client cap is **17 dBm** (~50 mW). Your phone is whispering while the AP is yelling.
- Path loss comes from **reflection, diffraction, scattering, and absorption** — the four ways a signal degrades before reaching you. Walls absorb, metal reflects, doorframes diffract, leaves scatter.

### Bands and channels
- **2.4 GHz**: 2400–2484 MHz. Channels are 22 MHz wide; **1, 6, and 11 are the only non-overlapping channels** in US/Canada. Adjacent channels overlap ~50%, which is why your neighbor on channel 3 wrecks your channel 1.
- **5 GHz**: 5150–5825 MHz. Channels typically 40 MHz wide, with options for 80 and 160 MHz.
- **6 GHz**: 5925–7125 MHz. The new construction zone — fewer legacy devices crowding it.

### 802.11 amendments (the version history)
| Standard | Band | Max Rate | Notable |
|---|---|---|---|
| 802.11b | 2.4 GHz | 11 Mbps | Ancient |
| 802.11a | 5 GHz | 54 Mbps | Same era as b, different band |
| 802.11g | 2.4 GHz | 54 Mbps | b's successor |
| 802.11n | 2.4/5 GHz | 600 Mbps | Introduced **MIMO**, 80 MHz channels |
| 802.11ac | 5 GHz | 3.47 Gbps | **MU-MIMO**, 160 MHz channels |
| 802.11ax (Wi-Fi 6/6E) | 2.4/5/6 GHz | 9.6 Gbps | **OFDMA**, **BSS coloring**, 80/160 MHz |

- **MIMO** = multiple antennas streaming in parallel, like a *Helldivers 2* squad firing four guns instead of one.
- **MU-MIMO** = the AP serving multiple clients simultaneously instead of round-robin.
- **OFDMA** = slicing one channel into smaller subcarriers so multiple low-bandwidth devices share airtime efficiently — the AP becomes a DoorDash driver carrying several orders in one trip instead of one delivery per run.
- **BSS coloring** tags frames so a device can ignore transmissions from a neighboring AP on the same channel, like ignoring the enemy team's pings in *Marvel Rivals*.

### Network modes
- **IBSS (ad-hoc)**: no AP, devices talk peer-to-peer. Like a *Mario Kart* local wireless lobby with no router involved.
- **BSS**: one AP coordinating all clients. The standard home Wi-Fi setup.
- **ESS**: multiple APs sharing the same SSID, joined by a **Distribution System** (usually wired Ethernet backbone). Lets you walk across an office without dropping the connection.
- **BSSID** = the AP's MAC address (the unique fingerprint).
- **SSID** = the friendly network name, up to 32 bytes ("StyxGuest").
- **Seamless roaming** requires identical SSID and security credentials across APs. Roaming kicks in around **-67 dBm** signal strength — that's the "this fight is going badly, retreat to the next AP" threshold.
- **Hidden SSID** just omits the name from beacons. It is not security. Anyone with a sniffer sees it the moment a real client associates.

### Access Point roles
- APs handle **beaconing, authentication, association, and data forwarding**.
- **Beacon frames** go out roughly every **100 ms** — the AP shouting "I'm here, here's my SSID, here's my supported rates" on loop, like a Twitch streamer's "starting soon" screen.
- **Lightweight APs** offload brains to a central wireless controller; **autonomous APs** handle everything themselves. Lightweight is the *Watch Dogs* drone — dumb hardware piloted by a smart controller back at HQ.

### 802.11 frame essentials
- **To DS / From DS** bits in the MAC header indicate whether the frame is going into or out of the distribution system.
- **Sequence control** field detects duplicate frames so retransmissions don't confuse the receiver.
- Management/control frames you'll see in any capture:
  - **Beacon** — AP advertising itself.
  - **Probe Request** — client asking "any APs out there?"
  - **Probe Response** — AP replying "yeah, me."
  - **Authentication Request/Response** — initial security handshake.
  - **Association Request/Response** — client formally joining the BSS, like accepting the *Elden Ring* multiplayer summon.
  - **Deauthentication** — explicit goodbye ("I'm leaving").
  - **Disassociation** — abrupt drop ("I just rage-quit"). Both are also weaponized in deauth attacks to kick clients off a network.

## Related concepts
[[WPA2 and WPA3 Security]]
[[Wireless Controllers and CAPWAP]]
[[RF Site Surveys and Heat Maps]]
[[Antennas and Polarization]]
[[Deauthentication Attacks]]
[[802.1X and EAP]]
[[Spectrum Analysis and Interference]]
[[Roaming and 802.11r/k/v]]