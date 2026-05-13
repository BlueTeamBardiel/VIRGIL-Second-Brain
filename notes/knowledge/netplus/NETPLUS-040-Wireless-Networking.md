# Wireless Networking

## What it is

In **Hitman**, 47 walks into the Sapienza marketplace and the whole town just *works* without wires. Vendors talk to suppliers, guards radio each other across the cliffs, the lab on the hill coordinates with the villa below — all invisible signal, no cables strung across the cobblestones. Now watch what happens when 47 plants an ICA signal jammer near the substation: guards lose contact, the radio chatter dies, coordination collapses. One bad RF environment and the whole operation fragments. That's wireless networking — invisible infrastructure that feels magical until something interferes, and then everything dies at once.

**Plain English:** wireless networking moves data through the air using radio waves instead of copper or fiber. Devices (clients) connect to **access points** (APs), which bridge them back into the wired network. In any deployment bigger than a house, a **wireless LAN controller** (WLC) orchestrates all the APs so they don't fight each other.

**Technical (N10-009 1.2 + 2.4):** wireless networking uses the IEEE 802.11 family of standards to transmit data over unlicensed 2.4 GHz, 5 GHz, and 6 GHz radio bands. APs operate at OSI Layer 2 as bridges, mapping wireless frames to wired Ethernet. Modern enterprise deployments use a controller-based architecture where a **WLC** (physical or virtual appliance) centrally manages configuration, RF tuning, client roaming, and security policy across many lightweight APs.

## Why it matters

Wireless is no longer the "nice to have" sitting next to the wired LAN — it's the LAN for most users. Laptops, phones, IoT, badge readers, VoIP handsets, the CEO's iPad — all wireless. When Wi-Fi dies, work dies. The helpdesk ticket queue becomes a wall.

For the exam, **Objective 1.2** lumps APs and controllers in with routers, switches, and firewalls as "networking appliances and functions" you must distinguish. **Objective 2.4** then drills into wireless standards, frequencies, channels, and antennas. Expect questions on AP vs WLC roles, autonomous vs lightweight APs, channel selection on 2.4 GHz, and which Wi-Fi generation runs on which band.

For your career: every enterprise tech eventually owns the Wi-Fi. It is the most-complained-about, least-understood layer of the network. Knowing it cold is leverage.

## Key facts

### Access points — what they actually do

An AP is a Layer 2 bridge with a radio. It takes 802.11 wireless frames from clients, strips the wireless headers, and forwards them as 802.3 Ethernet frames onto the wired network through its uplink port (almost always **PoE+** powered — one cable for power and data). Returning traffic gets re-wrapped in 802.11 and broadcast back over the air.

Two flavors:

| Type | Brain location | Config | Use case |
|---|---|---|---|
| **Autonomous AP** ("fat AP") | In the AP itself | Configured individually | Home, SOHO, very small office |
| **Lightweight AP** ("thin AP") | In the controller | AP is a dumb radio, WLC decides everything | Enterprise, anywhere with >5 APs |

Lightweight APs talk to the WLC using **CAPWAP** (Control And Provisioning of Wireless Access Points) on UDP ports **5246** (control) and **5247** (data). When the AP boots, it finds the controller via DHCP option 43, DNS, or broadcast, then downloads its config.

*If you have ten autonomous APs in one building, you have ten misconfigurations waiting to happen. Controllers exist because humans can't keep ten devices in sync by hand.*

### Wireless LAN Controller (WLC)

The WLC is the brain. One device — physical appliance, VM, or cloud-hosted — that:

- Pushes SSID, security, and VLAN config to every AP
- Runs **RRM** (Radio Resource Management): auto-selects channels and transmit power to minimize interference between your own APs
- Handles **client roaming** — when a laptop walks from AP1 to AP2, the WLC pre-authenticates so the handoff is seamless (no re-typing the Wi-Fi password mid-Teams-call)
- Centralizes 802.1X authentication against RADIUS
- Detects **rogue APs** — anything broadcasting an SSID it shouldn't
- Aggregates monitoring data — every client's signal strength, every AP's channel utilization

Controllers can be on-prem (Cisco 9800, Aruba Mobility Controller) or **cloud-managed** (Meraki, Aruba Central, Mist). Cloud-managed offloads the WLC to the vendor's data center — the APs tunnel up to the cloud for config, but data traffic stays local.

### Frequency bands and channels

| Band | Range | Channels (non-overlapping, US) | Trade-off |
|---|---|---|---|
| **2.4 GHz** | Long range, penetrates walls | **1, 6, 11** only | Crowded, slow, microwaves and Bluetooth fight you |
| **5 GHz** | Shorter range, more bandwidth | ~25 non-overlapping (20 MHz) | The workhorse for modern Wi-Fi |
| **6 GHz** | Shortest range, cleanest spectrum | 59 channels (20 MHz) | Wi-Fi 6E and 7 only, no legacy noise |

> **CompTIA exam trap:** 2.4 GHz has **only three non-overlapping channels: 1, 6, and 11.** Any other channel choice (3, 4, 9, etc.) overlaps with two of the three good ones and degrades all of them. CompTIA will offer "channel 4" as a tempting distractor. It is wrong every single time.

### Wi-Fi generations (802.11)

