---
tags: [knowledge, aplus, core-1-(220-1201)]
created: 2026-04-30
cert: CompTIA A+
chapter: 10
source: rewritten
---

# Network Services
**Critical backbone infrastructure that keeps every device connected, authenticated, and communicating across modern networks.**

---

## Overview

Imagine a massive warehouse (your data center) where thousands of workers need to find the right department, get their ID badge, and know where to go. Network services are those invisible systems managing the whole operation. For A+ candidates, understanding [[DNS]], [[DHCP]], and other core services is essential—these services power every network interaction, and troubleshooting them is a major part of your job.

---

## Key Concepts

### Domain Name System (DNS)

**Analogy**: DNS is like a phone directory. You know someone's name, but you need their phone number to call them. You look it up in the directory. Similarly, you know a website's name (google.com), but computers need the actual phone number (IP address) to reach it.

**Definition**: [[DNS]] ([[Domain Name System]]) translates human-readable fully qualified domain names ([[FQDN]]) into their corresponding [[IP addresses]]. It's a distributed, hierarchical system with thousands of [[DNS servers]] worldwide working together.

**Key Features**:
- Converts domain names → IP addresses (forward lookup)
- Converts IP addresses → domain names (reverse lookup)
- Uses [[DNS caching]] to reduce query load
- Organized in a hierarchical structure with [[root nameservers]], [[TLD servers]], and [[authoritative nameservers]]

**Common DNS Record Types**:

| Record Type | Purpose | Example |
|---|---|---|
| **A** | Maps FQDN to IPv4 address | example.com → 192.168.1.1 |
| **AAAA** | Maps FQDN to IPv6 address | example.com → 2001:db8::1 |
| **CNAME** | Creates alias for another domain | www.example.com → example.com |
| **MX** | Specifies mail server | mail.example.com |
| **NS** | Identifies nameserver | ns1.example.com |
| **PTR** | Reverse DNS lookup | 192.168.1.1 → example.com |
| **TXT** | Text records (SPF, DKIM) | Verification records |

**DNS Query Example**:
```
User types: professor-messer.com
Client queries local DNS server
Local server queries root nameserver
Root points to .com TLD server
TLD server points to authoritative nameserver
Authoritative nameserver returns: 203.0.113.42
Client connects to that IP address
```

---

### Dynamic Host Configuration Protocol (DHCP)

**Analogy**: DHCP is like a parking lot attendant. When you arrive, they hand you a ticket with your parking space number, how long you can stay, and where the bathroom is. When you leave, someone else gets that space. Your device doesn't permanently own the address—it's borrowed temporarily.

**Definition**: [[DHCP]] ([[Dynamic Host Configuration Protocol]]) automatically assigns [[IP addresses]], [[subnet masks]], [[default gateways]], and other network configuration to devices on a network. Instead of manually configuring every device, DHCP servers hand out addresses dynamically.

**DHCP Lease Process** (The Four-Way Handshake):

```
1. DISCOVER:  Client broadcasts "Is anyone offering IP addresses?"
2. OFFER:     DHCP server responds "I can give you X configuration"
3. REQUEST:   Client confirms "Yes, I'll take that offer"
4. ACK:       Server acknowledges lease is active
```

**DHCP Components**:
- [[DHCP Server]] - hands out addresses and config
- [[DHCP Client]] - requests configuration
- [[DHCP Lease]] - temporary IP assignment (typically 24-48 hours)
- [[DHCP Scope]] - range of available addresses to distribute

**DHCP vs. Static IP**:

| Aspect | DHCP | Static IP |
|---|---|---|
| Assignment | Automatic, temporary | Manual, permanent |
| Management | Centralized server | Individual devices |
| Flexibility | High (easy to move) | Low (harder to change) |
| Best For | Workstations, laptops | Servers, printers, routers |
| Configuration | Minimal | Requires manual setup |

---

### Network Time Protocol (NTP)

**Analogy**: NTP is like having a master clock in a train station. Every train conductor checks that clock to make sure they're synchronized. Without it, trains would arrive at random times and everything would be chaos.

**Definition**: [[NTP]] ([[Network Time Protocol]]) synchronizes the system clocks of computers across a network. Accurate time is critical for [[Kerberos]] authentication, [[log files]], security certificates, and system auditing.

**NTP Hierarchy** (Stratum Levels):
- **Stratum 0**: Atomic clocks (cesium clocks, GPS receivers)
- **Stratum 1**: Servers directly connected to Stratum 0 devices
- **Stratum 2**: Servers synchronized to Stratum 1 servers
- **Stratum 15**: Maximum synchronized level (anything above = unsync)

---

### File Transfer Protocol (FTP) & Secure FTP (SFTP)

**Analogy**: FTP is like using a public mailbox to send documents. Anyone watching could intercept them. SFTP is like putting those documents in a locked box first, then sending them.

**Definition**: [[FTP]] ([[File Transfer Protocol]]) transfers files between computers over a network. However, it transmits passwords and data in cleartext, making it a security risk. [[SFTP]] ([[SSH File Transfer Protocol]]) encrypts all transfers and is the modern secure alternative.

**FTP vs. SFTP Comparison**:

| Feature | FTP | SFTP |
|---|---|---|
| Encryption | None (cleartext) | Full encryption ([[SSH]]) |
| Port | 20/21 | 22 |
| Security | Poor | Excellent |
| Authentication | Plaintext username/password | SSH keys or encrypted password |
| Firewall Friendly | Requires port range | Single port (22) |
| Use Case | Legacy systems only | All modern deployments |

---

### Hypertext Transfer Protocol (HTTP/HTTPS)

