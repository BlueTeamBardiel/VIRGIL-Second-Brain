# RDP

## What it is
Think of RDP like a hotel's remote TV system — you're sitting in your room pressing buttons, but the actual processing happens on a TV head-end server somewhere else, and you're just watching the screen. Remote Desktop Protocol (RDP) is Microsoft's proprietary protocol (port 3389/TCP) that allows users to remotely control a Windows machine's graphical desktop over a network connection.

## Why it matters
In 2017–2019, attackers mass-scanned the internet for exposed RDP endpoints, purchasing access to compromised machines on dark web markets ("RDP shops") to deploy ransomware like Ryuk and BitPaymer. Defenders counter this by placing RDP behind a VPN or Network Level Authentication (NLA), which forces credential verification *before* a full session is established — dramatically shrinking the attack surface.

## Key facts
- RDP runs on **TCP/UDP port 3389** by default; this is a common exam question and a trivial firewall rule to block
- **BlueKeep (CVE-2019-0708)** is a critical wormable pre-authentication RDP vulnerability affecting Windows 7/Server 2008 — no login required to exploit
- **Network Level Authentication (NLA)** is the security control that requires authentication before session creation, reducing exposure to unauthenticated exploits
- RDP sessions can be hijacked using tools like **tscon** without knowing the target's password, making it a popular lateral movement technique
- **Credential stuffing and brute-force** are the #1 RDP attack vectors; account lockout policies and MFA are the primary mitigating controls

## Related concepts
[[Network Level Authentication]] [[BlueKeep]] [[Lateral Movement]] [[VPN]] [[Brute Force Attack]]