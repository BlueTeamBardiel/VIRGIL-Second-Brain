---
tags: [knowledge, aplus, core-1-(220-1201)]
created: 2026-04-30
cert: CompTIA A+
chapter: 08
source: rewritten
---

# Common Ports
**Master the port numbers that control network communication and firewall rules.**

---

## Overview

Network services need addresses to receive incoming requests — think of ports like apartment numbers in a building. [[TCP]] and [[UDP]] use port numbers to route data to the correct application, making them essential when diagnosing connectivity problems or locking down [[firewalls]]. A+ techs must memorize standard ports because they appear constantly in real-world troubleshooting and security configurations.

---

## Key Concepts

### Port Numbers and Protocol Association

**Analogy**: Ports are like radio station frequencies — your device tunes to the correct number to reach the right service. Just as 101.5 FM always broadcasts the same station, port 80 always expects [[HTTP]] traffic.

**Definition**: [[Port numbers]] are numerical identifiers (0-65535) assigned to [[TCP]] and [[UDP]] connections that tell a device which application should handle incoming data. [[Well-known ports]] (0-1023) are reserved for standard services.

**Why it matters**: Firewalls filter traffic by port number, making port knowledge critical for access control.

---

### FTP (File Transfer Protocol)

**Analogy**: FTP is like using a postal service with two separate trucks — one carries your letter (control instructions), the other hauls the actual packages (data files).

**Definition**: [[FTP]] is a protocol enabling file transfers between computers across networks, using two distinct ports for different purposes:

| Port | Purpose | Direction | Usage |
|------|---------|-----------|-------|
| **TCP 20** | Data Transfer (Active Mode) | Server → Client | Actual file content flows here |
| **TCP 21** | Control/Command Channel | Bidirectional | Login, commands, status messages |

**Key Detail**: Port 21 handles authentication and commands; port 20 streams the actual files. Some FTP variants use different port assignments for [[passive mode]].

---

### Standard Port Reference Table

| Service | Port(s) | Protocol | Purpose |
|---------|---------|----------|---------|
| [[SSH]] | 22 | TCP | Encrypted remote access |
| [[Telnet]] | 23 | TCP | Unencrypted remote access |
| [[SMTP]] | 25 | TCP | Sending email |
| [[DNS]] | 53 | TCP/UDP | Domain name resolution |
| [[HTTP]] | 80 | TCP | Web browsing (unencrypted) |
| [[HTTPS]] | 443 | TCP | Web browsing (encrypted) |
| [[FTP]] | 20/21 | TCP | File transfer |
| [[POP3]] | 110 | TCP | Email retrieval |
| [[IMAP]] | 143 | TCP | Email access/sync |
| [[RDP]] | 3389 | TCP | Windows remote desktop |

---

## Exam Tips

### Question Type 1: Port Identification
- *"A user cannot send emails. Traffic to port 25 is being blocked by the firewall. Which protocol is affected?"* → [[SMTP]] — the service sending mail (not retrieval).
- **Trick**: Don't confuse SMTP (sending, port 25) with POP3 (retrieving, port 110) — test makers love this swap.

### Question Type 2: Firewall Configuration
- *"You need to allow secure remote access. Which port should you open on the firewall?"* → TCP port 22 ([[SSH]]), not port 23 (unencrypted [[Telnet]]).
- **Trick**: Modern networks NEVER use Telnet — always choose SSH for security questions.

### Question Type 3: Dual-Port Services
- *"FTP uses which two ports?"* → TCP 20 (data) and TCP 21 (control).
- **Trick**: Port 20 = data transfer; port 21 = commands. Memorize the link.

---

## Common Mistakes

### Mistake 1: Confusing FTP Ports
**Wrong**: "Port 20 is for FTP authentication."
**Right**: Port 21 handles authentication and control commands; port 20 transfers actual file data.
**Impact on Exam**: You'll miss questions about which port to open for file uploads or login attempts.

### Mistake 2: Mixing Up Email Ports
**Wrong**: "POP3 is port 25."
**Right**: SMTP (sending) = 25; POP3 (retrieving) = 110; IMAP (syncing) = 143.
**Impact on Exam**: Email troubleshooting questions become impossible if you reverse these.

### Mistake 3: Thinking Telnet is Secure
**Wrong**: "Use Telnet (port 23) for remote access when SSH isn't available."
**Right**: SSH (port 22) encrypts credentials; Telnet sends passwords in plain text and is deprecated.
**Impact on Exam**: Any security-related remote access question requires SSH, never Telnet.

### Mistake 4: Assuming All Protocols Use TCP
**Wrong**: "All well-known ports use TCP only."
**Right**: [[DNS]] uses both TCP (port 53) and UDP (port 53) depending on query size.
**Impact on Exam**: You might incorrectly block UDP 53 while troubleshooting DNS issues.

---

## Real-World Application

When configuring a [[firewall]], you're essentially saying: "Allow traffic destined for port 80 on TCP" (HTTP web browsing). If users can't access email, check if port 25 (SMTP) and port 110 (POP3) are both open. If remote support staff can't connect, verify TCP 3389 (RDP) or TCP 22 (SSH) is permitted outbound.

---

## Related Topics
- [[TCP and UDP]]
- [[Firewall Rules and ACLs]]
- [[Network Troubleshooting]]
- [[HTTPS and Encryption]]
- [[Remote Access Protocols]]
- [[Email Protocols (SMTP, POP3, IMAP)]]

---

*Source: Rewritten from Professor Messer CompTIA A+ Core 1 (220-1201) | [[A+]] | [[Networking Fundamentals]]*