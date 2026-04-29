# Slack

## What it is
Like the gap between a fence post and the ground — small enough to ignore, large enough for something to slip through — slack in cybersecurity refers to the unused space within allocated data structures, particularly in file systems and network packets. Precisely, slack space is the difference between a file's logical size (actual data) and the physical space allocated to store it on disk; in networking, it refers to padding or unused fields in protocol headers.

## Why it matters
Digital forensic investigators routinely recover hidden or deleted evidence from file slack space — a malware author may embed a payload or exfiltrate data inside the slack of innocent-looking files, exploiting the fact that standard antivirus scans ignore regions beyond a file's logical end-of-file marker. In the 2014 Sony Pictures breach, forensic analysts examined slack space to reconstruct deleted communications and malware artifacts that attackers believed were irrecoverable.

## Key facts
- **File slack** = RAM slack (zero-padding from EOF to sector end) + Drive slack (unallocated sectors in the remaining cluster)
- A 1-byte file stored in a 4KB cluster wastes 4,095 bytes of drive slack — all potentially containing remnants of prior data
- **Network slack** refers to unused bits in fixed-length protocol headers (e.g., reserved bits in TCP/IP headers), sometimes abused for covert channel communication
- Tools like **Autopsy**, **FTK**, and **EnCase** specifically carve and analyze slack space during forensic investigations
- Slack space artifacts are admissible evidence and are explicitly tested in CompTIA Security+ and CySA+ forensic analysis objectives

## Related concepts
[[File Carving]] [[Digital Forensics]] [[Covert Channels]] [[Data Remnants]] [[Steganography]]