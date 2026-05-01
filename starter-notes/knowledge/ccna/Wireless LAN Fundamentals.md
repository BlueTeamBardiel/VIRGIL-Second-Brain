# Wireless LAN Fundamentals
**Why this matters:** Wireless LANs operate on fundamentally different principles than wired networks—understanding RF behavior, 802.11 standards, and service sets is essential for designing, troubleshooting, and passing the CCNA exam on wireless deployments.

---

## Core Concept: Why Wireless is Different

Think of wired Ethernet like a telephone conversation through a dedicated pipe—the signal stays inside, reaches one destination, and is private. Wireless is like shouting across a room: everyone in range hears you, you can only speak one at a time (half-duplex), and noise interferes with clarity.

[[IEEE 802.11]] (Wi-Fi) operates at Layers 1 and 2, just like [[Ethernet]], but uses **electromagnetic waves through air** instead of electrons through copper. The modularity of the [[TCP/IP model]] means Layers 3+ work identically—the difference is purely how the signal gets sent across the physical medium.

---

## 18.1 Wireless Communications Fundamentals

### Bounded vs. Unbounded Media

**Wired (Bounded):**
- Signal confined to cable
- Single destination
- Protected from interference
- Security by default (physical isolation)

**Wireless (Unbounded):**
- Signals radiate in all directions
- All devices in range receive transmissions
- Susceptible to interference
- Requires encryption for privacy
- Operates in half-duplex mode

### Five Critical Challenges of Wireless

#### 1. **All Devices Receive All Signals**
Like an [[Ethernet hub]], wireless devices broadcast to everyone in range. This is why [[VLAN]] security (encryption) is mandatory even on internal networks—anyone with a receiver can eavesdrop. This is fundamentally different from [[Ethernet switch]] behavior.

#### 2. **Airtime Contention (Half-Duplex Operation)**
Only one device can transmit at a time on a shared frequency. Multiple simultaneous transmissions = collision. This is why wireless throughput is always lower than wired—devices compete for airtime constantly. Switches offer full-duplex; wireless cannot.

#### 3. **Collision Avoidance: CSMA/CA vs. CSMA/CD**

| Protocol | Medium | Behavior | Recovery |
|----------|--------|----------|----------|
| [[CSMA/CD]] | Wired (hub) | Send and detect collision | Backoff and retry |
| [[CSMA/CA]] | Wireless | **Listen first**, avoid collision | Still retransmits if collision occurs |

**CSMA/CA Process:**
1. Device prepares frame for transmission
2. Listens to channel (CCA—Clear Channel Assessment)
3. If busy → wait random backoff period → listen again
4. If free → transmit immediately
5. If collision occurs anyway → both devices backoff exponentially

**Key insight:** CSMA/CA doesn't eliminate collisions, only reduces them by forcing devices to check before transmitting.

#### 4. **Signal Interference**
Radio frequency signals degrade and get disrupted by:
- Other [[IEEE 802.11]] networks on same/overlapping channels
- Non-802.11 RF sources: microwave ovens, cordless phones, [[Bluetooth LE]], baby monitors
- Physical obstacles: walls, metal, water

Careful [[channel selection]] and RF site surveys are critical design activities.

#### 5. **Regulatory Fragmentation**
- US: [[FCC]] (Federal Communications Commission)
- Europe: [[ETSI]] (European Telecommunications Standards Institute)
- Other regions: national bodies coordinating with [[ITU]] (International Telecommunications Union)

Different countries allow different frequency ranges and power levels. Equipment certified for one region may be illegal in another.

#### 6. **Free-Space Path Loss (FSPL)**
Wireless signals weaken with distance and are affected by:
- Reflection (bouncing off surfaces)
- Diffraction (bending around obstacles)
- Scattering (dispersal through irregular medium)
- Absorption (walls, metal, human bodies)

Coverage planning requires RF modeling, not just distance calculations.

---

## Radio Frequency Fundamentals

### Basic RF Properties

**Frequency and Wavelength:**
- Frequency measured in **Hertz (Hz)**
- Wavelength = Speed of Light / Frequency
- Higher frequency = shorter wavelength = more directional signal
- Lower frequency = longer wavelength = better penetration

**Key Formula:**
```
Wavelength (meters) = 300,000,000 m/s ÷ Frequency (Hz)
```

For 2.4 GHz: ~12 cm wavelength
For 5 GHz: ~6 cm wavelength

### ISM Bands (Industrial, Scientific, Medical)

These are unlicensed frequency ranges available worldwide (with local variations):

| Band | Frequency Range | Common Uses |
|------|-----------------|------------|
| 2.4 GHz | 2400–2484 MHz | [[IEEE 802.11b/g/n]], [[Bluetooth LE]], microwave ovens |
| 5 GHz | 5150–5825 MHz | [[IEEE 802.11a/n/ac/ax]] (less congestion) |
| 6 GHz | 5925–7125 MHz | [[IEEE 802.11]] (Wi-Fi 6E, newer) |

**2.4 GHz is "crowded"** because it's used by so many devices. **5 GHz is cleaner** but has shorter range due to higher frequency. **6 GHz is newest** but requires newer equipment.

### Channels and Non-Overlapping Channels

A **channel** is a specific frequency within a band. Channels can overlap, causing interference.

**2.4 GHz Example:**
- 14 channels defined, but only 1, 6, 11 are non-overlapping in most regions (US/Canada allows 1–11)
- Each channel is 22 MHz wide
- Adjacent channels overlap 50%

