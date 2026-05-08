# WLC Wireless LAN Controller

## What it is

In Demon's Souls, the Nexus is the hub where the Maiden in Black channels souls into your stats — the Archstones do the actual transport into each world, but every level-up, every meaningful decision, routes through her. That's exactly what a [[WLC]] does — the access points handle the radio work, but the controller centrally decides who they are, what they broadcast, and where the traffic goes.

A **Wireless LAN Controller** is a network device that centrally manages [[Lightweight Access Point|lightweight APs]] using the [[CAPWAP]] protocol, handling configuration, authentication, RF management, and client mobility from one control plane.

## Why it matters

Without a controller, every AP is an island — each one independently configured, independently updated, independently misbehaving. At scale this is operational suicide: 200 APs means 200 SSH sessions and 200 chances to fat-finger a PSK. Centralization lets one admin push a WLAN to a thousand APs in seconds, enables seamless roaming, and makes RF interference something the controller solves rather than something users complain about. **Exam angle:** know split-MAC, CAPWAP ports, and the deployment models cold.

## Key facts

### Split-MAC architecture

The 802.11 MAC functions are divided between the [[Lightweight AP]] and the WLC. The AP keeps real-time work; the WLC takes everything that benefits from a global view.

| Function | Handled by AP | Handled by WLC |
|---|---|---|
| Beacons, probe responses | ✓ | |
| MAC layer encryption/decryption | ✓ | |
| 802.11 ACKs, packet queuing | ✓ | |
| Association/authentication | | ✓ |
| Security policies, [[QoS]] | | ✓ |
| Client mobility / roaming | | ✓ |
| RF management ([[RRM]]) | | ✓ |

This is **[[Split-MAC Architecture]]** — the AP is dumb on purpose so the controller can be smart for all of them.

### CAPWAP tunnel

[[CAPWAP]] (Control And Provisioning of Wireless Access Points, RFC 5415) replaced the older [[LWAPP]]. Two tunnels run between every LAP and its WLC:

- **Control tunnel** — encrypted with [[DTLS]], **UDP 5246**
- **Data tunnel** — DTLS encryption optional, **UDP 5247**

Client traffic from the wireless side is encapsulated in CAPWAP and tunneled to the WLC, which then forwards it onto the wired LAN. The AP itself does not bridge wireless traffic onto the local VLAN (in centralized mode).

```
LAP ──[CAPWAP control: UDP 5246]──> WLC
LAP ──[CAPWAP data:    UDP 5247]──> WLC
```

### LAP discovery and join

The LAP finds its WLC in this order:
1. Broadcast on local subnet
2. Previously known WLCs (stored)
3. **[[DHCP Option 43]]** — WLC IP injected by DHCP
4. **DNS lookup** — `CISCO-CAPWAP-CONTROLLER.localdomain`
5. Manual configuration

After discovery: **Discovery → Join → Image check → Config → Run**.

### WLAN configuration

A [[WLAN]] on the WLC is the SSID-plus-policy bundle. Each WLAN ties:

- **SSID** (the broadcast name)
- **Interface / VLAN** on the WLC (where client traffic egresses)
- **Security** ([[WPA2]], [[WPA3]], [[802.1X]], PSK, Open)
- **QoS profile** (Platinum/Gold/Silver/Bronze)
- **Advanced** (band select, [[FlexConnect]], session timeout)

A WLC supports up to 512 WLANs, but only 16 can be active per AP radio.

### Deployment options

| Model | Where the WLC lives | Use case |
|---|---|---|
| **Unified (centralized)** | Dedicated physical appliance (e.g., Catalyst 9800-40/80) | Mid-to-large campus |
| **Embedded** | Inside a [[Catalyst]] switch (9800-CL on switch) | Branch / distributed |
| **Cloud** | VM in private cloud or [[Catalyst 9800-CL]] on public cloud | Flexible, scalable |
| **[[Mobility Express]]** | Runs on a capable AP itself — no separate controller | Small sites, ≤100 APs |
| **[[Autonomous AP]]** | No WLC at all — each AP is independent | Legacy, tiny deployments |

### AP modes worth knowing

- **Local** — default; CAPWAP-tunnels all traffic to WLC
- **[[FlexConnect]]** — AP can switch traffic locally if WLC is down (branch survivability)
- **Monitor** — no client service, just RF/IDS scanning
- **Sniffer**, **Bridge**, **SE-Connect** — specialized

### Roles in Cisco WLAN architecture

- **WLC** — the brain: control plane, policy, mobility
- **LAP** — the radio: real-time 802.11
- **[[AireOS]] / [[IOS-XE]]** — the WLC operating system (9800 series runs IOS-XE)
- **[[Cisco DNA Center]] / Catalyst Center** — manages the WLCs themselves at scale
- **[[ISE]]** — provides 802.1X/RADIUS authentication for WLANs

## Related concepts

[[CAPWAP]] · [[Lightweight AP]] · [[Split-MAC Architecture]] · [[Mobility Express]] · [[FlexConnect]] · [[Autonomous AP]] · [[WPA2]] · [[WPA3]] · [[802.1X]] · [[DHCP Option 43]] · [[RRM]] · [[Catalyst 9800]] · [[ISE]]

---
*Source: VIRGIL knowledge base — 2026-05-07*