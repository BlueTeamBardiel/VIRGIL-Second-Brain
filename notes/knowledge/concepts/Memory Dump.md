# Memory Dump

## What it is
Like pulling the emergency drain plug on an aquarium while the fish are still swimming — you capture everything in volatile memory exactly as it existed at that frozen moment. A memory dump is the process of copying the entire contents of RAM (or a specific process's memory space) to a file for offline analysis, preserving data that would otherwise vanish when a system powers down.

## Why it matters
In a live incident response scenario, an attacker running a fileless malware campaign (like a PowerShell-injected payload) leaves zero artifacts on disk — the only evidence lives in RAM. A responder who performs a memory dump using a tool like Volatility or WinPmem before pulling the plug can extract the running malicious process, injected shellcode, encryption keys, and even plaintext credentials that were actively in use.

## Key facts
- **Order of volatility** places RAM first — memory must be captured before any other evidence collection, as it is the most ephemeral artifact
- Tools like **Volatility Framework** and **Rekall** are the industry standard for parsing and analyzing memory dumps on Security+/CySA+ exams
- **Credential dumping tools** (e.g., Mimikatz) exploit memory dumps to extract NTLM hashes and plaintext passwords from LSASS process memory
- A memory dump can reveal **encryption keys for full-disk encryption** (e.g., BitLocker keys in RAM), which is why cold-boot attacks target it
- Under Windows, memory dumps are classified as: **complete memory dump**, **kernel memory dump**, or **minidump** — each capturing different scopes of data

## Related concepts
[[Volatile Evidence]] [[Fileless Malware]] [[Credential Dumping]] [[Live Forensics]] [[Order of Volatility]]