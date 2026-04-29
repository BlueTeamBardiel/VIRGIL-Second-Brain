# Junos OS

## What it is
Like a specialized chef's kitchen designed exclusively for Juniper Networks' hardware — every tool, layout, and workflow optimized for routing and switching rather than general cooking. Junos OS is a FreeBSD-based network operating system developed by Juniper Networks, running on routers, switches, and firewalls such as SRX, MX, and EX series devices. It uses a single unified codebase across all platforms, unlike Cisco's fragmented OS ecosystem.

## Why it matters
In 2015, Juniper disclosed that unauthorized code had been inserted into Junos OS's ScreenOS (used in NetScreen devices), creating a backdoor that allowed passive VPN traffic decryption — likely a nation-state implant. This incident illustrates how compromised network OS firmware can silently undermine encrypted communications at scale, affecting thousands of enterprise and government perimeters without leaving obvious traces in application-layer logs.

## Key facts
- Junos OS uses a **separated control plane and data plane** architecture, meaning routing decisions are processed independently from packet forwarding — improving stability and security isolation
- The **commit model** requires explicit configuration commits before changes take effect, creating a built-in change-control mechanism and easy rollback capability
- Junos supports **role-based access control (RBAC)** with class-based login profiles, limiting what administrative users can view or modify
- The **Junos Security Director** and built-in SRX firewall policies support stateful inspection, IPS, and application-layer visibility (AppSecure)
- Common attack surface includes **J-Web** (the GUI management interface), which has historically had CVEs involving authentication bypass and remote code execution

## Related concepts
[[Network Operating Systems]] [[Firewall Policy Management]] [[VPN Backdoors]] [[Role-Based Access Control]] [[Control Plane Security]]