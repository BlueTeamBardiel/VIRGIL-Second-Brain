# Network Devices

## What it is

Your home network is a small city. The **ISP's pipe** is the highway in. The **modem or ONT** is the border crossing — translating the ISP's signal into Ethernet your gear can speak. The **router** is city hall — it decides where every packet goes, hands out addresses, and runs the front gate. The **switch** is the local road grid — moving traffic between rooms at full speed. The **access point** is the cell tower for anything without a cable. The **firewall** is the immune system, deciding what gets in and what bounces. The **NIC** is the mouth and ears of every machine on the network.

Plain English: networking hardware is a stack of specialized boxes, each doing one job. In a home, two or three of them are crammed into one plastic shell labeled "wireless router." In an enterprise, every job runs on its own dedicated device, in a rack, with a console cable plugged into the back.

Technical: Layer 1 (PoE, patch panels, NICs, cabling) handles physical signaling. Layer 2 (switches, MAC addresses, access points) moves frames inside a network. Layer 3 (routers, firewalls) moves packets between networks and decides who's allowed to talk.

## Why it matters

Objective 220-1201 2.5 expects you to know what every box on this list does, where it sits, and how it differs from its neighbors. CompTIA loves the "what device do you install to solve X" question — and the trap answers always look plausible.

In the field, this is the language of every network ticket you'll ever touch. "The internet is down" could be the modem, the ONT, the router, the switch, the AP, the cable, the NIC, or the ISP. Knowing which box owns which symptom is the difference between fixing it in five minutes and rebooting random equipment for an hour.

## In your build, in the enterprise

**Beat 1 — Technical depth.** A **modem** terminates a coax line from a cable ISP and converts DOCSIS signaling to Ethernet. A **DSL modem** does the same for copper phone-line signaling. An **ONT** (Optical Network Terminal) terminates fiber — the ISP runs glass to your house, the ONT converts photons to electrons. A **router** has at least two interfaces (WAN and LAN), runs NAT, hands out DHCP, and forwards packets between networks. A **switch** is a Layer 2 device that learns MAC addresses and forwards frames only out the port where the destination lives — unlike a hub, it doesn't broadcast everything everywhere. **Managed switches** expose VLANs, QoS, port mirroring, and a config interface; **unmanaged switches** are dumb and just work. **Access points** bridge wireless clients onto the wired network. **Firewalls** filter traffic by rules — stateful inspection, port/protocol, sometimes Layer 7 application awareness. **PoE** delivers power over the same Ethernet cable carrying data: 802.3af (15.4W), 802.3at (30W), 802.3bt (60W or 90W). A **patch panel** is a passive termination point — solid-core wall runs land on the back, patch cables connect the front to switches.

**Beat 2 — Feynman example via gaming/personal build.** You move into a new apartment with gigabit fiber. The ISP installs a small white box on the wall — that's the **ONT**. It converts the fiber signal to a regular Ethernet jack.

