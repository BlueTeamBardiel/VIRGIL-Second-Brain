# MFT

## What it is
Think of the MFT as the card catalog in a library — it doesn't contain the books themselves, but it knows exactly where every book is shelved, who checked it out, and when. The **Master File Table (MFT)** is a special metadata database in NTFS file systems that records the location, timestamps, size, permissions, and attributes of every file and directory on a volume. Small files (under ~900 bytes) are even stored *directly inside* the MFT entry itself.

## Why it matters
During incident response, forensic analysts carve the MFT to reconstruct attacker timelines even after files have been deleted — because deleting a file in Windows only marks the MFT entry as available, it doesn't immediately erase the metadata. Attackers who know this sometimes attempt **MFT timestomping**, using tools like Metasploit's `timestomp` to overwrite $STANDARD_INFORMATION timestamps, hoping to throw analysts off. However, a sharp analyst cross-references `$FILENAME` attribute timestamps, which are harder to manipulate, exposing the deception.

## Key facts
- The MFT is stored in a hidden system file called `$MFT`, typically at the beginning of the NTFS volume
- Each MFT entry is **1,024 bytes (1 KB)** by default and contains two key timestamp sets: `$STANDARD_INFORMATION` and `$FILENAME`
- NTFS tracks **four timestamps** per file: Created, Modified, Accessed, and MFT Entry Changed (MACE)
- Discrepancies between `$STANDARD_INFORMATION` and `$FILENAME` timestamps are a **strong indicator of timestomping**
- Tools like **Autopsy**, **FTK**, and `analyzeMFT.py` are commonly used to parse and investigate the MFT

## Related concepts
[[NTFS Forensics]] [[Timestomping]] [[File System Analysis]] [[Anti-Forensics]] [[Digital Evidence Integrity]]