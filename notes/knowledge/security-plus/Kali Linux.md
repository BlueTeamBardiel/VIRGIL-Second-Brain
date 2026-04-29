# Kali Linux

## What it is
Think of it as a fully stocked surgeon's kit — except instead of scalpels and forceps, every tool is designed to probe, cut into, and analyze digital systems. Kali Linux is a Debian-based Linux distribution maintained by Offensive Security, purpose-built for penetration testing, digital forensics, and security research, with over 600 pre-installed offensive and defensive tools.

## Why it matters
During a sanctioned red team engagement, a penetration tester boots Kali Linux and uses its built-in Metasploit Framework to exploit an unpatched SMB vulnerability on a target Windows server — the same technique used in the 2017 WannaCry ransomware outbreak. The tester documents the attack path, helping the blue team patch the gap before a real adversary finds it. Without a consolidated platform like Kali, assembling and configuring these tools manually would consume hours before any actual testing begins.

## Key facts
- Kali Linux runs as root by default in older versions (pre-2020); newer releases use a standard non-root user to reduce accidental damage during testing
- It is maintained by **Offensive Security**, the same organization that offers the OSCP (Offensive Security Certified Professional) certification
- Kali supports multiple deployment modes: live boot USB, virtual machine, WSL2 on Windows, and ARM devices like Raspberry Pi
- Key built-in tools include **Nmap** (network scanning), **Wireshark** (packet capture), **Burp Suite** (web app testing), **Aircrack-ng** (wireless attacks), and **John the Ripper** (password cracking)
- Using Kali Linux against systems without explicit written authorization is illegal under the Computer Fraud and Abuse Act (CFAA) and equivalent laws globally

## Related concepts
[[Penetration Testing]] [[Metasploit Framework]] [[Nmap]] [[Privilege Escalation]] [[Network Reconnaissance]]