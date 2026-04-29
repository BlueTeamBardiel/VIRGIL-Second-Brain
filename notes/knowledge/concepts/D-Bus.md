# D-Bus

## What it is
Think of D-Bus as the intercom system inside a building — processes shout messages into a central hub, and any other process listening on the right "channel" can hear and respond. Precisely, D-Bus (Desktop Bus) is an inter-process communication (IPC) mechanism on Linux/Unix systems that allows processes to expose services, send signals, and invoke methods on other running processes through a message-passing broker called the D-Bus daemon.

## Why it matters
In 2019, researchers discovered CVE-2019-14287, a `sudo` privilege escalation that could be triggered via D-Bus services running with misconfigured PolicyKit (polkit) rules — an attacker could call a privileged D-Bus method and gain root access without a valid password. Defenders must audit which D-Bus interfaces are exposed by system services and ensure PolicyKit policies enforce least privilege on method calls.

## Key facts
- D-Bus has two main buses: the **system bus** (privileged, system-wide services like `NetworkManager`) and the **session bus** (per-user, desktop services)
- Services are identified by **well-known names** (e.g., `org.freedesktop.NetworkManager`) — attackers can impersonate services if name reservation is not properly enforced
- **PolicyKit (polkit)** is the authorization layer that governs who can call which D-Bus methods — misconfigured polkit rules are a common local privilege escalation vector
- Tools like `gdbus`, `dbus-send`, and `busctl` allow enumeration of exposed D-Bus interfaces and methods — used by both attackers and defenders
- D-Bus messages are **not encrypted by default**; on a shared session, other processes running as the same user can snoop session bus traffic

## Related concepts
[[Inter-Process Communication (IPC)]] [[Privilege Escalation]] [[PolicyKit (polkit)]] [[Linux Hardening]] [[Least Privilege]]