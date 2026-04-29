# RAM

## What it is
Think of RAM like a chef's prep counter — ingredients (data) pulled from the pantry (disk) are laid out here for immediate use, then cleared when service ends. Technically, RAM (Random Access Memory) is volatile, high-speed memory that temporarily holds the running OS, active processes, and data being actively processed by the CPU. Because it requires power to retain data, its contents are lost when a system powers off.

## Why it matters
RAM is a prime target for **live memory forensics** and credential theft. Tools like Mimikatz can scrape LSASS process memory from RAM and extract plaintext passwords or NTLM hashes — no disk access required. Defenders counter this by enabling **Credential Guard** on Windows systems, which isolates credential storage in a hardware-protected memory region inaccessible to standard processes.

## Key facts
- RAM is **volatile** — contents are lost on power loss, which is why first responders prioritize memory acquisition before shutdown during incident response
- The **order of volatility** (critical for CySA+) places RAM at the top — it must be captured before disk, logs, or network state
- **Cold boot attacks** can partially recover RAM contents by rapidly chilling memory chips, which slows electron decay — even after power loss
- **Memory forensics tools** like Volatility and Rekall analyze RAM dumps to recover running processes, open network connections, and injected shellcode
- Attackers use **process injection** (e.g., DLL injection, reflective loading) to hide malicious code entirely within RAM, leaving minimal disk artifacts

## Related concepts
[[Memory Forensics]] [[Order of Volatility]] [[Credential Dumping]] [[Cold Boot Attack]] [[Process Injection]]