# Controller-Based Architecture

## What it is
Think of it like an air traffic control tower: individual planes (access points) don't make routing decisions independently — a central tower coordinates everything. A controller-based network architecture centralizes the management of wireless access points (APs) or network devices through a dedicated controller (physical or virtual) that handles authentication, policy enforcement, and traffic decisions. The APs themselves become "thin" — lightweight devices that defer intelligence to the controller.

## Why it matters
When an attacker attempts an evil twin attack — standing up a rogue AP to intercept wireless traffic — a controller-based architecture makes detection significantly easier. The WLAN controller maintains awareness of all authorized APs and can automatically detect unauthorized devices broadcasting the same SSID, triggering alerts or blocking associations before credentials are harvested.

## Key facts
- **Thin APs vs. Fat APs**: In controller-based setups, APs are "thin" (lightweight), forwarding management traffic to the controller; standalone "fat" APs handle everything locally, increasing attack surface per device.
- **Centralized policy enforcement**: Authentication, VLAN assignment, and ACLs are pushed from the controller — a single misconfiguration point, but also a single remediation point.
- **CAPWAP protocol**: Controller and AP Wireless Protocol (CAPWAP) is the tunneling protocol used to link lightweight APs to their WLAN controller; runs over UDP ports 5246 (control) and 5247 (data).
- **Single point of failure risk**: If the controller goes down or is compromised, all managed APs may lose functionality — making the controller a high-value target for DoS attacks.
- **Rogue AP detection**: Controllers can use RF scanning and neighbor reports to continuously audit the wireless environment — a key compensating control in enterprise environments.

## Related concepts
[[Wireless Access Points]] [[CAPWAP]] [[Rogue Access Point Detection]] [[Network Segmentation]] [[WLAN Security]]