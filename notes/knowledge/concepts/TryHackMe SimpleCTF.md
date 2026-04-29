# TryHackMe SimpleCTF

## What it is
Like finding a hidden employee entrance at a bank because the front door has an alarm — this room teaches you to enumerate services, find a vulnerable CMS with weak credentials, and escalate privileges through a misconfigured sudo binary. SimpleCTF is a beginner-level Capture the Flag challenge on TryHackMe that chains reconnaissance, exploitation, and privilege escalation into a single coherent workflow.

## Why it matters
This room mirrors real-world intrusions where attackers exploit default or weak credentials in content management systems (CMS Made Simple CVE-2019-9053) to gain initial access, then pivot to root via sudo misconfigurations — a technique observed in countless SMB compromises. Understanding this chain helps defenders prioritize CMS patching and auditing sudoers files, two controls that directly map to hardening checklists.

## Key facts
- **CVE-2019-9053**: SQL injection vulnerability in CMS Made Simple versions below 2.2.10 that allows unauthenticated credential extraction via time-based blind SQLi
- **Enumeration tools used**: `nmap` for port scanning, `gobuster` for directory brute-forcing — both essential for the initial foothold phase
- **Default ports discovered**: SSH (22), HTTP (80), and a high-numbered port (2222 running SSH) — emphasizing that services can run on non-standard ports
- **Privilege escalation vector**: `vim` can be exploited via `sudo -l` if the user has unrestricted sudo rights on it; running `sudo vim` and spawning a shell with `:!/bin/bash` grants root
- **GTFOBins** is the reference for sudo/binary escape techniques — a critical resource for CySA+ and OSCP-style exams

## Related concepts
[[SQL Injection]] [[Privilege Escalation]] [[CMS Vulnerabilities]] [[GTFOBins]] [[Nmap Enumeration]]