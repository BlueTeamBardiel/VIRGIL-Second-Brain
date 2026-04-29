# Imaging

## What it is
Like pressing a wax seal onto a letter to capture every detail of the signet ring — not just the contents — disk imaging captures a sector-by-sector, bit-for-bit copy of an entire storage medium, including deleted files, slack space, and unallocated regions. This forensic duplicate preserves the exact binary state of a drive at a moment in time, allowing investigators to work on the copy without ever touching the original evidence.

## Why it matters
When a ransomware attack hits a corporate workstation, incident responders must image the infected drive *before* attempting remediation or rebooting the system. Working from the image rather than the live disk preserves volatile artifacts and maintains chain of custody — without it, defense attorneys could successfully argue that evidence was contaminated, potentially collapsing a prosecution or civil case.

## Key facts
- **Write blockers are mandatory** during acquisition — hardware or software write blockers prevent any writes to the source drive, preserving forensic integrity.
- **MD5 and SHA-256 hashes** are calculated on both the source and the image immediately after acquisition; matching hashes prove the copy is identical (hash verification).
- **dd** (Linux) and **FTK Imager** are the most commonly tested imaging tools on Security+/CySA+; dd command syntax (`dd if=/dev/sda of=image.img bs=512`) appears on exams.
- **Dead acquisition** (powered-off imaging) vs. **live acquisition** (running system) is a critical distinction — live acquisition captures RAM and active processes but risks altering the disk.
- **Order of volatility** governs when imaging occurs: RAM → swap/page file → disk, since disk images are the most persistent but least volatile artifact.

## Related concepts
[[Chain of Custody]] [[Forensic Analysis]] [[Write Blocker]] [[Hash Verification]] [[Order of Volatility]]