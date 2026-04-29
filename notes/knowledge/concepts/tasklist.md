# tasklist

## What it is
Like a restaurant's order board showing every active ticket in the kitchen, `tasklist` is a Windows command-line utility that displays all currently running processes — their names, Process IDs (PIDs), memory usage, and associated services. It's the built-in CLI equivalent of Task Manager, accessible without a GUI.

## Why it matters
Attackers who land on a Windows box routinely run `tasklist` during post-exploitation reconnaissance to check whether endpoint detection tools (like CrowdStrike's `CSFalcon.exe` or Carbon Black's `cb.exe`) are running before deploying malware or lateral movement tools. Defenders analyzing a compromised host use the same command — cross-referenced with baseline snapshots — to spot injected or masquerading processes like `svchost.exe` running from an unusual path.

## Key facts
- `tasklist /svc` maps each process to its hosted Windows services, critical for spotting malicious services hiding inside legitimate process wrappers
- `tasklist /m <dll>` lists all processes currently loading a specific DLL — useful for detecting DLL injection attacks
- `tasklist /fi "imagename eq malware.exe"` applies filters to narrow output, commonly used in incident response scripts
- Output can be formatted as CSV (`/fo csv`) for easy ingestion into SIEM tools or log correlation pipelines
- Threat actors frequently combine `tasklist` with `netstat` and `whoami` as part of a standard **discovery tactic** mapped to MITRE ATT&CK T1057 (Process Discovery)

## Related concepts
[[Process Injection]] [[MITRE ATT&CK]] [[Endpoint Detection and Response]] [[Living off the Land Binaries]] [[Windows Sysinternals]]