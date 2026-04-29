# Memory Analysis

## What it is
Think of RAM like a surgeon's scrub sink — everything actively in use gets washed through it, leaving traces even after the water drains. Memory analysis is the forensic examination of a system's volatile RAM to extract running processes, encryption keys, network connections, and injected code that disappears the moment the machine powers off.

## Why it matters
During the 2017 NotPetya attacks, malware injected itself directly into the `lsass.exe` process to harvest credentials — activity that left minimal disk artifacts but was fully visible in a memory dump. Incident responders who captured RAM images before rebooting affected systems recovered attacker tooling, injected shellcode, and plaintext passwords that would otherwise have been unrecoverable.

## Key facts
- **Volatility Framework** is the industry-standard open-source tool for parsing memory dumps; key plugins include `pslist`, `netscan`, `malfind`, and `dlllist`
- Encryption keys (including BitLocker and VeraCrypt keys) can persist in RAM and be extracted — this is the basis of **cold boot attacks**
- `malfind` detects injected code by flagging memory regions marked executable that lack a corresponding file on disk (VAD anomalies)
- Memory acquisition must happen **before shutdown** — volatile data is lost immediately on power-off, making live response critical
- The **order of volatility** (NIST SP 800-86) ranks RAM as the most volatile artifact, requiring collection before disk images, logs, or network captures

## Related concepts
[[Volatile vs Non-Volatile Evidence]] [[Process Injection]] [[Digital Forensics and Incident Response]] [[Order of Volatility]] [[Credential Dumping]]