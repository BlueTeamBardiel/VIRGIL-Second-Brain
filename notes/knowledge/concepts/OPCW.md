# OPCW

## What it is
Think of it like a skeleton key that works on every lock in a building — OPC (OLE for Process Control) Watcher is a Windows-based middleware protocol that bridges industrial control systems (ICS) with monitoring software. More precisely, OPCW (OPC Watcher) refers to the attack surface and exploitation techniques targeting OPC servers and clients in SCADA/ICS environments, where insecure COM/DCOM interfaces expose critical operational technology (OT) to network-based attacks.

## Why it matters
In the 2021 Oldsmar, Florida water treatment plant incident, attackers gained remote access to HMI software communicating over industrial protocols — the kind of attack vector that OPC interfaces routinely expose when left unpatched or misconfigured. An adversary who compromises an OPC server can silently manipulate sensor readings or actuator commands, causing physical-world consequences like chemical overdosing while operators see falsified "normal" readings on their dashboards.

## Key facts
- OPC Classic runs over DCOM (Distributed COM), which uses dynamic RPC ports — making firewall rules notoriously difficult to implement correctly, often leaving ports 135 and 1024–65535 exposed
- OPC UA (Unified Architecture) is the modern successor, using port 4840 and supporting TLS encryption — Classic OPC has no native encryption
- Attackers enumerate OPC servers using tools like OPCEnum to discover what industrial assets are reachable on a network segment
- Triton/TRISIS malware (2017) targeted Schneider Electric Safety Instrumented Systems that communicated via proprietary OPC-adjacent protocols, demonstrating how ICS protocol exploitation can disable safety systems
- Security+ and CySA+ emphasize network segmentation (DMZ between IT and OT) and protocol-aware firewalls as primary mitigations for OPC exposure

## Related concepts
[[SCADA Security]] [[ICS/OT Security]] [[DCOM Exploitation]] [[Network Segmentation]] [[Modbus]]