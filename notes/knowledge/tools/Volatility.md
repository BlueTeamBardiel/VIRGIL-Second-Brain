# Volatility

## What it is
Like a crime scene that gets bulldozed the moment power is cut, volatile memory holds evidence that exists only while the machine is running. Volatility is an open-source memory forensics framework used to extract and analyze artifacts from RAM dumps, virtual machine snapshots, and hibernation files. It reconstructs running processes, network connections, encryption keys, and injected code that never touches the disk.

## Why it matters
During a ransomware incident, the encryption key used by the malware often lives exclusively in RAM before files are locked. A forensic analyst who captures a memory image and runs Volatility's `malfind` plugin can extract injected shellcode and potentially recover that key — evidence that would be completely gone after a reboot. This makes live memory acquisition a critical first step in any incident response playbook.

## Key facts
- Volatility supports profiles/ISF symbols tied to specific OS versions (Windows, Linux, macOS) — using the wrong profile produces garbage output
- Key plugins include `pslist`/`pstree` (process enumeration), `netscan` (active connections), `malfind` (injected code detection), `dumpfiles` (extract loaded DLLs/executables), and `hivelist`/`hashdump` (registry hives and password hashes)
- Memory forensics can reveal **process hollowing** and **DLL injection** — both fileless malware techniques invisible to disk-based AV
- The order of volatility (RFC 3227) ranks RAM as the *most* volatile artifact — it must be captured before any other evidence collection
- Memory images are captured using tools like **WinPmem**, **DumpIt**, or **LiME** (Linux kernel module) before being analyzed in Volatility

## Related concepts
[[Memory Forensics]] [[Incident Response]] [[Fileless Malware]] [[Chain of Custody]] [[Process Injection]]