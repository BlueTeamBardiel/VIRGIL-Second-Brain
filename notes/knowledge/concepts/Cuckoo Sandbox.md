# Cuckoo Sandbox

## What it is
Like a terrarium where you put a scorpion to watch it sting a fake hand — Cuckoo Sandbox is an open-source automated malware analysis system that detonates suspicious files in an isolated virtual environment and records everything the malware does: file system changes, network calls, registry modifications, and process behavior.

## Why it matters
When the 2017 NotPetya campaign spread globally, incident responders needed to rapidly characterize the malware's behavior without infecting production systems. By submitting samples to dynamic analysis platforms like Cuckoo, analysts could observe its credential-harvesting routines, lateral movement via EternalBlue, and MBR-overwriting payload — intelligence that drove containment decisions within hours rather than days.

## Key facts
- **Dynamic analysis** distinguishes Cuckoo from static tools — it executes the malware and observes runtime behavior, catching obfuscated or packed code that static signatures miss
- Cuckoo uses a **guest VM agent** (agent.py) inside the analysis VM that communicates results back to the host; malware authors target this agent as a sandbox-detection artifact
- Generates structured reports including **API call logs, PCAP network captures, memory dumps, and screenshots** of the malware's GUI behavior
- Supports analysis of **PE executables, PDFs, Office documents, URLs, and scripts** — not just traditional binaries
- **Sandbox evasion techniques** (checking for VM artifacts like VMware registry keys, mouse movement, or CPU core count) are a direct countermeasure to Cuckoo-style environments

## Related concepts
[[Dynamic Malware Analysis]] [[Indicators of Compromise]] [[Virtual Machine Escape]] [[Malware Sandbox Evasion]] [[PCAP Analysis]]