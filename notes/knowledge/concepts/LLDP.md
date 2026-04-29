# LLDP

## What it is
Like name tags at a conference where every device shouts "Hi, I'm a Cisco switch on port 3, running firmware 12.4!"— Link Layer Discovery Protocol is a vendor-neutral Layer 2 protocol that allows network devices to advertise their identity, capabilities, and neighbors to directly connected devices. It operates at the data link layer and is defined in IEEE 802.1AB.

## Why it matters
An attacker with physical or logical access to a network segment can passively listen to LLDP frames and instantly map the network topology — discovering switch models, firmware versions, VLANs, and port configurations without sending a single active probe. This reconnaissance goldmine allows targeted exploitation of known CVEs against specific hardware before defenders even detect scanning activity. Disabling LLDP on edge ports facing untrusted devices (printers, IoT, guest networks) is a concrete hardening step.

## Key facts
- LLDP frames are sent every **30 seconds by default** and are **not forwarded** by switches — they only travel one hop
- LLDP-MED (Media Endpoint Discovery) extends LLDP for VoIP devices, advertising power requirements and VLAN assignments
- Unlike Cisco's proprietary **CDP (Cisco Discovery Protocol)**, LLDP is vendor-neutral and supported across all major vendors
- LLDP information is stored in a **Management Information Base (MIB)** accessible via SNMP, doubling as a passive asset inventory tool
- Disabling LLDP on untrusted ports is a **CIS Benchmark** recommendation and appears in network hardening checklists for Security+ objectives

## Related concepts
[[CDP (Cisco Discovery Protocol)]] [[Network Reconnaissance]] [[VLAN Hopping]] [[SNMP]] [[Layer 2 Security]]