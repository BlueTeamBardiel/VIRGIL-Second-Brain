# SCSI

## What it is
Think of SCSI like a specialized highway with its own traffic laws built purely for moving cargo between warehouses (storage devices) and a distribution center (CPU) — faster and more direct than a general-purpose road. Small Computer System Interface (SCSI) is a set of standards defining both the physical interface and command protocol for connecting and transferring data between computers and peripheral devices, especially hard drives and tape libraries. It predates SATA and operates using a bus architecture where multiple devices share a single connection channel.

## Why it matters
In enterprise environments, legacy SCSI-attached tape libraries are still used for backup and archival storage — making them attractive targets for ransomware actors who specifically hunt for and destroy backup media to maximize leverage. An attacker with physical or logical access to a SCSI bus can potentially issue raw SCSI commands to overwrite or corrupt drive firmware, bypassing operating system-level access controls entirely. Defenders must treat SCSI-connected storage as a critical asset requiring both physical access controls and firmware integrity monitoring.

## Key facts
- SCSI supports up to 16 devices on a single bus (including the host controller), each assigned a unique SCSI ID (0–15)
- iSCSI (Internet SCSI) encapsulates SCSI commands over TCP/IP networks, making storage area networks (SANs) remotely accessible — and remotely attackable
- iSCSI lacks built-in encryption by default; credentials (CHAP authentication) can be intercepted if traffic is unencrypted on the wire
- SCSI Command Descriptor Blocks (CDBs) can be crafted maliciously to send unauthorized ATA PASS-THROUGH commands, enabling direct disk manipulation
- For Security+: iSCSI SANs require network segmentation (dedicated VLANs) and mutual CHAP authentication as baseline security controls

## Related concepts
[[iSCSI]] [[Storage Area Network (SAN)]] [[CHAP Authentication]] [[Fibre Channel]] [[Firmware Attacks]]