# Computer Hacking Forensic Investigator

## What it is
Like a crime scene detective who arrives *after* the robbery to reconstruct exactly what the thief touched, moved, and stole — a Computer Hacking Forensic Investigator (CHFI) is a trained professional who systematically collects, preserves, and analyzes digital evidence from compromised systems to determine what happened, how, and by whom. The CHFI certification (EC-Council) validates skills in post-incident digital forensics across networks, endpoints, and cloud environments.

## Why it matters
After a ransomware attack hit a hospital network in 2020, forensic investigators had to recover encrypted logs, reconstruct the attacker's lateral movement through Active Directory, and identify the initial phishing email as the entry point — all while maintaining strict chain of custody so the evidence held up in court. Without CHFI-level methodology, critical artifacts would have been overwritten or rendered inadmissible before attribution was possible.

## Key facts
- **Chain of custody** is non-negotiable: every person who handles evidence must be logged; breaks in custody can invalidate evidence in legal proceedings
- **Order of volatility** dictates collection priority: CPU registers/RAM first, then swap space, disk, then remote logs (per RFC 3227)
- Forensic investigators work from **forensic images** (bit-for-bit copies using tools like FTK Imager or dd), never original media, to preserve integrity
- **Write blockers** (hardware or software) prevent any writes to source media during acquisition, protecting the original evidence
- File system artifacts like **$MFT** (NTFS Master File Table), deleted file recovery, and timestomping detection are core CHFI exam domains

## Related concepts
[[Digital Forensics]] [[Chain of Custody]] [[Incident Response]] [[Volatile Data Collection]] [[File System Forensics]]