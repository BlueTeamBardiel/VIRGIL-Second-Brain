# FTP

## What it is
Think of FTP like handing your house keys and a note with your address to a stranger on the street — everything is visible to anyone watching. File Transfer Protocol (FTP) is a TCP-based protocol operating on ports 20 (data) and 21 (control) used to transfer files between a client and server. It transmits credentials and data entirely in plaintext, making interception trivial on any shared network.

## Why it matters
In penetration tests and real breaches, attackers running packet captures on compromised network segments routinely harvest FTP credentials because they appear in cleartext — username and password fully readable in Wireshark. The 2011 Sony Pictures breach involved FTP servers with weak credentials exposed to the internet, contributing to massive data exfiltration. Defenders remediate this by migrating to SFTP or FTPS and enforcing firewall rules to block external FTP access entirely.

## Key facts
- FTP uses **two separate TCP connections**: port 21 for control commands and port 20 for active-mode data transfer
- **Anonymous FTP** allows login with username "anonymous" — a common misconfiguration that exposes internal files publicly
- **Active vs. Passive mode**: Active mode has the *server* initiate the data connection back to the client (firewall-hostile); Passive mode has the *client* initiate both connections (firewall-friendly)
- **FTPS** (FTP Secure) adds TLS/SSL encryption; **SFTP** (SSH File Transfer Protocol) is a completely different protocol tunneled over SSH — both replace plain FTP
- FTP is explicitly flagged as a **prohibited/legacy protocol** in frameworks like NIST SP 800-53 and PCI-DSS due to its plaintext nature

## Related concepts
[[SFTP]] [[TFTP]] [[Cleartext Protocols]] [[Active vs Passive Mode]] [[Network Sniffing]]