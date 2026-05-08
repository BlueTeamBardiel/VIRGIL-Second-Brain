# Wireless Roaming

## What it is

In Smash Bros, when a fighter gets launched off the stage and uses their recovery move to grab the ledge of a different platform — they keep their stock, their damage percentage, their items. The match continues seamlessly. That's exactly what wireless roaming does — a client jumps from one access point to another without dropping its connection.

**Wireless roaming** is the process by which a Wi-Fi client disassociates from one [[Access Point]] and reassociates with another while maintaining its IP address and active sessions.

## Why it matters

Without proper roaming, every walk down a hallway means a dropped Zoom call, a re-authenticated VPN, and a furious user. Slow roaming (>150ms) breaks voice and video; broken roaming breaks everything. On the CCNA, expect questions on the difference between L2 and L3 roaming, the role of the [[WLC]], and why **802.11r** exists.

## Key facts

### Intra-controller vs Inter-controller roaming

| Type | Description | Behavior |
|------|-------------|----------|
| **Intra-controller** | Client moves between APs on the **same WLC** | WLC updates its client database. Fast and simple. |
| **Inter-controller** | Client moves between APs on **different WLCs** | Controllers must coordinate. Can be L2 or L3. |

### Layer 2 vs Layer 3 roaming

- **Layer 2 roaming**: Both APs (or WLCs) share the same client VLAN/subnet. The client keeps its IP. Simple handoff.
- **Layer 3 roaming**: The new WLC is on a different subnet. To preserve the IP, the original WLC becomes the **anchor controller** and the new one the **foreign controller**. Traffic tunnels back to the anchor via [[CAPWAP]] / EoIP. Ugly but functional.

### The reassociation process

1. Client sends **probe requests**; APs respond with probe replies.
2. Client picks a target AP (signal strength, load, etc.).
3. Client sends an **802.11 reassociation request** to the new AP.
4. New AP confirms with reassociation response.
5. If [[802.1X]] is used, full [[EAP]] exchange + 4-way handshake — this is the slow part (often 300–700ms).

### Sticky client problem

Clients decide when to roam, not the network. A **sticky client** clings to a distant AP at -80 dBm signal because, technically, it still works. Result: terrible throughput, retries, and one user dragging down the cell.

Mitigations:
- **[[802.11k]]** — Neighbor reports. AP tells client which APs to consider.
- **[[802.11v]]** — BSS Transition Management. AP politely suggests "go roam now."
- **Aggressive client load balancing** / minimum RSSI thresholds on the WLC.

### Fast roaming standards

| Standard | Purpose |
|----------|---------|
| **802.11r** | Fast BSS Transition (FT). Pre-authenticates keys so the 4-way handshake is skipped on roam. Brings reassociation under ~50ms. |
| **802.11k** | Radio Resource Measurement — neighbor lists. |
| **802.11v** | Network-assisted roaming hints. |
| **PMK caching / OKC** | Older fast-roam methods, predate 802.11r. |

802.11r uses a two-tier key hierarchy (**PMK-R0**, **PMK-R1**) so the new AP already has crypto material when the client arrives. No full EAP. No re-typed password. Voice survives.

### Sample WLC config (Cisco AireOS)

```
config wlan security wpa akm ft-802.1x enable <wlan-id>
config wlan security ft enable <wlan-id>
config wlan security ft over-the-ds enable <wlan-id>
```

## Related concepts

[[WLC]] · [[CAPWAP]] · [[Access Point]] · [[802.1X]] · [[EAP]] · [[802.11k]] · [[802.11v]] · [[WPA2]] · [[WPA3]] · [[Mobility Group]]

---
*Source: VIRGIL knowledge base — 2026-05-07*