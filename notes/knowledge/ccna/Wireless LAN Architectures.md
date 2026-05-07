# Wireless LAN Architectures

## What it is

A WLAN architecture is the org chart for your access points. In Helldivers 2, you can either have every Helldiver freelancing their own stratagems, or you can have Super Earth Command coordinating the entire squad from orbit. Wi-Fi works the same way: APs can each be their own boss (autonomous), or they can be dumb terminals taking orders from a central brain called a Wireless LAN Controller (WLC), or they can phone home to a cloud service.

Underneath every architecture is the same 802.11 frame format — the actual radio packet that carries your TikTok scroll. Unlike Ethernet, which only needs a "from" and "to" address, 802.11 frames can carry up to **four** addresses because wireless frames often hop through an AP before reaching the wired network. Think of it like a Discord DM that has to pass through a moderator bot: the bot is a middleman, so the message needs to track who originally sent it, who's relaying it now, who's receiving it now, and who it's ultimately for.

## Why it matters

Picking the wrong architecture is like picking the wrong loadout in Escape from Tarkov — you only realize the mistake when it's too late. Three autonomous APs in a coffee shop? Fine. Three hundred autonomous APs across a campus? You'll spend your entire career SSH'ing into APs one at a time to change a password.

Architecture choice also dictates roaming. When you walk from the lobby to the elevator while still on a Spotify call, something has to hand your session off between APs without dropping it. Autonomous APs can't really coordinate that. A WLC can — it's the raid leader telling AP-2 "I'm passing you Beatrice's session, take over."

## Key facts

### 802.11 Frame Format

The 802.11 header is bulkier than Ethernet because wireless is messier. Here's the field rundown:

- **Frame Control (2 bytes)** — flags that say what kind of frame this is and which direction it's flowing
- **Duration/ID (2 bytes)** — how long the medium will be busy, so other clients shut up
- **Address 1, 2, 3, 4 (6 bytes each)** — the four-address game (more below)
- **Sequence Control (2 bytes)** — frame numbering, like patch notes versioning
- **QoS Control (0 or 2 bytes)** — only present if QoS is in use; flags priority traffic
- **HT Control (0 or 2 bytes)** — High Throughput control for 802.11n and beyond
- **FCS (4 bytes)** — CRC-32 checksum at the end, the "did this frame arrive intact" check

### The Four Addresses

Like a relay race in Mario Kart where the baton has to track both the original racer and the current racer:

- **DA (Destination Address)** — final recipient, the player you're actually mailing the item to
- **SA (Source Address)** — original sender, whoever first dropped the item in the mail
- **RA (Receiver Address)** — immediate next-hop receiver (often the AP)
- **TA (Transmitter Address)** — whoever just put it on the airwaves a millisecond ago
- **BSSID** — the AP's MAC address, basically the lobby ID stamping which BSS owns this frame

Two laptops on the same Wi-Fi can't talk directly to each other — every frame goes **through** the AP, even if the other laptop is six feet away. This is why RA/TA exist as separate fields from SA/DA.

### Joining a BSS — The Three-Stage Handshake

Connecting to Wi-Fi is like joining a Discord server: you find it, you prove you belong, then you actually join.

1. **Discovery** — find the AP
   - **Passive Scanning** — sit and listen for Beacon frames the AP broadcasts roughly every 100ms (like watching a Twitch stream's "Live" indicator)
   - **Active Scanning** — send Probe Requests, receive Probe Responses (you DM the server first)
2. **Authentication** — prove legitimacy. Critically, this does **not** join you to the network — it just gates entry. **Open Authentication** is the "no verification, just walk in" option common at coffee shops.
3. **Association** — the AP assigns you an **AID (Association Identifier)**, which also gets used during power-save mode to flag buffered frames for you

### Frame Categories

802.11 defines three message types:

- **Management** — Beacons, Probes, Authentication, Association, Reassociation, Disassociation, Deauthentication
- **Control** — RTS/CTS, ACKs, Block Ack, CF-End
- **Data** — actual payload, plus oddballs like Null frames and QoS Null frames

Notable members:

- **Beacon frames** — the AP's "Now Playing" status: SSID, supported rates, channel, security settings
- **RTS/CTS** — Request to Send / Clear to Send, fights the **hidden node problem** where two clients can hear the AP but not each other (like two snipers on opposite ridges in Call of Duty who can't see each other but both shoot the same building)
- **Reassociation Request** — used when roaming to a new AP while keeping your IP/session
- **Disassociation** — clean logout
- **Deauthentication** — forced termination, the kick command
- **Block Ack** — batched ACKs for many frames, like Steam telling you all your downloads finished at once instead of pinging per file
- **CF-End** — signals the end of a contention-free period
- **Null frames / QoS Null frames** — empty payload, used purely as power-save signaling

### Architecture Models

**Autonomous APs**
- Each AP is fully self-contained — its own brain, config, and policies
- Configured one-by-one, like manually editing each NPC's loadout in a modded Skyrim playthrough
- Fine for a few APs, miserable past a dozen

**Lightweight AP + WLC (Cisco Unified Wireless Architecture)**
- Lightweight APs (LAPs) run a minimal OS — they're the dumb minions, the WLC is the brain
- Frames tunnel from AP to WLC over **CAPWAP**: UDP **5246** for control, UDP **5247** for data
- CAPWAP tunnels can be wrapped in **DTLS** for encryption
- One WLC manages anywhere from **100 to 400 APs** depending on the model
- Enables seamless roaming because the WLC coordinates handoffs between APs
- Three deployment flavors:
  - **Centralized WLC** — one WLC in the data center, every AP tunnels back to it (single Helldivers Super Destroyer running every mission)
  - **Distributed WLC** — one WLC per building or floor (regional commanders)
  - **Hybrid WLC** — primary WLC in data center with failover WLCs at branches (main raid + backup raid leader)

**Cloud-Based APs**
- APs tunnel to a cloud service over **HTTPS port 443**
- Subscription model, no on-prem WLC hardware to rack and stack
- The dashboard lives somewhere else; you just plug APs in and they phone home

### Powering the APs

APs are usually mounted on ceilings where running an AC outlet is painful, so they pull power over the same Ethernet cable that carries data:

- **PoE (802.3af)** — 15.4W, enough for older or smaller APs
- **PoE+ (802.3at)** — 30W, needed for modern APs with multiple radios and higher transmit power

## Related concepts

[[802.11 Standards]] · [[CAPWAP]] · [[SSID and BSSID]] · [[Wireless Roaming]] · [[Hidden Node Problem]] · [[WPA2 and WPA3]] · [[Power over Ethernet]] · [[Wireless Site Survey]] · [[802.11 Channels and Bands]]