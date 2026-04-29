# HIDS

## What it is
Like a security camera installed *inside* a single house rather than watching the neighborhood, a Host-based Intrusion Detection System (HIDS) monitors activity on one specific endpoint — file system changes, running processes, log entries, and system calls — and alerts when something looks wrong. Unlike network-based IDS, it sees encrypted traffic and insider actions that never cross the wire.

## Why it matters
In the 2020 SolarWinds attack, adversaries modified software on individual hosts and manipulated local files to evade network detection entirely. A properly tuned HIDS watching for unauthorized changes to system binaries or unexpected process spawning from `SolarWinds.BusinessLayerHost.exe` could have flagged the compromise before lateral movement began.

## Key facts
- HIDS uses **file integrity monitoring (FIM)** as a core mechanism — it hashes critical files and alerts on unexpected changes (e.g., OSSEC, Tripwire)
- Operates in **detection mode only** — it alerts but does not block (contrast with HIPS, which can actively prevent)
- Detects **policy violations and insider threats** that bypass perimeter controls, since it monitors local user and process behavior
- **Log analysis** is a key HIDS function — it correlates OS and application logs against known attack signatures
- Resource overhead is a tradeoff: HIDS consumes CPU/memory on the monitored host, making deployment on every endpoint a management challenge

## Related concepts
[[NIDS]] [[File Integrity Monitoring]] [[HIPS]] [[SIEM]] [[Endpoint Detection and Response]]