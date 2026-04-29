# dbus-daemon

## What it is
Think of it as the post office inside a Linux system — applications drop off messages, and dbus-daemon routes them to the right recipient process. Precisely, it is the message broker daemon that implements D-Bus (Desktop Bus), an IPC (Inter-Process Communication) mechanism allowing processes on the same host to exchange structured messages and invoke remote methods on each other's objects.

## Why it matters
In 2019, a local privilege escalation vulnerability (CVE-2019-14271) in Docker exploited D-Bus trust relationships, and historically attackers with local access have abused poorly configured D-Bus policies to send privileged messages to system services — effectively calling root-owned functions without authorization. Defenders audit `/etc/dbus-1/system.d/` policy files to ensure services only accept messages from appropriate UIDs/GIDs, preventing unauthorized callers from invoking sensitive methods.

## Key facts
- **Two buses exist**: the `system` bus (for OS-level services like NetworkManager, systemd, BlueZ) and the `session` bus (per-user, scoped to a login session).
- **Policy files** in `/etc/dbus-1/system.d/` define who can send to or own specific bus names — misconfigured policies are a direct privilege escalation vector.
- **Authentication** uses Unix socket credentials (UID/GID) — the daemon verifies the kernel-reported PID/UID of the connecting process, not a user-supplied token.
- **`dbus-send` and `gdbus`** are common command-line tools attackers use to probe exposed interfaces and enumerate available methods on running services.
- D-Bus is a **local-only** protocol by default; it does not listen on network sockets, making it an intra-host lateral movement path rather than a remote entry point.

## Related concepts
[[Inter-Process Communication (IPC)]] [[Privilege Escalation]] [[Linux Hardening]] [[Least Privilege]] [[Attack Surface Reduction]]