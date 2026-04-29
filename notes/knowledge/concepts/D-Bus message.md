# D-Bus message

## What it is
Think of D-Bus like an internal postal system inside your Linux machine — processes drop envelopes (messages) into a shared mailbox, and the right service picks them up. Precisely, a D-Bus message is a structured inter-process communication (IPC) packet used by Linux desktop and system services to exchange method calls, signals, and replies over the D-Bus daemon. It carries a sender, destination, interface, member name, and typed payload — all routed by the `dbus-daemon` acting as message broker.

## Why it matters
In 2019, researchers discovered that unprivileged processes could craft malicious D-Bus messages targeting `polkit` (CVE-2019-6133), tricking the policy engine into granting elevated privileges by exploiting a race condition in PID-based authentication. This matters defensively because D-Bus is the backbone of `systemd`, `NetworkManager`, and `BlueZ` — meaning a poorly configured D-Bus policy file can become a local privilege escalation highway attackers abuse after initial foothold.

## Key facts
- D-Bus has two buses: the **system bus** (high-privilege, shared by OS services) and the **session bus** (per-user, for desktop apps) — attackers target the system bus for privilege escalation
- Access control is defined in XML **policy files** (e.g., `/etc/dbus-1/system.d/`) that specify which UIDs can send or receive specific message types
- D-Bus messages are **typed and serialized** using a wire format; fuzzing this serialization layer has historically uncovered memory corruption bugs
- The `dbus-send` and `gdbus` tools let penetration testers enumerate exposed services and call methods manually — useful for local enumeration post-compromise
- **CVE-2021-3560** (polkit bypass) exploited timing of D-Bus connection teardown to bypass authentication, requiring no special privileges

## Related concepts
[[Privilege Escalation]] [[polkit]] [[Inter-Process Communication (IPC)]]