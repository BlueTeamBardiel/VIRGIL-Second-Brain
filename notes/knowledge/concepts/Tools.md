# Tools

## What it is
Like a surgeon's tray holding scalpels, retractors, and sutures for different stages of an operation, cybersecurity tools are purpose-built instruments designed for specific phases of attack or defense. Precisely defined, tools are software or hardware utilities used to automate, assist, or execute security tasks across the attack lifecycle — from reconnaissance through post-exploitation or detection and response.

## Why it matters
During a red team engagement, an operator uses **Nmap** for port scanning, **Metasploit** for exploitation, and **Mimikatz** for credential harvesting — each tool purpose-matched to its phase. Defenders counter by deploying **Wireshark** or **Zeek** to capture traffic anomalies and **SIEM platforms** like Splunk to correlate alerts, demonstrating that tool selection directly determines operational outcome on both sides.

## Key facts
- **Nmap** performs host discovery, port scanning, and OS fingerprinting; its `-sV` flag enumerates service versions, critical for vulnerability mapping
- **Metasploit Framework** is the industry-standard exploitation platform; modules are categorized as exploits, payloads, auxiliary, and post-exploitation
- **Wireshark** captures packets in pcap format and decodes protocols in real time; it's the go-to tool for network forensics and traffic analysis on Security+ exams
- **Burp Suite** is the primary tool for web application testing, intercepting HTTP/HTTPS traffic between browser and server to identify injection and authentication flaws
- Tool categories map to the **MITRE ATT&CK** framework: reconnaissance tools (Shodan), execution tools (PowerShell Empire), exfiltration tools (Rclone) — knowing categories beats memorizing individual names

## Related concepts
[[Penetration Testing]] [[MITRE ATT&CK Framework]] [[Vulnerability Scanning]] [[SIEM]] [[Reconnaissance]]