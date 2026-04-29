# Remote Access Hardware

## What it is
Think of it as a secret physical keyhole drilled into the back of a server room door — one that bypasses the main lock entirely. Remote access hardware refers to dedicated out-of-band management devices (such as BMCs, KVM-over-IP switches, and iDRAC/iLO controllers) that allow administrators to access and control systems at the hardware level, independent of the operating system or network state.

## Why it matters
In 2022, researchers discovered that Baseboard Management Controllers (BMCs) on enterprise servers were exposed directly to the internet with default credentials, allowing attackers to gain full hardware-level control — including the ability to flash firmware, manipulate power states, and persist through OS reinstalls. Defending against this requires placing BMCs on isolated out-of-band management networks with strict access controls and mandatory credential changes.

## Key facts
- **BMC (Baseboard Management Controller)** operates on a separate power rail, meaning it remains accessible even when the host OS is powered off or crashed
- **IPMI (Intelligent Platform Management Interface)** is a common protocol used by BMCs; IPMI version 2.0 has a known cipher suite 0 vulnerability that allows authentication bypass
- **iDRAC (Dell) and iLO (HPE)** are vendor-specific remote management implementations — both have had critical CVEs allowing unauthenticated remote code execution
- Remote access hardware represents a **privileged attack surface below the OS layer**, making compromises nearly invisible to host-based security tools like EDR
- Best practice per NIST guidelines: management interfaces should be on a **dedicated, air-gapped or VLAN-isolated management network** (never on the production LAN)

## Related concepts
[[Out-of-Band Management]] [[Baseboard Management Controller]] [[Privileged Access Workstation]] [[Firmware Security]] [[VLAN Segmentation]]