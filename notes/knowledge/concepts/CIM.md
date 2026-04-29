# CIM

## What it is
Think of CIM as a universal electrical outlet adapter — it doesn't matter what country manufactured the device, everything plugs into the same standardized socket. The **Common Information Model (CIM)** is a vendor-neutral standard maintained by DMTF that provides a unified schema for describing IT infrastructure components — hardware, software, networks, and services — using consistent class definitions and relationships. Windows implements CIM natively through WMI (Windows Management Instrumentation), exposing system internals via a queryable object hierarchy.

## Why it matters
Attackers abuse CIM/WMI extensively for fileless malware execution and lateral movement — a technique so prevalent it appears in APT toolkits like those used in the NotPetya campaign. An adversary can use `wmic process call create` to spawn a malicious process remotely without touching disk, evading traditional file-based antivirus entirely. Defenders hunt these attacks by monitoring WMI event subscriptions, which attackers use to achieve persistence by registering malicious payloads that trigger on system events.

## Key facts
- CIM is the underlying standard; **WMI is Microsoft's proprietary implementation** of CIM on Windows systems
- WMI uses TCP **port 135** (RPC) for remote connections, with dynamic high ports for actual data transfer
- Attackers create **WMI event subscriptions** (EventFilter + EventConsumer + FilterToConsumerBinding) for fileless persistence that survives reboots
- CIM/WMI queries use **WQL (WMI Query Language)**, syntactically similar to SQL (e.g., `SELECT * FROM Win32_Process`)
- MITRE ATT&CK maps WMI abuse under **T1047** (Windows Management Instrumentation) for execution and **T1546.003** for event subscription persistence

## Related concepts
[[WMI]] [[Fileless Malware]] [[Lateral Movement]] [[Windows Registry]] [[MITRE ATT&CK]]