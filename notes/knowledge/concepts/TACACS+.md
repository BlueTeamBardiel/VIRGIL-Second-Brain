# TACACS+

## What it is
Imagine a bouncer at a VIP club who doesn't just check your ID at the door — he also logs every room you enter, every drink you order, and reports it all back to headquarters separately. TACACS+ (Terminal Access Controller Access-Control System Plus) is a Cisco-developed AAA protocol that handles Authentication, Authorization, and Accounting as *separate*, encrypted transactions over TCP port 49.

## Why it matters
When a network administrator's credentials are compromised, TACACS+ granular authorization logs can tell investigators exactly which router commands were executed and when — something RADIUS cannot provide at the same fidelity. In a 2020-era supply chain attack scenario, forensic teams used TACACS+ accounting logs to reconstruct an attacker's lateral movement through network infrastructure device by device.

## Key facts
- Uses **TCP port 49** — provides reliable, connection-oriented transport (vs. RADIUS which uses UDP)
- **Encrypts the entire packet payload**, not just the password field (RADIUS only encrypts the password)
- Separates AAA into **three independent functions**, enabling fine-grained control over network device command authorization
- Primarily designed for **device administration** (managing routers, switches, firewalls) — not end-user network access
- Proprietary to **Cisco** in its TACACS+ form, though the original TACACS was an open IETF protocol

## Related concepts
[[RADIUS]] [[AAA Framework]] [[Network Access Control]] [[Privileged Access Management]] [[802.1X]]