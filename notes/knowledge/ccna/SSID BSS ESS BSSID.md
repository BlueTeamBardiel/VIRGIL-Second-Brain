# SSID BSS ESS BSSID

## What it is

In Breath of the Wild, every Sheikah Tower looks identical from a distance — same shape, same name "Sheikah Tower" — but each has a unique location and activates its own slice of the map. That's exactly what wireless service sets do — the **SSID** is the family name everyone shares, while each tower (AP) has its own unique fingerprint (**BSSID**) and covers its own region (**BSS**), and together they form the whole map (**ESS**).

A **service set** is the IEEE 802.11 framework defining how stations identify and associate with wireless networks via a human-readable name (SSID), a per-AP MAC identifier (BSSID), and a coverage topology (BSS, ESS, or IBSS).

## Why it matters

When a client roams across a building, it stays connected because every AP advertises the same **SSID** but distinguishes itself by **BSSID** — get this wrong in design and clients either refuse to roam, ping-pong between APs, or fail to associate at all. On the exam, Cisco loves to ask which identifier is a MAC address (BSSID), which is the network name (SSID), and which describes the topology (BSS/ESS/IBSS). Misconfigured SSIDs across an ESS break seamless roaming; rogue APs spoofing your SSID with a different BSSID enable evil-twin attacks.

## Key facts

### The four terms

| Term | Stands for | What it actually is |
|------|------------|---------------------|
| **SSID** | Service Set Identifier | Human-readable network name, up to 32 characters, broadcast in beacons |
| **BSSID** | Basic Service Set Identifier | The AP radio's **MAC address** — uniquely identifies one AP/radio |
| **BSS** | Basic Service Set | One AP and its associated clients — single coverage cell |
| **ESS** | Extended Service Set | Two or more BSSs sharing the same SSID, connected via distribution system (wired LAN) |
| **IBSS** | Independent BSS | Ad-hoc mode — clients talk peer-to-peer, no AP |

### BSSID details

- A [[BSSID]] is a 48-bit [[MAC address]], usually the AP's radio MAC.
- Multi-SSID APs derive **virtual BSSIDs** by incrementing the base MAC — one BSSID per advertised SSID per radio.
- A dual-band AP (2.4 GHz + 5 GHz) has at least **two BSSIDs**, one per radio.

### How a client picks an AP

1. Client scans — passive (listens for beacons) or active (sends [[probe request]]).
2. APs respond with beacons/probe responses containing **SSID**, **BSSID**, supported rates, security.
3. Client picks based on signal strength ([[RSSI]]), SNR, supported rates, and security match.
4. Client sends **association request** to the chosen BSSID.
5. On roam, client re-associates to a new BSSID under the same SSID — the [[distribution system]] handles MAC table updates.

### ESS roaming requirements

- Same **SSID** on every AP.
- Different **BSSID** per AP (automatic — each radio has its own MAC).
- Overlapping coverage cells, typically **15–20% overlap** recommended.
- Non-overlapping channels in 2.4 GHz: **1, 6, 11**.
- Shared [[VLAN]] / subnet for Layer 2 roaming, or [[CAPWAP]] tunneling via [[WLC]] for Layer 3 roaming.

### IBSS

- No AP, no [[distribution system]].
- Clients generate a BSSID locally (random 46-bit value with universal/local bit set).
- Effectively dead in modern enterprise — Wi-Fi Direct replaced most use cases.

### Verifying on Cisco gear

```
show wlan summary
show wlan id <id>
show ap summary
show ap dot11 24ghz summary
show ap dot11 5ghz summary
```

On a [[WLC]], each WLAN maps an SSID to a profile; BSSIDs are assigned per AP radio automatically.

## Related concepts

[[802.11]] · [[WLC]] · [[CAPWAP]] · [[Wireless roaming]] · [[Probe request]] · [[Beacon frame]] · [[RSSI]] · [[Evil twin attack]] · [[Autonomous AP vs Lightweight AP]]

---
*Source: VIRGIL knowledge base — 2026-05-07*