| Standard | Marketing name | Max theoretical | Bands |
|---|---|---|---|
| 802.11a | — | 54 Mbps | 5 GHz |
| 802.11b | — | 11 Mbps | 2.4 GHz |
| 802.11g | — | 54 Mbps | 2.4 GHz |
| 802.11n | Wi-Fi 4 | 600 Mbps | 2.4 + 5 GHz, MIMO |
| 802.11ac | Wi-Fi 5 | ~6.9 Gbps | 5 GHz only, MU-MIMO |
| 802.11ax | Wi-Fi 6 / 6E | ~9.6 Gbps | 2.4 + 5 (+ 6 for 6E), OFDMA |
| 802.11be | Wi-Fi 7 | ~46 Gbps | 2.4 + 5 + 6 GHz, MLO |

*The "max theoretical" numbers are marketing fiction. Real-world throughput is half to a third of label speed once you account for protocol overhead, distance, and the guy in the next cube also streaming YouTube.*

### Antennas

- **Omnidirectional** — radiates in a doughnut, 360° horizontal. Default for indoor APs sitting on a ceiling.
- **Directional** (Yagi, panel, parabolic) — focuses signal in a beam. Use for point-to-point links between buildings, or to cover a long warehouse aisle.
- **MIMO / MU-MIMO** — multiple antennas transmitting simultaneously to one client (MIMO) or multiple clients (MU-MIMO). Standard since Wi-Fi 4.

### Security — quick reference

| Protocol | Status | Notes |
|---|---|---|
| WEP | Dead | Broken since 2001. Never deploy. |
| WPA | Dead | TKIP, also broken. |
| WPA2-Personal (PSK) | Acceptable | Pre-shared key. Home and small office. |
| WPA2-Enterprise | Good | 802.1X + RADIUS. Per-user credentials. |
| **WPA3-Personal (SAE)** | **Current** | Replaces PSK handshake with Simultaneous Authentication of Equals — resistant to offline dictionary attacks. |
| **WPA3-Enterprise** | **Current** | 192-bit cryptographic suite, mandatory PMF. |

### SSIDs, VLANs, and segmentation

One AP, multiple SSIDs. Map each SSID to a different VLAN at the WLC:

- `Corp` SSID → VLAN 10 → full network access via 802.1X
- `Guest` SSID → VLAN 99 → internet only, captive portal, no internal routing
- `IoT` SSID → VLAN 50 → printers, badge readers, kept away from user traffic

The AP tags frames as it bridges them onto the wired uplink (an 802.1Q trunk back to the switch). This is how a single radio serves three security zones without three sets of hardware.

### Where wireless sits in the big picture (Objective 1.2)

The exam objective bundles wireless gear with the rest of the appliance zoo. Quick orientation so you don't confuse roles:

- **[[Router]]** — L3, moves packets between networks
- **[[Switch]]** — L2, moves frames inside a network; the AP's uplink lands here
- **[[Firewall]]** — enforces policy at network boundaries
- **[[Load balancer]]** — distributes traffic across servers
- **AP / WLC** — extends the L2 network over the air
- **[[Proxy]]** / **[[CDN]]** / **[[NAS]]** / **[[SAN]]** — application and storage appliances, separate concern from wireless

### CompTIA exam traps

> **Trap 1:** A **lightweight AP cannot function without a controller.** If the WLAN goes down everywhere at once, suspect the WLC before suspecting the APs.

> **Trap 2:** **5 GHz is faster but shorter-range than 2.4 GHz.** If a user complains about Wi-Fi dropping in the far conference room, the answer is often "their device latched onto 5 GHz at the edge of range and won't roam back to 2.4." Band steering on the WLC fixes this.

> **Trap 3:** **CAPWAP uses UDP 5246/5247, not TCP.** Don't confuse with LWAPP (the older protocol it replaced).

> **Trap 4:** A **rogue AP** is an unauthorized AP on your network. An **evil twin** is an AP impersonating your SSID to harvest credentials. CompTIA will swap these definitions.

## Helpdesk reality

- User: *"The Wi-Fi is slow."* You check the WLC dashboard. They're connected at -78 dBm on 2.4 GHz channel 11, fighting three neighboring APs. The problem is RF, not bandwidth. Tell them to walk ten feet toward the AP. It will work.
- User: *"I can't connect to the Wi-Fi."* Ninety percent of the time: expired password, expired cert (for 802.1X), or device stuck remembering the old SSID. Forget-the-network-and-rejoin solves more wireless tickets than any other action.
- User: *"It worked yesterday."* Check the WLC for AP downtime overnight. A PoE switch rebooted, an AP didn't come back up, half the floor is now covered by the AP next door at terrible signal.
- Never promise "it'll be fixed in 5 minutes." RF problems take a site survey. A site survey takes a day. Set expectations honestly.
- Escalation: if you've confirmed the client is associated, has an IP from DHCP, and can ping the default gateway but nothing beyond — it's no longer a wireless problem. Hand it to the network team. The radio did its job.

## Related concepts

[[Switch]] · [[Router]] · [[Firewall]] · [[VLANs and trunking]] · [[802.1X authentication]] · [[RADIUS]] · [[PoE and PoE+]] · [[DHCP]] · [[Wireless security WPA2 WPA3]] · [[Wireless site survey]] · [[Rogue AP and evil twin]] · [[OSI model Layer 2]]

*Source: VIRGIL knowledge base — 2026-05-11*