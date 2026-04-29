# Docker network

## What it is
Think of it like a private phone exchange inside a building — containers can call each other by name without ever touching the public switchboard. Docker networking is the virtual networking layer that controls how containers communicate with each other, with the host system, and with external networks, using software-defined bridges, overlays, or host-mode adapters.

## Why it matters
In a 2019-style container escape scenario, an attacker who compromises one container on the default `bridge` network can probe other containers on the same bridge — they share a Layer 2 segment. Proper network segmentation using custom bridge networks with inter-container communication disabled, or dedicated overlay networks with explicit allow-lists, contains the blast radius to a single service rather than the entire application stack.

## Key facts
- Docker's **default bridge network** (`docker0`) allows all containers on it to communicate freely — this is a misconfiguration risk; custom networks should be used instead.
- **Four primary network drivers**: `bridge` (default, single host), `host` (shares host network namespace — eliminates container network isolation), `overlay` (multi-host, used in Swarm), and `none` (no networking).
- Using `--network host` mode means a compromised container can bind to any host port and sniff host-level traffic — a critical security boundary violation.
- Container names act as DNS hostnames **only within user-defined networks**, not the default bridge — a useful segmentation enforcement mechanism.
- Exposing ports with `-p` publishes them to `0.0.0.0` by default, making services reachable on all host interfaces including external ones — bind to `127.0.0.1` to restrict exposure.

## Related concepts
[[Container Security]] [[Network Segmentation]] [[Lateral Movement]] [[Namespace Isolation]] [[Microservices Attack Surface]]