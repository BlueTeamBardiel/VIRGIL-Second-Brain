# Host-Based Intrusion Detection

## What it is
Like a motion-sensor alarm installed *inside* your house rather than on the fence perimeter, a Host-Based Intrusion Detection System (HIDS) monitors activity from within a single endpoint — watching file changes, system calls, log entries, and running processes. It detects suspicious behavior or policy violations on that specific machine and generates alerts, but takes no automated action to stop the threat.

## Why it matters
In the 2020 SolarWinds attack, adversaries modified legitimate software files on thousands of endpoints to establish persistence. A properly configured HIDS using file integrity monitoring would have flagged the unexpected changes to Orion DLL files, potentially revealing the compromise weeks earlier than network-level detection did.

## Key facts
- **File Integrity Monitoring (FIM)** is a core HIDS function — tools like OSSEC and Tripwire create cryptographic hashes of critical system files and alert when hashes change unexpectedly.
- HIDS operates on **individual hosts** (servers, workstations), while Network-Based IDS (NIDS) monitors traffic across segments — they are complementary, not interchangeable.
- HIDS can detect **encrypted threats** that bypass network inspection, since it analyzes behavior after decryption occurs on the host.
- **Agent-based deployment** is the standard model: a lightweight agent runs on the endpoint and reports to a centralized management console (e.g., OSSEC server, Wazuh).
- A HIDS *detects and alerts* — it does **not** block. When blocking capability is added, it becomes a Host-Based Intrusion **Prevention** System (HIPS).

## Related concepts
[[Network-Based Intrusion Detection]] [[File Integrity Monitoring]] [[Security Information and Event Management]] [[Endpoint Detection and Response]] [[Log Analysis]]