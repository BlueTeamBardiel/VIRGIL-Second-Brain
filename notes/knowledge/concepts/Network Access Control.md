# Network Access Control

## What it is
Think of NAC like a hospital's security desk that checks your ID, confirms your appointment, and scans your bag before letting you anywhere near patients — not just once, but every time you enter. Network Access Control is a security framework that enforces policy-based restrictions on devices attempting to connect to a network, verifying identity, device health, and compliance posture before granting access.

## Why it matters
In 2017, the NotPetya outbreak spread laterally with devastating speed partly because unmanaged, unpatched devices sat freely on corporate networks with no enforcement checkpoints. A properly configured NAC solution performing posture assessment would have quarantined non-compliant machines — those missing patches or endpoint agents — into a remediation VLAN before they could propagate the worm laterally.

## Key facts
- **Posture assessment** checks device health (patch level, AV signatures, OS version) before granting access; failing devices are placed in a **quarantine VLAN** for remediation
- NAC can operate **pre-admission** (block before connecting) or **post-admission** (monitor and revoke access after suspicious behavior is detected)
- **802.1X** is the IEEE standard protocol most commonly used to enforce port-based NAC, requiring authentication via RADIUS before a switch port becomes active
- NAC integrates with **MDM/EMM** solutions to enforce mobile device compliance (e.g., requiring device encryption and screen lock)
- **Agentless NAC** uses SNMP, network scanning, or DHCP fingerprinting to assess devices that cannot run an agent (printers, IoT, guest devices)

## Related concepts
[[802.1X Authentication]] [[RADIUS]] [[VLAN Segmentation]] [[Endpoint Detection and Response]] [[Zero Trust Architecture]]