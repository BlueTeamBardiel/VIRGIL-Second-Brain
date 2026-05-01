---
tags: [knowledge, aplus, core-2-(220-1202)]
created: 2026-04-30
cert: CompTIA A+
chapter: 40
source: rewritten
---

# On-Path Attacks
**An attacker positions themselves between two communicating devices to eavesdrop on or manipulate network traffic.**

---

## Overview

Imagine two people having a private conversation in a hallway, and someone sneaks in between them to read their lips and intercept messages. That's essentially what an on-path attack does to network traffic. Instead of Device A and Device B talking securely, an attacker inserts themselves into the [[Network Communication]] chain, becoming invisible to both parties while capturing or altering every packet. This is critical for the A+ exam because it represents one of the most dangerous [[Network Security]] threats that endpoint detection can't always catch—the malicious middleman operates at the [[Network Layer]], not on the compromised devices themselves.

---

## Key Concepts

### On-Path Attack (Man-in-the-Middle / MITM)

**Analogy**: Think of a postal worker secretly opening your mail, reading it, photocopying sensitive pages, resealing it, and passing it along—you and the recipient never know the mail was tampered with.

**Definition**: A [[Network Attack]] where an attacker positions themselves between two communicating parties to intercept, monitor, and potentially modify data in transit. The two endpoints remain unaware the channel is compromised.

| Characteristic | Impact |
|---|---|
| **Detection Difficulty** | Very hard—endpoint security may see nothing |
| **Layer of Operation** | [[Network Layer]] (Layer 2-3) |
| **Visibility to End Devices** | None |
| **Data Modification** | Possible (active attack) |
| **Passive Monitoring** | Always possible (passive attack) |

---

### ARP Poisoning / ARP Spoofing

**Analogy**: Imagine a company phone directory where someone changes the entry so everyone looking up the boss's extension gets the attacker's phone number instead.

**Definition**: An attack exploiting the lack of security in the [[Address Resolution Protocol (ARP)]] to send false [[ARP]] replies on a [[Local Area Network (LAN)]]. The attacker floods the network with spoofed [[ARP]] packets, convincing devices that the attacker's [[MAC Address]] belongs to a target [[IP Address]] (typically the default gateway).

**Why ARP is Vulnerable**:
- No authentication mechanism
- Devices accept unsolicited [[ARP]] replies
- No verification of sender legitimacy

**Attack Flow**:
```
Normal situation:
Laptop (192.168.1.9 → MAC: 38:d5:xx:xx) 
Router (192.168.1.1 → MAC: bb:fe:xx:xx)

After ARP poisoning:
Attacker sends: "I am 192.168.1.1" (with attacker's MAC)
Laptop's ARP cache now points 192.168.1.1 → Attacker's MAC
All traffic meant for router now flows through attacker
```

---

### Silent Interception

**Analogy**: A burglar with a invisible cloak watching you type your PIN at an ATM—they see everything but leave no fingerprints.

**Definition**: The ability of an on-path attacker to observe traffic without the communicating devices detecting the intrusion. Antivirus and endpoint security on the laptop and router won't alert because the compromise isn't on those devices—it's in the network path between them.

---

## Exam Tips

### Question Type 1: Attack Identification
- *"A user's credentials are being stolen even though their antivirus is running. The network shows unusual ARP activity. What is this?"* → **ARP Poisoning / On-Path Attack**
- **Trick**: Students assume endpoint security will catch it—but MITM attacks bypass endpoints entirely. The threat is in the network, not the device.

### Question Type 2: Mitigation Recognition
- *"Which technology prevents ARP spoofing attacks?"* → **Dynamic ARP Inspection (DAI)**, [[DHCP Snooping]], or **Static ARP entries**
- **Trick**: Questions may confuse [[Firewall]] rules with ARP-layer defenses. Firewalls operate higher up and can't stop ARP poisoning.

### Question Type 3: Symptom Matching
- *"Users report slow internet and password failures despite correct credentials. What's a likely cause?"* → **On-path attack intercepting and modifying traffic**
- **Trick**: The "password failures" hint suggests [[Credential Theft]], which is classic MITM behavior.

---

## Common Mistakes

### Mistake 1: Believing Endpoint Security Is Enough
**Wrong**: "My antivirus runs on my laptop, so I'm protected from on-path attacks."
**Right**: Endpoint security monitors processes and files *on the device*. An on-path attack operates in the network path *between devices*, where antivirus has no visibility.
**Impact on Exam**: You'll lose points if you suggest endpoint tools as mitigation for MITM attacks. The fix is network-level: [[Switch]] security, [[VLAN]] segmentation, or [[Encryption]].

### Mistake 2: Confusing ARP with IP Spoofing
**Wrong**: "ARP poisoning is the same as spoofing an IP address."
**Right**: [[ARP]] spoofing poisons Layer 2 ([[MAC]] addresses) on a local subnet only. [[IP Spoofing]] forges Layer 3 addresses and can cross the internet.
**Impact on Exam**: Questions about LAN attacks = think ARP; questions about internet attacks = think IP spoofing or DNS poisoning.

### Mistake 3: Thinking Both Parties Always Notice
**Wrong**: "If someone's intercepting my traffic, I'll see it in my network settings."
**Right**: A silent on-path attack leaves no obvious signs on the end devices. The attacker forwards all traffic normally (they're not blocking it), so the connection works fine.
**Impact on Exam**: When asked "How would a user know about an on-path attack?", the answer isn't "they'd see network errors"—it's "they'd notice unusual behavior like credential failures or see suspicious [[ARP]] activity with tools like `arp -a`."

---

## Practical Defense Examples

### Detecting ARP Poisoning
```bash
# Windows: View ARP cache
arp -a

# Look for multiple entries pointing to the same MAC address
# Or unexpected MAC addresses for known IPs (like your router)

# Linux: Same command
arp -a
# Or
ip neigh show
```

### Mitigation Strategies

| Defense | Layer | Effectiveness |
|---|---|---|
| **[[HTTPS]] / [[TLS]]** | Application | Medium (encrypts payload, but MITM still occurs) |
| **[[Dynamic ARP Inspection (DAI)]]** | Layer 2 | High (on supported switches) |
| **[[DHCP Snooping]]** | Layer 2 | High (restricts DHCP replies) |
| **Static ARP Entries** | Layer 2 | High (but not scalable) |
| **[[VPN]]** | Transport | Very High (encrypts all traffic end-to-end) |
| **Port Security** | Layer 2 | Medium (limits unauthorized devices) |

---

## Related Topics
- [[Address Resolution Protocol (ARP)]]
- [[MAC Address Spoofing]]
- [[DNS Poisoning]]
- [[Network Sniffing]]
- [[Packet Sniffer]]
- [[HTTPS and Encryption]]
- [[Switch Security]]
- [[Virtual Local Area Network (VLAN)]]
- [[Dynamic ARP Inspection (DAI)]]
- [[DHCP Snooping]]

---

*Source: CompTIA A+ Core 2 (220-1202) | Rewritten Study Material*