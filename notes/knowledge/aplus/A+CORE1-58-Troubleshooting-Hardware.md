# Troubleshooting Hardware

## What it is

The topic title says "Troubleshooting Hardware" but the objective is networking gear — routers, switches, modems, ONTs, NICs, patch panels, firewalls, access points, PoE. This is the **nervous system and the voice** of every network: the boxes that carry signals between machines and the wider world, plus the diagnostic mindset for when one of them goes dark.

In plain English: a packet leaves your PC's NIC, crosses a patch cable to a wall jack, runs through structured cabling to a patch panel, lands on a switch port, gets routed by a router, hits a firewall, and finally exits through a modem or ONT to the ISP. Any one of those links can fail. Your job is to figure out which one — fast — without ripping out the whole stack.

Technical definition: networking hardware is the layer 1 and layer 2 infrastructure that moves frames between endpoints, plus the layer 3 boundary devices (routers, firewalls) that move packets between networks. Each device has a specific role, specific failure modes, and specific diagnostic signals.

## Why it matters

Networking failures are the #1 helpdesk ticket category outside of password resets. Users don't say "the switch port is in err-disabled state" — they say "internet's broken." Your career value is the speed at which you translate vague complaints into the correct box to power-cycle, replace, or escalate.

CompTIA tests this on **220-1201 Objective 2.5** (networking hardware devices) and weaves it through Objective 5.x (troubleshooting). Expect questions that hand you a symptom and ask which device is the likely culprit, plus questions on PoE standards and DSL-vs-ONT-vs-cable-modem identification.

## In your build, in the enterprise

**Beat 1 — Technical depth.**

The cast of devices, ranked by where the signal travels:

- **NIC** — physical media access. Every device has one (or several). Has a burned-in **MAC address** — 48-bit hex, first 24 bits identify the vendor (OUI), last 24 bits identify the specific card. Speeds: 1 GbE standard, 2.5/5/10 GbE on enthusiast and enterprise gear. Wireless NICs do the same job over radio.
- **Patch panel** — passive. No power, no logic. Just a termination point where structured in-wall cabling meets short patch cables that run to the switch. Bad terminations here cause intermittent drops that look like switch problems.
- **Switch** — layer 2. Forwards frames by MAC address. **Unmanaged** switches are plug-and-play, zero config, found at home and in tiny offices. **Managed** switches support VLANs, port mirroring, QoS, STP, SNMP — required in any real enterprise.
- **Router** — layer 3. Forwards packets between networks. The thing that knows where the internet is.
- **Firewall** — filters traffic by rules. May be a dedicated appliance (Palo Alto, Fortinet) or a feature on the router (home gear) or a host-based service (Windows Defender Firewall).
- **Access Point (AP)** — bridges wireless clients onto the wired network. Has its own MAC, broadcasts an SSID, handles 802.11 a/b/g/n/ac/ax/be.
- **Cable modem** — converts ISP coax (DOCSIS) to Ethernet.
- **DSL modem** — converts ISP twisted-pair phone-line signal to Ethernet. Mostly legacy now.
- **ONT (Optical Network Terminal)** — converts ISP fiber to Ethernet. The endpoint of a fiber drop. Typically **unmanaged** from the customer side — the ISP owns it.
- **PoE** — Power over Ethernet. Delivers power and data over the same Cat5e/6 cable. Standards: **802.3af (PoE, 15.4W)**, **802.3at (PoE+, 30W)**, **802.3bt (PoE++, 60W or 90W)**. Delivered by a PoE-capable **switch** or by an inline **injector** sitting between a regular switch and the powered device.

**Beat 2 — Feynman example via your home network.**

It's 11pm, you're in a Tarkov raid, and your ping spikes from 40 to 800. You die. You rage-quit. Now you're a detective.

**Step 1 — Identify.** Is it just you, or is everyone on the network suffering? Phone on Wi-Fi: also slow. Roommate on his PC: also slow. *Whole network, not just your machine.*

**Step 2 — Theory.** Could be the router, the modem/ONT, or the ISP itself. Look at the modem/ONT lights. Solid green on all four LEDs means signal is fine, problem is downstream — your router or your Wi-Fi. Flashing red on the WAN/Internet light means the ISP side is the problem. *The lights are the dashboard. Read them before touching anything.*

**Step 3 — Test.** Plug your PC directly into the modem with Ethernet. If speed is fine, the router or AP is the culprit. If speed is still bad, the ISP or modem is. *Bypass the suspect, see if the symptom moves.*

**Step 4 — Fix.** Power-cycle the router. If that doesn't work, log into it and check for a firmware update, overheating chassis, or a saturated channel on the 2.4 GHz band. *Cheap consumer routers die slowly from heat — they don't crash, they get flaky.*

**The kicker:** the actual cause was your roommate started a 4K stream while a Windows Update was downloading. *Bandwidth saturation looks identical to hardware failure until you check who's using the pipe.* Get used to that question — you'll ask it for the rest of your career.

**Beat 3 — Bridge to the enterprise.**

Same detective work, bigger stack, higher stakes. The user calls: "my desk phone and my PC both lost connection." You ask: just you, or the whole row? Whole row. *Now it's not the user's NIC or patch cable — it's upstream.*

At home you had one router and one switch built into it. In the enterprise the signal path looks like:

