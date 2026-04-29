# Real-time Scanning

## What it is
Like a bouncer checking IDs at the door rather than reviewing security footage after a fight breaks out — real-time scanning (also called on-access scanning) inspects files, processes, and network traffic *at the moment they are accessed or executed*, rather than during a scheduled sweep. It intercepts system calls at the OS kernel level, analyzing content before it can be loaded into memory or written to disk.

## Why it matters
In 2017, the WannaCry ransomware propagated by exploiting SMB vulnerabilities and immediately began encrypting files upon execution. Endpoints with properly configured real-time scanning could intercept the malicious payload the instant it attempted to write encrypted files or spawn child processes, stopping the encryption chain before significant damage occurred — whereas systems relying only on scheduled scans were fully compromised within minutes.

## Key facts
- Real-time scanning hooks into the OS via a **kernel-level filter driver**, allowing the AV/EDR engine to intercept file I/O operations before completion
- Creates measurable **performance overhead** (CPU/disk latency) — a key trade-off compared to scheduled scanning, especially relevant in high-throughput server environments
- Modern implementations use **behavioral heuristics and sandboxing**, not just signature matching, to catch zero-day threats that evade static analysis
- Can be bypassed by **fileless malware** that operates entirely in memory (e.g., PowerShell-based attacks), since no file is ever written to disk to trigger the scan
- On Security+/CySA+, real-time scanning is categorized under **endpoint protection platforms (EPP)** and contrasted with EDR, which adds detection and response capabilities beyond prevention

## Related concepts
[[Endpoint Detection and Response]] [[Heuristic Analysis]] [[Fileless Malware]] [[On-demand Scanning]] [[Behavioral Analysis]]