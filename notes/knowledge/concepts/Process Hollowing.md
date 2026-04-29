# Process Hollowing

## What it is
Imagine gutting a taxidermied animal and stuffing it with something entirely different — it looks like a fox on the outside, but there's a snake inside. Process hollowing works the same way: a legitimate process (like `svchost.exe`) is launched in a suspended state, its memory is unmapped and replaced with malicious code, then resumed — making malware appear to be a trusted process.

## Why it matters
The Dridex banking trojan famously used process hollowing to inject itself into `explorer.exe` or `svchost.exe`, bypassing application whitelisting controls that would have blocked an unknown executable outright. Security analysts hunting this technique look for processes whose on-disk image doesn't match what's loaded in memory — a red flag detectable by tools like Process Hacker or Volatility.

## Key facts
- **Execution flow:** CreateProcess (suspended) → NtUnmapViewOfSection → VirtualAllocEx → WriteProcessMemory → SetThreadContext → ResumeThread
- **Primary evasion goal:** Bypass application whitelisting and process-based detection since the parent process name (e.g., `svchost.exe`) appears legitimate
- **Detection artifact:** A mismatch between the process's memory-mapped image and the actual binary on disk — this discrepancy is a key forensic indicator
- **MITRE ATT&CK mapping:** T1055.012 — Process Injection: Process Hollowing, under the Defense Evasion and Privilege Escalation tactics
- **Differentiator from DLL injection:** Process hollowing replaces the entire process image; DLL injection only adds code to an existing running process without unmapping it

## Related concepts
[[Process Injection]] [[DLL Injection]] [[Defense Evasion]] [[Application Whitelisting]] [[Memory Forensics]]