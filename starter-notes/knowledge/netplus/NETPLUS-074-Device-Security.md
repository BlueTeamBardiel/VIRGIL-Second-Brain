---
tags: [knowledge, netplus, network-plus]
created: 2026-05-01
cert: CompTIA Network+
exam: N10-009
chapter: 074
source: rewritten
---

# Device Security
**Controlling what can talk to your computer by managing open doors and deciding who gets in.**

---

## Overview
Device security focuses on preventing unauthorized access to individual systems by controlling which [[network services]] and [[ports]] are exposed to potential attackers. This matters for Network+ because every device on a network represents a potential entry point—and as a network professional, you need to understand how to lock down those entry points to protect both individual systems and the broader network infrastructure.

---

## Key Concepts

### Port Exposure and Network Services
**Analogy**: Think of ports like doors on a house. Each [[service]] running on your computer is a door that's unlocked and visible to everyone walking by. Some doors you need open for guests; others are just attracting burglars.

**Definition**: Every [[network service]] (like [[HTTP]], [[SSH]], [[FTP]]) running on a device opens a corresponding [[port]] in the range 0–65,535. These open ports are visible to other devices on the network and represent potential entry points for attackers.

| Aspect | Details |
|--------|---------|
| Port Range | 0–65,535 |
| What opens them | Active [[network services]] |
| Visibility | Visible to other networked devices |
| Risk | Each open port = potential attack vector |

---

### Service Inventory and Auditing
**Analogy**: Imagine leaving doors unlocked in your house without knowing they're there. That's what happens when services run automatically without your knowledge—you have security vulnerabilities you don't even realize exist.

**Definition**: Many devices run background [[services]] by default that the system administrator may not be aware of. These unwanted or unnecessary services create open ports that become unnecessary [[attack surface]].

**Mitigation Approach**:
- Identify all running services
- Disable services you don't actively use
- Close associated ports at the [[firewall]] level
- Periodically audit for unexpected services

---

### Firewall-Based Port Control
**Analogy**: A [[firewall]] acts like a security guard at your front door. Instead of letting everyone pass through, it checks each visitor's credentials and decides whether to allow or deny them entry based on your rules.

**Definition**: A [[firewall]] is a policy-based security layer that controls which devices can access which [[ports]] on your computer. It can enforce different rules for internal network traffic versus external (internet) traffic.

**Decision Points**:
- Allow internal network users to access a port? (Yes/No)
- Allow external/internet users? (Yes/No)
- Which specific IP ranges or devices? (Whitelist)
- Which traffic should be blocked? (Blacklist)

---

### Network Scanning and Discovery
**Analogy**: A port scanner is like a security auditor who systematically tests every door in your building to see which ones are actually locked and which ones open when pushed.

**Definition**: Tools like [[Nmap]] scan a target device across all 65,535 possible ports to determine which ones are open (accepting connections), closed (rejecting connections), or filtered ([[firewall]]-blocked).

**CLI Example**:
```bash
nmap -p 1-65535 192.168.1.100
nmap -sV 192.168.1.100  # Identify services on open ports
nmap -A 192.168.1.100   # Aggressive scan (OS, version, script detection)
```

**What Results Tell You**:
- **Open**: Service is running and accepting connections
- **Closed**: Port is reachable but nothing is listening
- **Filtered**: [[Firewall]] is blocking access

---

## Exam Tips

### Question Type 1: Identifying Open Ports and Vulnerabilities
- *"A network administrator notices port 23 is open on a critical server. What is the primary security concern?"* → [[Telnet]] is running unencrypted; credentials are sent in plaintext. Should be replaced with [[SSH]] (port 22) or disabled entirely.
- *"You scan a workstation and find ports 3389, 5900, and 22 all open. What do these indicate?"* → Remote management services ([[RDP]], [[VNC]], [[SSH]]) that should probably be restricted to internal-only access via firewall rules.
- **Trick**: Don't assume an open port means the service is being actively used—it might be leftover from a previous install.

### Question Type 2: Firewall Rule Application
- *"Which firewall rule prevents internet users from reaching your internal web server while allowing internal traffic?"* → A rule that allows port 80/443 only for source IPs within your internal network range (e.g., 192.168.x.x).
- *"A firewall is configured to deny all inbound traffic by default. What additional rule is needed for external SSH access?"* → An explicit allow rule for port 22 from authorized external IP addresses.
- **Trick**: "Deny all, allow specific" is more secure than "allow all, deny specific" — watch for questions testing this principle.

### Question Type 3: Service Remediation
- *"Port 445 is open on all company workstations. What should be done?"* → Disable [[SMB]] unless it's required for file sharing, or restrict it to internal-only via firewall.
- *"An audit reveals unnecessary services running on a production server. What is the best practice?"* → Stop and disable the service, then verify the port is no longer listening.
- **Trick**: Closing a port at the firewall ≠ disabling the service. You need to do both for complete security.

---

## Common Mistakes

### Mistake 1: Confusing Firewall Rules with Service Disabling
**Wrong**: "I blocked port 22 at the firewall, so [[SSH]] is secure now."
**Right**: Blocking the port prevents external access, but the service is still running and consuming resources. You should actually disable the SSH service if you don't need it.
**Impact on Exam**: You may see questions asking whether a port is still "open" vs. "accessible"—these are different concepts. A port can be open (service listening) but not accessible (firewall-filtered).

### Mistake 2: Not Distinguishing Between Well-Known and Dynamic Ports
**Wrong**: "Ports above 49,152 are always safe to use."
**Right**: [[Ephemeral ports]] (49,152–65,535) are used by clients for outbound connections, but services can technically bind to any port. An attacker could run a malicious service on port 60,000.
**Impact on Exam**: Questions may ask which ports should never be opened or which port ranges are reserved for specific purposes. Know that 0–1,023 are well-known, 1,024–49,151 are registered.

### Mistake 3: Assuming All Open Ports Are Intentional
**Wrong**: "If a port is open, an administrator intentionally opened it."
**Right**: Malware, unpatched services, or forgotten installations can open unexpected ports. Regular audits with tools like [[Nmap]] are essential.
**Impact on Exam**: Expect questions about discovering unwanted open ports and the proper remediation workflow (identify → investigate → disable/firewall → verify).

### Mistake 4: Mixing Up Inbound vs. Outbound Firewall Rules
**Wrong**: "A firewall rule denying port 80 inbound will stop users from browsing the web."
**Right**: That rule stops external traffic from reaching your web server, but doesn't prevent internal users from accessing external websites. You'd need an outbound rule for that.
**Impact on Exam**: Carefully read whether questions ask about restricting access TO a device or access FROM a device.

---

## Related Topics
- [[Firewall]]
- [[Network Services]]
- [[SSH]]
- [[Telnet]]
- [[RDP]] (Remote Desktop Protocol)
- [[Nmap]]
- [[Port Scanning]]
- [[Vulnerability Assessment]]
- [[Security Best Practices]]
- [[Attack Surface]]
- [[Service Hardening]]

---

*Source: Professor Messer CompTIA Network+ N10-009 | [[Network+]]*