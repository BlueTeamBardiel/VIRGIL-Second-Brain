# Buffalo Link Station

## What it is
Like a USB hard drive that grew up and got a network card, a Buffalo LinkStation is a consumer/SMB Network Attached Storage (NAS) device that connects directly to a LAN, allowing multiple users to access shared storage without a dedicated file server. It runs an embedded Linux OS and exposes file shares via protocols like SMB/CIFS, NFS, and FTP.

## Why it matters
In 2021, a critical vulnerability (CVE-2021-20090) was discovered in the web management interface of Buffalo LinkStation devices — a path traversal flaw that allowed unauthenticated attackers to bypass authentication by manipulating URL paths, gaining admin access to the device. Attackers could then pivot from the NAS to the internal network, exfiltrate backups, or deploy ransomware to destroy stored data.

## Key facts
- Buffalo LinkStation devices run embedded Linux (BusyBox-based), making them susceptible to Linux-specific exploits and often lacking automatic security updates
- CVE-2021-20090 affected multiple vendors sharing the same Arcadyan firmware, demonstrating how shared OEM firmware creates widespread supply-chain vulnerability
- Default credentials (admin/password or admin/blank) are commonly left unchanged, making credential stuffing and brute-force attacks trivially effective
- SMB protocol exposure on NAS devices is a primary ransomware delivery vector — attackers encrypt or wipe NAS shares to destroy backups
- Buffalo LinkStation devices often lack centralized logging integration, making forensic investigation and anomaly detection difficult in incident response scenarios

## Related concepts
[[Network Attached Storage Security]] [[SMB Protocol Vulnerabilities]] [[Default Credentials]] [[Path Traversal]] [[Firmware Security]]