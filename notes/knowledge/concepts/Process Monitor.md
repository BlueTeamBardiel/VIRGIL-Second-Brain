# Process Monitor

## What it is
Think of it as a flight data recorder for your operating system — capturing every syscall, file touch, and registry write in real time. Process Monitor (ProcMon) is a Sysinternals tool for Windows that combines file system, registry, network, and process/thread activity monitoring into a single, filterable event stream. It records what processes do, not just that they exist.

## Why it matters
During malware analysis, ProcMon is the first tool an analyst drops into a sandbox to watch a suspicious binary detonate. When ransomware executes, ProcMon captures exactly which registry keys it modifies for persistence (e.g., `HKCU\Software\Microsoft\Windows\CurrentVersion\Run`), which files it encrypts, and which child processes it spawns — giving defenders a precise behavioral fingerprint before signature-based tools catch up.

## Key facts
- ProcMon captures **five event classes**: File System, Registry, Network, Process/Thread, and Profiling events
- Filters can be set by **process name, PID, operation type, or result** (e.g., "Result is ACCESS DENIED") — critical for cutting through noise
- **Boot logging** mode captures activity before the GUI loads, exposing rootkits and persistence mechanisms that execute at startup
- ProcMon output can be exported as CSV or PML (native format) for integration into SIEM or threat intelligence workflows
- It is a **passive observation tool** — it does not block or modify behavior, making it safe for controlled malware analysis environments

## Related concepts
[[Sysinternals Suite]] [[Dynamic Malware Analysis]] [[Registry Persistence]] [[Sandbox Analysis]] [[Windows Event Logging]]