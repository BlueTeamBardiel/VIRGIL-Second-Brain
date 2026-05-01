---
tags: [knowledge, aplus, core-2-(220-1202)]
created: 2026-04-30
cert: CompTIA A+
chapter: 73
source: rewritten
---

# Remote Access
**Controlling computers from anywhere on Earth like you're sitting right at their keyboard.**

---

## Overview

[[Remote Access]] is the ability to take command of another computer's interface and operating system from a completely different physical location. Help desk technicians, field support teams, and IT administrators rely on this daily to troubleshoot, maintain, and manage systems without being in the same room. For the A+ exam, you need to understand which protocols enable this magic, how to identify when it's running, and when to be suspicious of unauthorized connection attempts.

---

## Key Concepts

### Remote Desktop Protocol (RDP)

**Analogy**: Imagine having a magical window into someone else's monitor that shows their exact screen and lets you move their mouse and type on their keyboard from miles away. That's RDP—Microsoft's window into another Windows machine.

**Definition**: [[Remote Desktop Protocol (RDP)]] is Microsoft's proprietary protocol that transmits keyboard, mouse, and display data between computers over a network. It's built natively into Windows systems and allows complete remote control of a target machine.

| Feature | Details |
|---------|---------|
| **Default Port** | [[TCP Port 3389]] |
| **Operating Systems** | Windows (native), Mac/Linux (via clients) |
| **Mobile Support** | Yes—iOS, Android clients available |
| **Use Case** | Corporate helpdesk, system administration |

```
# Connecting via RDP on command line (Windows)
mstsc /v:192.168.1.50

# Specifying alternate port
mstsc /v:192.168.1.50:3390
```

---

### Virtual Network Computing (VNC)

**Analogy**: VNC is like the open-source cousin of RDP—instead of one company controlling the standard, anyone can build VNC clients and servers that work across any operating system.

**Definition**: [[Virtual Network Computing (VNC)]] uses the [[Remote Frame Buffer (RFB)]] protocol to share graphical screen data and input commands between machines. It's cross-platform, open-source, and platform-agnostic.

| Feature | RDP | VNC |
|---------|-----|-----|
| **Creator** | Microsoft | Open-source community |
| **Default Port** | 3389 | 5900 |
| **Platform Support** | Primarily Windows | All OS |
| **Compression** | Built-in | Variable |
| **Security** | Kerberos-aware | Basic encryption |

---

### Port Identification & Security

**Analogy**: Open ports are like unlocked doors in a building. If you see port 3389 wide open, someone's broadcasting "come control my desktop from anywhere."

**Definition**: [[Network ports]] are the "doorways" services listen on. Scanning for specific ports reveals what remote services a machine is running.

**Critical Port Numbers**:
- **[[TCP Port 3389]]** → RDP is listening (almost certainly Windows remote desktop)
- **[[TCP Port 5900]]** → VNC is listening (could be any OS)
- **[[TCP Port 22]]** → [[SSH]] is listening (secure shell, not graphical)

```bash
# Windows: Check listening ports
netstat -ano | findstr LISTENING

# Linux: Check for VNC listening
sudo netstat -tlnp | grep 5900

# Cross-platform: PowerShell method
Get-NetTCPConnection -State Listen
```

---

## Exam Tips

### Question Type 1: Protocol Identification
- *"A technician notices port 3389 is open on a Windows machine. What service is most likely running?"* → [[Remote Desktop Protocol (RDP)]] / Remote Desktop Service
- *"An administrator wants to remotely manage Linux servers and Windows workstations with one tool. What's the cross-platform solution?"* → [[VNC]] (or SSH for command-line)
- **Trick**: Port 3389 **always** means RDP on Windows—this is the classic giveaway question. Don't overthink it.

### Question Type 2: Security Scenarios
- *"You receive a call from 'Microsoft Support' asking to remote into your computer. What's your first action?"* → Hang up and verify the caller through official Microsoft channels. This is a classic [[Remote Access scam]].
- **Trick**: The exam loves testing whether you know remote access is a **vector for social engineering**. Legitimate support will never cold-call asking for access.

### Question Type 3: Port & Protocol Matching
- *"Which port is associated with VNC?"* → 5900
- *"An organization wants encrypted remote access for Linux servers. Which protocol combines remote access with strong encryption?"* → [[SSH]] (port 22)
- **Trick**: Don't confuse VNC (graphical, port 5900) with SSH (command-line, port 22). VNC looks like your desktop; SSH is text-only.

---

## Common Mistakes

### Mistake 1: Confusing RDP and VNC
**Wrong**: "VNC is just Microsoft's version of remote desktop, so they're basically the same thing."
**Right**: RDP is Microsoft's proprietary protocol for Windows; VNC is open-source and works on any OS. They use different ports (3389 vs. 5900) and different underlying protocols.
**Impact on Exam**: You'll get questions asking which protocol works on Linux or what port number identifies each service. Wrong confusion = wrong answer.

### Mistake 2: Ignoring Security Implications
**Wrong**: "Remote access is just a tool. If someone connects, they must be authorized."
**Right**: Open remote access ports (especially RDP on the public internet) are **major attack vectors**. Scammers actively scan for port 3389 and use social engineering to gain access.
**Impact on Exam**: A+ tests your real-world judgment. Questions will ask "What should you do if an unknown third party requests remote access?" The answer is verify their identity first, not grant access blindly.

### Mistake 3: Forgetting about Authentication
**Wrong**: "RDP and VNC are the same—both require usernames and passwords."
**Right**: RDP integrates with Windows [[authentication]] (Kerberos, NTLM); VNC has simpler authentication. RDP can be more secure in enterprise environments because it uses OS-level credentials.
**Impact on Exam**: Questions may ask which is safer for corporate networks. RDP wins because it leverages existing Windows security infrastructure.

### Mistake 4: Misidentifying Ports
**Wrong**: "Port 5900 is for RDP because it's a higher number."
**Right**: Port assignments are arbitrary—RDP chose 3389, VNC chose 5900. You must memorize these.
**Impact on Exam**: Port identification questions are **direct** on the A+. You'll see: "Port 3389 = RDP" as a flashcard concept.

---

## Related Topics
- [[Network Ports and Services]]
- [[TCP/IP Protocols]]
- [[SSH (Secure Shell)]]
- [[Firewall Configuration]]
- [[Social Engineering and Security Scams]]
- [[Windows Remote Desktop Service]]
- [[Authentication Methods]]
- [[Network Troubleshooting Tools]]

---

*Source: Rewritten from Professor Messer CompTIA A+ Core 2 (220-1202) Remote Access Lecture | [[A+]] [[Core 2]] [[220-1202]]*