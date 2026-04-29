# Batch Parameter Block

## What it is
Think of it like a sticky note stapled to the front of a file folder — it tells the operating system exactly how to handle the enclosed data before anything inside gets read. A Batch Parameter Block (BPB) is a data structure located in the boot sector of a disk volume that stores critical filesystem metadata, including bytes per sector, sectors per cluster, and volume size. It essentially gives the OS its "how to read this disk" instructions at the earliest possible moment during the boot process.

## Why it matters
Attackers targeting the boot process — such as those deploying bootkits like Rovnix or TDL4 — specifically corrupt or spoof the BPB to manipulate how the OS interprets disk structures, enabling rootkit persistence before any security software loads. A forensic analyst examining a suspected bootkit infection will compare the on-disk BPB values against in-memory representations, since discrepancies between the two are a classic indicator of tampering. Defending against this requires Secure Boot and integrity measurements via TPM to detect unauthorized changes.

## Key facts
- The BPB is located at offset 0x0B from the start of the Volume Boot Record (VBR), immediately after the jump instruction and OEM ID
- In NTFS volumes, the BPB defines the Bytes Per Sector (typically 512 or 4096), Sectors Per Cluster, and location of the Master File Table (MFT)
- Bootkit malware manipulates the BPB to redirect disk reads, allowing malicious code to intercept OS loading transparently
- Forensic discrepancy between the on-disk BPB and the OS's in-memory cached copy is a high-confidence indicator of compromise (IoC)
- Secure Boot (UEFI feature) validates the integrity of the VBR and BPB before execution, blocking unauthorized modifications

## Related concepts
[[Volume Boot Record]] [[Master Boot Record]] [[Bootkit]] [[Secure Boot]] [[Rootkit Persistence]]