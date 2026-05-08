# LWAP and CAPWAP

## What it is

In Tekken, your character on screen throws the punches, but the actual logic — frame data, hit detection, combo state — lives in the game engine. Mishima alone on the stage is just the puppet; the engine pulls the strings. That's exactly what an [[LWAP]] does — the access point handles the radio, but a controller somewhere else does all the thinking.

A **Lightweight Access Point (LWAP)** is an AP that depends on a [[Wireless LAN Controller|WLC]] for configuration, authentication, and forwarding decisions, communicating with it via the [[CAPWAP]] tunnel.

## Why it matters

One [[Autonomous AP]] you can babysit. Two hundred you cannot. Without centralized control, you're SSH'ing into each AP to push SSID changes, RF tuning, and security policy — and praying nothing drifts. LWAPs plus a WLC turn that nightmare into a single config push. When CAPWAP breaks, APs in [[Local Mode]] stop serving clients entirely; in [[FlexConnect]] mode they keep serving locally cached SSIDs. Exam angle: memorize the ports (5246 control, 5247 data) and know which mode survives WAN failure.

## Key facts

### LWAP vs Autonomous AP

| Feature | [[Autonomous AP]] | [[LWAP]] |
|---|---|---|
| Brains | On the AP itself | On the [[WLC]] |
| Config | Per-AP CLI/GUI | Centralized via WLC |
| IOS image | Full IOS | Lightweight image |
| Scale | Tens | Thousands |
| Roaming | Manual / clunky | Seamless via WLC |

### CAPWAP — the tunnel

**Control and Provisioning of Wireless Access Points**, defined in [[RFC 5415]]. It encapsulates AP-to-WLC traffic in two [[UDP]] tunnels:

| Tunnel | Port | Carries | Encryption |
|---|---|---|---|
| **Control** | UDP **5246** | Config, mgmt, keepalives | [[DTLS]] (mandatory) |
| **Data** | UDP **5247** | Client wireless frames | DTLS (optional) |

CAPWAP runs over IP, so the WLC can sit anywhere routable — same VLAN, different building, different continent.

### LWAPP — the predecessor

[[LWAPP]] (Lightweight Access Point Protocol) was Cisco's pre-standard version. CAPWAP replaced it in 2009. Differences worth knowing:

- LWAPP was Layer 2 or Layer 3; CAPWAP is **IP/UDP only**
- LWAPP encryption was AES key wrap; CAPWAP uses **DTLS**
- LWAPP is dead. Don't pick it on the exam unless the question is historical.

### AP modes (the ones CCNA cares about)

- **[[Local Mode]]** — default. All client traffic is tunneled back to the WLC via CAPWAP, then dumped onto the wired network. Centralized everything. If CAPWAP dies, the AP stops bridging clients.
- **[[FlexConnect]]** — designed for branch offices over a WAN link. AP can switch traffic **locally** at the branch even if the WLC is unreachable. Two sub-states:
  - *Connected mode* — WLC reachable, central or local switching per SSID
  - *Standalone mode* — WLC unreachable, AP keeps serving locally-switched SSIDs from cache
- Other modes exist (Monitor, Sniffer, Bridge, SE-Connect) but rarely surface on CCNA.

### WLC discovery (how an LWAP finds its master)

In order, the AP tries:
1. Broadcast on local subnet
2. **[[DHCP]] Option 43** (vendor-specific, lists WLC IPs)
3. **[[DNS]]** lookup of `CISCO-CAPWAP-CONTROLLER.localdomain`
4. Previously cached WLC IPs (priming)

After discovery → DTLS handshake → join → image check → config download → ready.

### Useful commands

On the WLC:
```
show capwap client rcb
show ap summary
show ap join stats summary all
config ap mode flexconnect <ap-name>
```

On the LWAP console (limited):
```
show capwap ip config
show capwap client config
capwap ap controller ip address <wlc-ip>
```

## Related concepts

[[Wireless LAN Controller]] · [[Split-MAC Architecture]] · [[FlexConnect]] · [[Local Mode]] · [[DTLS]] · [[DHCP Option 43]] · [[Autonomous AP]] · [[LWAPP]] · [[Mobility Express]]

---
*Source: VIRGIL knowledge base — 2026-05-07*