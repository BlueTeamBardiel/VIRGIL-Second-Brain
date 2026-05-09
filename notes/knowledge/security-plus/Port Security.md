# Port Security

## What it is

In Assassin's Creed, every restricted area has guards who check whether you belong — wear the wrong robes near a Templar checkpoint and the eagle icon flips red, alarms sound, and you're swarmed before you reach the next rooftop. Port Security on a switch does the same thing at the network's front door: the switchport checks the MAC address of whatever just plugged in, and if it isn't on the approved list, the port shuts itself down or quarantines the intruder.

**Port Security** is a Layer 2 switch feature that restricts which devices can transmit on a physical switchport by binding the port to one or more authorized MAC addresses, with a configurable violation action when a non-approved MAC appears.

## Why it matters

Without port security, anyone with physical access to an unattended jack — a conference room, a lobby phone, an unused cubicle — can plug in a rogue laptop, a Raspberry Pi, or a malicious access point and land directly on your internal LAN. That single oversight enables [[MAC flooding]], [[ARP spoofing]], rogue [[DHCP server]]s, and unauthorized [[network sniffing]]. On the SY0-701 exam, this lives under **Objective 3.2** ("Apply security principles to secure enterprise infrastructure"). CompTIA's favorite trap: confusing **port security** (Layer 2 MAC filtering on switches) with **[[802.1X]]** (port-based authentication) or with **TCP/UDP port** filtering on a [[firewall]]. Three different things, all called "port" something.

## Key facts

### Core mechanism

- Switch maintains a **MAC address table** per port listing approved sources.
- MACs can be **statically configured**, **dynamically learned**, or **sticky** (learned dynamically, then saved to running config).
- When an unauthorized MAC transmits, the configured **violation action** triggers.

### Violation modes

| Mode | Behavior | Use case |
|------|----------|----------|
| **Protect** | Drops unauthorized frames silently | Low-noise environments |
| **Restrict** | Drops frames + logs/SNMP trap + counter increments | Monitoring with alerts |
| **Shutdown** | Port goes **err-disabled**; requires admin reset | High-security default |

### What it defends against

- **[[MAC flooding]]** — attacker fills [[CAM table]] to force switch into hub mode; port security caps MACs per port.
- **Rogue devices** — unauthorized laptops, hubs, APs, or [[IoT]] gear plugged into open jacks.
- **MAC spoofing** (partially) — limited, since static MAC binding can be defeated by an attacker who clones the legitimate MAC.

### What it does NOT defend against

- A determined attacker who **clones the authorized MAC** of a known device.
- Threats above Layer 2 — port security is blind to IP, application, or payload.
- Insiders with legitimate device access.

### Related Layer 2 hardening (often confused, often paired)

| Feature | Purpose |
|---------|---------|
| **[[802.1X]]** | Port-based authentication via [[RADIUS]]; checks identity, not just MAC |
| **[[DHCP snooping]]** | Blocks rogue [[DHCP server]]s |
| **[[Dynamic ARP Inspection]] (DAI)** | Validates ARP replies against DHCP snooping binding table |
| **[[BPDU Guard]]** | Disables port if it receives [[Spanning Tree Protocol]] BPDUs (rogue switch defense) |
| **[[Root Guard]]** | Prevents downstream switches from becoming STP root |

### Exam-relevant gotchas

- **"Sticky MAC"** is a common SY0-701 distractor — know that it's dynamic learning persisted to config.
- Port security is configured **per interface**, not globally.
- **Err-disabled** ports do not auto-recover unless `errdisable recovery` is configured.
- Pair port security with [[NAC]] (Network Access Control) for posture checking, not just identity.

## Related concepts

[[802.1X]] · [[NAC]] · [[MAC flooding]] · [[CAM table]] · [[DHCP snooping]] · [[Dynamic ARP Inspection]] · [[BPDU Guard]] · [[VLAN]] · [[Network segmentation]] · [[RADIUS]]

---
*Source: VIRGIL knowledge base — 2026-05-08*