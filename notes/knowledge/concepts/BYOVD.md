# BYOVD

## What it is
Like a thief who can't pick the lock so they borrow a master key from a legitimate locksmith and use it for the break-in — Bring Your Own Vulnerable Driver (BYOVD) is an attack technique where adversaries load a legitimate, signed (but exploitable) kernel driver onto a target system to gain kernel-level privileges. Because the driver is legitimately signed, security tools and Windows Driver Signature Enforcement (DSE) allow it to load without complaint.

## Why it matters
In 2022, the BlackByte ransomware group used a vulnerable version of the MSI Afterburner driver (RTCore64.sys) to disable security products running as kernel-protected processes — something impossible from userland. This technique is particularly dangerous because it sidesteps Endpoint Detection and Response (EDR) tools by attacking from the same privilege ring the EDR relies on, effectively blinding the defender before the main payload executes.

## Key facts
- BYOVD exploits the gap between *trusted* (signed) and *safe* (unexploitable): Microsoft's WHQL signing doesn't guarantee a driver is vulnerability-free
- Operates at **Ring 0** (kernel mode), giving attackers the ability to kill EDR processes, manipulate memory, and disable security controls
- Microsoft maintains a **Vulnerable Driver Blocklist** (updated via Windows Defender Application Control / WDAC) as the primary mitigation
- Common targets include AV/EDR termination, credential dumping, and rootkit installation — all requiring kernel access
- Notable real-world drivers abused: `gdrv.sys` (Gigabyte), `RTCore64.sys` (MSI), `mhyprot2.sys` (Genshin Impact anti-cheat)

## Related concepts
[[Privilege Escalation]] [[Kernel Exploitation]] [[Driver Signature Enforcement]] [[EDR Evasion]] [[Living Off the Land]]