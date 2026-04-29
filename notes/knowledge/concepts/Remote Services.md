# Remote Services

## What it is
Think of remote services like a universal skeleton key ring — protocols that let administrators unlock and operate systems from across a network without being physically present. Precisely, remote services are network-accessible interfaces (SSH, RDP, VNC, Telnet, WinRM) that allow interactive or automated control of a host from a remote location, and are heavily targeted by attackers seeking lateral movement or initial access.

## Why it matters
In the 2021 Colonial Pipeline attack, threat actors gained initial access through a legacy VPN account with no MFA — a remote access service exposed to the internet. This single unprotected entry point cascaded into a ransomware deployment that shut down fuel distribution across the U.S. East Coast, demonstrating that remote services without strong authentication controls are catastrophically high-risk assets.

## Key facts
- **MITRE ATT&CK T1021** covers lateral movement via remote services, including RDP (T1021.001), SMB/Windows Admin Shares (T1021.002), and SSH (T1021.004)
- RDP runs on **TCP port 3389** and is one of the most brute-forced services exposed on the internet; disabling it or placing it behind a VPN dramatically reduces attack surface
- **SSH (port 22)** is generally safer than Telnet (port 23) because it encrypts traffic; Telnet transmits credentials in plaintext
- **WinRM (ports 5985/5986)** powers PowerShell remoting and is frequently abused post-compromise for fileless lateral movement
- Defense strategy: enforce **MFA, network segmentation, just-in-time (JIT) access**, and monitor for unusual login times/geolocations on all remote service logs

## Related concepts
[[Lateral Movement]] [[Brute Force Attacks]] [[Multi-Factor Authentication]] [[VPN]] [[Attack Surface Management]]