> Wall jack → patch panel in the IDF closet → switch port → distribution switch uplink → core switch → firewall → router → ISP handoff (ONT or fiber transceiver)

For the dead-row problem, you walk to the IDF closet, look at the switch. One port LED is dark — that's the uplink to distribution. Cable's seated. Other end on the distribution switch is amber/flashing — link negotiation failing. Replace the patch cable between patch panel and switch. Lights come back. Row's back online.

If the desk phones are PoE, you also check that the switch's PoE budget isn't exhausted. A 24-port switch with a 370W PoE budget can power maybe 12 phones at PoE+ before it starts dropping power to the lowest-priority ports. *PoE budget is the silent killer in growing offices — nobody tracks it until phones randomly reboot.*

**Beat 4 — The point.**

**Home network**: one router/switch/AP combo box, one modem or ONT, three cables total. Power-cycle solves 80% of issues.

**Enterprise network**: separate firewall, separate router, core switch, distribution switches, dozens of access switches, dozens of APs, hundreds of patch panels and cables. Power-cycling at random is malpractice — you'll take down a whole floor.

Same fundamental question on both: **where does the signal stop?** Walk the path. Read the lights. Bypass the suspect. The diagnostic mindset scales; the consequences of guessing scale faster. Get this question into your bones.

## Key facts

### ISP edge devices

| Device | ISP medium | Tech | Typical role |
|---|---|---|---|
| **Cable modem** | Coax | DOCSIS 3.0/3.1/4.0 | Home and SMB |
| **DSL modem** | Twisted pair phone line | ADSL/VDSL | Legacy, rural |
| **ONT** | Fiber | GPON/XGS-PON | Modern home and enterprise |

ONTs are nearly always **unmanaged from the customer side** — the ISP provisions them and you don't touch the config. Cable and DSL modems can be either ISP-locked or customer-owned (managed by you).

### PoE standards

| Standard | Common name | Max power per port | Typical use |
|---|---|---|---|
| **802.3af** | PoE | 15.4W (12.95W at device) | VoIP phones, small APs |
| **802.3at** | PoE+ | 30W (25.5W at device) | Modern APs, PTZ cameras |
| **802.3bt Type 3** | PoE++ / 4PPoE | 60W | High-power APs, video bars |
| **802.3bt Type 4** | PoE++ / 4PPoE | 90W | LED lighting, thin clients, displays |

**PoE delivery methods:**
- **PoE switch** — purpose-built, all ports can deliver power up to the switch's total PoE budget
- **PoE injector** — inline brick between a non-PoE switch and the powered device. Power in on one side, data in on another, combined PoE-data out the third port. Cheap retrofit for one or two devices.

### Switch types

- **Unmanaged** — plug it in, it works. No VLANs, no monitoring, no config. Home, small office, or behind-a-desk expansion.
- **Managed** — full config: VLANs, STP, port security, link aggregation, QoS, SNMP, port mirroring. Every enterprise switch.

### MAC addresses

48-bit, written as six hex pairs: `00:1A:2B:3C:4D:5E`. First three pairs = **OUI** (Organizationally Unique Identifier, assigned to vendor by IEEE). Last three = unique per device. Burned into the NIC at manufacture — but spoofable in software (relevant for security and for MAC filtering bypass).

### CompTIA exam traps

> **CompTIA exam trap:** ONT vs cable modem vs DSL modem. ONT = fiber, cable modem = coax, DSL = phone-line twisted pair. CompTIA will describe the physical medium and expect you to name the device. Don't overthink it — match the cable to the box.

> **CompTIA exam trap:** routers vs switches. Switches forward by MAC (layer 2, within a network). Routers forward by IP (layer 3, between networks). A "router" you buy at Best Buy is actually a router + switch + AP + firewall in one box — but on the exam, treat each function discretely.

> **CompTIA exam trap:** PoE standards by wattage. Memorize: af = 15.4W, at = 30W, bt = 60W or 90W. If a question gives you a device wattage requirement and asks which standard, work backward from the table.

> **CompTIA exam trap:** patch panel is **passive**. No power, no logic. If a question describes a "device that terminates structured cabling without active electronics," it's a patch panel, not a switch.

## Helpdesk reality

- **"The internet is down."** → Just you, or everyone? That single question routes the entire ticket. Single user = their machine, their cable, their port. Everyone = upstream gear.
- **"My desk phone keeps rebooting."** → PoE budget exhausted on the switch, or a failing PoE injector, or a marginal cable that can't carry full power. Check the switch's PoE utilization before blaming the phone.
- **"My laptop won't connect to Wi-Fi but my phone does."** → Driver, NIC radio, or saved-network corruption on the laptop. The AP is fine — phone proved it.
- **"It worked yesterday."** → Something changed. Patch cable kicked loose, port shut down by security policy, switch rebooted overnight, ISP maintenance window. Ask what's different, walk the path.
- **Never promise** a fix time on ISP-side outages. You don't control the ONT or the line to the street. Set expectations: "I've confirmed the issue is with the carrier, ticket is open, I'll update you when they update me."

## Related concepts

[[Cabling and Connectors]] · [[TCP IP Fundamentals]] · [[Wireless Standards]] · [[SOHO Networking]] · [[Network Troubleshooting Tools]] · [[Firewalls and Security Appliances]] · [[VLANs and Managed Switches]]

*Source: VIRGIL knowledge base — 2026-05-10*