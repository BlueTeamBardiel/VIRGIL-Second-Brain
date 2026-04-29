# Forensics

## What it is
Like a crime scene investigator who reconstructs a murder from a dried coffee stain and a partial footprint, digital forensics reconstructs what happened on a system by examining artifacts left behind. It is the disciplined process of identifying, preserving, collecting, analyzing, and reporting digital evidence in a manner that maintains its integrity and legal admissibility.

## Why it matters
After a ransomware attack hits a hospital, forensic investigators examine Windows Event Logs, prefetch files, and NTFS $MFT records to determine the initial access vector — discovering that a phishing email spawned a malicious PowerShell process 72 hours before encryption began. This timeline reconstruction tells defenders exactly which controls failed and provides evidence for potential prosecution or insurance claims.

## Key facts
- **Order of volatility** dictates evidence collection sequence: CPU registers/RAM → swap/pagefile → disk → remote logs → archival media (most volatile first)
- **Write blockers** (hardware or software) must be used when imaging drives to prevent evidence contamination — any write to the original media can invalidate evidence in court
- **Chain of custody** documents every person who handled evidence, timestamps included; a broken chain can make evidence inadmissible
- **Hashing** (MD5, SHA-256) proves evidence integrity — a matching hash between original and forensic copy confirms no tampering occurred
- Common artifact locations on Windows: `%AppData%\Roaming`, Prefetch (`C:\Windows\Prefetch`), Registry hives, Event Logs (`C:\Windows\System32\winevt\Logs`), and LNK files in Recent Items

## Related concepts
[[Incident Response]] [[Chain of Custody]] [[Log Analysis]] [[Steganography]] [[Volatile Memory Analysis]]