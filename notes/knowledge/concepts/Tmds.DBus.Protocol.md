# Tmds.DBus.Protocol

## What it is
Think of it like a postal sorting office inside Linux — messages between applications get routed through a central hub with strict addressing rules. Tmds.DBus.Protocol is a .NET/C# library implementing the D-Bus inter-process communication (IPC) protocol, enabling managed code applications to send and receive messages over the D-Bus message bus used extensively in Linux desktop and system services.

## Why it matters
An attacker who compromises a process with access to the system D-Bus bus (org.freedesktop.systemd1, for example) can call privileged methods — such as starting or stopping systemd units — without needing a direct root shell. Security researchers have used D-Bus exposure as a local privilege escalation vector, where a poorly sandboxed application using a library like Tmds.DBus.Protocol inadvertently exposes high-privilege service interfaces to lower-trust callers.

## Key facts
- D-Bus has two primary buses: the **system bus** (shared, high-privilege, system-wide) and the **session bus** (per-user login session); misconfigurations on the system bus are the higher-severity risk
- Tmds.DBus.Protocol uses **Unix domain sockets** as its default transport, meaning traffic stays within the host — no network interception, but local access is sufficient for attack
- **PolicyKit (polkit)** governs authorization for D-Bus method calls; CVE-2021-3560 exploited a race condition in polkit to bypass D-Bus authentication checks
- The library supports **introspection**, which allows callers to enumerate available interfaces and methods — a useful reconnaissance step for attackers on a compromised Linux host
- From a CySA+ perspective, D-Bus abuse is a **lateral movement / privilege escalation** technique catalogued under MITRE ATT&CK T1559 (Inter-Process Communication)

## Related concepts
[[Inter-Process Communication (IPC)]] [[Privilege Escalation]] [[Unix Domain Sockets]] [[PolicyKit (polkit)]] [[MITRE ATT&CK T1559]]