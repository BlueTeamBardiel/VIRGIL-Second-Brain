# Master Boot Record

## What it is
Think of it as the bouncer at the door of your hard drive — it's the first 512 bytes read by the BIOS/firmware when a computer starts, and it contains both the partition table and a tiny bootloader program that hands execution off to the operating system. Located at sector 0 of a storage device, it runs before any OS security controls are active, making it extraordinarily privileged and extraordinarily vulnerable.

## Why it matters
Bootkits like Necurs and the infamous TDL4 rootkit infected the MBR to load malicious code before Windows could defend itself — surviving reboots, antivirus scans, and even OS reinstalls. Defenders respond by enabling Secure Boot (UEFI), which cryptographically verifies bootloader integrity and refuses to execute unsigned code, effectively neutering MBR-level persistence. Incident responders also use tools like `dd` to forensically image and compare the MBR against a known-good baseline to detect tampering.

## Key facts
- The MBR is exactly **512 bytes**: 446 bytes of bootloader code, 64 bytes of partition table (4 entries × 16 bytes), and a 2-byte signature `0x55AA`
- It supports a maximum of **4 primary partitions** and disks up to **2TB** — limitations that drove adoption of GPT (GUID Partition Table)
- MBR infections are a classic **persistence mechanism** (MITRE ATT&CK T1542.003 — Pre-OS Boot: Bootkit)
- **Overwriting the MBR** is also used as a destructive wiper technique (e.g., Shamoon, NotPetya used MBR destruction to render systems unbootable)
- `bootrec /fixmbr` (Windows) and `dd if=/dev/zero of=/dev/sda bs=446 count=1` (Linux) are standard MBR repair/wipe commands

## Related concepts
[[Rootkit]] [[Secure Boot]] [[UEFI]] [[Bootkit]] [[Disk Forensics]]