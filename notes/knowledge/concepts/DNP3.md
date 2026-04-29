# DNP3

## What it is
Think of DNP3 as the postal system for power grids — a specialized delivery protocol that ensures control messages reliably reach substations, water treatment pumps, and pipeline sensors even over noisy, degraded communication lines. Precisely: DNP3 (Distributed Network Protocol 3) is a SCADA/ICS communication protocol standardized as IEEE 1815, designed for reliable master-to-outstation communication in critical infrastructure environments. Unlike IT protocols built for clean Ethernet environments, DNP3 was engineered for serial links and radio telemetry where packet loss is expected.

## Why it matters
In the 2015 Ukraine power grid attack, adversaries used Industroyer/BlackEnergy malware that included a DNP3 module specifically capable of sending spoofed commands to substation equipment — operators saw legitimate-looking traffic while attackers opened breakers across the grid. Because DNP3 was historically designed without authentication, an attacker with network access could craft valid commands without credentials. DNP3 Secure Authentication (SA v5) was introduced to address this, but legacy deployments remain largely unauthenticated.

## Key facts
- **No built-in authentication by default** — original spec assumed physical security would protect the network; SA v5 adds HMAC-based challenge-response
- **Three-layer architecture**: Application Layer, Data Link Layer, and Pseudo-Transport Layer — does not map cleanly to OSI
- **Operates on TCP port 20000** (and UDP 20000) when tunneled over IP networks
- **Used in electric utilities, water/wastewater, and oil & gas** — heavily regulated under NERC CIP standards for electric sector deployments
- **Supports unsolicited reporting** — outstations can push data to masters without polling, making traffic analysis harder for defenders

## Related concepts
[[SCADA Security]] [[Modbus]] [[ICS/OT Security]] [[NERC CIP]] [[Modbus]]

---
[[SCADA Security]] [[Modbus]] [[ICS/OT Security]] [[NERC CIP]] [[Industroyer Malware]]