# GTP

## What it is
Think of GTP (GPRS Tunneling Protocol) as the postal system inside a mobile carrier's network — it wraps your mobile data packets in an envelope and routes them between cell towers and the internet core. Precisely, GTP is the tunneling protocol used in 3G/4G/5G mobile core networks to carry user data and control signaling between network nodes (eNodeB, SGSN, GGSN, and PGW).

## Why it matters
In 2020, researchers demonstrated that attackers who gain access to a carrier's GTP infrastructure can spoof legitimate subscriber sessions by injecting malicious GTP packets — effectively hijacking another user's mobile data tunnel and bypassing authentication. This is particularly dangerous because many enterprise networks rely on 4G LTE connections as backup links, meaning a GTP-level attack can bridge into corporate infrastructure.

## Key facts
- GTP runs over **UDP port 2123** (control plane, GTP-C) and **UDP port 2152** (user plane, GTP-U)
- A **TEID (Tunnel Endpoint Identifier)** is the 32-bit value that identifies each GTP tunnel — spoofing a valid TEID is the core of session hijacking attacks
- GTP has **no built-in encryption or authentication** by default — it assumes the carrier's network is trusted (a dangerous assumption)
- Attackers on the internet cannot directly reach GTP nodes unless the carrier misconfigures firewall rules — **GTP should never be exposed to public IP space**
- GTP-C messages include **Create Session Request / Delete Session Request**, which attackers can forge to create or destroy subscriber sessions

## Related concepts
[[Tunneling Protocols]] [[Mobile Network Security]] [[Session Hijacking]] [[UDP Exploitation]] [[Network Segmentation]]