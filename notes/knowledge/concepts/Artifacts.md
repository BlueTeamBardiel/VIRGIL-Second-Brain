# Artifacts

## What it is
Like footprints left in mud after a burglar breaks in, artifacts are the digital remnants that remain on a system after activity — malicious or otherwise — has occurred. Precisely, artifacts are files, registry entries, log entries, memory traces, or other data objects left behind by processes, users, or malware that can be collected and analyzed during forensic investigations or incident response.

## Why it matters
During a ransomware investigation, a forensic analyst examines artifacts such as prefetch files, Windows Event Logs, and registry run keys to reconstruct exactly when the malware executed, which user account it leveraged, and which files it accessed — even after the attacker attempted to delete evidence. Without understanding artifacts, responders cannot establish a reliable timeline or attribution, leaving organizations blind to the full scope of compromise.

## Key facts
- **Volatile artifacts** (RAM, running processes, network connections) disappear when a system is powered off — they must be captured first using tools like Volatility or WinPmem
- **Persistent artifacts** survive reboots and include prefetch files (`C:\Windows\Prefetch`), registry hives, browser history, and event logs
- **Windows-specific artifacts**: LNK files, Jump Lists, Shellbags, Amcache, and NTFS $MFT are frequently tested forensic evidence sources
- Artifacts are central to the **Order of Volatility** (RFC 3227), which dictates collection sequence: registers/cache → RAM → network state → disk → backups
- Attackers use **anti-forensic techniques** (log wiping, timestomping, secure deletion) specifically to destroy artifacts and break the forensic chain

## Related concepts
[[Digital Forensics]] [[Chain of Custody]] [[Order of Volatility]] [[Incident Response]] [[Log Analysis]]