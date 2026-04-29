# VulnHub

## What it is
Like a gym full of punching bags shaped like real criminals — VulnHub is a free repository of deliberately vulnerable virtual machines that practitioners download and attack in isolated lab environments. It provides pre-built, intentionally misconfigured systems designed to simulate real-world exploitation scenarios from boot to root.

## Why it matters
A SOC analyst preparing to recognize lateral movement techniques can spin up a VulnHub machine like "Kioptrix" and practice the exact Samba exploit chain (MS-RPC buffer overflow → shell → privilege escalation) that attackers used in the wild. This hands-on repetition builds the muscle memory to recognize attack artifacts — registry changes, unusual process trees, suspicious netcat listeners — that appear in actual incident response scenarios.

## Key facts
- VulnHub hosts 800+ free downloadable VM images in OVA/VMDK formats, importable directly into VirtualBox or VMware
- Machines are rated by difficulty (beginner → intermediate → advanced) and often mirror real CVEs or CTF competition challenges
- The standard goal is **"boot-to-root"**: gain initial foothold via a vulnerability, then escalate to root/SYSTEM — mirroring the actual attacker kill chain
- Always deployed on **host-only or NAT-isolated networks** to prevent accidental exposure of vulnerable systems to live internet traffic
- Complements certifications like OSCP (PWK course), CySA+, and Pentest+ by providing free, legal exploitation practice without cloud costs

## Related concepts
[[Capture The Flag (CTF)]] [[Privilege Escalation]] [[Penetration Testing Methodology]] [[OSCP]] [[Hack The Box]]