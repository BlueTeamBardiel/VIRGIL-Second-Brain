# Life Cycle Management

## What it is

In **Civilization**, you build a Warrior on turn 12. He's useful — clears barbarians, scouts the map, escorts a Settler. Then it's turn 90 and you discover Iron Working. You upgrade him to a Swordsman. Turn 140, Gunpowder — he becomes a Musketman. Turn 200, you're researching Industrialization and that same unit, now a Rifleman, is staring down an enemy's Cavalry. Eventually he's obsolete. You disband him for the gold, or he dies to a Tank because you didn't upgrade in time. Every unit, every building, every Wonder has a window where it matters and a window where it's a liability sitting on a tile costing maintenance.

That's exactly what life cycle management does — it tracks every asset on your network from the day you rack it to the day you wipe it and recycle the chassis, so nothing rots in production while you're not looking.

**Life cycle management** is the organizational process of tracking hardware, software, firmware, and configurations across their useful life: procurement, deployment, operation, maintenance, decommissioning, and disposal. CompTIA wraps it together with documentation, change management, and configuration management under Objective 3.1 because in practice you cannot do one without the others.

## Why it matters

The number one reason networks catch fire is that someone forgot a switch existed. A 2012 Cisco 2960 humming in a closet, running firmware with a known CVE, no support contract, no one logged into it in four years. It works until it doesn't, and when it doesn't, nobody has the password and nobody knows what VLANs are trunked across it.

On the exam, expect questions on **EOL vs EOS**, what belongs in a **physical vs logical diagram**, why a **golden configuration** matters, and the difference between **change management** and **configuration management**. In the field, this is the difference between a clean audit and a six-figure fine. *Auditors don't care that your network works. They care that you can prove you know what's on it.*

## Key facts

### Documentation — the artifacts you maintain

You document so the next person (often: you, in eighteen months, at 3am) can understand what's there without reverse-engineering it.

| Artifact | What it shows | Why CompTIA cares |
|---|---|---|
| **Physical diagram** | Actual cabling, rack positions, port-to-port runs, [[Layer 1]] reality | Where the fiber actually goes between buildings |
| **Logical diagram** | IP subnets, VLANs, routing, [[Layer 3]] flow | How traffic moves regardless of which cable carries it |
| **Rack diagram** | U-by-U layout of each rack, PDU assignments, weight distribution | Field tech finds the device without counting from the top |
| **Cable map** | Patch panel port → switch port → wall jack → workstation | The only document that matters during a [[Cable Testing\|cable fault]] |
| **Network diagram** | Umbrella term — usually logical, sometimes a hybrid | The thing you hand a new hire on day one |
| **[[Wireless Survey]] / heat map** | Signal strength overlaid on floor plan, AP placement, channel plan | Pre-deployment and post-deployment, mandatory for 2.4/5/6 GHz planning |
| **Asset inventory** | Every device, model, serial, location, owner, warranty status | The single source of truth for everything below |

The asset inventory is the spine. Lose it and every other document is fiction.

### The life cycle stages

1. **Procurement** — purchase order, warranty registration, asset tagging
2. **Deployment** — rack, cable, configure, document, add to inventory and IPAM
3. **Operation** — monitor, patch, back up configs
4. **Maintenance** — firmware updates, hardware refresh, license renewals
5. **End-of-life (EOL)** — vendor announces the product line is discontinued; you can still buy it briefly, support continues
6. **End-of-support (EOS)** — vendor stops releasing patches, bug fixes, and security updates; the device is now a ticking CVE
7. **Decommissioning** — wipe configs, remove from inventory, secure-erase storage, recycle or destroy

> **CompTIA exam trap:** EOL and EOS are not the same. **End-of-Life** = no longer sold; existing support contracts continue. **End-of-Support** = no more patches, period. A device can be EOL for years before it hits EOS. The exam will give you a scenario with both dates and ask which one triggers a forced replacement. EOS is the hard deadline.

### Hardware life cycle

**[[Hardware]]** lives on physical timelines: warranty, depreciation, mean time between failure. Track:

- Model, serial, MAC, asset tag
- Purchase date, warranty expiration, **[[Warranty Support]]** tier (next-business-day, 4-hour, 24x7)
- Physical location (building, room, rack, U-position)
- Power draw and PDU port

**Warranty support** tiers matter at 2am. A 4-hour replacement SLA on your core router is worth its weight in gold. NBD on a closet switch with a hot spare is fine. *Match the warranty tier to the blast radius of the failure, not to the price of the device.*

### Software life cycle

**[[Software]]** has its own clocks running in parallel: vendor support, license expiration, security patch cadence.

- **[[Operating System|OS]]** — Cisco IOS, IOS-XE, NX-OS, JunOS, Arista EOS, FortiOS. Each has a release train with maintenance, extended, and deferred branches.
- **Firmware** — the code on switches, APs, NICs, drive controllers. Often forgotten until a CVE drops.
- **[[Patches and Bug Fixes]]** — vendor-released code changes. Test in lab, schedule via change management, never push to production on a Friday.
- **Licensing** — feature licenses (DNA, ATP, threat-prevention) often expire independently of the hardware. An expired license can disable features silently.

