# Wireless LAN Configuration

## What it is

A Wireless LAN Controller (WLC) is the raid leader of your wireless network. Individual access points (APs) are the squad members — they hear what's happening on the wireless side, but every meaningful decision (where to go, who to trust, what VLAN to dump traffic into) gets called by the leader. Without the WLC, a lightweight AP is basically a Helldiver with no Super Destroyer overhead — it can't do much on its own.

Technically, the WLC is a centralized device that manages a fleet of lightweight APs. It translates 802.11 wireless frames into 802.3 Ethernet frames, maps SSIDs to VLANs, enforces security and QoS, and shepherds clients as they roam between APs. The APs themselves stay "dumb" on purpose — they handle real-time radio stuff (beaconing, encryption at the radio level, ACKs) while the WLC handles the brains. This division of labor is called the **split-MAC architecture**.

The glue between AP and WLC is **CAPWAP** — a tunneling protocol that wraps wireless traffic inside regular IP packets so it can travel across your wired network to the controller and back.

## Why it matters

Configuring a hundred standalone APs is like manually leveling a hundred Pokémon — you'd lose your mind, and they'd all end up with slightly different movesets. Centralized control means one config, one security policy, one VLAN map, applied everywhere consistently. Add a new SSID? Push it from the WLC and every AP gets it instantly.

It also makes roaming actually work. When you walk from the kitchen to the bedroom and your phone hops between two APs without dropping your video call, that handoff is coordinated by the WLC through the CAPWAP tunnel. Standalone APs would treat each handoff like a fresh login at a new bouncer's door.

## Key facts

### Split-MAC: who does what

- **WLC handles**: Layer 2 management, security policy, VLAN-to-WLAN mapping, CAPWAP tunneling, client roaming, QoS enforcement. Think of it as the game server.
- **Lightweight AP handles**: real-time radio operations only. It's the client process — fast reflexes, no strategy.

### CAPWAP — the tunnel between AP and WLC

- Encapsulates 802.11 frames inside IP packets so they can be carried across the wired LAN to the WLC.
- **UDP 5246** = control plane (the chat channel between AP and WLC).
- **UDP 5247** = data plane (the actual user traffic).
- Optional **DTLS** encryption — control traffic is encrypted by default; data traffic encryption is optional.
- Enables seamless client handoff between APs because all traffic funnels through one brain.

### WLC physical ports

- Can be configured as **access ports**, **trunk ports**, or **LAG members**.
- Cisco WLCs support only **static LAG (mode on)** — no LACP, no PAgP. It's a "trust me, both sides are bundled" arrangement, like co-op in Elden Ring where you both just have to know the rules ahead of time.

### WLC logical interfaces

These are virtual interfaces inside the WLC, each with a job:

- **Management Interface** — the WLC's own IP for GUI, SSH, Telnet. The admin's front door.
- **AP-Manager Interface** — the CAPWAP tunnel endpoint that APs talk to.
- **Virtual Interface** — a loopback-style address used for client mobility and DHCP relay tricks. Not reachable from the outside; it's an internal anchor.
- **Dynamic Interface** — maps each SSID to its client VLAN. One per client VLAN, basically. This is how guest Wi-Fi traffic ends up on VLAN 50 while corporate traffic ends up on VLAN 10.

### WLAN configuration (in WLC-speak)

In WLC GUI terminology, a **WLAN** = one SSID and its associated config bundle. Each WLAN gets:

- An SSID name (the network name your phone sees)
- Security settings
- QoS profile
- VLAN mapping (which Dynamic Interface it ties to)

You can host multiple WLANs on the same AP — like running multiple Discord servers from the same account, each with its own rules and members.

### WPA2 security

- Defined by the **802.11i** standard.
- **WPA2-PSK** uses a passphrase between **8 and 63 characters** — your standard home Wi-Fi password setup.
- Encryption algorithm is **CCMP (AES)**. AES is the industrial-grade lock; CCMP is the specific way it's bolted onto wireless frames.

### Lightweight AP onboarding — the boot sequence

When a lightweight AP powers on, it has no idea where its WLC lives. It's a fresh recruit looking for HQ. The process:

1. AP plugs into a switch on an **access port in the management VLAN**.
2. AP gets an IP via DHCP.
3. **DHCP Option 43** (Cisco vendor-specific) hands the AP the WLC's IP address — this is the "go talk to that controller" instruction. Without Option 43, the AP is lost.
4. **DHCP Option 42** can hand over the NTP server so the AP's clock is right (certificates won't validate with a wrong clock).
5. AP builds CAPWAP tunnel to WLC, downloads its config, and goes live.

The **management VLAN** is what carries this initial AP-to-WLC handshake. After that, client traffic can land on whatever VLANs the Dynamic Interfaces map them to.

### Supporting wired-side config

- **STP PortFast** on the AP's switchport skips the ~30-second STP convergence delay. Without it, the AP sits there twiddling its thumbs through listening/learning states while DHCP times out — like waiting through an unskippable cutscene every reboot.
- A **multilayer switch** routes between VLANs using **SVIs** (`interface vlan X`), which act as the default gateway for hosts in that VLAN. So your wireless guest VLAN and corporate VLAN can both exit through the same switch without a separate router.

## Related concepts

[[CAPWAP]]
[[Split-MAC Architecture]]
[[802.11i and WPA2]]
[[DHCP Options]]
[[VLANs and Trunking]]
[[STP PortFast]]
[[SVI and Inter-VLAN Routing]]
[[LAG and EtherChannel]]
[[Wireless Roaming]]