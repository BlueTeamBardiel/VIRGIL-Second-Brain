# Eraser

## What it is
Like a janitor who scrubs floors and empties trash *after* a burglary to destroy footprints and fingerprints, Eraser is a secure file deletion tool for Windows that overwrites data multiple times so it cannot be forensically recovered. Standard deletion merely removes the file's directory entry while leaving raw data on disk; Eraser overwrites that data with random patterns, zeros, or DoD-standard wipes to make recovery computationally infeasible.

## Why it matters
An insider threat preparing to leave a company might use Eraser to permanently destroy evidence of data exfiltration — wiping copied files, browser history, and USB transfer logs before handing in their badge. Incident responders and forensic investigators must identify *when* Eraser (or similar tools) was run by examining Windows Event Logs, Prefetch files, and shellbag artifacts, since the tool's own execution leaves traces even when target data is gone.

## Key facts
- Eraser supports multiple overwrite standards including DoD 5220.22-M (7-pass), Gutmann (35-pass), and simple single-pass pseudorandom data
- It can be scheduled to automatically wipe free space, meaning deleted files are continuously sanitized without user interaction — a stealth persistence option
- On SSDs and flash storage, Eraser's overwrite passes are **unreliable** due to wear-leveling and over-provisioning; hardware-level ATA Secure Erase or encryption-then-delete is preferred
- Eraser's presence in Prefetch (`ERASER.EXE-XXXXXXXX.pf`) or registry Run keys is itself a forensic indicator of anti-forensic intent
- NIST SP 800-88 provides the authoritative guidance on media sanitization, categorizing methods as Clear, Purge, and Destroy — Eraser typically achieves only "Clear" level

## Related concepts
[[Anti-Forensics]] [[Secure File Deletion]] [[Data Remanence]] [[Media Sanitization]] [[Prefetch Files]]