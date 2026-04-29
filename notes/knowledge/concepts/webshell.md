# webshell

## What it is
Think of a webshell like a hidden employee badge taped inside a server's break room — once planted, anyone who knows it's there can walk in and issue commands any time they want. Precisely: a webshell is a malicious script (commonly PHP, ASP, or JSP) uploaded to a web server that provides an attacker with remote command execution through HTTP requests, effectively turning a web browser into a terminal.

## Why it matters
In the 2021 Microsoft Exchange Server attacks (HAFNIUM), threat actors exploited ProxyLogon vulnerabilities to drop China Chopper webshells onto thousands of corporate Exchange servers. This gave attackers persistent, low-noise access to internal networks long after the initial vulnerability was patched — because defenders forgot to hunt for the implants left behind.

## Key facts
- Webshells are commonly uploaded via **file upload vulnerabilities, LFI/RFI, or CVE exploitation** — the upload vector is distinct from the shell itself
- China Chopper is a notable one-liner webshell: just ~4KB, making it nearly invisible in directory listings
- They enable **persistence, lateral movement, data exfiltration, and C2 communication** — all over standard port 80/443, blending with normal traffic
- Detection methods include **file integrity monitoring (FIM), anomalous process trees** (e.g., `httpd` spawning `cmd.exe`), and scanning for known signatures via tools like **YARA** or **web server log analysis**
- MITRE ATT&CK maps webshells to **T1505.003** (Server Software Component: Web Shell) under the Persistence tactic

## Related concepts
[[file inclusion vulnerability]] [[persistence]] [[command and control]] [[YARA]] [[privilege escalation]]