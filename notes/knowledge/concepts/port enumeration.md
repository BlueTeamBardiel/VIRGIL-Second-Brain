# port enumeration

## What it is
Like a burglar walking down a street trying every door and window to see which ones open, port enumeration is the systematic probing of a target system's TCP/UDP ports to discover which services are actively listening. It maps the attack surface before exploitation begins, identifying open ports, associated services, and software versions.

## Why it matters
During the 2017 WannaCry outbreak, attackers specifically scanned for systems with TCP port 445 (SMB) open before deploying the EternalBlue exploit — organizations that had enumerated and closed unnecessary ports were protected. Defenders use the same technique during vulnerability assessments to find exposed services that shouldn't be internet-facing, such as a database listening on port 3306 with no firewall rule blocking external access.

## Key facts
- **Nmap** is the industry-standard tool; `-sS` (SYN scan) is stealthy, `-sV` fingerprints service versions, `-O` attempts OS detection
- TCP **SYN scan** sends a SYN packet and interprets the response: SYN-ACK = open, RST = closed, no response = filtered
- Common high-value ports to know: 21 (FTP), 22 (SSH), 23 (Telnet), 80/443 (HTTP/HTTPS), 445 (SMB), 3389 (RDP), 3306 (MySQL)
- **UDP scanning** is slower and less reliable than TCP because closed UDP ports may silently drop packets rather than sending RST responses
- Port enumeration is a core phase of **reconnaissance** in the cyber kill chain and maps directly to the "Scanning" step in the CEH/Nmap methodology

## Related concepts
[[network reconnaissance]] [[vulnerability scanning]] [[banner grabbing]] [[firewall evasion]] [[attack surface]]