# PAgP

## What it is
Think of PAgP like two band members who audition each other before agreeing to play together — they negotiate first, then perform in sync. Port Aggregation Protocol (PAgP) is a Cisco-proprietary Layer 2 protocol that automatically negotiates and forms EtherChannel link bundles between switches, combining multiple physical ports into a single logical high-bandwidth link.

## Why it matters
An attacker on a misconfigured access port can send crafted PAgP frames to trick a switch into negotiating an EtherChannel with their device, effectively elevating themselves to a trunk-like aggregated link. This can be chained with VLAN hopping attacks — once the attacker has an aggregated link, they may manipulate trunk negotiation to gain access to traffic across multiple VLANs that should be off-limits.

## Key facts
- PAgP has two active modes: **Auto** (passive, waits for PAgP frames) and **Desirable** (actively sends PAgP frames); Auto + Auto = no channel formed
- **Auto + Desirable or Desirable + Desirable** = EtherChannel successfully negotiated
- PAgP is Cisco-proprietary; the open standard equivalent is **LACP (IEEE 802.3ad)**
- Hardening countermeasure: set ports not intended for EtherChannel to **"channel-group mode off"** and disable PAgP with `no pagp enable` to prevent unauthorized negotiation
- PAgP operates at **Layer 2**, making it invisible to Layer 3 security controls — it must be secured at the switch configuration level

## Related concepts
[[EtherChannel]] [[LACP]] [[VLAN Hopping]] [[Trunk Port Security]] [[Switch Spoofing]]