**5 GHz Example:**
- Many more channels (typically 24–48 depending on region)
- Channels 40 MHz wide (80/160 MHz for [[802.11]]/[[802.11ax]])
- More space = less contention for airtime

**Key Point:** For 2.4 GHz deployments, plan to use **only channels 1, 6, and 11** in the same area to avoid interference. This limits how many APs can coexist.

---

## IEEE 802.11 Standards Overview

[[IEEE 802.11]] defines Layer 1 and Layer 2 operations for wireless LANs. Multiple amendments extend the base standard with improvements.

| Standard | Year | Frequency | Max Data Rate | Key Feature |
|----------|------|-----------|----------------|------------|
| [[802.11b]] (Wi-Fi 1) | 1999 | 2.4 GHz | 11 Mbps | First practical WLAN |
| [[802.11a]] (Wi-Fi 2) | 1999 | 5 GHz | 54 Mbps | Less interference, shorter range |
| [[802.11g]] (Wi-Fi 3) | 2003 | 2.4 GHz | 54 Mbps | Backward-compatible with 802.11b |
| [[802.11n]] (Wi-Fi 4) | 2009 | 2.4/5 GHz | 600 Mbps | MIMO, wider channels (40/80 MHz) |
| [[802.11]] (Wi-Fi 5) | 2013 | 5 GHz | 3.47 Gbps | 80/160 MHz channels, MU-MIMO |
| [[802.11ax]] (Wi-Fi 6) | 2021 | 2.4/5/6 GHz | 9.6 Gbps | OFDMA, BSS coloring, better efficiency |

**Key Takeaway for CCNA:** Older standards (802.11b/a) are obsolete. Expect questions on 802.11n, 802.11ac, and 802.11ax in modern deployments.

---

## Service Sets: How Devices Communicate

A **service set** is a group of wireless devices communicating together. [[IEEE 802.11]] defines several types.

### Independent Basic Service Set (IBSS / Ad-Hoc)

- **No Access Point required**
- Devices communicate directly peer-to-peer
- One device acts as "synchronization beacon"
- Limited range and performance
- **Rarely used in enterprise** (no centralized management)

### Basic Service Set (BSS) / Infrastructure Mode

- **Requires an [[Access Point (AP)]]**
- All devices associate to a single AP
- AP acts as central hub for all communications
- Standard enterprise deployment model
- Single AP covers limited area

**Components:**
- **BSSID:** MAC address of the AP (48 bits, printed as 6 hex pairs)
- **SSID:** Friendly name of the network (up to 32 bytes, broadcast in beacons or hidden)
- **Beacon frame:** Regular frame (every ~100 ms) from AP advertising its presence

### Extended Service Set (ESS) / Roaming

- **Multiple APs with same SSID**
- Devices roam between APs seamlessly
- All APs on same channel or different non-overlapping channels
- **Distribution System (DS):** backbone connecting APs (wired Ethernet)

**Requirements for seamless roaming:**
1. Same SSID
2. Same security credentials (PSK/enterprise auth)
3. Different [[BSSID]] per AP
4. Sufficient signal overlap (~-67 dBm threshold)
5. Same IP subnet or [[802.11k]]/[[802.11v]] support for faster transitions

### Service Set Identifier (SSID)

- **Broadcast SSID:** Sent in beacon frames (users see it in available networks)
- **Hidden SSID:** Not sent in beacons, but can still be discovered by probe requests
- **Security through obscurity:** Hiding SSID provides no real security (determined clients can still find it)

---

## Access Points (APs)

An **[[Access Point]]** is a Layer 1/2 device that bridges wireless and wired networks.

### Core AP Functions

| Function | Details |
|----------|---------|
| **Beaconing** | Sends beacon frames every ~100 ms (default ~10 per second) |
| **Authentication** | Verifies device identity (open, WPA2, WPA3) |
| **Association** | Registers device and assigns resources |
| **Data forwarding** | Relays frames between wireless clients and wired network |
| **Channel management** | Monitors RF environment, selects best channel |
| **Rate adaptation** | Adjusts data rate based on signal quality |

### AP Deployment Modes

| Mode | Role | Typical Use |
|------|------|------------|
| **Standalone** | Independent AP + built-in DHCP/firewall | Small office, home |
| **Lightweight AP** (LAP) | Managed by wireless controller | Enterprise, campus |
| **Mesh** | Multi-hop relaying to wired network | Areas without wired backbone |

For CCNA, focus on lightweight AP model managed by a controller.

---

## 802.11 Frame Structure (Simplified)

Like Ethernet frames have source/dest MAC + payload, 802.11 frames have additional complexity:

```
[MAC Header] [Payload] [FCS]
```

**Key fields in 802.11 MAC header:**
- **To DS / From DS:** Indicates if frame is going to/from distribution system
- **BSSID:** AP's MAC address
- **Source MAC:** Sending device
- **Destination MAC:** Receiving device
- **Sequence control:** Fragmentation and frame number (detects duplicates)

**Special frame types (not carrying user data):**
- **Beacon:** AP advertisement
- **Probe Request:** Device asking "is anyone out there?"
- **Probe Response:** AP replies with capabilities
- **Authentication Request/Response:** Security handshake
- **Association Request/Response:** Device joining the BSS
- **Deauthentication:** Explicit disconnect
- **Disassociation:** Sudden disconnect

---

## Transmit Power and Coverage

**EIRP (Effective Isotropic Radiated Power):**
- Measured in dBm
- Maximum varies by regulation (US: 30 dBm typical for APs, 17 dBm for clients)
- Higher power = longer range

---
*Source: Acing the CCNA Exam, Volume 2, Chapter 18 | [[CCNA]]*
