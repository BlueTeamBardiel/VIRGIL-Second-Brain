# systemd-machined

## What it is
Think of it as a hotel concierge that keeps a guest registry for every virtual machine and container running on a Linux host — tracking who checked in, what room they're in, and managing their keys. Precisely, `systemd-machined` is a system daemon that tracks and manages the lifecycle of local virtual machines and containers, exposing their metadata via D-Bus. It integrates with systemd's cgroup hierarchy to enforce resource boundaries and identity for each "machine."

## Why it matters
In 2021, researchers demonstrated that misconfigured D-Bus policies on `systemd-machined` could allow an unprivileged container process to query host-level machine metadata or, in edge cases, trigger privilege escalation by abusing the `org.freedesktop.machine1` interface. Defenders auditing container escape paths must enumerate D-Bus exposure — a compromised container that can reach `machined` over D-Bus gains visibility into sibling containers and host identity information it should never see.

## Key facts
- Communicates exclusively over D-Bus using the interface `org.freedesktop.machine1` — any process with access to the system bus can query it
- Integrates with **systemd-nspawn**, **libvirt**, and **Docker** to register machines automatically upon startup
- Stores machine metadata under `/run/systemd/machines/` — writable only by root, but readable paths can leak container names and leaders (PIDs)
- The `machinectl` CLI is the front-end; commands like `machinectl shell` can spawn a privileged shell inside a registered container — a known lateral movement vector if access controls are weak
- Governed by polkit policies; an improperly configured polkit rule can grant unprivileged users `machinectl shell` access, bypassing namespace isolation

## Related concepts
[[D-Bus Security]] [[systemd-nspawn]] [[Container Escape]] [[Privilege Escalation]] [[cgroups]]