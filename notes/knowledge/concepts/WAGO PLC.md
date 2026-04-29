# WAGO PLC

## What it is
Think of it like a ruggedized traffic controller brain bolted inside an industrial cabinet — it reads sensors, makes decisions, and flips physical switches without human input. WAGO PLCs (Programmable Logic Controllers) are compact, DIN-rail-mounted industrial control devices manufactured by WAGO Kontakttechnik, widely deployed in building automation, manufacturing, and energy infrastructure. They run real-time control logic and often expose web-based management interfaces, making them both operationally critical and network-accessible.

## Why it matters
In 2021, security researchers disclosed multiple critical vulnerabilities (CVE-2021-34566, CVE-2021-34567) in WAGO PLC web-based management components, allowing unauthenticated remote code execution — meaning an attacker on the same network could rewrite ladder logic controlling physical machinery without ever touching the device. In ICS/OT environments, this translates directly to physical damage, production halt, or safety system bypass, the exact threat profile seen in attacks like TRITON/TRISIS against safety instrumented systems.

## Key facts
- WAGO PLCs frequently run **e!COCKPIT** or **CODESYS**-based runtime environments, which have their own CVE histories independent of the hardware
- Default credentials (`admin/wago` or `user/user`) are commonly left unchanged in operational deployments, a persistent finding in ICS pen tests
- They communicate over **Modbus TCP**, **EtherNet/IP**, and **PROFIBUS**, protocols that lack native authentication or encryption
- WAGO devices often sit on **flat OT networks** with no segmentation from corporate IT, violating Purdue Model zone separation
- CISA has issued multiple ICS-CERT advisories specifically for WAGO products, making them a recognized high-risk asset class in critical infrastructure assessments

## Related concepts
[[Industrial Control Systems (ICS)]] [[Modbus Protocol]] [[OT Network Segmentation]] [[CODESYS Vulnerabilities]] [[Purdue Model]]