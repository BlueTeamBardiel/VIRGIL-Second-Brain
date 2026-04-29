# Tmds.DBus

## What it is
Think of D-Bus like an internal postal system inside a Linux machine — processes drop messages into a shared mailbox, and other processes pick them up. Tmds.DBus is a .NET/C# library that lets managed code participate in that postal system, implementing the D-Bus IPC (Inter-Process Communication) protocol for cross-process messaging on Linux and macOS.

## Why it matters
Attackers who compromise a low-privilege process on a Linux system can use D-Bus to reach privileged system services — for example, calling PolicyKit (polkit) methods or manipulating systemd units. The 2021 **CVE-2021-3560** polkit vulnerability was exploitable precisely because D-Bus message timing could be abused to bypass authentication; .NET applications using Tmds.DBus could be entry points or targets in such privilege escalation chains if they expose sensitive D-Bus interfaces without proper caller authentication checks.

## Key facts
- Tmds.DBus communicates over either a **system bus** (shared, high-privilege services) or a **session bus** (per-user, lower privilege) — misidentifying which bus an application uses is a common misconfiguration.
- D-Bus messages include a **sender credential** (UID/PID) that services should validate; Tmds.DBus exposes this via `IMethodContext` — skipping this check is a direct privilege escalation risk.
- The library supports **signal subscriptions**, meaning a malicious process can listen for sensitive broadcast events (e.g., network credential changes) without sending any traffic.
- Tmds.DBus targets **.NET Standard 2.0+**, making it relevant in containerized Linux microservices where developers may not expect OS-level IPC attack surfaces.
- D-Bus is **not encrypted or authenticated by default** at the message layer — confidentiality depends entirely on OS-level socket permissions.

## Related concepts
[[Inter-Process Communication (IPC)]] [[Privilege Escalation]] [[PolicyKit (polkit)]] [[Linux Hardening]] [[Least Privilege]]