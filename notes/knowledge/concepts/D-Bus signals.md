# D-Bus signals

## What it is
Think of D-Bus signals like a PA announcement in a hospital — one department broadcasts a message to the entire building, and any department that cares can listen without the broadcaster knowing who heard. Precisely, D-Bus signals are one-way, broadcast messages sent over the Linux Inter-Process Communication (IPC) D-Bus system, where a process emits an event (e.g., "network connected") and any subscribed process can receive it without the sender establishing a direct connection. Unlike method calls, signals have no return value and no guaranteed recipient.

## Why it matters
In 2019, researchers demonstrated that unprivileged processes on a Linux system could subscribe to D-Bus signals from privileged daemons (like NetworkManager or systemd) and harvest sensitive state information — IP addresses, VPN transitions, hardware device insertions — purely by listening to broadcast signals. An attacker with local code execution can use this passive eavesdropping to time privilege escalation attempts or map network topology without triggering obvious syscalls.

## Key facts
- D-Bus signals are **unauthenticated broadcasts** on the session or system bus — any process with bus access can subscribe unless policy rules explicitly restrict it
- The **system bus** (more privileged, handles hardware/OS events) is the higher-value target; the **session bus** is per-user-login
- D-Bus policy files (`/etc/dbus-1/system.d/`) control which users/processes can **send or receive** specific signals — misconfigurations create information leakage
- Tools like `dbus-monitor` and `busctl monitor` let attackers (or defenders) capture all signals in real time with no special privileges on a default system bus
- CVE-2020-12049 (flatpak D-Bus proxy bypass) shows signals can be used to **escape sandbox restrictions** when filtering policies are incomplete

## Related concepts
[[Inter-Process Communication (IPC)]] [[Linux Privilege Escalation]] [[Least Privilege]]