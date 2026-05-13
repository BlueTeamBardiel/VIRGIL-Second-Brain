# Network Documentation

## What it is

In **Half-Life**, when Gordon Freeman arrives at Black Mesa, the tram ride past the facility shows you everything: the test chambers, the silos, the reactor cores, the security checkpoints. Someone built a map of that complex. Someone labeled every door, every rail line, every coolant pipe. When the resonance cascade hits and HECU marines start sweeping floor by floor, the only people who survive are the ones who know which vent leads where and which keycard opens which blast door. The scientists who didn't know the layout died at their desks.

That's exactly what network documentation does — it's the map of your facility that you draw *before* the cascade, because nobody draws good maps during a fire.

In N10-009 terms: **network documentation** is the formal, version-controlled record of every component, connection, configuration, and process that makes the network run. It covers physical hardware, logical addressing, change history, baseline configurations, vendor relationships, and lifecycle status. Documentation is what turns "tribal knowledge in one guy's head" into an asset the org actually owns.

## Why it matters

Documentation is the unsexy domain. It will not get you hired. It will get you fired faster than almost anything else when it's missing. CompTIA objective **3.1** tests it because every real outage post-mortem ends with the same line: *the documentation was out of date.*

When the senior network admin quits and the replacement starts on Monday, documentation is the entire onboarding. When the audit team shows up, documentation is the audit. When a ransomware crew encrypts the file server and you need to rebuild the core switch from scratch at 3am, the backup config and the rack diagram are the only things between you and unemployment.

*Tribal knowledge is a liability disguised as competence.*

## Key facts

### Network diagrams: physical vs. logical

Two diagrams, same network, different questions answered.

| Type | Shows | Used for |
|---|---|---|
| **Physical diagram** | Actual cables, port numbers, rack units, room locations, MDF/IDF layout | Hands-on work: cable traces, hardware replacement, smoke-test path |
| **Logical diagram** | IP subnets, VLANs, routing relationships, [[OSI Model\|OSI]] layer flow, trust zones | Design, troubleshooting at L3+, security review, change planning |

The physical diagram tells you "the cable from switch-A port 24 runs through the ceiling tile to jack B-217." The logical diagram tells you "VLAN 30 routes through the core, hits the firewall, NATs to the WAN." You need both. CompTIA will give you a scenario and ask which diagram answers the question — read carefully.

### Rack diagrams and cable maps

A **rack diagram** is the elevation view of a single rack: U1 at the bottom or top, every device labeled, every power feed noted. Good rack diagrams include weight loading, power draw, and heat output because you don't want to find out the rack is overloaded the day a UPS battery sags.

A **cable map** documents every patch run: source device/port → destination device/port, cable ID, length, type ([[Twisted Pair Cabling|Cat6a]], [[Fiber Optic Cabling|OM4 fiber]]), and termination details. The cable map is what saves you when the patch panel looks like spaghetti and you need to know which of the 48 blue cables goes to the conference room AP.

### Wireless survey / heat map

A **wireless survey** measures actual RF coverage, signal strength, noise floor, and channel utilization across the physical space. The output is a **heat map** — a floor plan colored by signal strength. You run a passive survey (just listen) for the existing environment and an active survey (associate and test throughput) for performance validation.

Heat maps drive AP placement, antenna selection, and channel planning. Without one, you're guessing — and guessing in 2.4 GHz is how you end up with three APs on channel 6 stomping on each other.

### IP address management (IPAM)

[[IPAM]] is the system of record for every IP address, subnet, VLAN, and DNS-to-IP mapping in the environment. Small shops run it in a spreadsheet (badly). Real shops run dedicated tools — phpIPAM, NetBox, Infoblox, Microsoft IPAM.

IPAM tracks:

- Subnet allocations and CIDR boundaries
- Static vs. [[DHCP]] reserved ranges
- Gateway addresses
- VLAN assignments per subnet
- DNS records tied to each IP
- Owner/purpose per address

*The day you have two devices fighting over .1 because nobody updated the spreadsheet is the day you build a real IPAM.*

### Configuration management

Three configurations every device has, and CompTIA wants you to know all three:

