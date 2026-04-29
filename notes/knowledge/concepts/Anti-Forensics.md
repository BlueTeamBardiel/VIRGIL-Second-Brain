# Anti-Forensics

## What it is
Like a burglar who wipes fingerprints, bleaches footprints, and burns the getaway car — anti-forensics is the deliberate manipulation, erasure, or obfuscation of digital evidence to impede investigation. Precisely defined: it encompasses any technique used to prevent forensic examiners from recovering, analyzing, or attributing artifacts of malicious activity.

## Why it matters
After the 2014 Sony Pictures breach, attackers used a custom wiper (Destover) to overwrite the Master Boot Record and destroy file system metadata, crippling incident responders' ability to reconstruct the timeline and scope of exfiltration. Without intact logs and file artifacts, attribution became a months-long intelligence effort rather than a forensic one — demonstrating how anti-forensics shifts the burden dramatically onto defenders.

## Key facts
- **Log tampering** is the most common form: attackers clear Windows Event Logs (`wevtutil cl System`) or `/var/log/auth.log` to erase authentication trails
- **Timestomping** modifies MACB timestamps (Modified, Accessed, Changed, Born) on files to make malware appear older or blend with legitimate files — detectable via $MFT analysis on NTFS
- **Steganography** hides data inside innocuous files (images, audio), bypassing DLP tools that scan for file types rather than content anomalies
- **Secure deletion tools** (e.g., `shred`, `sdelete`) overwrite file data blocks to prevent carving, though SSDs with wear-leveling can make this unreliable
- **Volume Shadow Copy deletion** (`vssadmin delete shadows /all`) is a signature behavior of ransomware to eliminate recovery points — flagged by CySA+ as a high-fidelity IOC

## Related concepts
[[Digital Forensics]] [[Log Management]] [[Timestomping]] [[Steganography]] [[Incident Response]]