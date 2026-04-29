# vulnerable-machines

## What it is
Think of a vulnerable machine like a deliberately unlocked house in a training neighborhood — every window, door, and latch has a known weakness so aspiring locksmiths can practice their craft legally. Precisely, vulnerable machines are intentionally misconfigured or unpatched virtual systems (like HackTheBox, TryHackMe, or VulnHub instances) designed to teach offensive and defensive security techniques in a safe, legal environment.

## Why it matters
A SOC analyst preparing to respond to ransomware incidents can practice detecting lateral movement on a deliberately vulnerable Windows Server 2008 R2 machine running EternalBlue (MS17-010) — the exact exploit used in WannaCry — without touching production systems. This hands-on repetition builds muscle memory for recognizing attack signatures that no textbook alone can replicate.

## Key facts
- **Metasploitable** is one of the most commonly used vulnerable VMs, running intentionally weak services like vsftpd 2.3.4 (which contains a backdoor on port 6200)
- **CVE practice** on vulnerable machines maps directly to MITRE ATT&CK techniques, helping analysts correlate exploits to TTPs
- Vulnerable machines are isolated on **host-only or NAT networks** — never bridged to live networks, as they represent an immediate compromise risk
- **Flags (CTF-style)** in platforms like HackTheBox serve as proof-of-exploitation, typically found after privilege escalation to root/SYSTEM
- Common vulnerability categories practiced: SQL injection, buffer overflows, misconfigured services, weak credentials, and unpatched CVEs (directly tested on Security+/CySA+)

## Related concepts
[[penetration-testing]] [[CVE]] [[privilege-escalation]] [[CTF]] [[network-segmentation]]