**Analogy**: HTTP is the language a customer and store clerk use to communicate. HTTPS is the same conversation, but they're both speaking in a secret code only they understand.

**Definition**: [[HTTP]] ([[Hypertext Transfer Protocol]]) is the protocol for transferring web pages and resources. [[HTTPS]] adds [[SSL/TLS]] encryption to secure the connection, protecting passwords, credit cards, and sensitive data.

**HTTP vs. HTTPS**:

| Aspect | HTTP | HTTPS |
|---|---|---|
| Port | 80 | 443 |
| Encryption | None | TLS/SSL encryption |
| Security | Unencrypted | Encrypted end-to-end |
| Certificate | Not required | Required (signed cert) |
| Use Case | Legacy/internal only | All public websites |

---

### Post Office Protocol (POP3) & Internet Message Access Protocol (IMAP)

**Analogy**: POP3 is like going to your mailbox, grabbing all your mail, and taking it home—once it's yours, the mailbox is empty. IMAP is like having a personal assistant who keeps your mail organized at the post office and you can view it from anywhere.

**Definition**: [[POP3]] ([[Post Office Protocol version 3]]) downloads email from a server to a local client and typically deletes it from the server. [[IMAP]] ([[Internet Message Access Protocol]]) keeps email on the server, allowing access from multiple devices and maintaining folder organization.

**POP3 vs. IMAP**:

| Feature | POP3 | IMAP |
|---|---|---|
| Email Storage | Downloaded locally | Stored on server |
| Multiple Devices | Difficult | Seamless |
| Bandwidth | Lower | Higher |
| Offline Access | Yes | Limited |
| Port | 110 (or 995 encrypted) | 143 (or 993 encrypted) |
| Best For | Single device users | Mobile/multi-device users |

---

### Simple Mail Transfer Protocol (SMTP)

**Analogy**: SMTP is the postal service that picks up your letter from your house and takes it to the post office. It only handles sending, not receiving.

**Definition**: [[SMTP]] ([[Simple Mail Transfer Protocol]]) handles outgoing email transmission. It works with [[POP3]] or [[IMAP]] (which handle receiving) to provide complete email functionality.

**SMTP Details**:
- Port: 25 (standard), 587 (submission), 465 (encrypted)
- One-way communication (send only)
- Works with mail servers to route messages
- Often requires [[authentication]] on modern networks

---

### Secure Shell (SSH)

**Analogy**: SSH is like a secure tunnel through a dangerous neighborhood. Your messages travel through the same streets, but they're invisible to anyone watching.

**Definition**: [[SSH]] ([[Secure Shell]]) provides encrypted remote access to systems. It replaces insecure protocols like [[Telnet]] and is used for secure command-line administration, file transfer ([[SFTP]]), and tunneling.

**SSH Key Features**:
- Port: 22
- Encrypted communication (protects passwords)
- Uses public/private [[cryptographic keys]] or password authentication
- Replaces Telnet, rsh, rlogin
- Supports command execution and file transfer

---

### Virtual Private Network (VPN)

**Analogy**: VPN is like a private tunnel through a busy highway. Even though you're using public roads, nobody can see inside your tunnel, and your destination appears to be from wherever your tunnel entrance is.

**Definition**: [[VPN]] ([[Virtual Private Network]]) creates an encrypted tunnel between your device and a VPN server, encrypting all traffic and masking your true IP address. It provides privacy, security, and remote access to corporate networks.

**VPN Use Cases**:
- Accessing corporate resources remotely
- Encrypting data on public Wi-Fi
- Masking IP address from ISPs and websites
- Bypassing geographic restrictions

**Common VPN Protocols**:

| Protocol | Encryption | Speed | Security | Port |
|---|---|---|---|---|
| [[OpenVPN]] | Strong | Good | Excellent | 1194 |
| [[WireGuard]] | Strong | Excellent | Excellent | 51820 |
| [[IPSec]] | Strong | Good | Excellent | 500, 4500 |
| [[L2TP]] | Weak (needs IPSec) | Fair | Good | 1701 |

---

### Lightweight Directory Access Protocol (LDAP)

**Analogy**: LDAP is like a giant address book for your entire organization. Instead of searching multiple filing cabinets, you search one organized directory to find user information, permissions, and resources.

**Definition**: [[LDAP]] ([[Lightweight Directory Access Protocol]]) is a protocol for accessing and maintaining distributed directory information services. It's commonly used for [[Active Directory]] queries, user authentication, and organizational data lookup.

**LDAP Characteristics**:
- Hierarchical directory structure
- Used for authentication and authorization
- Port: 389 (standard), 636 (encrypted with SSL/TLS)
- Supports searching, filtering, and modifying directory entries

---

## Exam Tips

### Question Type 1: Protocol Identification
- *"Which protocol is used to automatically assign IP addresses to DHCP clients?"* → **DHCP** (Dynamic Host Configuration Protocol)
- *"What protocol translates domain names to IP addresses?"* → **DNS** (Domain Name System)
- *"Which protocol encrypts remote command-line access?"* → **SSH** (Secure Shell)
- **Trick**: Don't confuse [[DNS]] (domain name resolution) with [[DHCP]] (IP assignment)—they work together but serve different purposes.

### Question Type 2: Port Number Matching
- *"SSH operates on port ___?"* → **22**
- *"HTTPS uses port ___?"* → **443**
- *"Standard HTTP uses port ___?"* → **80**
- *"SMTP submission port is commonly ___?"* → **587** (or 25 for standard SMTP)
- **Trick**: Memorize the major ports—they appear on almost every exam. Use a mnemonic: "HTTP is 80, HTTPS is 443