**The router:** You plug the ONT into the WAN port of your own router (not the ISP's combo box, because that thing's firmware hasn't been updated since 2022). The router gets a public IP from the ISP, hands out 192.168.1.x to everything inside, and runs your firewall rules. *One device, three jobs: gateway, DHCP server, firewall.*

**The switch:** You've got a gaming PC, a NAS, a Plex server, a console, and a Steam Deck dock — five wired devices, and the router only has four LAN ports. So you drop a cheap 8-port **unmanaged switch** under the desk. Plug it into the router, plug everything else into the switch. The switch learns MACs in seconds and forwards traffic at line rate. *You don't need to configure it. That's the entire point of unmanaged.*

**The AP:** Your phone, laptop, and smart bulbs need wireless. The router has Wi-Fi built in, but the signal dies at the back bedroom. You hang a real **access point** on the ceiling, run a single Cat6 to it, and power it via **PoE** from a small PoE injector. One cable, power and data, no wall wart near the AP. *PoE exists because running mains power to ceiling-mounted devices is miserable.*

**The kicker:** The ISP combo box you bypassed was modem + router + switch + AP in one shell. It worked. It just worked badly at all four jobs simultaneously. *Separating concerns is why your network stops crashing during raid night.*

**Beat 3 — Bridge from gaming to enterprise.** Now scale that apartment up to a 200-person office. The ONT is still an ONT — but now it feeds a business router with redundant WAN links and a real firewall appliance behind it (Palo Alto, Fortinet, pfSense on real hardware). The "switch under the desk" becomes a stack of 48-port **managed switches** in a rack, with VLANs separating the guest network from the finance network from the VoIP phones. The wall jacks in every cubicle don't go to switches directly — they terminate at a **patch panel** in the server room, and short patch cables hop from the panel to the switches. The "AP on the ceiling" becomes 40 APs on the ceiling, all powered by **PoE switches** (no injectors at scale — that's a wiring closet you don't want to manage), all controlled by a centralized wireless controller. The firewall is no longer "a checkbox in the router config" — it's a dedicated appliance with its own Layer 7 inspection, IPS, and a full-time admin tuning rules.

**Beat 4 — The point.** Same fundamental question at every scale: *where does the traffic enter, who routes it, who switches it, who carries it the last hop, and who decides what's allowed?* In your apartment those jobs collapse into two boxes. In the enterprise they're seven boxes in a rack. The questions are identical. Get them into your bones — every network you'll ever troubleshoot is some version of this same diagram.

## Key facts

### The device map

| Device | Layer | Job | Home | Enterprise |
|---|---|---|---|---|
| Cable modem | L1/L2 | DOCSIS coax → Ethernet | ISP-supplied | Rare; business cable exists |
| DSL modem | L1/L2 | Phone-line copper → Ethernet | Legacy/rural | Branch offices in DSL-only areas |
| ONT | L1 | Fiber → Ethernet | ISP-installed wall box | Same box, business SLA |
| Router | L3 | Inter-network forwarding, NAT, DHCP | Combo box or prosumer | Dedicated, redundant, BGP |
| Switch | L2 | Forwards frames by MAC | Unmanaged 5–8 port | Managed 24/48 port stacks, VLANs |
| Access point | L2 | Wireless ↔ wired bridge | Built into router | Ceiling-mount, PoE, controller-managed |
| Firewall | L3/L4/L7 | Traffic filtering | Router feature | Dedicated NGFW appliance |
| Patch panel | L1 | Passive cable termination | None | Every server room |
| NIC | L1/L2 | Host's network interface | Onboard | Onboard + add-in (10G, fiber) |

### Managed vs unmanaged switches

**Unmanaged:** plug-and-play. No config, no IP, no web UI. Forwards frames, that's it. Fine for a home. Useless when you need VLANs.

**Managed:** has its own IP, web/CLI/SSH access. Supports VLANs, port mirroring (SPAN), QoS, link aggregation (LACP), STP tuning, PoE per-port control. Mandatory in any environment with multiple network segments — guest Wi-Fi, VoIP, IoT, production all on separate VLANs sharing the same physical switch.

### NIC — physical media access

The NIC is where the OS meets the wire. Every NIC has a **MAC address** — 48 bits, burned in at the factory (the first 24 bits identify the manufacturer — the OUI). The MAC is how Layer 2 identifies who's who on the local segment. The NIC handles framing, CRC, collision detection (legacy), and physical signaling — copper, fiber, or wireless radio.

Modern NICs offload work the CPU used to do: TCP segmentation, checksum calculation, RSS for multi-core scaling. Server NICs add SR-IOV for VM passthrough and 10/25/40/100 Gbps speeds. Your gaming PC has a 2.5GbE NIC onboard. A storage server has dual 25GbE on an add-in card.

### PoE — Power over Ethernet

PoE sends DC power down the unused (or data-shared) pairs of an Ethernet cable. One cable to the AP, the IP camera, the VoIP phone, the door reader — power and data both.

| Standard | Common name | Power at PSE | Power at PD |
|---|---|---|---|
| 802.3af | PoE | 15.4 W | 12.95 W |
| 802.3at | PoE+ | 30 W | 25.5 W |
| 802.3bt Type 3 | PoE++ / 4PPoE | 60 W | 51 W |
| 802.3bt Type 4 | PoE++ / 4PPoE | 90 W | 71.3 W |

**PSE** (Power Sourcing Equipment) is the switch or injector. **PD** (Powered Device) is the AP, camera, phone.

**Injector vs PoE switch:** an injector is a small inline brick — data in from a regular switch, data + power out to the device. Use injectors when you have one or two PoE devices and a non-PoE switch. **PoE switches** have power built into every port (or a subset) — use them when you have more than a few PoE devices. At scale, injectors become a wiring nightmare.

> **CompTIA exam trap:** Modem vs router. The modem talks to the ISP. The router talks to your devices and to the modem. CompTIA will show you a topology and ask which device fails when "internet works inside the house but the WAN is down" — that's the modem/ONT, not the router.

> **CompTIA exam trap:** Switch vs hub. Hubs are dead in production but alive on exams. A hub repeats every frame to every port (one collision domain). A switch forwards frames only to the destination port (one collision domain per port). If the question mentions collision domains, it's testing this distinction.

> **CompTIA exam trap:** PoE standards and wattage. Memorize the three numbers — 15.4W, 30W, 90W — and which standard goes with which. CompTIA loves to ask "you need to power a 60W device, which standard?" Answer: 802.3bt.

> **CompTIA exam trap:** ONT is fiber, DSL modem is copper phone line, cable modem is coax. They all output Ethernet. Don't confuse the input side.

## Helpdesk reality

- **"The internet is down."** Check the modem/ONT lights first — that tells you if the ISP signal is alive. If those are green, move to the router. If router lights are good, check the user's NIC and cable. Layer 1 up.
- **"Wi-Fi works in the living room but not the bedroom."** Not a router problem — a coverage problem. Recommend an additional AP or mesh node, not a router replacement.
- **"My VoIP phone won't power on."** Check if the switch port is PoE-enabled and if the budget isn't exceeded. Managed switches show per-port PoE status. A 24-port switch with a 370W PoE budget can't power 24 full-PoE+ devices simultaneously — the math doesn't work.
- **"I plugged in a new switch and now nothing works."** Check for a switching loop. They plugged both ends of a patch cable into the same switch, or daisy-chained two switches in a loop. STP should catch it on a managed switch. Unmanaged switch + loop = broadcast storm = network down.
- **"Can I just use the ISP's combo box?"** You can. It'll work. It will also be slower, less secure, and harder to troubleshoot when it breaks. In a business environment: never. Always your own router and firewall behind the ISP gear, even if the ISP gear stays in place as a bridge.

## Related concepts

[[Network Cables and Connectors]] · [[TCP-IP and Ports]] · [[Wireless Networking and Standards]] · [[SOHO Router Configuration]] · [[VLANs and Network Segmentation]] · [[Firewalls and Network Security]] · [[OSI Model Layers]]

*Source: VIRGIL knowledge base — 2026-05-10*