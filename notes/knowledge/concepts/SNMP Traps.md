# SNMP Traps

## What it is
Think of SNMP Traps like a smoke detector: instead of you constantly checking whether the house is on fire, the detector *calls you* the moment something goes wrong. Precisely, an SNMP Trap is an unsolicited, asynchronous alert sent from a network device (agent) to a management station (manager) when a specific event or threshold condition occurs — without the manager needing to poll for it. Unlike standard SNMP queries, traps are fire-and-forget UDP messages sent to port 162.

## Why it matters
Attackers who compromise network infrastructure can forge or suppress SNMP Traps to blind NOC teams during an intrusion — for example, disabling interface-down traps while rerouting traffic through a rogue switch. Conversely, defenders configure trap receivers as a lightweight IDS layer: an unexpected "cold start" trap from a core router at 3 AM is a high-fidelity signal that the device was rebooted, possibly after tampering.

## Key facts
- SNMP Traps use **UDP port 162** (manager receives); SNMP polling uses UDP port 161 (agent receives)
- SNMPv1 traps have **no authentication** — any host can send a spoofed trap to a manager
- SNMPv3 introduced **message integrity and encryption**, making trap authentication cryptographically verifiable
- **SNMPv2c** introduced the "Inform" message, which *requires acknowledgment* from the manager — unlike the original fire-and-forget trap
- Community strings in SNMPv1/v2c are transmitted in **plaintext**, making them trivially sniffable via packet capture

## Related concepts
[[SNMP Community Strings]] [[Network Device Hardening]] [[Syslog]] [[UDP Security]] [[SNMPv3]]