---
tags: [knowledge, netplus, network-plus]
created: 2026-05-01
cert: CompTIA Network+
exam: N10-009
chapter: 070
source: rewritten
---

# ARP and DNS Poisoning
**Attackers masquerade as trusted network devices to intercept, eavesdrop on, or manipulate data in transit.**

---

## Overview
Spoofing attacks involve an attacker falsifying their identity to gain unauthorized access or position themselves within network communications. On the Network+ exam, you'll encounter multiple spoofing vectors—from [[Address Resolution Protocol|ARP]] manipulation to [[Domain Name System|DNS]] deception—all designed to enable [[Man-in-the-Middle Attack|on-path attacks]]. Understanding how these layer 2 and layer 7 attacks work is critical for network security troubleshooting and threat mitigation.

---

## Key Concepts

### Spoofing (General Definition)
**Analogy**: Imagine a con artist wearing a fake police uniform and badge to convince people they have authority they don't actually possess. The uniform is the disguise; the impersonation is the threat.

**Definition**: [[Spoofing]] is an attack technique where a malicious actor forges the identity of a legitimate entity—whether an IP address, MAC address, email sender, or phone number—to gain trust or access they wouldn't normally receive. This is the foundational technique enabling more complex attacks.

**Common Spoofing Vectors**:
| Vector | Layer | Target | Example |
|--------|-------|--------|---------|
| [[MAC Address Spoofing]] | Layer 2 | Network devices | Pretending to be the router |
| [[IP Spoofing]] | Layer 3 | Network hosts | Claiming to be 192.168.1.1 |
| [[Email Spoofing]] | Layer 7 | Users | Fake "From:" header |
| [[Caller ID Spoofing]] | Telecom | Users | Fake phone number display |

---

### Address Resolution Protocol (ARP)
**Analogy**: Think of your network like an apartment complex. You know your neighbor's apartment number (IP address), but to deliver mail, you need their physical mailbox location (MAC address). ARP is like asking "Who lives at apartment 192.168.1.1?" so you can find the right mailbox.

**Definition**: [[Address Resolution Protocol|ARP]] is a Layer 2 protocol that maps IP addresses (Layer 3) to [[MAC Addresses|physical MAC addresses]] (Layer 2) on a local network segment. When a device needs to communicate with another device on the same subnet, it broadcasts an ARP request: "Who has this IP? Send me your MAC address."

**How Normal ARP Works**:
```
Device A (192.168.1.100) → "Who has 192.168.1.1?"
Router (192.168.1.1) → "That's me! My MAC is AA:BB:CC:DD:EE:FF"
Device A → Stores mapping in ARP cache
Device A → Sends frames to that MAC address
```

---

### ARP Poisoning (ARP Spoofing)
**Analogy**: Instead of waiting for someone to ask "Who lives at apartment 192.168.1.1?", a malicious person rushes forward and shouts "That's me!" while giving a fake address. Now all mail goes to the wrong mailbox.

**Definition**: [[ARP Poisoning|ARP poisoning]] (also called [[ARP Spoofing]]) is an attack where an attacker floods the network with unsolicited [[ARP Response|ARP replies]], claiming to own an IP address they don't actually control—typically the default gateway or another critical host. The victim devices trust these replies and update their ARP cache tables with the attacker's MAC address.

**Attack Flow**:
```
Attacker → "I am 192.168.1.1 (the router)"
           "My MAC is AA:BB:CC:DD:EE:11" (attacker's actual MAC)

Victim Device → Updates ARP cache with wrong mapping
               All traffic destined for router now goes to attacker
               Attacker can: intercept, monitor, modify, drop packets
```

**Impact**: This enables a [[Man-in-the-Middle Attack|MITM]] attack where the attacker sits between the victim and legitimate gateway, fully controlling the conversation.

---

### DNS Poisoning
**Analogy**: Imagine a phone book (DNS) where someone replaces the entry for "bank.com" with the attacker's phone number. Users think they're calling their bank, but they're actually reaching a fake bank run by the attacker.

**Definition**: [[DNS Poisoning|DNS poisoning]] (also called [[DNS Spoofing]]) is an attack where an attacker corrupts the [[DNS Cache]] with false [[DNS Records|DNS records]], causing users' devices to resolve legitimate domain names to attacker-controlled IP addresses. This can happen through cache poisoning, man-in-the-middle interception of DNS traffic, or compromised DNS servers.

**Attack Vector Comparison**:

| Attack Type | Target | Method | Result |
|------------|--------|--------|--------|
| [[ARP Poisoning]] | [[ARP Cache]] | Fake ARP replies | Attacker intercepts Layer 2 traffic |
| [[DNS Poisoning]] | [[DNS Cache]] | Fake DNS responses | Users redirected to fake websites |
| [[IP Spoofing]] | Network routing | Forged source IP | Attacker impersonates origin |

---

### Man-in-the-Middle (MITM) Attacks
**Analogy**: Two people pass notes in a classroom. An attacker intercepts each note, reads it, modifies it if desired, then passes it along. Both original parties think they're communicating directly, unaware they're being monitored and manipulated.