- **Baseline / golden configuration** — the known-good template every new device of this class starts from. The standard build. VLAN 1 disabled, default passwords removed, SNMPv3 only, syslog pointed at the collector, NTP set, banner installed.
- **Production configuration** — the live running config on the device right now. Differences from baseline are intentional and documented (or they're drift and need remediation).
- **Backup configuration** — the saved copy, ideally pulled nightly to a config-management server (RANCID, Oxidized, SolarWinds NCM, Git). Versioned. Diff-able. Restorable.

> **CompTIA exam trap:** Baseline configuration is the *template* you build from. Backup configuration is the *snapshot* of the live device. These are not the same thing. A scenario asking "what do you restore from after a config wipe?" wants the **backup**. A scenario asking "what do you compare against to detect drift?" wants the **baseline**.

### Asset inventory

Every piece of hardware and software, tracked from purchase to disposal. Minimum fields:

- Asset tag / serial number
- Make, model, MAC address
- Location (building, room, rack, U)
- Owner / department
- Purchase date, warranty expiration
- OS / firmware version
- EOL and EOS dates
- Disposal date and method (when decommissioned)

Asset inventory feeds licensing, lifecycle planning, insurance, and incident response ("is this MAC ours?").

### Software management and licensing

Track every OS, firmware, application, and license. License audits are not theoretical — Microsoft, Oracle, VMware, and Cisco will all eventually ask. Document:

- Software name and version
- License type (per-seat, per-socket, subscription, perpetual)
- License keys and entitlements
- Renewal dates
- Assigned devices/users

### Life-cycle management

Every device and software product moves through the same arc:

| Stage | Meaning |
|---|---|
| **Procurement** | Purchase, receive, asset-tag |
| **Deployment** | Provision from baseline, document in IPAM, add to monitoring |
| **Production** | Patches, firmware updates, config changes — all via change management |
| **End-of-Life (EOL)** | Vendor stops selling the product. Still supported. Plan replacement. |
| **End-of-Support (EOS)** | Vendor stops issuing patches and security fixes. **Remove from production.** |
| **Decommissioning** | Remove from rack, wipe configs, destroy/sanitize storage, update inventory, surrender license seats |

> **CompTIA exam trap:** EOL ≠ EOS. EOL means "no longer sold." EOS means "no longer patched." A device can be EOL for years while still under support. The compliance risk hits at **EOS** — running EOS gear is how you fail PCI, HIPAA, and your next pen test.

### Patches, bug fixes, firmware, and OS

Different layers of the stack, different update cadences:

- **Firmware** — the code burned into the device (switch, router, AP, NIC). Updated rarely, carefully, with a reboot. Test in lab first.
- **Operating system (OS)** — Cisco IOS, Junos, Windows Server, Linux distro. Patched on a regular cycle, security patches expedited.
- **Software** — applications running on the OS. Patched independently.
- **Bug fixes** — vendor-issued corrections to known defects, bundled into patches.

Document every change: what was applied, when, by whom, the rollback plan, and the verification step.

### Change management

The formal process that gates every production change. The flow:

1. **Request** submitted with scope, justification, risk
2. **Review** by CAB (Change Advisory Board) — peers and stakeholders
3. **Approval** or rejection with conditions
4. **Schedule** in a maintenance window
5. **Implementation** with rollback plan ready
6. **Verification** that the change worked and didn't break anything else
7. **Documentation** — update diagrams, IPAM, baseline if relevant, close the ticket

Emergency changes get an expedited path but still get documented after the fact. *"I just made a quick change"* is the seven-word horror story.

### Request process tracking and service requests

Every user-facing ask — new VLAN, port activation, firewall rule, VPN account — flows through a tracked request system (ServiceNow, Jira, Zendesk). The ticket *is* the audit trail. Verbal requests don't exist. If it's not in the ticket queue, it didn't happen.

### Warranty support and SLAs

Track every vendor warranty: device, serial, coverage start/end, support level (next business day, 4-hour, 24x7x4). Out-of-warranty production hardware is a ticking clock.

A **Service-Level Agreement (SLA)** is the contractual commitment defining uptime, response time, and resolution time — between you and a vendor, or between IT and the business. SLAs drive redundancy decisions. A 99.99% SLA (52 minutes of downtime per year) means you cannot have a single point of failure anywhere in the path.

### CompTIA exam traps

> **Trap:** Layer 1 documentation is the cable map and rack diagram. Layer 2 documentation is the VLAN map and MAC tables. Layer 3 documentation is the IP/subnet/routing diagram. A "show me where VLAN 40 traverses the core" question is L2/L3 logical, not L1 physical.

> **Trap:** Decommissioning is not just "unplug it." The exam-correct sequence is: remove from monitoring → wipe configs → sanitize storage → physical removal → update asset inventory → reclaim licenses → certificate of destruction. Skipping the wipe leaks credentials. Skipping the inventory update creates phantom assets.

> **Trap:** A backup configuration restored to a device with newer firmware may not load cleanly. Document firmware versions alongside config backups, or you'll find out during the rebuild.

## Helpdesk reality

- User says *"the jack in my office doesn't work."* You pull up the cable map, find the jack ID on the faceplate, trace it to the patch panel, find that port 14 on switch-2 is shut down. The cable map turned a 45-minute cable trace into a 90-second lookup.
- New hire on the network team asks *"what's the IP scheme here?"* If your answer is "ask Dave, he knows," you don't have documentation, you have Dave. Dave will quit.
- Auditor asks *"show me your asset inventory and your EOS replacement plan."* If you can't produce both in under five minutes, you fail the audit before lunch.
- Never promise *"I'll just make a quick change real fast."* That sentence has caused more outages than any attack ever has. Every change goes through change management, even at 2am.
- Escalation point: if the running config doesn't match the baseline and nobody knows why, that's config drift — stop, snapshot the current state, and find out what changed before you touch anything else.

## Related concepts

[[Change Management]] · [[IPAM]] · [[OSI Model]] · [[DHCP]] · [[DNS]] · [[VLAN]] · [[Wireless Site Survey]] · [[SNMP]] · [[Syslog]] · [[Backup and Recovery]] · [[SLA]] · [[Network Monitoring]]

*Source: VIRGIL knowledge base — 2026-05-11*