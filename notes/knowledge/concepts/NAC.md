# NAC

## What it is
Like a bouncer at a club who checks your ID *and* your outfit before letting you in, Network Access Control verifies not just *who* you are but *what your device looks like* before granting network entry. NAC is a security framework that enforces policy-based controls on devices attempting to connect to a network, checking health posture (patch level, AV status, OS version) alongside identity. Devices that fail the health check are quarantined to a remediation VLAN rather than dropped entirely.

## Why it matters
In 2017, the NotPetya worm spread devastatingly fast across corporate networks partly because unmanaged and unpatched machines had unrestricted lateral access. A properly implemented NAC solution would have quarantined those endpoints the moment they failed posture checks — containing the outbreak before it reached critical infrastructure. NAC is a direct technical control against the "flat network" problem that makes malware propagation trivial.

## Key facts
- NAC operates in two modes: **pre-admission** (checks device before granting access) and **post-admission** (monitors device behavior after it's already connected)
- **802.1X** is the IEEE standard most commonly used to enforce NAC at the port/wireless level, using RADIUS as the authentication backend
- Devices failing posture checks are typically redirected to a **quarantine/remediation VLAN** where they can receive patches but not reach production systems
- NAC agents can be **persistent** (installed software) or **dissolvable** (temporary agents that run during authentication and self-delete)
- NAC enforces concepts like **posture assessment**, checking for: current AV signatures, host firewall enabled, OS patch level, and approved software inventory

## Related concepts
[[802.1X]] [[RADIUS]] [[VLAN]] [[Zero Trust Architecture]] [[Endpoint Detection and Response]]