**Definition**: A [[Man-in-the-Middle Attack|MITM attack]] occurs when an attacker positions themselves between two communicating parties, able to eavesdrop on, intercept, or modify traffic. [[ARP Poisoning|ARP poisoning]] and [[DNS Poisoning|DNS poisoning]] are common enablers of MITM attacks on local networks.

**Example Scenario**:
```
Legitimate Path: Victim → Router → Internet
MITM Path:       Victim → Attacker (acting as router) → Router → Internet
                            ↓ (attacker reads/modifies)
```

---

### ARP Cache
**Definition**: Every device on a network maintains an [[ARP Cache|ARP cache table]]—a temporary mapping of recently resolved IP-to-MAC address pairs. This cache speeds up future communications since devices don't need to repeatedly broadcast ARP requests for the same IP.

**Viewing Your ARP Cache (CLI)**:
```bash
# Windows
arp -a

# Linux/macOS
arp -a
# or newer systems
ip neighbor show
```

**Output Example**:
```
192.168.1.1    aa:bb:cc:dd:ee:ff    [Gateway]
192.168.1.100  11:22:33:44:55:66    [Another device]
```

When poisoned, the attacker's MAC address replaces the legitimate gateway MAC, redirecting all outbound traffic.

---

## Exam Tips

### Question Type 1: Identifying Attack Type
- *"A user's web traffic is being intercepted by an attacker on the same subnet. The attacker's MAC address appears in the user's ARP cache for the gateway address. Which attack occurred?"* → [[ARP Poisoning]]
- **Trick**: Don't confuse ARP spoofing (Layer 2) with DNS spoofing (Layer 7). The question's mention of "ARP cache" and "MAC address" points to ARP.

### Question Type 2: Recognizing MITM Preconditions
- *"Which of the following attacks would allow an attacker to sit between a client and the default gateway without physical wire tapping?"* → [[ARP Poisoning]] or [[DHCP Spoofing]]
- **Trick**: On-path attacks require the attacker to redirect traffic. ARP poisoning is the classic wired LAN mechanism; [[Evil Twin|rogue access points]] work for wireless.

### Question Type 3: Attack Prevention
- *"Which of the following helps prevent ARP poisoning?"* → [[Static ARP Entries]], [[ARP Inspection]], [[VLAN]] segmentation, or port security
- **Trick**: Encryption (TLS/SSL) doesn't prevent the MITM position—it just makes the intercepted data unreadable. That's important but different from prevention.

### Question Type 4: DNS-Specific Threats
- *"Users are being redirected to a phishing website when they type legitimate.com. The attacker likely used which attack?"* → [[DNS Poisoning]] or [[DNS Hijacking]]
- **Trick**: If the question mentions "users' devices" or "resolving domain names," think DNS. If it mentions "ARP cache," think ARP.

---

## Common Mistakes

### Mistake 1: Confusing ARP and DNS Poisoning
**Wrong**: "Both ARP and DNS poisoning work at the same layer and prevent communication."
**Right**: [[ARP Poisoning|ARP poisoning]] operates at Layer 2 (data link) to redirect frames to the attacker's MAC address; [[DNS Poisoning|DNS poisoning]] operates at Layer 7 (application) to redirect domain names to attacker IP addresses. They achieve MITM differently.
**Impact on Exam**: You'll get questions asking "which attack targets the ARP cache?" vs. "which attack redirects domain names?" Mixing them up guarantees wrong answers.

### Mistake 2: Assuming Spoofing = Immediate Compromise
**Wrong**: "If ARP poisoning happens, the attacker automatically has full access to all user data."
**Right**: ARP poisoning positions the attacker to intercept traffic, but data may still be encrypted (HTTPS, VPN). The attacker gains visibility and MITM capability, not automatic decryption.
**Impact on Exam**: Questions on "limitations of ARP poisoning" expect you to mention encryption as a mitigating control. Saying "spoofing = game over" misses the nuance.

### Mistake 3: Thinking Spoofing Requires High Privilege
**Wrong**: "Only administrators or root users can conduct spoofing attacks."
**Right**: [[ARP Spoofing]] and [[DNS Spoofing]] tools run from unprivileged user accounts on the local network. No special privilege is needed if you're on the same subnet.
**Impact on Exam**: Expect scenario questions where an "ordinary user account" conducts an on-path attack. The attacker doesn't need admin—just network proximity.

### Mistake 4: Overlooking Passive Monitoring
**Wrong**: "Spoofing attacks always involve active modification of traffic."
**Right**: An attacker can use ARP poisoning simply to monitor/eavesdrop without modifying packets. Passive MITM is still a threat, especially before encryption became ubiquitous.
**Impact on Exam**: Watch for questions testing whether you understand MITM for *eavesdropping* vs. only for *modification*. Both are valid attack goals.

---

## Related Topics
- [[Man-in-the-Middle Attack]]
- [[Network Segmentation]]
- [[Port Security]]
- [[VLAN]]
- [[Dynamic Host Configuration Protocol|DHCP]] spoofing
- [[Evil Twin]] (wireless equivalent)
- [[SSL Strip]] (HTTPS downgrade MITM)
- [[Packet Sniffing]]
- [[Encryption]] (TLS/SSL mitigation)
- [[Static ARP Entries]]

---

*Source: Professor Messer CompTIA Network+ N10-009 (Rewritten) | [[Network+]]*