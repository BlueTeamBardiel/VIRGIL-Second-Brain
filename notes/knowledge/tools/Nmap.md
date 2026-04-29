# nmap

## What it is
Think of nmap as a postal worker who knocks on every door in a neighborhood, notes which ones open, and reports back on who answered. Precisely, nmap (Network Mapper) is an open-source CLI tool that performs host discovery, port scanning, service enumeration, and OS fingerprinting across IP networks. It works by crafting and analyzing raw packets to map the attack surface of a target system.

## Why it matters
During a penetration test, a security team uses nmap to discover that a legacy Windows server has TCP port 445 (SMB) exposed to the internet — the exact vector exploited by WannaCry. Without this reconnaissance step, the vulnerability would remain invisible until an attacker found it first. Defenders also use nmap continuously to audit their own networks for unauthorized services and shadow IT.

## Key facts
- **SYN scan (`-sS`)** is the default "stealth" scan — it sends a SYN packet and never completes the TCP handshake, reducing log footprint on many systems
- **Service/version detection (`-sV`)** probes open ports to identify the running application and version (e.g., OpenSSH 8.2), critical for CVE matching
- **OS fingerprinting (`-O`)** requires at least one open and one closed port and uses TCP/IP stack behavior differences to guess the OS
- **NSE (Nmap Scripting Engine)** allows scripts (e.g., `vuln`, `smb-vuln-ms17-010`) to automate vulnerability checks during scanning
- **TCP connect scan (`-sT`)** completes the full handshake and is detectable; used when raw packet privileges are unavailable

## Related concepts
[[Port Scanning]] [[Enumeration]] [[Vulnerability Scanning]] [[Reconnaissance]] [[Metasploit]]