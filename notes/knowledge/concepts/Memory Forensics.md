# Memory Forensics

## What it is
Like dusting a crime scene while the body is still warm — RAM captures everything that was *actively happening* the moment you freeze it. Memory forensics is the acquisition and analysis of a system's volatile memory (RAM) to recover running processes, decrypted data, network connections, and artifacts that never touch disk.

## Why it matters
During the 2020 SolarWinds attack, malware like SUNBURST executed largely in-memory to evade endpoint detection tools that only scan the filesystem. Analysts performing memory forensics on infected hosts could recover injected shellcode, decrypted C2 communications, and credential material that left zero trace in log files or disk storage.

## Key facts
- **Volatility** is the industry-standard open-source framework for memory analysis; it uses OS-specific *profiles* to parse memory structures correctly across Windows, Linux, and macOS
- RAM is **volatile** — power loss destroys evidence, so acquisition must happen *before* shutdown (order of volatility: CPU registers → RAM → swap/pagefile → disk)
- Key analysis targets include **process injection artifacts** (e.g., hollowed processes), **network sockets**, **registry hives loaded in memory**, and **cleartext credentials** (passwords, encryption keys)
- **Hibernation files** (`hiberfil.sys`) and **crash dumps** (`memory.dmp`) on Windows can serve as offline memory snapshots when live acquisition isn't possible
- The **pslist vs. psscan** technique in Volatility reveals hidden/unlinked processes: `pslist` walks the active process linked list (rootkits can unlink themselves), while `psscan` scans raw memory for EPROCESS structures regardless of linkage

## Related concepts
[[Volatile vs Non-Volatile Evidence]] [[Process Injection]] [[Digital Forensics and Incident Response (DFIR)]] [[Order of Volatility]] [[Rootkits]]