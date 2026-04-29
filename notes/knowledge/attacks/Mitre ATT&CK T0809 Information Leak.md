# Mitre ATT&CK T0809 Information Leak

## What it is
Like a factory worker accidentally leaving a blueprint in a public parking lot, an Information Leak occurs when an ICS/OT system inadvertently exposes sensitive operational data to unauthorized parties. Formally, T0809 describes adversaries collecting data that has been unintentionally made available — through misconfigured protocols, banner grabbing, or exposed engineering files — without active exfiltration effort required.

## Why it matters
In the 2021 Oldsmar, Florida water treatment attack, the adversary likely leveraged exposed remote access software visible on Shodan, a classic information leak scenario where system details were publicly discoverable. Defenders counter this by auditing what OT assets are internet-facing and ensuring protocols like Modbus and DNP3 don't broadcast device details to unauthenticated requestors.

## Key facts
- T0809 is classified under the **Collection** tactic in the ICS ATT&CK Matrix, distinguishing it from enterprise network reconnaissance
- Common leak vectors include **HMI banners**, unprotected historian databases, cleartext OT protocols (Modbus, DNP3), and poorly secured engineering workstation shares
- Information leaks in ICS environments often expose **ladder logic, process setpoints, and network topology** — data that enables precise sabotage
- Unlike IT environments, many OT devices cannot be patched easily, making leaked firmware version data especially dangerous for long-term exploitation planning
- Shodan and Censys are the primary tools adversaries use to passively harvest ICS information leaks without ever touching the target network

## Related concepts
[[OT/ICS Security]] [[OSINT]] [[Reconnaissance (TA0043)]] [[Modbus Protocol]] [[Defense in Depth]]