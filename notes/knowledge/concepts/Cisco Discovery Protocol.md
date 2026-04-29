# Cisco Discovery Protocol

## What it is
Like neighbors leaving their business cards in each other's mailboxes, CDP is a proprietary Layer 2 protocol that Cisco devices use to automatically advertise their identity, capabilities, and network topology to directly connected neighbors. It operates independently of any Layer 3 protocol and requires no configuration — it runs by default on nearly every Cisco interface.

## Why it matters
An attacker who gains access to a network segment can passively listen to CDP advertisements and harvest a detailed blueprint of the infrastructure: device models, IOS versions, IP addresses, and VLAN configurations — all without sending a single packet. This reconnaissance goldmine allows precise exploitation targeting known vulnerabilities in specific Cisco IOS versions before the defender even knows reconnaissance occurred.

## Key facts
- CDP operates at **Layer 2 only**, meaning it cannot traverse routers and is confined to directly connected neighbors
- Advertisements are sent every **60 seconds** by default, with a hold-time of **180 seconds**
- CDP frames reveal: **device hostname, platform model, IOS version, IP addresses, port ID, and VTP domain name** — all in cleartext
- **Disabling CDP** on external-facing or untrusted interfaces (`no cdp enable`) is a CIS Benchmark hardening recommendation
- CDP is a recognized vector for **information disclosure** attacks; its data can also be used to craft **VoIP attacks** by identifying Cisco IP phones and their associated Voice VLANs
- LLDP (Link Layer Discovery Protocol) is the IEEE 802.1AB standard equivalent, found on non-Cisco devices and carrying similar risks

## Related concepts
[[Network Reconnaissance]] [[VLAN Hopping]] [[Link Layer Discovery Protocol]] [[Network Hardening]] [[Information Disclosure]]