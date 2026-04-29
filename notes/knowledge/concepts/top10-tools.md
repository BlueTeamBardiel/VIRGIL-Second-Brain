# top10-tools

## What it is
Like a master locksmith's toolkit hanging on the wall — each tool purpose-built for a specific lock — the cybersecurity Top 10 Tools are the canonical utilities that professionals reach for during assessments, investigations, and defense operations. Specifically, this refers to the most widely used open-source and commercial tools across penetration testing, network analysis, vulnerability scanning, and forensics. Organizations like SANS and exam bodies (CompTIA, EC-Council) treat fluency in these tools as a baseline competency.

## Why it matters
During a red team engagement, an attacker uses **Nmap** to map open ports, **Metasploit** to exploit a vulnerable SMB service, and **Mimikatz** to dump credentials from memory — all within 30 minutes. Defenders who understand these same tools can correlate logs, build detection signatures, and recognize attack patterns before lateral movement completes.

## Key facts
- **Nmap** — network discovery and port scanning; uses TCP SYN, UDP, and version detection scans
- **Wireshark** — packet capture and protocol analysis; critical for spotting cleartext credentials or C2 beaconing
- **Metasploit Framework** — exploitation platform with modules for known CVEs; used in both offense and security validation
- **Burp Suite** — HTTP/HTTPS proxy for web application testing; catches SQLi, XSS, and IDOR vulnerabilities in traffic
- **Nessus / OpenVAS** — vulnerability scanners that map findings to CVE/CVSS scores, directly relevant to risk prioritization on CySA+
- **Autopsy / FTK** — digital forensics platforms for disk image analysis, file carving, and timeline reconstruction
- Tools are categorized by phase: **Reconnaissance → Scanning → Exploitation → Post-exploitation → Reporting**

## Related concepts
[[penetration-testing]] [[vulnerability-scanning]] [[network-forensics]] [[packet-analysis]] [[exploit-frameworks]]