Software management means knowing which version runs where, when it was patched, and when the license renews. If you can't answer those three questions for every device, you don't have software management — you have software hope.

### Configuration management vs change management

These are different things and CompTIA will test the distinction.

**[[Configuration Management]]** is about *what the configuration is*:
- **Production configuration** — what's running right now on the device
- **Backup configuration** — the most recent known-good snapshot, stored off-device
- **Baseline / golden configuration** — the standard template every device of this class is built from (e.g., every access switch gets the same SNMP community, same NTP servers, same management VLAN, same syslog target)

**[[Change Management]]** is about *how the configuration changes*:
- **Request process tracking** — ticket opened, business justification documented
- **Service request** — formal submission for review
- **Approval** — Change Advisory Board (CAB) signs off
- **Implementation window** — scheduled maintenance, not whenever
- **Rollback plan** — *if you can't undo it in fifteen minutes, you're not ready to deploy it*
- **Post-change verification** — does it actually work, and did it break anything else?

> **CompTIA exam trap:** Configuration management answers "what is configured?" Change management answers "how did it get that way and who approved it?" A backup config is configuration management. A ticket with CAB approval is change management. The exam will phrase one and offer the other as a distractor.

### IPAM — the address book

**IP Address Management (IPAM)** tracks every IP allocation across the organization: static assignments, DHCP scopes, reserved blocks, VLAN-to-subnet mappings, DNS records. Without IPAM you get duplicate IPs, exhausted scopes, and the immortal helpdesk ticket *"the printer was working yesterday."*

Modern IPAM tools (Infoblox, BlueCat, phpIPAM, NetBox) integrate with DNS and DHCP so the three stay in sync. *Spreadsheet IPAM is fine until two admins edit the same row.*

### SLAs — the contract that defines "broken"

A **Service-Level Agreement (SLA)** is the written contract between IT and the business (internal) or between you and a vendor (external) defining:

- Uptime target (99.9% = ~8.76 hours downtime/year; 99.99% = ~52 minutes)
- Mean time to respond and mean time to repair
- Penalties for missing the target
- What's explicitly excluded (scheduled maintenance, force majeure)

SLAs feed back into life cycle decisions: a 99.99% SLA means you need redundant hardware, hot spares, and 4-hour warranty support. *The SLA dictates the budget, not the other way around.*

### Decommissioning — the part everyone skips

When a device hits EOS or gets replaced:

1. Capture final config to the archive
2. Remove from monitoring, IPAM, DNS
3. Revoke certificates and management credentials
4. Wipe the device (factory reset is not enough — secure-erase storage)
5. Update the asset inventory with disposition (recycled, destroyed, sold, redeployed)
6. Physically remove from the rack and update the rack diagram
7. Certificate of destruction if data-bearing

The most common breach vector for decommissioned gear is a switch sold on eBay with the running config still intact, including the IPsec pre-shared keys to a partner network.

### CompTIA exam traps

> **Trap — physical vs logical diagram:** Physical = cables, racks, ports. Logical = IPs, VLANs, routing. If the question mentions a [[Layer 1]] or [[Layer 2]] cable run, it's physical. If it mentions subnets or routing, it's logical.

> **Trap — golden config:** The golden / baseline configuration is the *template*, not the current running config. Production config drifts from golden over time. Configuration management catches the drift.

> **Trap — firmware vs OS:** On a switch, the OS (IOS, NX-OS) is often called firmware in vendor docs. CompTIA generally treats firmware as the lower-level code on components (NICs, controllers, APs) and OS as the device's main software. Read the question carefully.

## Helpdesk reality

- **"My new laptop can't get on the network."** — Asset wasn't added to IPAM, MAC isn't in the NAC allow-list, or the switch port is still in the wrong VLAN from the last user. Check the inventory before you check the cable.
- **"This switch is acting weird since last Tuesday."** — Pull the change log for last Tuesday. Ninety percent of "weird" is "someone changed something and didn't document it."
- **"Can you just push the firmware update real quick?"** — No. It goes through change management. *"Real quick"* is how outages are born.
- **Never promise** an unsupported (EOS) device will be patched against a new CVE. It won't. The answer is replacement, not patching.
- **Escalation point:** if a device is past EOS and management won't fund replacement, get the risk acceptance in writing. *Verbal risk acceptance evaporates the moment the breach hits the news.*

## Related concepts

[[Change Management]] · [[Configuration Management]] · [[Network Documentation]] · [[Asset Inventory]] · [[IPAM]] · [[Wireless Survey]] · [[Rack Diagrams]] · [[Patches and Bug Fixes]] · [[SLA]] · [[Decommissioning]] · [[Backup and Recovery]]

*Source: VIRGIL knowledge base — 2026-05-11*