# Interfaces and Cables

## What it is
Like plumbing in a building — the pipes determine what can flow, how fast, and where — network interfaces and cables are the physical layer that governs how data moves between devices. Precisely: interfaces are hardware endpoints (NICs, ports) and cables are the physical media (copper, fiber, coax) that connect them, operating at OSI Layer 1.

## Why it matters
A red team operator with brief physical access can plug a rogue device into an exposed RJ-45 port and launch a man-in-the-middle attack before anyone notices — because the cable and interface don't authenticate, they just conduct. Disabling unused switch ports and using 802.1X port-based authentication are direct defensive responses to this physical attack surface.

## Key facts
- **RJ-45 / Ethernet (Cat5e/Cat6/Cat6a)** — most common LAN copper cable; Cat6a supports 10Gbps up to 100m; susceptible to wiretapping via vampire taps or induction
- **Fiber optic (single-mode vs. multi-mode)** — harder to tap passively than copper, but optical taps exist; single-mode spans kilometers, multi-mode spans ~500m
- **USB interfaces** — high-risk physical attack vector; "Rubber Ducky" and BadUSB attacks weaponize USB to emulate keyboards and inject malicious commands
- **Serial/Console ports (RS-232, RJ-45 console)** — often grant unauthenticated privileged access to network devices; must be physically secured or require local password
- **Coaxial cable** — used in cable internet (DOCSIS) and legacy networks; historically vulnerable to signal splicing on shared-medium architectures

## Related concepts
[[Physical Security]] [[OSI Model]] [[802.1X Port-Based Authentication]] [[BadUSB Attacks]] [[Network Access Control]]