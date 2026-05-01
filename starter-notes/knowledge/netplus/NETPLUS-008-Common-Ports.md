---
tags: [knowledge, netplus, network-plus]
created: 2026-05-01
cert: CompTIA Network+
exam: N10-009
chapter: 008
source: rewritten
---

# Common Ports
**Understanding which port numbers enable specific network services is fundamental to configuring and troubleshooting applications.**

---

## Overview
In your role as a network administrator, you'll frequently need to identify, configure, and verify the correct [[port numbers]] that applications use to communicate across the network. The CompTIA Network+ exam expects you to memorize the standard [[well-known ports]] (0-1023) associated with common protocols and services. This knowledge directly impacts your ability to troubleshoot connectivity issues, configure firewalls, and manage network security.

---

## Key Concepts

### File Transfer Protocol (FTP)
**Analogy**: Think of FTP like a postal service with two separate workflows—one person handles moving the actual mail (packages), while another person manages all the paperwork, addresses, and logistics. Both need to work together.

**Definition**: [[FTP]] is a cross-platform file transfer mechanism that operates over two [[TCP]] ports simultaneously to separate data movement from control operations.

| Aspect | Port | Purpose |
|--------|------|---------|
| **Control Channel** | TCP 21 | Authentication, directory listing, commands |
| **Data Channel** | TCP 20 | Actual file transfer, uploads, downloads |

**Capabilities**:
- [[Username]]/[[password]] authentication
- File upload and download operations
- Directory navigation and listing
- File creation, deletion, and renaming
- Batch operations across multiple files

---

### Secure Shell (SSH)
**Analogy**: If [[Telnet]] is like shouting commands across an open town square where everyone can hear, [[SSH]] is like having a private phone conversation where everything you say is scrambled so only the person on the other end can understand it.

**Definition**: [[SSH]] is an encrypted remote access protocol that provides secure command-line management of distant systems through a protected [[tunnel]].

| Feature | Telnet | SSH |
|---------|--------|-----|
| **Port** | TCP 23 | TCP 22 |
| **Encryption** | None | Full encryption |
| **Authentication** | Basic | Key-based or password |
| **Security Level** | Deprecated | Industry standard |

**Key Advantages**:
- End-to-end [[encryption]] of all data
- Protected against [[packet sniffing]]
- Secure credential transmission
- Remote command execution capability
- [[Tunneling]] support for other protocols

---

### Secure File Transfer Protocol (SFTP)
**Analogy**: SFTP takes the familiar FTP workflow but wraps the entire conversation in an encrypted envelope, so no one eavesdropping on the network can see what files are being moved or what commands are being sent.

**Definition**: [[SFTP]] combines [[FTP]] functionality with [[SSH]] encryption, running exclusively over [[TCP 22]] instead of FTP's dual-port model.

**Comparison to FTP**:
```
FTP:  [Unencrypted Control on Port 21] + [Unencrypted Data on Port 20]
SFTP: [Everything Encrypted on Port 22]
```

---

## Exam Tips

### Question Type 1: Port Number Identification
- *"A user reports they cannot transfer files securely to a remote server. Which port should you verify is open on the firewall?"* → **TCP 22 (for SFTP)** or **TCP 21/20 (for standard FTP)**
- *"Your organization wants to eliminate unencrypted remote access. Which protocol and port should you disable?"* → **TCP 23 ([[Telnet]])**

**Trick**: The exam may ask about [[FTP]] and expect you to remember it uses *two* ports, not one. Many students forget TCP 20.

### Question Type 2: Protocol Matching
- *"Which of the following provides encrypted file transfer?"* → **SFTP (port 22)**, not FTP
- *"A firewall rule allows only port 22. Which file transfer method will work?"* → **SFTP only**

**Trick**: Don't confuse SFTP (port 22) with FTPS (port 989/990—FTP with SSL/TLS).

### Question Type 3: Security Implications
- *"Why would an organization migrate from FTP to SFTP?"* → **Credentials and data are encrypted; unencrypted FTP exposes passwords in plaintext.**

---

## Common Mistakes

### Mistake 1: Confusing FTP Port Numbers
**Wrong**: "FTP runs on port 21."
**Right**: "FTP uses TCP 21 for control commands and TCP 20 for data transfer. Port 21 is what you configure, but both must be open for the protocol to function."
**Impact on Exam**: You may see a question asking which ports to open for FTP. Answering "just 21" is incomplete and will be marked wrong.

### Mistake 2: Mixing Up SFTP and FTPS
**Wrong**: "SFTP and FTPS are the same thing—both encrypt FTP."
**Right**: [[SFTP]] runs over [[SSH]] on port 22. [[FTPS]] is FTP wrapped in [[SSL]]/[[TLS]] and uses ports 989 (data) and 990 (control).
**Impact on Exam**: These are distinct protocols with different ports and different encryption mechanisms. The N10-009 expects you to distinguish between them.

### Mistake 3: Forgetting SSH Does More Than Terminal Access
**Wrong**: "SSH is only for command-line remote access."
**Right**: SSH (port 22) is a *protocol* that enables encrypted tunneling for multiple services, including SFTP, port forwarding, and remote command execution.
**Impact on Exam**: Questions may ask what service runs on port 22 beyond just terminal access. Understanding [[tunneling]] and [[port forwarding]] is important.

### Mistake 4: Assuming All File Transfer Uses the Same Port
**Wrong**: "All file transfer protocols use port 20 or 21."
**Right**: SFTP uses port 22, FTPS uses different ports (989/990), and [[TFTP]] uses port 69. Each protocol has its own standard ports.
**Impact on Exam**: Scenario-based questions may describe a service on an unexpected port and ask you to identify it. Don't assume all file transfer = FTP ports.

---

## Related Topics
- [[TCP and UDP Protocols]]
- [[Well-Known Ports and Port Ranges]]
- [[Encryption and Tunneling]]
- [[Firewall Configuration and Port Rules]]
- [[Network Security Best Practices]]
- [[SSH Keys and Public Key Infrastructure]]
- [[Telnet vs SSH]]

---

*Source: Professor Messer CompTIA Network+ N10-009 (Rewritten) | [[Network+]]*